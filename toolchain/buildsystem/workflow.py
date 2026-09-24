"""Locked build lifecycle, artifact provenance and program cloning."""
from contextlib import contextmanager
from datetime import datetime, timezone
import fcntl
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
from .model import Build, BuildError, catalog, identifier, input_path, load_build, read_toml
from .backends.diamond import DiamondBackend, launcher


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
    paths = set(build.inputs) | set((build.root / 'toolchain/buildsystem').rglob('*.py'))
    if build.backend == 'foss':
        paths |= set((build.root / 'toolchain/hdl').rglob('*.v'))
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
def locked(build: Build):
    """Hold a nonblocking process lock across project, build, GUI or clean work."""
    directory = safe_directory(build)
    lockdir = safe_directory(build, build.root / 'toolchain/build/locks')
    lockdir.mkdir(parents=True, exist_ok=True)
    lockpath = lockdir / f'{build.name}.{build.target}.{build.backend}.lock'
    fd = os.open(lockpath, os.O_CREAT | os.O_RDWR | os.O_NOFOLLOW, 0o600)
    with os.fdopen(fd, 'w') as stream:
        try:
            fcntl.flock(stream, fcntl.LOCK_EX | fcntl.LOCK_NB)
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
        guard(directory)
        clear_publication(build, directory)
        directory.mkdir(parents=True, exist_ok=True)
        metadata = directory / 'metadata'
        metadata.mkdir(exist_ok=True)
        write_json(metadata / 'status.json', {'status': 'running'})
        before = hashes(build)
        try:
            proj, log = prepare(build, directory)
            output = backend_for(build).build(proj, log)
            versions = re.findall(r'3\.14\.0\.\d+\.\d+', output)
            if build.backend == 'diamond' and build.expected_version not in versions:
                raise BuildError(f'Expected Diamond {build.expected_version} not reported; see {log}')
            if before != hashes(build):
                raise BuildError('Inputs changed during build; outputs were not published')
            exports = {}
            for ext in (('jed', 'bit') if build.backend == 'diamond' else ('bit',)):
                path = proj / 'impl' / f'firmware_impl.{ext}'
                if not path.is_file() or not path.stat().st_size:
                    raise BuildError(f'Missing fresh export: {path}; see {log}')
                exports[ext] = path
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
            record = {'schema_version': 1, 'status': 'success', 'program': build.name,
                      'target': build.target, 'backend': build.backend, 'device': build.device,
                      'top': build.top, 'standard': build.standard,
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
                              options=dict(build.options, lse_vhdl2008='True' if build.standard == '2008' else 'False'))
            else:
                record['tools'] = json.loads((directory / 'metadata/reports/tools.json').read_text())
                record['limitations'] = 'Experimental MachXO2 flow; no hardware or Diamond bitstream equivalence established; no JEDEC export.'
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
    for folder in ('programs', 'toolchain', 'docs'):
        if (root / folder).is_symlink():
            raise BuildError(f'Authored directory must not be a symlink: {root / folder}')
    programs = root / 'programs'
    outputs = [root / 'toolchain/build', root / 'docs/_build',
               root / 'docs/_generated', root / '.venv']
    if programs.is_dir():
        for program in programs.iterdir():
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
            if name in ('.git', 'archive'):
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
        result = subprocess.run([str(executable), str(proj / 'firmware.ldf')], cwd=proj)
        if result.returncode:
            raise BuildError(f'Diamond GUI exited {result.returncode}')


