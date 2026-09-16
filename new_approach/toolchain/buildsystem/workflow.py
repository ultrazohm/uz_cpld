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
from .model import Build, BuildError, identifier, load_build, read_toml
from .backends.diamond import DiamondBackend, launcher


def digest(path: Path) -> str:
    """Return a file's SHA-256 digest."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def hashes(build: Build) -> dict:
    """Hash authored inputs and the Python implementation used for this build."""
    paths = set(build.inputs) | set((build.root / 'toolchain/buildsystem').rglob('*.py'))
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
    lockdir = build.build_root / '.locks'
    if lockdir.is_symlink():
        raise BuildError('Lock directory must not be a symlink')
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
    return {str(p.relative_to(project)): digest(p) for p in sorted(project.rglob('*'))
            if p.is_file() and p.suffix in ('.ldf', '.sty', '.tcl')}


def guard(directory: Path):
    """Refuse regeneration when generated configuration was edited externally."""
    project, record = directory / 'project', directory / 'configuration.json'
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
        DiamondBackend().prepare(build, project, log)
    finally:
        # Even a failed generation can be safely retried if it remains unchanged.
        if project.exists():
            write_json(directory / 'configuration.json', configuration(project))
    return project, logs / f'{stamp}-build.log'


def project(build: Build) -> Path:
    """Create a GUI-compatible project without synthesizing it."""
    with locked(build) as directory:
        path, _ = prepare(build, directory)
        return path / 'firmware.ldf'


def build_program(build: Build) -> Path:
    """Build fresh firmware; publish success only after input/output validation.

    Failed attempts retain logs and intermediates. Previous artifacts are removed
    before invoking Diamond so they cannot be mistaken for the current result.
    """
    with locked(build) as directory:
        guard(directory)
        artifacts = directory / 'artifacts'
        if artifacts.is_symlink():
            raise BuildError('Artifact directory must not be a symlink')
        if artifacts.exists():
            shutil.rmtree(artifacts)
        directory.mkdir(parents=True, exist_ok=True)
        write_json(directory / 'status.json', {'status': 'running'})
        before = hashes(build)
        try:
            proj, log = prepare(build, directory)
            output = DiamondBackend().build(proj, log)
            versions = re.findall(r'3\.14\.0\.\d+\.\d+', output)
            if build.expected_version not in versions:
                raise BuildError(f'Expected Diamond {build.expected_version} not reported; see {log}')
            if before != hashes(build):
                raise BuildError('Inputs changed during build; outputs were not published')
            exports = {}
            for ext in ('jed', 'bit'):
                path = proj / 'impl' / f'firmware_impl.{ext}'
                if not path.is_file() or not path.stat().st_size:
                    raise BuildError(f'Missing fresh export: {path}; see {log}')
                exports[ext] = path
            artifacts.mkdir()
            for ext, path in exports.items():
                shutil.copy2(path, artifacts / f'firmware.{ext}')
            reports = artifacts / 'reports'; reports.mkdir()
            for p in (proj / 'impl').rglob('*'):
                if p.is_file() and p.suffix.lower() in {'.twr', '.mrp', '.par', '.pad', '.srr', '.rpt', '.bgn', '.html', '.log'}:
                    destination = reports / p.relative_to(proj / 'impl')
                    destination.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(p, destination)
            def git(*args):
                result = subprocess.run(['git', '-C', str(build.root), *args], capture_output=True, text=True)
                return result.stdout.strip() if result.returncode == 0 else None
            record = {'schema_version': 1, 'status': 'success', 'program': build.name,
                      'target': build.target, 'backend': build.backend, 'device': build.device,
                      'top': build.top, 'standard': build.standard,
                      'tool_version': build.expected_version, 'launcher': str(launcher()),
                      'launcher_sha256': digest(launcher()),
                      'options': dict(build.options, lse_vhdl2008='True' if build.standard == '2008' else 'False'),
                      'generated_configuration': configuration(proj),
                      'warnings': [line for line in output.splitlines() if 'WARNING' in line.upper()],
                      'timing_acceptance': 'not evaluated: no program timing budget defined',
                      'git_revision': git('rev-parse', 'HEAD'),
                      'git_status': git('status', '--porcelain', '--untracked-files=all'),
                      'inputs': before, 'completed_at': datetime.now(timezone.utc).isoformat(),
                      'log': str(log.relative_to(build.root)),
                      'outputs': {str(p.relative_to(artifacts)): digest(p) for p in sorted(artifacts.rglob('*')) if p.is_file()}}
            write_json(artifacts / 'build.json', record)
            write_json(directory / 'status.json', {'status': 'success'})
        except Exception as exc:
            if artifacts.exists():
                shutil.rmtree(artifacts)
            write_json(directory / 'status.json', {'status': 'failed', 'error': str(exc)})
            raise
        finally:
            if (directory / 'project').exists():
                write_json(directory / 'configuration.json', configuration(directory / 'project'))
        return artifacts


def clean(build: Build, discard_project_changes: bool = False):
    """Remove only the selected generated directory, protecting GUI edits by default."""
    with locked(build) as directory:
        if not discard_project_changes:
            guard(directory)
        if directory.exists():
            shutil.rmtree(directory)


def gui(build: Build):
    """Open the native GUI under the same lock used by builds.

    The launcher must remain foregrounded until Diamond closes. Do not open the
    same implementation separately while a managed operation is running.
    """
    executable = launcher(gui=True)
    with locked(build) as directory:
        # Preserve existing GUI experiments; explicit project/build regenerates.
        proj = directory / 'project'
        if not (proj / 'firmware.ldf').is_file():
            proj, _ = prepare(build, directory)
        result = subprocess.run([str(executable), str(proj / 'firmware.ldf')], cwd=proj)
        if result.returncode:
            raise BuildError(f'Diamond GUI exited {result.returncode}')


def scaffold(root: Path, name: str, template: str, target: str = 'uz_dslot_xo2') -> Path:
    """Clone an existing program, renaming its files and manifest references.

    ``template`` names a program under ``programs/``; no template directory is
    used. HDL entities and testbench behavior are preserved. Additional local
    files are copied, excluding Python caches. External inputs must be localized
    before cloning so the new program is independently editable.
    """
    root = root.resolve()
    name, template, target = map(identifier, (name, template, target))
    if (root / 'programs').is_symlink():
        raise BuildError('Programs directory must not be a symlink')
    destination = root / 'programs' / name
    if destination.exists() or destination.is_symlink():
        raise BuildError(f'Program already exists: {destination}')
    original = load_build(root, template, target)
    source = original.manifests[0].parent
    meta = read_toml(original.manifests[0])
    local_inputs = [s.path for s in original.sources] + [original.constraint, original.testbench]
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
               original.constraint.relative_to(source): Path(f'{name}_constraints.lpf'),
               original.testbench.relative_to(source): Path(f'{name}_tb.py')}
    for old, new in renames.items():
        if (source / new).exists() and new != old:
            raise BuildError(f'Clone filename conflicts with an existing file: {new}')
    meta['name'] = name
    meta['sources'] = [{'path': str(renames.get(s.path.relative_to(source), s.path.relative_to(source))),
                        'library': s.library} for s in original.sources]
    meta['constraints'] = [f'{name}_constraints.lpf']
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
        load_build(root, name, target)
    except Exception:
        shutil.rmtree(destination)
        raise
    return destination
