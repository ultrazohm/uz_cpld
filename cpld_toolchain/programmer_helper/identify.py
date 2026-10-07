"""Read MachXO2 identity registers through the UltraZohm FT4232 channel B."""
from datetime import datetime, timezone
from pathlib import Path
import re
import sys
import tempfile
import xml.etree.ElementTree as ET

from cpld_toolchain.toolchain.buildsystem.identity import resolve_usercode
from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.buildsystem.backends.diamond import tcl
from cpld_toolchain.toolchain.buildsystem.workflow import workspace_lock, write_json
from .helper import DEFAULT_DIAMOND_PORT
from .usb import diamond_usb
from .diamond import command as diamond_command, environment as diamond_environment


def openocd_path():
    from cpld_toolchain.tools import openocd_path as locate
    return locate()


def preflight(backend, cable=None, serial=None, probe_index=None):
    """Reject unsupported wiring before any programming takes place."""
    if backend not in ('diamond', 'foss'):
        raise BuildError('Unknown programmer backend')
    expected = DEFAULT_DIAMOND_PORT if backend == 'diamond' else 0
    if probe_index not in (None, expected) or cable not in (None, 'ft4232_b'):
        raise BuildError('Identity readback supports UltraZohm FT4232 channel B: Diamond probe_index=1 or FOSS probe_index=0; use usb_serial for a particular FOSS probe')
    if serial is not None and (not serial or any(ord(c) < 32 for c in serial)):
        raise BuildError('Invalid USB serial number')
    if backend == 'diamond':
        if cable is not None or serial is not None:
            raise BuildError('Diamond uses the USB2 cable; select its port with --probe-index')
        return
    if not openocd_path().is_file():
        raise BuildError(f'Identity readback requires OpenOCD: {openocd_path()}; set CPLD_OPENOCD')


def programming_preflight(backend, cable=None, serial=None, probe_index=None):
    record = None
    if backend == 'foss':
        from cpld_toolchain.toolchain.foss.flasher import verify
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


# Transparent USERCODE access avoids FLASH Display USERCODE's SRAM erase.
DIAMOND_READS = (
    ('idcode', 'FLASH', 'FLASH Display ID', 'ID', 8),
    ('usercode', 'XFLASH', 'XFLASH Display USERCODE', 'USERCODE', 8),
    ('traceid', 'SECKEYS', 'Security Display TraceID', 'ID', 16),
)


def diamond_xcf(root, chain, destination, mode, operation, port=None):
    from .program import diamond_scan_xcf
    if (mode, operation) not in [(item[1], item[2]) for item in DIAMOND_READS]:
        raise BuildError('Unsupported Diamond identity operation')
    diamond_scan_xcf(root, chain, destination, port)
    tree = ET.parse(destination)
    for device in tree.findall('./Chain/Device'):
        device.find('Operation').text = operation
        option = device.find('Option')
        if option is None:
            option = ET.SubElement(device, 'Option')
        for key, value in (('AccessMode', mode), ('TCKFrequency', '1.000000 MHz')):
            item = option.find(key)
            if item is None:
                item = ET.SubElement(option, key)
            item.text = value
    ET.indent(tree, space='\t')
    destination.write_bytes(b'<?xml version="1.0" encoding="utf-8"?>\n'
                            b'<!DOCTYPE ispXCF SYSTEM "IspXCF.dtd" >\n' +
                            ET.tostring(tree.getroot(), encoding='utf-8') + b'\n')


def parse_diamond(chain, output, operation, field, width):
    """Bind each value to its chain position; reject partial or duplicate reads."""
    count = 5 if chain == 'dslots' else 1
    name = 'LCMXO2-2000HC' if chain == 'dslots' else 'LCMXO2-4000HC'
    headers = list(re.finditer(r'^Device(\d+) ([^:]+): ([^\r\n]+)\s*$', output, re.M))
    if [(int(m[1]), m[2], m[3].strip()) for m in headers] != [
            (i, name, operation) for i in range(1, count + 1)]:
        raise BuildError('Incomplete or unexpected Diamond identity readback')
    values = []
    for i, header in enumerate(headers):
        end = headers[i + 1].start() if i + 1 < len(headers) else len(output)
        block = output[header.end():end]
        matches = re.findall(r'^' + re.escape(field) + r'\s*:\s*(?:0x)?([0-9a-fA-F]{'
                             + str(width) + r'})\.?\s*$', block, re.M)
        if len(matches) != 1 or 'Operation Done. No errors.' not in block:
            raise BuildError(f'Incomplete Diamond {field} readback at position {i + 1}')
        values.append(matches[0])
    return values


