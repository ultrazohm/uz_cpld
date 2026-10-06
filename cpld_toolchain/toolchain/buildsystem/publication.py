"""Shared, verified firmware snapshots for local builds and CI archives."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
from zipfile import ZIP_DEFLATED, ZipFile

from .identity import read_registry
from .model import BuildError, load_build
from .report import _row
from .workflow import safe_directory, workspace_lock, write_json


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
        safe_directory(build)
        safe_directory(build, build.directory / 'metadata/build.json')
        row = _row(build)
        if row['status'] != 'success':
            raise BuildError(f'{build.qualified_name} ({build.target}): {row["status"]} build evidence')
        record = json.loads((build.directory / 'metadata/build.json').read_text())
        if record.get('git_revision') != revision:
            raise BuildError(f'{build.qualified_name}: build belongs to another Git revision')
        files = {}
        for extension in (('bit', 'jed') if build.backend == 'diamond' else ('bit',)):
            source = build.firmware_path(extension)
            safe_directory(build, source)
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
    """Index canonical firmware in place; never create a second export copy."""
    root, builds = Path(root).resolve(), list(builds)
    backends = {build.backend for build in builds}
    if len(backends) != 1:
        raise BuildError('Local publication requires one backend')
    backend = backends.pop()
    output = root / 'build' / backend
    with workspace_lock(root, exclusive=True):
        safe_directory(builds[0], output)
        invalidate(builds[0])
        # Requested builds must succeed. Older outputs are included only while
        # they still pass the same source, registry, revision and checksum checks.
        collect(root, builds)
        indexed = {(b.release_cycle, b.name, b.target): b for b in builds}
        for record in sorted(output.glob('*/*/*/metadata/build.json')):
            target = record.parent.parent.name
            name = record.parent.parent.parent.name
            cycle = record.parent.parent.parent.parent.name
            key = (cycle, name, target)
            if key in indexed:
                continue
            try:
                build = load_build(root, name, target, backend, cycle)
                collect(root, [build])
            except (BuildError, OSError, ValueError):
                continue
            indexed[key] = build
        payloads = collect(root, indexed.values())
        output.mkdir(parents=True, exist_ok=True)
        write_json(output / 'manifest.json', json.loads(payloads['manifest.json']))
    return output


def invalidate(build):
    """A rebuild or cleanup must not leave a manifest advertising removed firmware."""
    output = build.root / 'build' / build.backend / 'manifest.json'
    safe_directory(build, output)
    output.unlink(missing_ok=True)


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
