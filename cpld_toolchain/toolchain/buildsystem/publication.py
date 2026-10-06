"""Shared, verified firmware snapshots for local builds and CI archives."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
from zipfile import ZIP_DEFLATED, ZipFile

from .identity import read_registry
from .model import BuildError
from .report import _row
from .workflow import safe_directory, workspace_lock


def collect(root, builds):
    """Collect exactly the requested builds while the caller holds the workspace lock."""
    builds = list(builds)
    if not builds:
        raise BuildError('No builds selected for publication')
    backends = {build.backend for build in builds}
    if len(backends) != 1:
        raise BuildError('A firmware publication must use one backend')
    result = subprocess.run(['git', '-C', str(root), 'rev-parse', 'HEAD'],
                            capture_output=True, text=True)
    revision = result.stdout.strip() if result.returncode == 0 else None
    manifest = {'schema_version': 1, 'git_revision': revision,
                'backend': builds[0].backend,
                'release_cycles': sorted({build.release_cycle for build in builds}),
                'builds': [], 'identity_registry': read_registry(root)}
    payloads = {}
    for build in sorted(builds, key=lambda b: (b.release_cycle, b.name, b.target)):
        row = _row(build)
        if row['status'] != 'success':
            raise BuildError(f'{build.qualified_name} ({build.target}): {row["status"]} build evidence')
        record = json.loads((build.directory / 'metadata/build.json').read_text())
        if record.get('git_revision') != revision:
            raise BuildError(f'{build.qualified_name}: build belongs to another Git revision')
        files = {}
        for extension in (('bit', 'jed') if build.backend == 'diamond' else ('bit',)):
            source = build.firmware_path(extension)
            payload = source.read_bytes()
            checksum = hashlib.sha256(payload).hexdigest()
            if not payload or record['outputs'].get(source.name) != checksum:
                raise BuildError(f'{source}: missing or mismatched firmware checksum')
            destination = f'{build.release_cycle}/{build.name}/{build.target}/{source.name}'
            payloads[destination] = payload
            files[destination] = checksum
        manifest['builds'].append({'release_cycle': build.release_cycle, 'program': build.name,
                                  'target': build.target, 'device': build.device,
                                  'identity': row['identity'], 'files': files,
                                  'provenance': record})
    payloads['manifest.json'] = (json.dumps(manifest, indent=2, sort_keys=True) + '\n').encode()
    return payloads


def publish(root, builds):
    """Replace the selected release/backend snapshot only after complete validation."""
    root, builds = Path(root).resolve(), list(builds)
    scopes = {(build.backend, build.release_cycle) for build in builds}
    if len(scopes) != 1:
        raise BuildError('Local publication requires one backend and release')
    backend, cycle = scopes.pop()
    output = root / 'cpld_toolchain/toolchain/build/publication' / backend / cycle
    with workspace_lock(root, exclusive=True):
        payloads = collect(root, builds)
        safe_directory(builds[0], output)
        output.parent.mkdir(parents=True, exist_ok=True)
        if output.is_symlink():
            raise BuildError(f'Publication must not be a symlink: {output}')
        with tempfile.TemporaryDirectory(prefix='.firmware-', dir=output.parent) as temporary:
            staging = Path(temporary) / 'snapshot'
            staging.mkdir()
            for name, payload in payloads.items():
                path = staging / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(payload)
            previous = Path(temporary) / 'previous'
            if output.exists():
                output.rename(previous)
            try:
                staging.rename(output)
            except OSError:
                if previous.exists():
                    previous.rename(output)
                raise
    return output


def archive(root, builds, output):
    """Write the same snapshot layout as a ZIP, without overwriting a release archive."""
    root, output = Path(root).resolve(), Path(output).absolute()
    with workspace_lock(root, exclusive=True):
        if output.exists() or output.is_symlink():
            raise BuildError(f'Archive already exists: {output}; choose a new output path')
        payloads = collect(root, builds)
        output.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix='.firmware-', dir=output.parent) as temporary:
            staged = Path(temporary) / 'firmware.zip'
            with ZipFile(staged, 'w', compression=ZIP_DEFLATED) as bundle:
                for name, payload in payloads.items():
                    bundle.writestr(name, payload)
            staged.replace(output)
    return output