def diamond_read(root, chain, directory, probe_index):
    from .program import run_command
    values = {}
    port = DEFAULT_DIAMOND_PORT if probe_index is None else probe_index
    with diamond_usb(port):
        for key, mode, operation, field, width in DIAMOND_READS:
            xcf = directory / f'{key}.xcf'
            diamond_xcf(root, chain, xcf, mode, operation, port)
            log = directory / f'{key}-pgrcmd.log'
            command = diamond_command(root, xcf, log)
            options = {'env': diamond_environment(command)} if sys.platform == 'win32' else {}
            stdout = run_command(command, directory / f'{key}-stdout.log', **options)
            # pgrcmd duplicates messages on stdout and in its log: parse one only.
            raw = log.read_text(errors='replace') if log.exists() else stdout
            values[key] = parse_diamond(chain, raw, operation, field, width)
    return ''.join(f'UZ_IDENTITY {i} {idcode} {usercode} {traceid}\n'
                   for i, (idcode, usercode, traceid) in enumerate(zip(
                       values['idcode'], values['usercode'], values['traceid'])))


def parse(root, chain, output, *, registry=None):
    count, expected = (5, 0x012BB043) if chain == 'dslots' else (1, 0x012BC043)
    found = re.findall(r'^UZ_IDENTITY (\d+) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{16})\s*$', output, re.M)
    if [int(row[0]) for row in found] != list(range(count)):
        raise BuildError('Incomplete or duplicate device identity readback')
    devices = []
    for index, idcode, usercode, traceid in found:
        if int(idcode, 16) != expected:
            raise BuildError(f'Unexpected device IDCODE at JTAG index {index}')
        resolved = resolve_usercode(root, int(usercode, 16), registry=registry)
        devices.append({'index': int(index), 'label': 's3c' if chain == 's3c' else f'slot{int(index) + 1}',
                        'idcode': idcode.upper(), 'usercode': usercode.upper(), 'traceid': traceid.upper(),
                        'silicon_id': traceid[-14:].upper(), 'identity': resolved})
    return devices


def identify(root, chain, backend='diamond', cable=None, serial=None, probe_index=None, *, output=None, registry=None):
    from .program import run_command
    preflight(backend, cable, serial, probe_index)
    root = Path(root).resolve()
    with workspace_lock(root):
        base = root / 'build/programmer/identification'
        for path in [base, *base.parents]:
            if path == root:
                break
            if path.is_symlink():
                raise BuildError(f'Identity output directory must not be a symlink: {path}')
        base.mkdir(parents=True, exist_ok=True)
        directory = Path(tempfile.mkdtemp(prefix='read-', dir=base)) if output is None else output
        directory.mkdir(parents=True, exist_ok=True)
        if backend == 'diamond':
            raw = diamond_read(root, chain, directory, probe_index)
        else:
            config = directory / 'identify.cfg'
            config.write_text(script(chain, serial))
            command = (str(openocd_path()), '-f', str(config))
            with diamond_usb(DEFAULT_DIAMOND_PORT, serial=serial):
                raw = run_command(command, directory / 'identify.log')
        devices = parse(root, chain, raw, registry=registry)
        write_json(directory / 'identity.json', {'chain': chain, 'programmer_backend': backend, 'devices': devices,
                   'read_at': datetime.now(timezone.utc).isoformat()})
        for device in devices:
            identity = device['identity']
            name = (f'{identity["program"]}, revision {identity["revision"]}' if identity and identity['known_build']
                    else f'{identity["program"]}, unknown revision {identity["revision"]}' if identity else 'unknown firmware')
            print(f'{device["label"]}: USERCODE 0x{device["usercode"]}, TraceID 0x{device["traceid"]}: {name}')
        return devices
