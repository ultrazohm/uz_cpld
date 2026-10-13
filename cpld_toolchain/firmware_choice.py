"""Interactive ZIP selection shared by repository and frozen programmer CLIs."""
from datetime import datetime
import json
import re
from pathlib import Path, PurePosixPath, PureWindowsPath
import shutil
import sys
import tempfile

from . import settings, workspace
from .programmer_helper import release
from .toolchain import firmware_download as downloads
from .toolchain.buildsystem.model import BuildError, read_toml


def interactive():
    return sys.stdin.isatty() and sys.stdout.isatty()


def ask(prompt):
    try:
        return input(prompt).strip()
    except EOFError:
        raise BuildError('Selection cancelled') from None


def choose(title, labels):
    print(title)
    for index, label in enumerate(labels, 1):
        print(f'  {index}. {label}')
    while True:
        answer = ask('Select [1], or q to cancel: ')
        if answer.lower() == 'q':
            raise BuildError('Selection cancelled')
        if not answer:
            return 0
        if answer.isdigit() and 1 <= int(answer) <= len(labels):
            return int(answer) - 1
        print('Enter a listed number or q.')


class MissingFirmwareSelection(BuildError):
    """A missing snapshot can be replaced through an explicit interactive choice."""


def selected_firmware(root):
    root = Path(root).resolve()
    path = root / 'firmware.json'
    try:
        data = json.loads(path.read_text(encoding='utf-8'))
        if (not isinstance(data['path'], str) or not isinstance(data['sha256'], str) or
                not re.fullmatch(r'[0-9a-f]{64}', data['sha256'])):
            raise ValueError('invalid path or checksum')
        relative = Path('firmware') / data['sha256'] / downloads.ASSET
        firmware = root / relative
        if data['schema_version'] == 2:
            if data['path'] != relative.as_posix():
                raise ValueError('snapshot path must be relative to this workspace')
        elif data['schema_version'] == 1:
            # Old selections stored native absolute paths. Resolve the same
            # checksum-addressed snapshot under the current container/mount first.
            old = Path(data['path'])
            if not PurePosixPath(data['path']).is_absolute() and not PureWindowsPath(data['path']).is_absolute():
                raise ValueError('legacy selection requires an absolute path')
            if not firmware.exists() and old.is_absolute():
                firmware = old
        else:
            raise ValueError('unsupported selection format')
        _, evidence = release.read_package(firmware)
        if evidence['archive_sha256'] != data['sha256']:
            raise BuildError('Selected firmware changed. Inspect and select it again before programming.')
        return firmware
    except FileNotFoundError:
        raise MissingFirmwareSelection(
            f'Saved firmware is unavailable in workspace {root}. Supply --firmware FILE.zip '
            'or choose a package interactively.') from None
    except (KeyError, TypeError, ValueError) as exc:
        raise BuildError(f'Invalid firmware selection {path}: {exc}') from exc


def select(root, path):
    _, evidence = release.read_package(path)
    workspace.prepare(root)
    destination = root / 'firmware' / evidence['archive_sha256'] / downloads.ASSET
    destination.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='.select-', dir=destination.parent) as temporary:
        staged = Path(temporary) / downloads.ASSET
        shutil.copyfile(path, staged)
        _, snapshot = release.read_package(staged)
        if snapshot['archive_sha256'] != evidence['archive_sha256']:
            raise BuildError('Firmware changed while selecting; previous selection preserved.')
        staged.replace(destination)
    settings.atomic_json(root / 'firmware.json', dict(schema_version=2, path=destination.relative_to(root).as_posix(),
                         source=str(path), sha256=evidence['archive_sha256']))
    return destination


def source(root, standalone=False):
    if standalone or not (root / 'programs/releases.toml').is_file():
        return 'ultrazohm/uz_cpld', 'refs/heads/master'
    return downloads.source(root)


def candidates(root):
    result = []
    for path in sorted((root / 'build/downloads').glob('*/' + downloads.ASSET)):
        try:
            manifest, evidence = release.read_package(path)
            info = {}
            receipt = path.with_name(path.name + '.json')
            if receipt.exists():
                info = json.loads(receipt.read_text(encoding='utf-8'))
                if (info['schema_version'] != 1 or
                        type(info['release_id']) is not int or
                        not isinstance(info['repository'], str) or not isinstance(info['ref'], str) or
                        info['sha256'] != evidence['archive_sha256'] or
                        info['git_revision'] != manifest['git_revision']):
                    raise ValueError('download receipt differs from firmware')
                stamp = datetime.fromisoformat(info['published_at'].replace('Z', '+00:00'))
                if stamp.tzinfo is None:
                    raise ValueError('publication time needs a timezone')
                info['timestamp'] = stamp.timestamp()
            label = (f'{path.parent.name} — {info.get("published_at", "publication date unknown")} — '
                     f'{info.get("repository", "unknown repository")} {info.get("ref", "")} — '
                     f'{manifest["git_revision"][:8]}')
            result.append((path, info, label))
        except (BuildError, OSError, ValueError, KeyError, TypeError, AttributeError) as exc:
            print(f'Skipping {path}: {exc}', file=sys.stderr)
    return sorted(result, key=lambda row: (row[1].get('timestamp', float('-inf')),
                                           row[1].get('release_id', 0)), reverse=True)


