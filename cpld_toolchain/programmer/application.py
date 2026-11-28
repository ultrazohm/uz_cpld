"""Shared application operations for Python, CLI and GUI clients."""
import json
from pathlib import Path
import sys
import tempfile

from .. import workspace
from ..toolchain.buildsystem.model import BuildError, read_toml


def catalog(path):
    from ..programmer_helper.release import read_package
    manifest, evidence = read_package(Path(path))
    cycles = {}
    for entry in manifest['builds']:
        targets = cycles.setdefault(entry['release_cycle'], {'s3c': [], 'dslot': []})
        target = {'uz_s3c_xo2': 's3c', 'uz_dslot_xo2': 'dslot'}.get(entry['target'])
        if target:
            targets[target].append(entry['program'])
    for targets in cycles.values():
        for target, names in targets.items():
            targets[target] = sorted(set(names))
    return dict(cycles=cycles, commit=manifest['git_revision'], sha256=evidence['archive_sha256'])


def validate_assignments(info, selection, target=None):
    cycle = selection.get('release')
    if cycle not in info['cycles']:
        raise BuildError('Choose a release present in the selected firmware package.')
    targets = info['cycles'][cycle]
    if target in (None, 's3c') and selection.get('s3c') not in targets['s3c']:
        raise BuildError('Choose an S3C program from the selected release.')
    if target in (None, 'dslot'):
        for position in range(1, 6):
            if selection.get('slots', {}).get(str(position)) not in targets['dslot']:
                raise BuildError(f'Choose a program for D{position} from the selected release.')


def scan(root, chain, backend, serial=None, cable=None, probe_index=None):
    from ..programmer_helper import program as p
    from ..programmer_helper.usb import diamond_usb
    (root / 'build/programmer/scans').mkdir(parents=True, exist_ok=True)
    directory = Path(tempfile.mkdtemp(prefix='scan-', dir=root / 'build/programmer/scans'))
    if backend == 'foss':
        from ..programmer_helper.foss import run
        if not cable or cable.startswith(('ft2232', 'ft4232')):
            p.require_usb_bus()
        from contextlib import nullcontext
        guard = (diamond_usb(p.DEFAULT_DIAMOND_PORT, serial=serial)
                 if cable in (None, p.DEFAULT_FOSS_CABLE) and probe_index in (None, 0) else nullcontext())
        with guard:
            raw = run(p.scan_command(chain, cable, serial, probe_index), directory / 'scan.log')
        devices = p.parse_scan(raw)
        if chain is None:
            chain = 's3c' if devices == [(0, 0x012BC043)] else 'dslots'
        expected_id = 0x012BC043 if chain == 's3c' else 0x012BB043
        matches = (len(devices) == (1 if chain == 's3c' else 5)
                   and [i for i, _ in devices] == list(range(len(devices)))
                   and all(code == expected_id for _, code in devices))
        rows = [dict(label='S3C' if chain == 's3c' else f'D{i + 1}', idcode=f'{code:08X}')
                for i, code in devices]
    else:
        from ..programmer_helper.diamond import command
        from ..programmer_helper.identify import parse_diamond
        p.require_usb_bus()
        if chain is None:
            from ..programmer_helper.identify import detect_chain
            chain = detect_chain(root, backend, cable, serial, probe_index, directory)
        xcf = directory / 'scan.xcf'
        p.diamond_scan_xcf(root, chain, xcf, probe_index)
        log = directory / 'pgrcmd.log'
        # run_diamond owns the interface lock and driver detachment itself.
        raw = p.run_diamond(command(root, xcf, log), directory / 'stdout.log', xcf)
        codes = parse_diamond(chain, log.read_text(errors='replace') if log.exists() else raw,
                              'FLASH Display ID', 'ID', 8)
        expected = '012BC043' if chain == 's3c' else '012BB043'
        matches = all(code.upper() == expected for code in codes)
        rows = [dict(label='S3C' if chain == 's3c' else f'D{i + 1}', idcode=code.upper())
                for i, code in enumerate(codes)]
    return dict(message='Expected chain detected.' if matches else
                'Unexpected chain. Check the physical JTAG access state and scan again.',
                devices=rows, chain_matches=matches, target='s3c' if chain == 's3c' else 'dslot')


# The existing GUI sends these shared fields on every request. Keep that
# envelope compatible, but reject misspelled or unsupported action options.
_ENVELOPE = {'firmware', 'expected_sha256', 'selection', 'device_id', 'target'}
_OPTIONS = {
    'load': set(), 'select': set(), 'releases': set(),
    'download': {'release_id', 'release_commit'},
    'download_firmware': {'remote', 'output', 'git_url', 'branch', 'stable'},
    'drivers': {'default_driver'}, 'scan': {'target'}, 'identify': {'target'},
    'save': {'destination', 'override'}, 'initialize': {'destination', 'override'},
    'program': {'target', 'release', 'build_backend', 'source'},
    'prepare': {'target', 'release', 'build_backend', 'source'},
    'execute': {'plan_id', 'review_sha256'},
    'build_selection': {'target', 'release', 'build_backend'},
}


