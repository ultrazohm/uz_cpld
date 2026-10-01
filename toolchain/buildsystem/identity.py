"""Tracked program numbers and collision-checked, input-specific USERCODEs."""
from contextlib import contextmanager
from toolchain.locking import directory_lock
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile

from .model import BuildError, identifier, release_cycles

REGISTRY = 'programs/usercodes.json'
LIMIT = 0xFFFF


def _object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise BuildError(f'Duplicate identity registry key: {key}')
        result[key] = value
    return result


def read_registry(root):
    path = Path(root) / REGISTRY
    if path.is_symlink() or path.parent.is_symlink():
        raise BuildError('USERCODE registry must not be a symlink')
    try:
        data = json.loads(path.read_text(), object_pairs_hook=_object)
        if data['schema_version'] != 1 or not isinstance(data['programs'], dict):
            raise ValueError('unsupported schema')
        numbers = set()
        for name, entry in data['programs'].items():
            cycle, program = name.split('/')
            identifier(cycle); identifier(program)
            number = entry['number']
            if type(number) is not int or not 1 <= number <= LIMIT or number in numbers:
                raise ValueError(f'duplicate or invalid program number for {name}')
            numbers.add(number)
            revisions, fingerprints = set(), set()
            for revision, build in entry['builds'].items():
                if not re.fullmatch(r'[1-9][0-9]*', revision) or not 1 <= int(revision) <= LIMIT:
                    raise ValueError(f'invalid revision for {name}')
                fingerprint = build['fingerprint']
                if not re.fullmatch(r'[0-9a-f]{64}', fingerprint) or fingerprint in fingerprints:
                    raise ValueError(f'duplicate or invalid build fingerprint for {name}')
                identifier(build['target'])
                if build['backend'] not in ('diamond', 'foss'):
                    raise ValueError('invalid backend')
                if not isinstance(build['artifacts'], list):
                    raise ValueError('invalid artifact history')
                revisions.add(int(revision)); fingerprints.add(fingerprint)
            if type(entry['next_revision']) is not int or not max(revisions, default=0) < entry['next_revision'] <= LIMIT + 1:
                raise ValueError(f'invalid revision counter for {name}')
        if type(data['next_program']) is not int or not max(numbers, default=0) < data['next_program'] <= LIMIT + 1:
            raise ValueError('invalid program counter')
        return data
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as exc:
        raise BuildError(f'{path}: invalid or missing USERCODE registry: {exc}. Restore/merge the tracked registry; never reset its counters.') from exc


@contextmanager
def _transaction(root):
    """Serialize short registry transactions on a stable directory inode."""
    base = Path(root) / 'programs'
    with directory_lock(base, blocking=True):
        data = read_registry(root)
        before = json.dumps(data, sort_keys=True)
        yield data
        if json.dumps(data, sort_keys=True) != before:
            handle, temporary = tempfile.mkstemp(prefix='.usercodes-', dir=base)
            try:
                with os.fdopen(handle, 'w') as stream:
                    stream.write(json.dumps(data, indent=2, sort_keys=True) + '\n')
                    stream.flush()
                    os.fsync(stream.fileno())
                os.chmod(temporary, 0o644)
                os.replace(temporary, Path(root) / REGISTRY)
            finally:
                if os.path.exists(temporary):
                    os.unlink(temporary)


def _reserve(data, qualified):
    cycle, name = qualified.split('/')
    identifier(cycle); identifier(name)
    if qualified not in data['programs']:
        number = data['next_program']
        if number > LIMIT:
            raise BuildError('Program number space exhausted; numbers are never reused')
        data['programs'][qualified] = {'number': number, 'next_revision': 1, 'builds': {}}
        data['next_program'] += 1
    return data['programs'][qualified]


def reserve_program(root, name, cycle):
    with _transaction(root) as data:
        return _reserve(data, f'{cycle}/{name}')['number']


