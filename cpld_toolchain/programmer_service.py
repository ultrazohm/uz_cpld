"""Structured, noninteractive operations for the optional programmer window.

No GUI imports here. Each request runs in an isolated process and retains the
managed programmer's validation, USB locks, immutable snapshots and readback.
"""
import json
from pathlib import Path
import sys
import tempfile

from . import settings, workspace
from .toolchain.buildsystem.model import BuildError, read_toml


def catalog(path):
    from .programmer_helper.release import read_package
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


def scan(root, chain, backend, serial=None):
    from .programmer_helper import program as p
    from .programmer_helper.usb import diamond_usb
    directory = Path(tempfile.mkdtemp(prefix='scan-', dir=root / 'build/programmer/gui'))
    if backend == 'foss':
        from .programmer_helper.foss import run
        from .programmer_helper.identify import programming_preflight
        programming_preflight(backend, None, serial, None)
        p.require_usb_bus()
        with diamond_usb(p.DEFAULT_DIAMOND_PORT, serial=serial):
            raw = run(p.scan_command(chain, None, serial), directory / 'scan.log')
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
        from .programmer_helper.diamond import command
        from .programmer_helper.identify import parse_diamond
        p.require_usb_bus()
        if chain is None:
            from .programmer_helper.identify import detect_chain
            chain = detect_chain(root, backend, None, serial, None, directory)
        xcf = directory / 'scan.xcf'
        p.diamond_scan_xcf(root, chain, xcf)
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


def operate(request):
    root = Path(request['workspace']).resolve()
    workspace.prepare(root)
    (root / 'build/programmer/gui').mkdir(parents=True, exist_ok=True)
    action = request['action']
    with workspace.use(root):
        if action == 'load':
            from .firmware_choice import selected_firmware, MissingFirmwareSelection
            from .standalone import included_firmware
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
            from .firmware_choice import select
            path = select(root, Path(request['firmware']))
            return dict(message='Firmware selected.', firmware=str(path), **catalog(path))
        if action == 'releases':
            from .toolchain.firmware_download import available
            versions = available('ultrazohm/uz_cpld')
            return dict(message=f'{len(versions)} published firmware releases available.' if versions else
                        'No compatible published firmware releases are available.', releases=versions)
        if action == 'download':
            from .toolchain.firmware_download import download_release
            from .firmware_choice import select
            path = select(root, download_release(root, 'ultrazohm/uz_cpld', request['release_id'],
                                                expected_commit=request['release_commit']))
            return dict(message='Firmware downloaded and selected.', firmware=str(path), **catalog(path))
        if action == 'drivers':
            from .driver_setup import setup
            states = []
            setup('setup_foss_drivers' if request['backend'] == 'foss' else 'setup_diamond_driver',
                  device_id=request.get('device_id') or None, report=states.append)
            state = states[-1]
            message = ('Driver installed. Restart Windows before scanning or programming.' if state['restart_required'] else
                       'Driver already configured. Scan to check readiness.' if state['already_bound'] else
                       'Driver configured. Scan to check readiness.')
            return dict(message=message, driver=state)
        target = request.get('target')
        if target not in (None, 's3c', 'dslot') or request.get('backend', 'foss') not in ('foss', 'diamond'):
            raise BuildError('Invalid target or programmer backend.')
        backend = request.get('backend', 'foss')
        serial = request.get('serial') or None
        if backend == 'diamond' and serial:
            raise BuildError('USB serial selection is supported by the FOSS backend only.')
        chain = {'s3c': 's3c', 'dslot': 'dslots'}.get(target)
        if action == 'scan':
            return scan(root, chain, backend, serial)
        if action == 'identify' and not request.get('firmware'):
            from .programmer_helper.identify import identify
            return dict(message='Firmware identities read. Select a firmware package to resolve unknown programs.',
                        devices=identify(root, chain, backend, serial=serial))
        if action == 'program' and target is None:
            raise BuildError('Choose Program S3C or Program D-slots.')
        firmware = Path(request['firmware'])
        info = catalog(firmware)  # Revalidate on every operation, before USB.
        if request.get('expected_sha256') and info['sha256'] != request['expected_sha256']:
            raise BuildError('Firmware changed after it was displayed. Choose and review the package again before continuing.')
        if action == 'identify':
            from .programmer_helper.identify import identify
            return dict(message='Firmware identities read.',
                        devices=identify(root, chain, backend, serial=serial, firmware=firmware))
        selection = request['selection']
        validate_assignments(info, selection, None if action == 'save' else target)
        if action == 'save':
            from .programmer_helper.program import create_selection
            destination = root / 'selection.toml'
            if destination.exists() and not request.get('override'):
                raise BuildError('selection.toml already exists. Confirm replacement before saving.')
            from .firmware_choice import select
            select(root, firmware)
            create_selection(destination, release=selection['release'], s3c=selection['s3c'],
                             slots={int(k): v for k, v in selection['slots'].items()},
                             override=request.get('override', False))
            return dict(message='Assignments saved to selection.toml.')
        if action == 'program':
            from .programmer_helper.program import plan, execute
            cycle, output, builds, steps = plan(root, selection, selection['release'], chain,
                                                backend, None, serial, source='zip', firmware=firmware)
            directory = execute(root, cycle, chain, backend, output, builds, steps, None, serial)
            record = json.loads((directory / 'result.json').read_text())
            return dict(message='Flash programmed, verified and identity readback confirmed.',
                        devices=record.get('devices', []), record=str(directory / 'result.json'))
        raise BuildError(f'Unknown programmer operation: {action}')


def worker(request_path, result_path):
    """Logs go to the worker's redirected output; only JSON crosses into the UI."""
    try:
        result = dict(ok=True, **operate(json.loads(Path(request_path).read_text())))
    except Exception as exc:
        import traceback
        traceback.print_exc()
        result = dict(ok=False, message=str(exc))
    settings.atomic_json(Path(result_path), result)
    return 0 if result['ok'] else 2


if __name__ == '__main__':
    raise SystemExit(worker(*sys.argv[1:]))