def resolve(root, value=None, *, included=None, standalone=False, prompt=True):
    if value and str(value) != 'latest-downloaded':
        return Path(value).expanduser().absolute()
    if not value and (root / 'firmware.json').exists():
        try:
            path = selected_firmware(root)
        except MissingFirmwareSelection as exc:
            if not prompt or not interactive():
                raise
            print(str(exc))
        else:
            print(f'Using selected firmware: {path}')
            return path
    if value:
        repository, ref = source(root, standalone)
        matches = [row for row in candidates(root)
                   if row[1].get('repository') == repository and row[1].get('ref') == ref]
        if not matches:
            raise BuildError(f'No recorded download for {repository} {ref}; run firmware_download or supply --firmware FILE.zip')
        print(f'Using latest downloaded firmware: {matches[0][2]}')
        return matches[0][0]
    if not prompt or not interactive():
        raise BuildError('No firmware selected. Supply --firmware FILE.zip, use --firmware latest-downloaded, '
                         'or run program in an interactive terminal to choose a package.')
    rows = candidates(root)
    try:
        repository, ref = source(root, standalone)
        rows.sort(key=lambda row: (row[1].get('repository') == repository and row[1].get('ref') == ref), reverse=True)
    except BuildError:
        pass  # Local packages remain usable with detached or unavailable Git metadata.
    paths = [row[0] for row in rows]
    labels = [row[2] for row in rows]
    if included and included.is_file():
        manifest, _ = release.read_package(included)
        paths.append(included)
        labels.append(f'Included firmware — {manifest["git_revision"][:8]}')
    index = choose('Choose firmware package:', labels + ['Download newest published firmware…', 'Enter ZIP path…'])
    if index < len(paths):
        path = paths[index]
    elif index == len(paths):
        repository, ref = source(root, standalone)
        branch = ask(f'Branch [{ref.removeprefix("refs/heads/")}]: ') or ref
        path = downloads.download(root, git_url='https://github.com/' + repository, branch=branch)
    else:
        path = Path(ask('Firmware ZIP path: ')).expanduser().resolve()
    return select(root, path)


def guide_program(root, options, *, selection_base=None, confirm=False, selection_mode=None):
    """Fill absent/obsolete assignments from the package; keep valid selections."""
    options = dict(options)
    if options.get('dry_run') == '1' or not interactive():
        return options
    if options.get('source', 'zip' if 'firmware' in options else 'local') == 'zip':
        manifest, _ = release.read_package(options['firmware'])
    else:
        from .toolchain.buildsystem.model import catalog, program_targets, release_cycles
        cycles = release_cycles(root)
        manifest = dict(release_cycles=cycles, builds=[
            dict(release_cycle=cycle, program=name, target=target)
            for cycle in cycles for name in catalog(root, cycle)
            for target in program_targets(root, name, cycle)])
    target = options['target']
    keys = ['s3c_program'] if target == 's3c' else [f'dslot{i}' for i in range(1, 6)]
    direct = any(key in options for key in keys)
    if direct and not confirm:
        return options
    selection = {}
    selection_path = Path(options.get('selection', str((selection_base or root) / 'selection.toml'))).expanduser()
    if not direct and selection_mode != 'manual' and selection_path.exists():
        selection = read_toml(selection_path)  # Malformed files remain errors, not silent replacements.
    if (not isinstance(selection, dict) or set(selection) - {'slots', 's3c', 'release', 'build_backend'} or
            not isinstance(selection.get('slots', {}), dict) or
            set(selection.get('slots', {})) - {'1', '2', '3', '4', '5'}):
        raise BuildError(f'Invalid selection file: {selection_path}')
    cycle = options.get('release_cycle') or selection.get('release')
    if not cycle and (root / 'programs/releases.toml').exists():
        cycle = read_toml(root / 'programs/releases.toml').get('current')
    cycles = sorted(manifest['release_cycles'])
    if not cycles:
        raise BuildError('No release cycles are available')
    if confirm and selection_mode != 'file' and not options.get('release_cycle'):
        ordered = sorted(cycles, key=lambda name: name != cycle)
        cycle = ordered[choose('Choose release cycle:', ordered)]
    if cycle not in cycles:
        if options.get('release_cycle') or (selection_mode == 'file' and len(cycles) != 1):
            raise BuildError(f'Firmware source has no release cycle {cycle}')
        cycle = cycles[0] if len(cycles) == 1 else cycles[choose('Choose release cycle / S3C family:', cycles)]
    options['release_cycle'] = cycle
    names = sorted(entry['program'] for entry in manifest['builds']
                   if entry['release_cycle'] == cycle and entry['target'] == f'uz_{target}_xo2')
    if not names:
        raise BuildError(f'Firmware source has no {target} programs in {cycle}')
    guided = False
    for i, key in enumerate(keys, 1):
        current = options.get(key) if direct else (selection.get('s3c') if target == 's3c'
                                                   else selection.get('slots', {}).get(str(i)))
        if confirm and not direct and selection_mode != 'file':
            ordered = sorted(names, key=lambda name: name != current)
            label = 'S3C' if target == 's3c' else f'D-slot {i}'
            current = ordered[choose(f'Choose program for {label} ({cycle}):', ordered)]
            guided = True
        if current not in names:
            if direct:
                raise BuildError(f'Firmware source has no {cycle}/{current} on {target}')
            label = 'S3C' if target == 's3c' else f'D-slot {i}'
            current = names[choose(f'Choose program for {label} ({cycle}):', names)]
            guided = True
        options[key] = current
    options.pop('selection', None)
    if guided or confirm:
        print(f'Programming {target} from {cycle}: ' + ', '.join(options[key] for key in keys))
        print('Assignments apply to this invocation; selection.toml is unchanged.')
        if choose('Continue with erase, program and verify?', ['Cancel', 'Program']) == 0:
            raise BuildError('Programming cancelled')
    return options