def assign_programs(root):
    """Include uncatalogued manifests and unfinished generator starters."""
    from .workflow import workspace_lock
    root = Path(root).resolve()
    with workspace_lock(root, exclusive=True), _transaction(root) as data:
        for cycle in release_cycles(root):
            for directory in sorted((root / 'programs' / cycle).iterdir()):
                if directory.is_dir() and ((directory / f'{directory.name}.toml').is_file() or
                                           (directory / 'generator.toml').is_file()):
                    if directory.is_symlink():
                        raise BuildError(f'Program directory must not be a symlink: {directory}')
                    _reserve(data, f'{cycle}/{directory.name}')


def fingerprint(build):
    from .workflow import hashes
    value = {'program': build.qualified_name, 'target': build.target,
             'backend': build.backend, 'inputs': hashes(build)}
    return hashlib.sha256(json.dumps(value, sort_keys=True).encode()).hexdigest()


def reserve_build(build):
    source_hash = fingerprint(build)
    with _transaction(build.root) as data:
        entry = _reserve(data, build.qualified_name)
        revision = next((int(r) for r, b in entry['builds'].items() if b['fingerprint'] == source_hash), None)
        if revision is None:
            revision = entry['next_revision']
            if revision > LIMIT:
                raise BuildError(f'{build.qualified_name}: build revision space exhausted')
            entry['next_revision'] += 1
            entry['builds'][str(revision)] = {'fingerprint': source_hash, 'target': build.target,
                                             'backend': build.backend, 'artifacts': []}
        return {'program': build.qualified_name, 'program_number': entry['number'], 'revision': revision,
                'usercode': f'{(entry["number"] << 16) | revision:08X}', 'fingerprint': source_hash}


def resolve_usercode(root, usercode):
    number, revision = usercode >> 16, usercode & LIMIT
    for name, entry in read_registry(root)['programs'].items():
        if entry['number'] == number:
            build = entry['builds'].get(str(revision))
            return {'program': name, 'program_number': number, 'revision': revision,
                    'known_build': build is not None, 'build': build}
    return None


def validate_identity(build, identity):
    if not isinstance(identity, dict):
        raise BuildError('Firmware has no registered identity; rebuild it')
    if (set(identity) != {'program', 'program_number', 'revision', 'usercode', 'fingerprint'} or
            not isinstance(identity['usercode'], str) or not re.fullmatch(r'[0-9A-F]{8}', identity['usercode'])):
        raise BuildError('Malformed firmware identity; rebuild it')
    resolved = resolve_usercode(build.root, int(identity['usercode'], 16))
    if (not resolved or resolved['program'] != build.qualified_name or not resolved['known_build'] or
            resolved['build']['fingerprint'] != fingerprint(build) or
            identity != dict(program=build.qualified_name, program_number=resolved['program_number'],
                             revision=resolved['revision'], usercode=f'{int(identity["usercode"], 16):08X}',
                             fingerprint=resolved['build']['fingerprint'])):
        raise BuildError('Firmware identity does not match the registry and current build inputs')
    return identity


def record_artifacts(build, record):
    identity = validate_identity(build, record['identity'])
    artifact = {'completed_at': record['completed_at'], 'git_revision': record['git_revision'],
                'firmware_sha256': {ext: record['outputs'][build.firmware_path(ext).name]
                                    for ext in (('jed', 'bit') if build.backend == 'diamond' else ('bit',))}}
    with _transaction(build.root) as data:
        entry = data['programs'][build.qualified_name]
        if entry['number'] != identity['program_number'] or entry['builds'][str(identity['revision'])]['fingerprint'] != identity['fingerprint']:
            raise BuildError('Registry changed during artifact publication')
        history = entry['builds'][str(identity['revision'])]['artifacts']
        if not any(item['firmware_sha256'] == artifact['firmware_sha256'] for item in history):
            history.append(artifact)


def constraint_text(build, identity):
    """The registry owns USERCODE; historical LPF values are explicitly replaced."""
    text = build.constraint.read_text()
    text = re.sub(r'(?im)\bUSERCODE\s+(?:HEX|BIN|ASCII)\s+"[^"\r\n]*"\s*;', '', text)
    return text.rstrip() + f'\n\n# Assigned by programs/usercodes.json; do not edit this generated LPF.\nUSERCODE HEX "{identity["usercode"]}";\n'
