"""Validate release ZIPs and stage selected firmware without local build records."""
from dataclasses import dataclass
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import shutil
import tempfile
from zipfile import BadZipFile, ZipFile

from cpld_toolchain.toolchain.buildsystem.identity import (
    read_registry, resolve_usercode, validate_registry,
)
from cpld_toolchain.toolchain.buildsystem.model import BuildError, identifier, read_toml
from cpld_toolchain.toolchain.buildsystem.workflow import digest, safe_directory, workspace_lock, write_json
from cpld_toolchain.toolchain.firmware_download import verify_archive
from .helper import jedec_metadata, read_selection

DEVICES = {'uz_dslot_xo2': 'LCMXO2-2000HC-4TG100C',
           'uz_s3c_xo2': 'LCMXO2-4000HC-4TG144C'}


@dataclass(frozen=True)
class ReleasePackage:
    directory: Path
    registry: dict
    evidence: dict
    manifest_sha256: str


@dataclass(frozen=True)
class ReleaseFirmware:
    """A release artifact, deliberately independent of the local Build model."""
    root: Path
    package: ReleasePackage
    release_cycle: str
    name: str
    target: str
    backend: str
    identity: dict
    artifact: Path
    sha256: str

    @property
    def directory(self):
        return self.package.directory

    def firmware_path(self, extension):
        if self.artifact.suffix != '.' + extension:
            raise BuildError(f'Release firmware has no .{extension} artifact')
        return self.artifact

    def verify(self, extension):
        path = safe_directory(self, self.firmware_path(extension))
        manifest = safe_directory(self, self.directory / 'manifest.json')
        if not manifest.is_file() or digest(manifest) != self.package.manifest_sha256:
            raise BuildError('Release manifest snapshot changed since planning')
        if not path.is_file() or digest(path) != self.sha256:
            raise BuildError('Release firmware snapshot changed since planning')
        if extension == 'jed' and jedec_metadata(path)[1] != self.identity['usercode']:
            raise BuildError('Release JEDEC USERCODE differs from its identity')
        return path, self.sha256


def validate_manifest(manifest):
    """Bind every firmware entry to its device, identity, and published history."""
    registry = validate_registry(manifest['identity_registry'])
    if not isinstance(manifest.get('git_revision'), str) or not re.fullmatch(
            r'[0-9a-fA-F]{40}', manifest['git_revision']):
        raise BuildError('Release manifest requires a Git commit')
    indexed = {}
    for entry in manifest['builds']:
        cycle, name, target = (identifier(entry[key]) for key in ('release_cycle', 'program', 'target'))
        key = cycle, name, target
        if key in indexed:
            raise BuildError(f'Duplicate release firmware entry: {key}')
        if target not in DEVICES or entry['device'] != DEVICES[target]:
            raise BuildError(f'Release firmware has an incompatible device: {key}')
        identity = entry['identity']
        if not isinstance(identity, dict) or not isinstance(identity.get('usercode'), str) or not re.fullmatch(
                r'[0-9A-F]{8}', identity['usercode']):
            raise BuildError(f'Malformed release firmware identity: {key}')
        resolved = resolve_usercode(None, int(identity['usercode'], 16), registry=registry)
        if (not resolved or resolved['program'] != f'{cycle}/{name}' or not resolved['known_build'] or
                resolved['build']['target'] != target or resolved['build']['backend'] != manifest['backend'] or
                identity != dict(program=resolved['program'], program_number=resolved['program_number'],
                                 revision=resolved['revision'], usercode=identity['usercode'],
                                 fingerprint=resolved['build']['fingerprint'])):
            raise BuildError(f'Release identity does not match its registry: {key}')
        files = entry['files']
        extensions = {PurePosixPath(path).suffix for path in files}
        required = {'.jed', '.bit'} if manifest['backend'] == 'diamond' else {'.bit'}
        if extensions != required or len(files) != len(required):
            raise BuildError(f'Release firmware must contain exactly {sorted(required)}: {key}')
        if any(PurePosixPath(path).parent.as_posix() != '/'.join(key) for path in files):
            raise BuildError(f'Release firmware path does not match its program and target: {key}')
        provenance = entry['provenance']
        expected = dict(program=name, release_cycle=cycle, target=target,
                        device=DEVICES[target], backend=manifest['backend'])
        if (provenance.get('status') != 'success' or provenance.get('identity') != identity or
                provenance.get('git_revision') != manifest['git_revision'] or
                any(provenance.get(field) != value for field, value in expected.items()) or
                any(provenance.get('outputs', {}).get(PurePosixPath(path).name) != checksum
                    for path, checksum in files.items())):
            raise BuildError(f'Release provenance does not match its firmware: {key}')
        inputs = provenance['inputs']
        if not isinstance(inputs, dict) or not inputs or any(
                not isinstance(value, str) or not re.fullmatch(r'[0-9a-f]{64}', value) for value in inputs.values()):
            raise BuildError(f'Release provenance has invalid input hashes: {key}')
        fingerprint = {'program': identity['program'], 'target': target, 'backend': manifest['backend'],
                       'inputs': provenance['inputs']}
        if hashlib.sha256(json.dumps(fingerprint, sort_keys=True).encode()).hexdigest() != identity['fingerprint']:
            raise BuildError(f'Release provenance does not match its identity fingerprint: {key}')
        checksums = {PurePosixPath(path).suffix[1:]: checksum for path, checksum in files.items()}
        if not any(item.get('firmware_sha256') == checksums for item in resolved['build']['artifacts']):
            raise BuildError(f'Release firmware is absent from its identity artifact history: {key}')
        indexed[key] = entry
    cycles = manifest.get('release_cycles')
    if not isinstance(cycles, list) or sorted(cycles) != sorted({key[0] for key in indexed}):
        raise BuildError('Release manifest has inconsistent release cycles')
    return indexed