def guide_init(root, options, *, selection_base=None, standalone=False, included=None):
    """Choose a complete selection before the writer creates or replaces it."""
    options = dict(options)
    fields = {'release', 's3c', *(f'dslot_{i}' for i in range(1, 6))}
    destination = Path(options.get('selection', str((selection_base or root) / 'selection.toml'))).expanduser()
    if (fields.intersection(options) or options.get('dry_run') == '1' or not interactive()
            or destination.exists() and options.get('override') != '1'):
        return options
    from .toolchain.buildsystem.model import catalog, program_targets, release_cycles
    if standalone or (root / 'firmware.json').exists() or not (root / 'programs/releases.toml').exists():
        firmware = resolve(root, included=included, standalone=standalone)
        manifest, _ = release.read_package(firmware)
        cycles = sorted(manifest['release_cycles'])
        entries = manifest['builds']
        print(f'Choose assignments from firmware: {firmware}')
    else:
        cycles = release_cycles(root)
        entries = [dict(release_cycle=cycle, program=name, target=target)
                   for cycle in cycles for name in catalog(root, cycle)
                   for target in program_targets(root, name, cycle)]
        print('Choose assignments from the local release catalogs.')
    if not cycles:
        raise BuildError('No release cycles are available')
    cycle = cycles[choose('Choose release cycle:', cycles)]
    s3c = sorted({entry['program'] for entry in entries
                  if entry['release_cycle'] == cycle and entry['target'] == 'uz_s3c_xo2'})
    slots = sorted({entry['program'] for entry in entries
                   if entry['release_cycle'] == cycle and entry['target'] == 'uz_dslot_xo2'})
    if not s3c or not slots:
        raise BuildError(f'{cycle} must contain both S3C and D-slot programs to initialize all assignments')
    options['release'] = cycle
    options['s3c'] = s3c[choose('Choose S3C program:', s3c)]
    for i in range(1, 6):
        options[f'dslot_{i}'] = slots[choose(f'Choose D{i} program (JTAG position {i}):', slots)]
    print(f'Save to {destination}: release={cycle}, S3C={options["s3c"]}, ' +
          ', '.join(f'D{i}={options[f"dslot_{i}"]}' for i in range(1, 6)))
    print('This saves a selection file only; no hardware is accessed.')
    return options


def start_program(options, *, selection_base=None, standalone=False):
    """Choose assignment mode first, then target and firmware source."""
    options = dict(options)
    if options.get('target'):
        return options, None
    if options.get('dry_run') == '1' or not interactive():
        raise BuildError('program requires --target dslot|s3c; run in a terminal for guided programming')
    path = Path(options.get('selection', str((selection_base or Path.cwd()) / 'selection.toml'))).expanduser()
    mode = ['manual', 'file'][choose('How would you like to select programs?',
                                    ['Manual selection', f'Use selection.toml ({path})'])]
    if mode == 'file' and not path.is_file():
        raise BuildError(f'{path} is missing; run init_programmer or choose manual selection')
    options['target'] = ['dslot', 's3c'][choose('What would you like to program?', ['D1–D5 chain', 'S3C'])]
    options.pop('selection', None)
    if mode == 'file':
        from .programmer_helper.helper import read_selection
        slots, s3c, cycle, _ = read_selection(path, 's3c' if options['target'] == 's3c' else 'dslots')
        for key in ('release', 'release_cycle', 's3c_program', *(f'dslot{i}' for i in range(1, 6))):
            options.pop(key, None)
        if cycle:
            options['release_cycle'] = cycle
        if options['target'] == 's3c':
            options['s3c_program'] = s3c
        else:
            options.update({f'dslot{i}': name for i, name in slots.items()})
        print(f'Using release and assignments from {path}')
    if standalone:
        # The frozen application supports ZIP firmware only. Still make its
        # source explicit at the same point in the guided flow.
        choose('Choose firmware source:', ['Published firmware ZIP'])
        options['source'] = 'zip'
    elif 'source' not in options:
        options['source'] = ['zip', 'local'][choose('Choose firmware source:', ['Published firmware ZIP', 'Local builds'])]
    return options, mode
