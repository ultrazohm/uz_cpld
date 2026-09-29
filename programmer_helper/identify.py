"""Read MachXO2 identity registers through the UltraZohm FT4232 channel B."""
from datetime import datetime, timezone
import os
from pathlib import Path
import re
import shutil
import tempfile

from toolchain.buildsystem.identity import resolve_usercode
from toolchain.buildsystem.model import BuildError
from toolchain.buildsystem.backends.diamond import tcl
from toolchain.buildsystem.workflow import workspace_lock, write_json
from .helper import DEFAULT_DIAMOND_PORT
from .usb import diamond_usb


def openocd_path():
    candidate = os.environ.get('CPLD_OPENOCD') or shutil.which('openocd')
    return Path(candidate) if candidate else Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite')) / 'bin/openocd'


def preflight(backend, cable=None, serial=None, probe_index=None):
    """Reject unsupported wiring before any programming takes place."""
    if backend not in ('diamond', 'foss'):
        raise BuildError('Unknown programmer backend')
    expected = DEFAULT_DIAMOND_PORT if backend == 'diamond' else 0
    if probe_index not in (None, expected) or cable not in (None, 'ft4232_b'):
        raise BuildError('Identity readback supports UltraZohm FT4232 channel B: Diamond probe_index=1 or FOSS probe_index=0; use usb_serial for a particular FOSS probe')
    if serial is not None and (not serial or any(ord(c) < 32 for c in serial)):
        raise BuildError('Invalid USB serial number')
    if not openocd_path().is_file():
        raise BuildError(f'Identity readback requires OpenOCD: {openocd_path()}; set CPLD_OPENOCD')


def programming_preflight(backend, cable=None, serial=None, probe_index=None):
    record = None
    if backend == 'foss':
        from toolchain.foss.flasher import verify
        from .program import loader_path
        try:
            record = verify(loader_path())
        except ValueError as exc:
            raise BuildError(str(exc)) from exc
    preflight(backend, cable, serial, probe_index)
    return record


def script(chain, serial=None):
    if chain not in ('dslots', 's3c'):
        raise BuildError('Choose the dslots or s3c chain')
    count, expected = (5, 0x012BB043) if chain == 'dslots' else (1, 0x012BC043)
    lines = ['adapter driver ftdi', 'ftdi vid_pid 0x0403 0x6011', 'ftdi channel 1',
             'ftdi layout_init 0x0008 0x000b', 'transport select jtag',
             'adapter speed 1000', 'reset_config none',
             'gdb_port disabled', 'tcl_port disabled', 'telnet_port disabled']
    if serial:
        lines.append(f'adapter serial {tcl(serial)}')
    for index in range(count):
        lines.append(f'jtag newtap cpld{index} tap -irlen 8 -ircapture 0x01 -irmask 0x03 -expected-id 0x{expected:08x}')
    lines += ['init', 'jtag arp_init',
              f'if {{[llength [jtag names]] != {count}}} {{error "Unexpected JTAG chain length"}}']
    for index in range(count):
        tap = f'cpld{index}.tap'
        lines += [f'irscan {tap} 0xe0', f'set id [drscan {tap} 32 0]',
                  f'if {{[expr 0x$id] != {expected}}} {{error "Unexpected device at position {index}"}}',
                  f'irscan {tap} 0xc0', f'set user [drscan {tap} 32 0]',
                  f'irscan {tap} 0x19', f'set trace [drscan {tap} 32 0 32 0]',
                  f'puts "UZ_IDENTITY {index} $id $user [lindex $trace 1][lindex $trace 0]"', f'irscan {tap} 0xff']
    # Turn any chain/read error into a nonzero process result.
    return 'if {[catch {\n' + '\n'.join(lines) + '\n} message]} {\nputs stderr $message\nshutdown error\n}\nshutdown\n'


def parse(root, chain, output):
    count, expected = (5, 0x012BB043) if chain == 'dslots' else (1, 0x012BC043)
    found = re.findall(r'^UZ_IDENTITY (\d+) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{16})\s*$', output, re.M)
    if [int(row[0]) for row in found] != list(range(count)):
        raise BuildError('Incomplete or duplicate device identity readback')
    devices = []
    for index, idcode, usercode, traceid in found:
        if int(idcode, 16) != expected:
            raise BuildError(f'Unexpected device IDCODE at JTAG index {index}')
        resolved = resolve_usercode(root, int(usercode, 16))
        devices.append({'index': int(index), 'label': 's3c' if chain == 's3c' else f'slot{int(index) + 1}',
                        'idcode': idcode.upper(), 'usercode': usercode.upper(), 'traceid': traceid.upper(),
                        'silicon_id': traceid[-14:].upper(), 'identity': resolved})
    return devices


def identify(root, chain, backend='diamond', cable=None, serial=None, probe_index=None, *, output=None):
    from .program import run_command
    preflight(backend, cable, serial, probe_index)
    root = Path(root).resolve()
    with workspace_lock(root):
        base = root / 'toolchain/build/programmer/identification'
        for path in [base, *base.parents]:
            if path == root:
                break
            if path.is_symlink():
                raise BuildError(f'Identity output directory must not be a symlink: {path}')
        base.mkdir(parents=True, exist_ok=True)
        directory = Path(tempfile.mkdtemp(prefix='read-', dir=base)) if output is None else output
        directory.mkdir(parents=True, exist_ok=True)
        config = directory / 'identify.cfg'
        config.write_text(script(chain, serial))
        command = (str(openocd_path()), '-f', str(config))
        # The same interface lock and driver restoration used for Diamond also
        # protect OpenOCD. With no serial, refuse ambiguous multiple probes.
        with diamond_usb(DEFAULT_DIAMOND_PORT, serial=serial):
            raw = run_command(command, directory / 'identify.log')
        devices = parse(root, chain, raw)
        write_json(directory / 'identity.json', {'chain': chain, 'devices': devices,
                   'read_at': datetime.now(timezone.utc).isoformat()})
        for device in devices:
            identity = device['identity']
            name = (f'{identity["program"]}, revision {identity["revision"]}' if identity and identity['known_build']
                    else f'{identity["program"]}, unknown revision {identity["revision"]}' if identity else 'unknown firmware')
            print(f'{device["label"]}: USERCODE 0x{device["usercode"]}, TraceID 0x{device["traceid"]}: {name}')
        return devices
