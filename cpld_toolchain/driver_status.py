"""Read Windows PnP metadata without opening or changing USB interfaces."""
import base64
import json
import os
from pathlib import Path
import re
import subprocess
import sys

from . import external


INTERFACE = re.compile(r'^USB\\VID_0403&PID_6011&MI_01\\', re.IGNORECASE)
QUERY = r"""
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
$devices = @(Get-CimInstance Win32_PnPEntity -Filter "PNPDeviceID LIKE 'USB%VID_0403&PID_6011&MI_01%'" |
    Where-Object { $_.Present -eq $true } |
    Select-Object Name, PNPDeviceID, Service, ConfigManagerErrorCode)
ConvertTo-Json -InputObject $devices -Compress
"""


def inspect_windows():
    """Return every connected channel B; query failures must not imply absence."""
    powershell = Path(os.environ.get('SystemRoot', r'C:\Windows')) / 'System32/WindowsPowerShell/v1.0/powershell.exe'
    encoded = base64.b64encode(QUERY.encode('utf-16-le')).decode('ascii')
    with external.system_libraries():
        result = subprocess.run(
            [str(powershell), '-NoLogo', '-NoProfile', '-NonInteractive', '-EncodedCommand', encoded],
            stdin=subprocess.DEVNULL, capture_output=True, encoding='utf-8', errors='replace',
            timeout=15, env=external.environment())
    if result.returncode:
        raise ValueError(' '.join(result.stderr.split())[:240] or f'PowerShell exit {result.returncode}')
    devices = json.loads(result.stdout.lstrip('\ufeff'))
    if not isinstance(devices, list) or any(not isinstance(d, dict) for d in devices):
        raise ValueError('Unexpected Windows PnP response')
    rows = []
    for device in devices:
        identifier = device.get('PNPDeviceID')
        if not isinstance(identifier, str):
            raise ValueError('Windows PnP response lacks a device ID')
        if not INTERFACE.match(identifier):
            continue
        service = device.get('Service') or '(none)'
        if not isinstance(service, str):
            raise ValueError('Windows PnP response has an invalid driver service')
        code = device.get('ConfigManagerErrorCode')
        if type(code) is not int:
            state = 'UNKNOWN'
        elif code != 0:
            state = 'DEVICE ERROR'
        elif service.lower() == 'winusb':
            state = 'CONFIGURED'
        elif service.lower() == 'ftdibus':
            state = 'INCOMPATIBLE'
        else:
            state = 'CHECK DRIVER'
        rows.append((state, f'{identifier}; driver service: {service}; Windows problem code: {code}'))
    return rows


def report():
    if sys.platform != 'win32':
        return
    print('\nWindows USB driver status (FOSS backend; FT4232 channel B / Interface 1)')
    try:
        rows = inspect_windows()
    except (OSError, ValueError, subprocess.SubprocessError) as exc:
        print(f'  UNKNOWN: driver query failed: {exc}')
        print('  Check Interface 1 in Device Manager; this does not mean the device is absent.')
        return
    if not rows:
        print('  ABSENT: no connected USB VID 0403, PID 6011, MI_01 interface found.')
    for state, detail in rows:
        print(f'  {state}: {detail}')
    if any(state == 'INCOMPATIBLE' for state, _ in rows):
        print('  FTDI VCP/D2XX is incompatible with this FOSS backend. Run uz_cpld setup_foss_drivers')
        print('  to bind WinUSB to Interface 1 only; leave A, C and D unchanged.')
        print('  Switch back with uz_cpld setup_diamond_driver.')
    if any(state == 'CHECK DRIVER' for state, _ in rows):
        print('  This driver is not verified here; WinUSB is the recommended binding for this FOSS backend.')
    print('  Driver metadata only: USB access, exclusive availability and JTAG communication were not tested.')