def validate_request(action, options):
    if not isinstance(action, str) or action not in _OPTIONS:
        raise BuildError(f'Unknown programmer operation: {action}')
    unknown = set(options) - _ENVELOPE - _OPTIONS[action]
    if unknown:
        raise BuildError(f'Unsupported {action} options: {", ".join(sorted(unknown))}')
    for key in ('override', 'stable', 'default_driver'):
        if key in options and type(options[key]) is not bool:
            raise BuildError(f'{key} must be a JSON boolean')


def _operate(request, *, api=None):
    root = Path(request['workspace']).resolve()
    action = request['action']
    if action not in ('load', 'select', 'releases', 'download', 'download_firmware', 'drivers', 'scan', 'identify',
                       'save', 'initialize', 'program', 'prepare', 'execute', 'build_selection'):
        raise BuildError(f'Unknown programmer operation: {action}')
    from . import Programmer
    api = api or Programmer(root, backend=request.get('backend', 'foss'), serial=request.get('serial') or None,
                     cable=request.get('cable'), probe_index=request.get('probe_index'))
    with workspace.use(root):
        if action == 'load':
            from ..firmware_choice import selected_firmware, MissingFirmwareSelection
            from ..standalone import included_firmware
            path = request.get('firmware')
            if not path:
                if (root / 'firmware.json').exists():
                    try:
                        path = selected_firmware(root)
                    except MissingFirmwareSelection:
                        return dict(message='Saved firmware is missing. Choose another ZIP.', cycles={})
                elif included_firmware().is_file():
                    path = included_firmware()
            selection = root / 'selection.toml'
            return dict(message='Firmware ready.' if path else 'Choose a firmware ZIP to begin.',
                        firmware=str(path) if path else '',
                        selection=read_toml(selection) if selection.exists() else {},
                        **(catalog(path) if path else {'cycles': {}}))
        if action == 'select':
            from ..firmware_choice import select
            path = select(root, Path(request['firmware']))
            return dict(message='Firmware selected.', firmware=str(path), **catalog(path))
        if action == 'releases':
            from ..toolchain.firmware_download import available
            versions = available('ultrazohm/uz_cpld')
            return dict(message=f'{len(versions)} published firmware releases available.' if versions else
                        'No compatible published firmware releases are available.', releases=versions)
        if action == 'download':
            from ..toolchain.firmware_download import download_release
            from ..firmware_choice import select
            path = select(root, download_release(root, 'ultrazohm/uz_cpld', request['release_id'],
                                                expected_commit=request['release_commit']))
            return dict(message='Firmware downloaded and selected.', firmware=str(path), **catalog(path))
        if action == 'drivers':
            from ..driver_setup import setup, setup_default
            if sys.platform != 'win32' and request.get('default_driver'):
                code = setup_default(device_id=request.get('device_id'))
                return dict(message='USB permission rules installed; reconnect the programmer.', code=code)
            states = []
            setup('setup_foss_drivers' if request['backend'] == 'foss' else 'setup_diamond_driver',
                  device_id=request.get('device_id') or None, report=states.append)
            state = states[-1]
            message = ('Driver installed. Restart Windows before scanning or programming.' if state['restart_required'] else
                       'Driver already configured. Scan to check readiness.' if state['already_bound'] else
                       'Driver configured. Scan to check readiness.')
            return dict(message=message, driver=state)
        target = request.get('target')
        if action == 'scan':
            return api.scan(target=target)
        if action == 'identify':
            return dict(message='Firmware identities read.', devices=api.identify(target=target,
                firmware=request.get('firmware') or None, expected_sha256=request.get('expected_sha256')))
        if action == 'execute':
            return api.execute_review(request['plan_id'], request['review_sha256'])
        if action == 'build_selection':
            return api.build_selection(request['selection'], release=request.get('release'),
                                       target=target, backend=request.get('build_backend', 'diamond'))
        if action == 'download_firmware':
            return api.download_firmware(**{key: request[key] for key in
                ('remote', 'output', 'git_url', 'branch', 'stable') if key in request})
        if action == 'initialize':
            return api.initialize_assignments(request.get('selection'), destination=request.get('destination'),
                                               override=request.get('override', False))
        if action == 'save':
            return api.save_assignments(request['selection'], destination=request.get('destination'),
                override=request.get('override', False), firmware=request.get('firmware') or None,
                expected_sha256=request.get('expected_sha256'))
        if action in ('program', 'prepare'):
            firmware = request.get('firmware') or None
            source = request.get('source', 'zip' if firmware else 'local')
            if source not in ('local', 'zip') or (source == 'zip') != (firmware is not None):
                raise BuildError('Use source=local without firmware, or source=zip with firmware=FILE.zip')
            operation = api.prepare_review if action == 'prepare' else api.program
            return operation(request['selection'], target=target, release=request.get('release'),
                firmware=firmware, build_backend=request.get('build_backend'),
                expected_sha256=request.get('expected_sha256'))
        raise BuildError(f'Unknown programmer operation: {action}')