def registry_conflicts(root, selected):
    """Report conflicting local labels, without changing or requiring a local registry."""
    if not (root / 'programs/usercodes.json').exists():
        return []
    try:
        local = read_registry(root)
    except BuildError as exc:
        return [f'Local registry cannot be compared: {exc}']
    conflicts = set()
    for entry in selected:
        identity = entry['identity']
        resolved = resolve_usercode(root, int(identity['usercode'], 16), registry=local)
        local_program = local['programs'].get(identity['program'])
        if ((local_program and local_program['number'] != identity['program_number']) or
                (resolved and (resolved['program'] != identity['program'] or
                 (resolved['known_build'] and (resolved['build']['fingerprint'] != identity['fingerprint'] or
                  resolved['build']['target'] != entry['target'] or
                  resolved['build']['backend'] != entry['provenance']['backend']))))):
            conflicts.add(f"Local registry conflicts with release identity {identity['program']} "
                          f"USERCODE 0x{identity['usercode']}; using the ZIP registry for this run")
    return sorted(conflicts)


def stage(root, selection, cycle_name, chain, programmer_backend, firmware, build_backend=None):
    """Validate first, then extract only selected artifacts to a private directory."""
    root = Path(root).resolve()
    path = Path(firmware).absolute()
    slots, s3c, selection_cycle, _ = read_selection(selection, chain)
    output = None
    try:
        with workspace_lock(root), path.open('rb') as stream:
            checksum = hashlib.sha256()
            for block in iter(lambda: stream.read(1024 * 1024), b''):
                checksum.update(block)
            stream.seek(0)
            with ZipFile(stream) as archive:
                manifest = verify_archive(archive)
                indexed = validate_manifest(manifest)
                backend = manifest['backend']
                if build_backend is not None and backend != build_backend:
                    raise BuildError('build_backend does not match the ZIP manifest')
                if programmer_backend == 'diamond' and backend != 'diamond':
                    raise BuildError('Diamond programming requires Diamond JEDEC firmware')
                cycle = cycle_name or selection_cycle
                if cycle is None:
                    defaults = root / 'programs/releases.toml'
                    if defaults.is_file():
                        cycle = read_toml(defaults).get('current')
                    elif len(manifest['release_cycles']) == 1:
                        cycle = manifest['release_cycles'][0]
                    else:
                        raise BuildError('Select a release_cycle from the ZIP or set release in selection.toml')
                cycle = identifier(cycle)
                target = 'uz_s3c_xo2' if chain == 's3c' else 'uz_dslot_xo2'
                assignments = [('s3c', 0, s3c)] if chain == 's3c' else [
                    (f'slot{i}', i - 1, slots[i]) for i in range(1, 6)]
                selected = []
                for label, index, name in assignments:
                    entry = indexed.get((cycle, name, target))
                    if entry is None:
                        raise BuildError(f'ZIP has no firmware for {cycle}/{name} on {target}')
                    selected.append((label, index, entry))
                conflicts = registry_conflicts(root, [entry for _, _, entry in selected])
                for warning in conflicts:
                    print(f'Warning: {warning}')
                base = root / 'build/programmer/packages'
                for parent in (base, *base.parents):
                    if parent == root:
                        break
                    if parent.is_symlink():
                        raise BuildError(f'Generated path is a symlink: {parent}')
                base.mkdir(parents=True, exist_ok=True)
                output = Path(tempfile.mkdtemp(prefix='package-', dir=base))
                manifest_path = output / 'manifest.json'
                write_json(manifest_path, manifest)
                evidence = {'source': 'zip', 'archive': str(path), 'archive_sha256': checksum.hexdigest(),
                            'git_revision': manifest['git_revision'], 'registry_conflicts': conflicts}
                package = ReleasePackage(output, manifest['identity_registry'], evidence, digest(manifest_path))
                builds = []
                extension = 'jed' if backend == 'diamond' else 'bit'
                for label, index, entry in selected:
                    member = next(name for name in entry['files'] if name.endswith('.' + extension))
                    destination = output / f'{label}.{extension}'
                    with archive.open(member) as source, destination.open('xb') as sink:
                        shutil.copyfileobj(source, sink)
                    build = ReleaseFirmware(root, package, cycle, entry['program'], target, backend,
                                            entry['identity'], destination, entry['files'][member])
                    build.verify(extension)
                    builds.append((label, index, build))
                stream.seek(0)
                final_checksum = hashlib.sha256()
                for block in iter(lambda: stream.read(1024 * 1024), b''):
                    final_checksum.update(block)
                if final_checksum.hexdigest() != checksum.hexdigest():
                    raise BuildError('Firmware ZIP changed while staging')
                write_json(output / 'selection.json', dict(evidence, release_cycle=cycle,
                           programs={label: build.name for label, _, build in builds}))
                return cycle, output, builds
    except BaseException as exc:
        if output is not None:
            shutil.rmtree(output)
        if isinstance(exc, (BadZipFile, KeyError, TypeError, AttributeError, ValueError, RuntimeError)):
            raise BuildError(f'Invalid firmware ZIP: {exc}') from exc
        raise
