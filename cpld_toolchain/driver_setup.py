"""Explicit Windows driver setup commands shared by repository and standalone CLI."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from . import external, tools, repository_root
from .toolchain.buildsystem.model import BuildError

CAPABILITY = 'uz-cpld-driver-helper 1'
ACTIONS = ('setup_foss_drivers', 'setup_diamond_driver')


def verify(binary):
    record = json.loads(binary.with_name('driver-helper.json').read_text(encoding='utf-8'))
    pin = json.loads(Path(__file__).with_name('windows_driver_pin.json').read_text(encoding='utf-8'))
    if not isinstance(record, dict):
        raise ValueError('Invalid driver helper receipt')
    if record.get('schema_version') != 1 or record.get('pin') != pin or record.get('linkage') != 'static':
        raise ValueError('Driver helper provenance does not match this application')
    files = record.get('files', {})
    if not isinstance(files, dict) or binary.name not in files:
        raise ValueError('Driver helper receipt omits its executable')
    for name, wanted in files.items():
        if not isinstance(name, str) or not isinstance(wanted, str):
            raise ValueError('Invalid driver helper checksum entry')
        relative = Path(name)
        if relative.is_absolute() or '..' in relative.parts or ':' in name or '\\' in name:
            raise ValueError('Invalid driver helper receipt path')
        path = binary.parent / relative
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != wanted:
            raise ValueError(f'Driver helper checksum mismatch: {name}')
    return record


def helper_path():
    explicit = os.environ.get('CPLD_DRIVER_HELPER')
    candidates = [Path(explicit)] if explicit else [
        tools.bundled_directory() / 'windows-drivers/uz-cpld-driver-helper.exe',
        repository_root() / 'build/windows-drivers/uz-cpld-driver-helper.exe']
    binary = next((path.resolve() for path in candidates if path.is_file()), None)
    if binary is None:
        raise BuildError('Bundled Windows driver helper is missing. Use a current Windows standalone download. '
                         'Repository users can place the windows-drivers CI artifact in build/windows-drivers, '
                         'or set CPLD_DRIVER_HELPER to the helper inside that download.')
    try:
        verify(binary)
    except (OSError, ValueError) as exc:
        raise BuildError(f'Driver helper verification failed: {exc}') from exc
    return binary


def invoke(binary, *args, capture=True):
    argv = [str(binary), *args]
    try:
        with external.system_libraries():
            if capture:
                return subprocess.run(argv, env=external.environment(), stdin=subprocess.DEVNULL,
                                      capture_output=True, text=True, encoding='utf-8', errors='replace', timeout=30)
            # An elevated helper can outlive its unelevated parent. Do not kill the
            # parent or release the programmer lock while installation is running.
            with subprocess.Popen(argv, env=external.environment()) as process:
                while True:
                    try:
                        return subprocess.CompletedProcess(argv, process.wait())
                    except KeyboardInterrupt:
                        print('Waiting for Windows driver setup to finish before releasing the programmer.', flush=True)
    except (OSError, subprocess.SubprocessError) as exc:
        raise BuildError(f'Windows driver helper could not run: {exc}') from exc


def devices(binary):
    result = invoke(binary, '--list')
    if result.returncode:
        raise BuildError(f'Cannot enumerate Windows programmers: {result.stderr.strip()}')
    rows = json.loads(result.stdout)
    if not isinstance(rows, list) or any(not isinstance(row, dict) or not isinstance(row.get('device_id'), str)
                                         or not isinstance(row.get('service'), str) for row in rows):
        raise ValueError('Invalid driver helper device list')
    return rows


def select(rows, device_id=None):
    if device_id:
        rows = [row for row in rows if row['device_id'].casefold() == device_id.casefold()]
    if not rows:
        raise BuildError('No matching connected FT4232 channel B / Interface 1 was found. No driver was changed.')
    if len(rows) != 1:
        listing = '\n'.join('  ' + row['device_id'] for row in rows)
        raise BuildError('Multiple programmers are connected. Select one with --device-id "ID":\n' + listing)
    return rows[0]


def setup(action, *, device_id=None):
    if sys.platform != 'win32':
        raise BuildError('Driver switching is supported on native Windows only. Linux uses its existing USB permission setup.')
    if action not in ACTIONS:
        raise ValueError('Unknown driver setup action')
    binary = helper_path()
    version = invoke(binary, '--version')
    if version.returncode or not version.stdout.startswith(CAPABILITY + ';'):
        raise BuildError('Driver helper capability check failed')
    # Share the lock used by this application's programming operations. The native
    # helper also serializes elevated setup across Windows sessions.
    from .programmer_helper.usb import diamond_usb, DEFAULT_DIAMOND_PORT
    with diamond_usb(DEFAULT_DIAMOND_PORT):
        selected = select(devices(binary), device_id)
        foss = action == 'setup_foss_drivers'
        expected = 'winusb' if foss else 'ftdibus'
        if selected['service'].casefold() == expected:
            print(f'{selected["device_id"]}: {selected["service"]} is already bound. Run doctor or scan to check readiness.')
            return 0
        print(f'Selected programmer: {selected["device_id"]}', flush=True)
        print(f'Channel B driver: {selected["service"] or "none"} -> {"WinUSB (FOSS)" if foss else "FTDI (Diamond)"}', flush=True)
        print('Close Diamond and other programmer applications. Approve the Windows administrator prompt to continue.', flush=True)
        result = invoke(binary, '--foss' if foss else '--diamond', selected['device_id'], capture=False)
        if result.returncode == 3010:
            print('Driver installed. Restart Windows before scanning or programming.')
            return 0
        if result.returncode:
            raise BuildError(f'Driver setup did not complete (exit {result.returncode}). '
                             'See the helper window and run doctor for the current binding. '
                             'Administrator approval and an installed FTDI package are required for Diamond restoration.')
        current = select(devices(binary), selected['device_id'])
        if current['service'].casefold() != expected:
            raise BuildError('Driver installation returned success but the expected binding is not visible. '
                             'Reconnect the programmer and run doctor before programming.')
    print(f'Driver configured for {"FOSS" if foss else "Diamond"}. Run scan with the corresponding programmer backend.')
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=ACTIONS)
    parser.add_argument('--device-id')
    args = parser.parse_args(argv)
    return setup(args.action, device_id=args.device_id)


if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (BuildError, OSError, ValueError, subprocess.SubprocessError) as exc:
        print(f'uz_cpld: {exc}', file=sys.stderr)
        raise SystemExit(2)
