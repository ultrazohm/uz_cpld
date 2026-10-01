"""Locked build lifecycle, artifact provenance and program cloning."""
from contextlib import contextmanager, ExitStack
from datetime import datetime, timezone
from toolchain.locking import directory_lock, file_lock
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
from .model import Build, BuildError, catalog, identifier, input_path, load_build, read_toml, release_directory, resolve_release, resolve_program
from .backends.diamond import DiamondBackend, launcher, synthesis_options
from .ghdl import read_vhdl
from toolchain.diamond import environment as diamond_environment


def backend_for(build):
    if build.backend == 'diamond':
        return DiamondBackend()
    from .backends.foss import FossBackend
    return FossBackend()


def digest(path: Path) -> str:
    """Return a file's SHA-256 digest."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def hashes(build: Build) -> dict:
    """Hash authored inputs and the Python implementation used for this build."""
    code = build.root / 'toolchain/buildsystem'
    paths = set(build.inputs) | {code / name for name in
                                 ('model.py', 'workflow.py', 'cli.py', 'identity.py', 'backends/' + build.backend + '.py')}
    paths.add(build.root / 'toolchain/locking.py')
    if build.backend == 'diamond':
        paths.add(build.root / 'toolchain/diamond.py')
    if build.backend == 'foss':
        paths |= {code / 'ghdl.py', code / 'foss_config.py'}
        paths |= set((build.root / 'toolchain/hdl').rglob('*.v'))
        paths |= set((build.root / 'toolchain/hdl').rglob('*.vhdl'))
    return {str(p.relative_to(build.root)): digest(p) for p in sorted(paths)}


def write_json(path: Path, value):
    """Atomically write a JSON record in its destination directory."""
    temp = path.with_suffix('.tmp')
    temp.write_text(json.dumps(value, indent=2, sort_keys=True) + '\n')
    temp.replace(path)


def safe_directory(build: Build, directory: Path | None = None) -> Path:
    """Reject symlinks in generated directory ancestry before any deletion."""
    directory = build.directory if directory is None else directory
    current = build.root
    for part in directory.relative_to(build.root).parts:
        current /= part
        if current.is_symlink():
            raise BuildError(f'Generated path is a symlink: {current}')
    return directory


@contextmanager
def workspace_lock(root: Path, *, exclusive: bool = False):
    """Coordinate cleanup with a persistent workspace lock on either platform."""
    with ExitStack() as stack:
        try:
            stack.enter_context(directory_lock(root, exclusive=exclusive))
        except BlockingIOError as exc:
            raise BuildError(f'Workspace operation already active: {root}') from exc
        yield


@contextmanager
def locked(build: Build):
    """Exclude cleanup and competing project, build, GUI or clean operations."""
    with workspace_lock(build.root):
        directory = safe_directory(build)
        lockdir = safe_directory(build, build.root / 'toolchain/build/locks')
        lockdir.mkdir(parents=True, exist_ok=True)
        lockpath = lockdir / f'{build.release_cycle}.{build.name}.{build.target}.{build.backend}.lock'
        with ExitStack() as stack:
            try:
                stack.enter_context(file_lock(lockpath))
            except BlockingIOError as exc:
                raise BuildError(f'Build or GUI already active: {directory}') from exc
            yield directory


def configuration(project: Path) -> dict:
    """Fingerprint generated project settings, including GUI-added metadata."""
    result = {str(p.relative_to(project)): digest(p) for p in sorted(project.rglob('*'))
              if p.is_file() and (p.suffix in ('.ldf', '.sty', '.tcl', '.ys', '.lpf'))}
    plan = project.parent / 'metadata/build-plan.json'
    if plan.is_file():
        result['metadata/build-plan.json'] = digest(plan)
    return result


def guard(directory: Path):
    """Refuse regeneration when generated configuration was edited externally."""
    metadata = directory / 'metadata'
    if metadata.is_symlink():
        raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
    project, record = directory / 'project', metadata / 'configuration.json'
    if project.exists():
        if not record.is_file() or json.loads(record.read_text()) != configuration(project):
            raise BuildError(f'Generated configuration changed in {project}. Transfer useful settings into manifests, then use clean --discard-project-changes explicitly.')


def prepare(build: Build, directory: Path):
    """Prepare a fresh project, retaining previous logs and guarding GUI changes."""
    guard(directory)
    project = directory / 'project'
    if project.is_symlink():
        raise BuildError('Project directory must not be a symlink')
    if project.exists():
        shutil.rmtree(project)
    logs = directory / 'logs'
    if logs.is_symlink():
        raise BuildError('Logs directory must not be a symlink')
    logs.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    log = logs / f'{stamp}-prepare.log'
    try:
        from .identity import reserve_build
        metadata = directory / 'metadata'
        if metadata.is_symlink():
            raise BuildError('Metadata directory must not be a symlink')
        metadata.mkdir(exist_ok=True)
        write_json(metadata / 'identity.json', reserve_build(build))
        backend_for(build).prepare(build, project, log)
    finally:
        # Even a failed generation can be safely retried if it remains unchanged.
        if project.exists():
            metadata = directory / 'metadata'
            if metadata.is_symlink():
                raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
            metadata.mkdir(exist_ok=True)
            write_json(metadata / 'configuration.json', configuration(project))
    return project, logs / f'{stamp}-build.log'


def project(build: Build) -> Path:
    """Create a Diamond project or a FOSS build plan without synthesizing it."""
    with locked(build) as directory:
        path, _ = prepare(build, directory)
        return path / 'firmware.ldf' if build.backend == 'diamond' else path.parent / 'metadata/build-plan.json'


def clear_publication(build: Build, directory: Path):
    """Remove published firmware, reports and provenance without losing diagnostics."""
    metadata = directory / 'metadata'
    if metadata.is_symlink():
        raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
    json_reports = metadata / 'reports'
    if json_reports.is_symlink():
        raise BuildError(f'JSON report directory must not be a symlink: {json_reports}')
    reports = directory / 'reports'
    if reports.is_symlink():
        raise BuildError(f'Report directory must not be a symlink: {reports}')
    for extension in ('jed', 'bit'):
        build.firmware_path(extension).unlink(missing_ok=True)
    (metadata / 'build.json').unlink(missing_ok=True)
    if json_reports.exists():
        shutil.rmtree(json_reports)
    if reports.exists():
        shutil.rmtree(reports)


def build_program(build: Build) -> Path:
    """Build fresh firmware; publish success only after input/output validation.

    Failed attempts retain logs and intermediates. Previous artifacts are removed
    before invoking the selected backend so they cannot be mistaken for the current result.
    """
    with locked(build) as directory:
        current = load_build(build.root, build.name, build.target, build.backend, build.release_cycle)
        if current != build:
            raise BuildError('Build configuration changed since it was loaded; reload before building')
        guard(directory)
        clear_publication(build, directory)
        directory.mkdir(parents=True, exist_ok=True)
        metadata = directory / 'metadata'
        metadata.mkdir(exist_ok=True)
        write_json(metadata / 'status.json', {'status': 'running'})
        try:
            before = hashes(build)
            proj, log = prepare(build, directory)
            output = backend_for(build).build(proj, log)
            from .backends.diamond import reported_versions
            versions = reported_versions(output)
            if build.backend == 'diamond' and build.expected_version not in versions:
                raise BuildError(f'Expected Diamond {build.expected_version}; reported {", ".join(versions) or "no full version"}; see {log}')
            if before != hashes(build):
                raise BuildError('Inputs changed during build; outputs were not published')
            exports = {}
            for ext in (('jed', 'bit') if build.backend == 'diamond' else ('bit',)):
                path = proj / 'impl' / f'firmware_impl.{ext}'
                if not path.is_file() or not path.stat().st_size:
                    raise BuildError(f'Missing fresh export: {path}; see {log}')
                exports[ext] = path
            from .identity import validate_identity, record_artifacts
            identity = validate_identity(build, json.loads((metadata / 'identity.json').read_text()))
            if build.backend == 'diamond':
                values = re.findall(rb'(?m)^UH([0-9A-Fa-f]{8})\*\r?$', exports['jed'].read_bytes())
                if values != [identity['usercode'].encode()]:
                    raise BuildError('Exported JEDEC USERCODE does not match the registered build identity')
            published = []
            for ext, path in exports.items():
                destination = build.firmware_path(ext)
                shutil.copy2(path, destination)
                published.append(destination)
            reports = directory / 'reports'; reports.mkdir()
            for p in (proj / 'impl').rglob('*'):
                if p.is_file() and p.suffix.lower() in {'.twr', '.mrp', '.par', '.pad', '.srr', '.rpt', '.bgn', '.html', '.log', '.json', '.config'}:
                    destination = (metadata / 'reports' if p.suffix.lower() == '.json' else reports) / p.relative_to(proj / 'impl')
                    destination.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(p, destination)
            def git(*args):
                result = subprocess.run(['git', '-C', str(build.root), *args], capture_output=True, text=True)
                return result.stdout.strip() if result.returncode == 0 else None
            record = {'schema_version': 1, 'status': 'success', 'program': build.name, 'release_cycle': build.release_cycle,
                      'target': build.target, 'backend': build.backend, 'device': build.device,
                      'top': build.top, 'standard': build.standard, 'identity': identity,
                      'tool_version': build.expected_version,
                      'options': build.options,
                      'generated_configuration': configuration(proj),
                      'warnings': [line for line in output.splitlines() if 'WARNING' in line.upper()],
                      'timing_acceptance': 'not evaluated: no program timing budget defined',
                      'git_revision': git('rev-parse', 'HEAD'),
                      'git_status': git('status', '--porcelain', '--untracked-files=all'),
                      'inputs': before, 'completed_at': datetime.now(timezone.utc).isoformat(),
                      'log': str(log.relative_to(build.root)),
                      'outputs': {str(p.relative_to(directory)): digest(p) for p in sorted([*published, *reports.rglob('*'), *(metadata / 'reports').rglob('*')]) if p.is_file()}}
            if build.backend == 'diamond':
                record.update(launcher=str(launcher()), launcher_sha256=digest(launcher()),
                              synthesis=build.synthesis, options=synthesis_options(build))
            else:
                record['tools'] = json.loads((directory / 'metadata/reports/tools.json').read_text())
                record['limitations'] = 'Experimental MachXO2 flow; no hardware or Diamond bitstream equivalence established; no JEDEC export.'
            record_artifacts(build, record)
            write_json(metadata / 'build.json', record)
            write_json(metadata / 'status.json', {'status': 'success'})
        except Exception as exc:
            clear_publication(build, directory)
            write_json(metadata / 'status.json', {'status': 'failed', 'error': str(exc)})
            raise
        finally:
            if (directory / 'project').exists():
                write_json(metadata / 'configuration.json', configuration(directory / 'project'))
        return directory


def clean(build: Build, discard_project_changes: bool = False):
    """Remove only the selected generated directory, protecting GUI edits by default."""
    with locked(build) as directory:
        if not discard_project_changes:
            guard(directory)
        if directory.exists():
            shutil.rmtree(directory)


def clean_all(root: Path):
    """Remove generated toolchain outputs, documentation, caches and local environment."""
    root = root.resolve()
    with workspace_lock(root, exclusive=True):
        _clean_all(root)


def _clean_all(root: Path):
    """Delete generated files while holding the exclusive workspace lock."""
    for folder in ('programs', 'toolchain', 'docs'):
        if (root / folder).is_symlink():
            raise BuildError(f'Authored directory must not be a symlink: {root / folder}')
    programs = root / 'programs'
    outputs = [root / 'toolchain/build', root / 'docs/_build', root / 'docs/_generated']
    environment = root / '.venv'
    if Path(sys.prefix).resolve().is_relative_to(environment.resolve()):
        print(f'Keeping active Python environment: {environment}')
    else:
        outputs.append(environment)
    if programs.is_dir():
        for cycle in programs.iterdir():
            if cycle.is_symlink():
                raise BuildError(f'Release directory must not be a symlink: {cycle}')
            if cycle.is_dir():
                for program in cycle.iterdir():
                    if program.is_symlink():
                        raise BuildError(f'Program directory must not be a symlink: {program}')
                    if program.is_dir():
                        outputs.append(program / 'build')
    for path in outputs:
        if path.is_symlink():
            raise BuildError(f'Generated path must not be a symlink: {path}')
    for path in outputs:
        if path.is_dir():
            shutil.rmtree(path)
    for parent, dirs, files in os.walk(root, topdown=True, followlinks=False):
        base = Path(parent)
        for name in list(dirs):
            path = base / name
            if name in ('.git', 'archive', '.venv'):
                dirs.remove(name)
            elif name in ('__pycache__', '.pytest_cache'):
                if path.is_symlink():
                    raise BuildError(f'Cache path must not be a symlink: {path}')
                shutil.rmtree(path)
                dirs.remove(name)
        for name in files:
            if name.endswith('.pyc'):
                (base / name).unlink()


def gui(build: Build):
    """Open the native GUI under the same lock used by builds.

    The launcher must remain foregrounded until Diamond closes. Do not open the
    same implementation separately while a managed operation is running.
    """
    if build.backend != 'diamond':
        raise BuildError('gui is only supported by backend=diamond; FOSS project emits a build plan')
    executable = launcher(gui=True)
    with locked(build) as directory:
        # Preserve existing GUI experiments; explicit project/build regenerates.
        proj = directory / 'project'
        if not (proj / 'firmware.ldf').is_file():
            proj, _ = prepare(build, directory)
        result = subprocess.run([str(executable), str(proj / 'firmware.ldf')], cwd=proj, env=diamond_environment(executable))
        if result.returncode:
            raise BuildError(f'Diamond GUI exited {result.returncode}')


def generator_template(root: Path, name: str, target: str | None = None,
                       backend: str | None = None, release_cycle: str | None = None) -> Path:
    """Create editable generator inputs; catalog registration follows generation."""
    from cpld_vhdl_generator import load_config
    from cpld_vhdl_generator.generator import program_name
    root = root.resolve()
    name = program_name(name)
    release_cycle = resolve_release(root, release_cycle)
    if target not in (None, 'uz_dslot_xo2') or backend not in (None, 'diamond'):
        raise BuildError('The generator template supports target=uz_dslot_xo2 backend=diamond')
    with workspace_lock(root, exclusive=True):
        if (root / 'programs').is_symlink():
            raise BuildError('Programs directory must not be a symlink')
        destination = release_directory(root, release_cycle) / name
        if destination.exists() or destination.is_symlink() or name in catalog(root, release_cycle):
            raise BuildError(f'Program already exists: {destination}')
        destination.mkdir()
        try:
            (destination / 'generator.toml').write_text(f'''schema_version = 3
name = "{name}"
routing = "routing.csv"
contract = "s3c_power_on_debounce_v1"
clock = "machxo2"
pilot_policy = "unused"
s3c_library = "../../../xo2_library/s3c"
target = "uz_dslot_xo2"
''')
            (destination / 'routing.csv').write_text('output,normal_state,safe_state\n' +
                ''.join(f'd_{i:02d},fpga_{i:02d},0\n' for i in range(30)))
            (destination / 'description.rst').write_text(
                'Purpose\n-------\n\nDescribe the adapter and its routing here.\n')
            load_config(destination / 'generator.toml')
            from .identity import reserve_program
            reserve_program(root, name, release_cycle)
        except Exception:
            shutil.rmtree(destination)
            raise
        return destination


def register_program(root: Path, name: str, release_cycle: str | None = None):
    """Atomically add a validated program to the catalog without duplicates."""
    from .identity import reserve_program
    reserve_program(root, name, resolve_release(root, release_cycle))
    path = release_directory(root, release_cycle) / 'catalog.toml'
    if path.is_symlink():
        raise BuildError('Program catalog must not be a symlink')
    programs = catalog(root, release_cycle)
    if name in programs:
        return
    fd, temporary = tempfile.mkstemp(prefix='.catalog-', suffix='.tmp', dir=path.parent)
    try:
        with os.fdopen(fd, 'w') as stream:
            stream.write('programs = ' + json.dumps([*programs, name]) + '\n')
        os.chmod(temporary, path.stat().st_mode & 0o777)
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


def generate_program(root: Path, name: str, target: str | None = None,
                     backend: str | None = None, release_cycle: str | None = None) -> Path:
    """Generate project artifacts, validate them, and register the finished program."""
    from cpld_vhdl_generator import generate, load_config
    root = root.resolve()
    name, release_cycle = resolve_program(root, name, release_cycle)
    with workspace_lock(root, exclusive=True):
        config_path = input_path(root, root, f'programs/{release_cycle}/{name}/generator.toml')
        if config_path != release_directory(root, release_cycle) / name / 'generator.toml':
            raise BuildError('Generation requires a regular program-local generator.toml')
        config = load_config(config_path)
        if config.name != name:
            raise BuildError('Generator name must match the program directory')
        if target is not None and config.target is not None and target != config.target:
            raise BuildError(f'{name} does not support target {target}')
        if config.target and backend not in (None, 'diamond'):
            raise BuildError('Generated projects support backend=diamond')
        manifest = config_path.parent / f'{name}.toml'
        if manifest.exists() and read_toml(manifest).get('generator') != 'generator.toml':
            raise BuildError('Repository generator must be program-local generator.toml')
        generate(config_path, config_path.parent)
        load_build(root, name, target, backend, release_cycle)
        register_program(root, name, release_cycle)
        return config_path.parent


def scaffold(root: Path, name: str, template: str, target: str | None = None, backend: str | None = None, release_cycle: str | None = None, template_release_cycle: str | None = None) -> Path:
    """Clone an existing program and register it in the catalog.

    ``template`` names a program under ``programs/``; no template directory is
    used. HDL entities and testbench behavior are preserved. Additional local
    files are copied, excluding Python caches. Shared HDL stays shared; the
    top-level source, constraints and testbench remain program-owned.
    """
    if template == 'generator':
        return generator_template(root, name, target, backend, release_cycle)
    root = root.resolve()
    with workspace_lock(root, exclusive=True):
        return _scaffold(root, name, template, target, backend, release_cycle, template_release_cycle)


def _scaffold(root, name, template, target, backend, release_cycle, template_release_cycle):
    """Clone while the caller holds the exclusive workspace lock."""
    from cpld_vhdl_generator.toml import dumps

    root = root.resolve()
    name = identifier(name)
    release_cycle = resolve_release(root, release_cycle)
    template, template_release_cycle = resolve_program(root, template, template_release_cycle or release_cycle)
    original = load_build(root, template, target, backend, template_release_cycle)
    if 'generator' in read_toml(original.manifests[0]):
        from cpld_vhdl_generator.generator import program_name
        name = program_name(name)
    if target is not None:
        target = identifier(target)
    if (root / 'programs').is_symlink():
        raise BuildError('Programs directory must not be a symlink')
    destination = release_directory(root, release_cycle) / name
    if destination.exists() or destination.is_symlink():
        raise BuildError(f'Program already exists: {destination}')
    catalog_path = release_directory(root, release_cycle) / 'catalog.toml'
    if catalog_path.is_symlink():
        raise BuildError('Program catalog must not be a symlink')
    programs = catalog(root, release_cycle)
    if name in programs:
        raise BuildError(f'Program already listed in catalog: {name}')
    source = original.manifests[0].parent
    meta = read_toml(original.manifests[0])
    primary_constraint = input_path(root, source, meta['constraints'][0])
    local_inputs = [s.path for s in original.sources if s.path.is_relative_to(source)] + [primary_constraint, original.testbench]
    generated_project = False
    if 'generator' in meta:
        from cpld_vhdl_generator import load_config
        config_path = input_path(root, source, meta['generator'])
        local_inputs.append(config_path)
        generator_config = load_config(config_path)
        local_inputs.append(generator_config.routing)
        generated_project = generator_config.target is not None
    if 'foss_constraints' in meta:
        local_inputs.append(input_path(root, source, meta['foss_constraints'][0]))
    if 'foss_equivalence_blacklist' in meta:
        local_inputs.append(input_path(root, source, meta['foss_equivalence_blacklist']))
    if any(path.is_relative_to(source / 'build') for path in local_inputs):
        raise BuildError('Cloning requires authored inputs outside the generated build directory')
    if any(not path.is_relative_to(source) for path in local_inputs):
        raise BuildError('Cloning requires program-local inputs for constraints, testbench and generator configuration/routing')
    if 'generator' in meta:
        # Normalize aliases such as ../<template>/generator.toml before copying.
        meta['generator'] = str(input_path(root, source, meta['generator']).relative_to(source))
    if any(path.is_symlink() for path in source.rglob('*')
           if path.relative_to(source).parts[0] != 'build'):
        raise BuildError('Cloning requires regular files, not symlinks, in the source program')
    if 'generator' in meta:
        primary = original.sources[-1].path
    else:
        declaration = re.compile(r'\bentity\s+' + re.escape(original.top) + r'\s+is\b', re.I)
        candidates = [entry.path for entry in original.sources
                      if entry.library.lower() == 'work' and
                      declaration.search(re.sub(r'--[^\n]*', '', read_vhdl(entry.path)))]
        if len(candidates) != 1:
            raise BuildError('Cloning requires exactly one work-library source declaring the top entity')
        primary = candidates[0]
    if not primary.is_relative_to(source):
        raise BuildError('Cloning requires a program-local source declaring the top entity')
    renames = {Path(f'{template}.toml'): Path(f'{name}.toml'),
               primary.relative_to(source): Path(f'{name}.vhdl'),
               primary_constraint.relative_to(source): Path(f'{name}_constraints.lpf'),
               original.testbench.relative_to(source): Path(f'{name}_tb.py')}
    if 'generator' in meta:
        # The generator renames its owned HDL using the receipt and preserves the routing specification.
        del renames[primary.relative_to(source)]
    if 'foss_constraints' in meta:
        renames[input_path(root, source, meta['foss_constraints'][0]).relative_to(source)] = Path(f'{name}_foss_constraints.lpf')
    if 'foss_equivalence_blacklist' in meta:
        renames[input_path(root, source, meta['foss_equivalence_blacklist']).relative_to(source)] = Path(f'{name}_foss_equivalence_blacklist.txt')
    if generated_project:
        # All four project files belong to the generator receipt. Let generation
        # rename them together, preserving ownership and protection of edits.
        renames = {}
    for old, new in renames.items():
        if (source / new).exists() and new != old:
            raise BuildError(f'Clone filename conflicts with an existing file: {new}')
    meta['name'] = name
    meta['sources'] = [{'path': str(renames.get(s.path.relative_to(source), s.path.relative_to(source)))
                        if s.path.is_relative_to(source) else os.path.relpath(s.path, destination),
                        'library': s.library} for s in original.sources]
    meta['constraints'] = [f'{name}_constraints.lpf']
    if 'foss_constraints' in meta:
        meta['foss_constraints'] = [f'{name}_foss_constraints.lpf']
    if 'foss_equivalence_blacklist' in meta:
        meta['foss_equivalence_blacklist'] = f'{name}_foss_equivalence_blacklist.txt'
    meta['testbench'] = f'{name}_tb.py'

    destination.mkdir()
    try:
        shutil.copytree(source, destination, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('build', '__pycache__', '*.pyc', '.pytest_cache'))
        for old, new in renames.items():
            (destination / old).rename(destination / new)
        if 'generator' in meta:
            from cpld_vhdl_generator import generate, load_config, source_entries
            generator_path = destination / meta['generator']
            generator_config = read_toml(generator_path)
            generator_config['name'] = name
            source_config = source / meta['generator']
            for field in ('s3c_library', 'routing', 'contract'):
                value = generator_config.get(field)
                if value and (source_config.parent / value).exists():
                    resolved = (source_config.parent / value).resolve()
                    if not resolved.is_relative_to(source):
                        generator_config[field] = os.path.relpath(resolved, generator_path.parent)
            generator_path.write_text(dumps(generator_config))
            generation_output = destination / primary.parent.relative_to(source)
            generate(generator_path, generation_output)
            generated_sources = source_entries(load_config(generator_path), generation_output)
            meta['top'] = name
            meta['sources'] = [{'path': os.path.relpath(s.path, destination), 'library': s.library}
                               for s in generated_sources]
        if not generated_project:
            (destination / f'{name}.toml').write_text(dumps(meta))
        load_build(root, name, target, backend, release_cycle)
        register_program(root, name, release_cycle)
    except Exception:
        shutil.rmtree(destination)
        raise
    return destination