def scaffold(root: Path, name: str, template: str, target: str | None = None, backend: str | None = None) -> Path:
    """Clone an existing program and register it in the catalog.

    ``template`` names a program under ``programs/``; no template directory is
    used. HDL entities and testbench behavior are preserved. Additional local
    files are copied, excluding Python caches. External inputs must be localized
    before cloning so the new program is independently editable.
    """
    root = root.resolve()
    name, template = map(identifier, (name, template))
    if target is not None:
        target = identifier(target)
    if (root / 'programs').is_symlink():
        raise BuildError('Programs directory must not be a symlink')
    destination = root / 'programs' / name
    if destination.exists() or destination.is_symlink():
        raise BuildError(f'Program already exists: {destination}')
    catalog_path = root / 'programs/catalog.toml'
    if catalog_path.is_symlink():
        raise BuildError('Program catalog must not be a symlink')
    programs = catalog(root)
    if name in programs:
        raise BuildError(f'Program already listed in catalog: {name}')
    original = load_build(root, template, target, backend)
    source = original.manifests[0].parent
    meta = read_toml(original.manifests[0])
    primary_constraint = input_path(root, source, meta['constraints'][0])
    local_inputs = [s.path for s in original.sources] + [primary_constraint, original.testbench]
    if 'foss_constraints' in meta:
        local_inputs.append(input_path(root, source, meta['foss_constraints'][0]))
    if any(path.is_relative_to(source / 'build') for path in local_inputs):
        raise BuildError('Cloning requires authored inputs outside the generated build directory')
    if any(not path.is_relative_to(source) for path in local_inputs):
        raise BuildError('Cloning requires program-local inputs; copy shared inputs into the source program first')
    if any(path.is_symlink() for path in source.rglob('*')
           if path.relative_to(source).parts[0] != 'build'):
        raise BuildError('Cloning requires regular files, not symlinks, in the source program')
    primary = source / f'{template}.vhdl'
    if primary not in [s.path for s in original.sources]:
        raise BuildError(f'Cloning requires the primary source {primary.name}')
    renames = {Path(f'{template}.toml'): Path(f'{name}.toml'),
               primary.relative_to(source): Path(f'{name}.vhdl'),
               primary_constraint.relative_to(source): Path(f'{name}_constraints.lpf'),
               original.testbench.relative_to(source): Path(f'{name}_tb.py')}
    if 'foss_constraints' in meta:
        renames[Path(meta['foss_constraints'][0])] = Path(f'{name}_foss_constraints.lpf')
    for old, new in renames.items():
        if (source / new).exists() and new != old:
            raise BuildError(f'Clone filename conflicts with an existing file: {new}')
    meta['name'] = name
    meta['sources'] = [{'path': str(renames.get(s.path.relative_to(source), s.path.relative_to(source))),
                        'library': s.library} for s in original.sources]
    meta['constraints'] = [f'{name}_constraints.lpf']
    if 'foss_constraints' in meta:
        meta['foss_constraints'] = [f'{name}_foss_constraints.lpf']
    meta['testbench'] = f'{name}_tb.py'

    def toml_value(value):
        if isinstance(value, dict):
            return '{' + ', '.join(f'{k} = {toml_value(v)}' for k, v in value.items()) + '}'
        if isinstance(value, list):
            return '[' + ', '.join(toml_value(v) for v in value) + ']'
        return json.dumps(value)

    destination.mkdir()
    try:
        shutil.copytree(source, destination, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('build', '__pycache__', '*.pyc', '.pytest_cache'))
        for old, new in renames.items():
            (destination / old).rename(destination / new)
        (destination / f'{name}.toml').write_text(
            ''.join(f'{key} = {toml_value(value)}\n' for key, value in meta.items()))
        load_build(root, name, target, backend)
        fd, temporary = tempfile.mkstemp(prefix='.catalog-', suffix='.tmp', dir=catalog_path.parent)
        try:
            with os.fdopen(fd, 'w') as stream:
                stream.write('programs = ' + json.dumps([*programs, name]) + '\n')
            os.chmod(temporary, catalog_path.stat().st_mode & 0o777)
            os.replace(temporary, catalog_path)
        finally:
            if os.path.exists(temporary):
                os.unlink(temporary)
    except Exception:
        shutil.rmtree(destination)
        raise
    return destination
