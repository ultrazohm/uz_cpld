"""Plan and explicitly execute CPLD programming from a container or native host."""
from cpld_toolchain import repository_root
import argparse
from contextlib import ExitStack, nullcontext
from dataclasses import dataclass
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import xml.etree.ElementTree as ET

from cpld_toolchain.toolchain.buildsystem.model import BuildError, identifier, load_build, resolve_release
from cpld_toolchain.toolchain.buildsystem.workflow import build_program, digest, locked, safe_directory, workspace_lock, write_json
from .helper import (DEFAULT_DIAMOND_PORT, SLOT_TEMPLATE, S3C_TEMPLATE, render_xcf,
                     jedec_metadata, read_selection, verified_firmware, direct_selection)
from .usb import diamond_usb
from .diamond import command as diamond_command, environment as diamond_environment
from .release import ReleaseFirmware


# UltraZohm: one FT4232, channel B for either physical CPLD chain.
DEFAULT_FOSS_CABLE = 'ft4232_b'
DEFAULT_FOSS_PROBE_INDEX = 0


@dataclass(frozen=True)
class FirmwareSnapshot:
    label: str
    index: int
    source: Path
    artifact: Path
    sha256: str


@dataclass(frozen=True)
class Step:
    label: str
    build: object
    artifact: Path
    sha256: str
    command: tuple[str, ...]
    firmware: tuple[FirmwareSnapshot, ...] = ()
    port: int | None = None


def firmware_input(build, extension):
    return build.verify(extension) if isinstance(build, ReleaseFirmware) else verified_firmware(build, extension)


def firmware_identity(build, *, validate=False):
    if isinstance(build, ReleaseFirmware):
        return build.identity
    identity = json.loads((build.directory / 'metadata/build.json').read_text())['identity']
    if validate:
        from cpld_toolchain.toolchain.buildsystem.identity import validate_identity
        return validate_identity(build, identity)
    return identity


def firmware_lock(build):
    return workspace_lock(build.root) if isinstance(build, ReleaseFirmware) else locked(build)


def create_selection(destination: Path, *, release=None, s3c=None, slots=None):
    """Create an editable selection in the caller's directory without overwriting."""
    template = Path(__file__).with_name('selection.example.toml').read_text()
    replacements = {}
    if release is not None:
        replacements['release'] = identifier(release) if release else ''
    if s3c is not None:
        replacements['s3c'] = identifier(s3c)
    for position, name in (slots or {}).items():
        if position not in range(1, 6):
            raise BuildError('D-slot position must be 1..5')
        replacements[f'"{position}"'] = identifier(name)
    for key, value in replacements.items():
        template = re.sub(rf'(?m)^{re.escape(key)} = .*$',
                          lambda match: f'{key} = {json.dumps(value)}', template)
    try:
        with destination.open('x') as stream:
            stream.write(template)
    except FileExistsError:
        print(f'{destination} already exists; kept your selection.')
        return
    print(f'Created {destination} with selected programs. Edit the programs and release as needed.')
    print('Use uz_cpld list to see programs, then uz_cpld program --target s3c or dslot.')


def build_selection(root: Path, selection: Path, release_cycle=None, *, target=None,
                    backend='diamond'):
    """Validate all selected builds before compiling each distinct firmware once."""
    chain = {'dslot': 'dslots', 's3c': 's3c'}.get(target)
    slots, s3c, selected_release, _ = read_selection(selection, chain)
    cycle = resolve_release(root, release_cycle or selected_release)
    builds = []
    for selected_chain in ([chain] if chain else ['dslots', 's3c']):
        builds.extend(selected_chain_builds(root, cycle, slots, s3c, selected_chain, backend))
    unique = {build.directory: build for _, _, build in builds}
    from cpld_toolchain.toolchain.buildsystem.backends.diamond import preflight
    preflight(list(unique.values()))
    for build in unique.values():
        print(build_program(build))
    from cpld_toolchain.toolchain.buildsystem.publication import publish
    print(publish(root, list(unique.values())))


def loader_path() -> Path:
    from cpld_toolchain.tools import loader_path as locate
    return locate()


def cable_args(chain: str, cable: str | None, serial: str | None,
               probe_index: int | None) -> list[str]:
    # These are openFPGALoader probe indices; Diamond FTUSB ports can enumerate
    # interfaces of one FTDI chip and must be checked separately.
    args = ['--cable', cable or DEFAULT_FOSS_CABLE, '--freq', '1000000']
    if serial:
        args += ['--ftdi-serial', serial]
    else:
        args += ['--cable-index', str(probe_index if probe_index is not None else
                                      DEFAULT_FOSS_PROBE_INDEX)]
    return args


def scan_command(chain: str, cable: str | None, serial: str | None,
                 probe_index: int | None = None) -> tuple[str, ...]:
    return (str(loader_path()), *cable_args(chain, cable, serial, probe_index), '--detect')


def parse_scan(output: str) -> list[tuple[int, int]]:
    """Read the zero-based chain index and IDCODE reported by openFPGALoader."""
    markers = list(re.finditer(r'(?mi)^\s*index\s+(\d+)\s*:\s*$', output))
    devices = []
    for offset, marker in enumerate(markers):
        end = markers[offset + 1].start() if offset + 1 < len(markers) else len(output)
        match = re.search(r'(?mi)^\s*idcode\s+(0x[0-9a-f]+)\b', output[marker.end():end])
        if match is None:
            raise BuildError(f'Cannot read IDCODE for JTAG index {marker[1]}')
        devices.append((int(marker[1]), int(match[1], 16)))
    if not devices:
        raise BuildError('No JTAG devices were reported; inspect openFPGALoader output and USB access')
    return devices


def check_chain(chain: str, output: str):
    expected_id = 0x012BB043 if chain == 'dslots' else 0x012BC043
    expected_count = 5 if chain == 'dslots' else 1
    devices = parse_scan(output)
    if devices != [(index, expected_id) for index in range(expected_count)]:
        actual = ', '.join(f'{index}:0x{idcode:08x}' for index, idcode in devices)
        raise BuildError(f'{chain} JTAG chain does not match {expected_count} expected MachXO2 devices: {actual}')
    return devices


def diamond_scan_xcf(root: Path, chain: str, destination: Path, port: int | None = None):
    """Build an XCF containing only MachXO2's read-only FLASH Display ID operation."""
    template = SLOT_TEMPLATE if chain == 'dslots' else S3C_TEMPLATE
    tree = ET.parse(template)
    project = tree.getroot()
    if (project.findtext('./ProjectOptions/OperationOverride') != 'No Override' or
            project.findtext('./ProjectOptions/Process') != 'ENTIRED CHAIN'):
        raise BuildError(f'{template}: unexpected project operation settings')
    devices = project.findall('./Chain/Device')
    expected_id = 0x012BB043 if chain == 'dslots' else 0x012BC043
    expected_count = 5 if chain == 'dslots' else 1
    if len(devices) != expected_count:
        raise BuildError(f'{template}: expected {expected_count} scan positions')
    for position, device in enumerate(devices, start=1):
        if (device.findtext('Pos') != str(position) or
                int(device.findtext('IDCode', '0'), 16) != expected_id):
            raise BuildError(f'{template}: unexpected device at position {position}')
        operation = device.find('Operation')
        if operation is None:
            raise BuildError(f'{template}: missing operation at position {position}')
        # MachXO2's FLASH access mode rejects the generic "Display ID" name.
        operation.text = 'FLASH Display ID'
        for field in ('File', 'FileTime', 'JedecChecksum'):
            item = device.find(field)
            if item is not None:
                item.text = None
    cable = project.find('CableOptions')
    if cable is None or cable.findtext('CableName') != 'USB2':
        raise BuildError(f'{template}: expected a USB2 cable')
    for item in cable.findall('USBID'):
        cable.remove(item)
    port = DEFAULT_DIAMOND_PORT if port is None else port
    port_address = cable.find('PortAdd')
    if port < 0 or port_address is None:
        raise BuildError(f'{template}: invalid USB2 port {port}')
    port_address.text = f'FTUSB-{port}'
    ET.indent(tree, space='\t')
    destination.write_bytes(b'<?xml version="1.0" encoding="utf-8"?>\n'
                            b'<!DOCTYPE ispXCF SYSTEM "IspXCF.dtd" >\n' +
                            ET.tostring(project, encoding='utf-8') + b'\n')


def require_usb_bus():
    if not sys.platform.startswith('linux'):
        return  # Native Windows driver access is checked by the vendor tools.
    bus = Path('/dev/bus/usb')
    if not bus.is_dir() or not any(bus.glob('*/*')):
        raise BuildError('No USB device nodes are visible at /dev/bus/usb. Connect the programmer and check USB permissions; containers also need USB forwarding.')


def run_command(command: tuple[str, ...], log: Path, *, env=None) -> str:
    """Stream tool output to the terminal and retain a log."""
    log.parent.mkdir(parents=True, exist_ok=True)
    with log.open('w') as stream:
        stream.write('$ ' + shlex.join(command) + '\n')
        stream.flush()
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                   text=True, errors='replace', env=env)
        lines = []
        try:
            for line in process.stdout:
                print(line, end='')
                stream.write(line)
                lines.append(line)
            result = process.wait()
        except BaseException:
            # Stop Diamond before releasing the USB context and restoring its driver.
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()
            raise
        finally:
            process.stdout.close()
    if result:
        raise BuildError(f'Programmer failed with exit code {result}; see {log}')
    return ''.join(lines)


def run_diamond(command: tuple[str, ...], log: Path, xcf: Path) -> str:
    """Use the XCF's actual cable port for both scanning and programming."""
    project = ET.parse(xcf).getroot()
    port = re.fullmatch(r'FTUSB-(\d+)', project.findtext('./CableOptions/PortAdd', ''))
    if project.findtext('./CableOptions/CableName') != 'USB2' or port is None:
        raise BuildError(f'{xcf}: expected a USB2 FTUSB port')
    from cpld_toolchain.external import system_libraries
    with diamond_usb(int(port[1])), system_libraries():
        return run_command(command, log, env=diamond_environment(command))


def selected_chain_builds(root: Path, cycle: str, slots: dict[int, str], s3c: str,
                          chain: str, backend: str):
    if chain == 'dslots':
        return [(f'slot{position}', position - 1,
                 load_build(root, slots[position], 'uz_dslot_xo2', backend, cycle))
                for position in range(1, 6)]
    return [('s3c', 0, load_build(root, s3c, 'uz_s3c_xo2', backend, cycle))]


def verify_diamond_plan(step, builds, current):
    """Bind the XCF, snapshot bytes and fresh builds to the requested positions."""
    expected = [(label, index, build.firmware_path('jed')) for label, index, build in builds]
    if [(f.label, f.index, f.source) for f in step.firmware] != expected:
        raise BuildError('Programming plan does not match the requested selection')
    if step.artifact.is_symlink() or not step.artifact.is_file() or digest(step.artifact) != step.sha256:
        raise BuildError('Generated XCF changed before programming')
    tree = ET.parse(step.artifact)
    devices = tree.findall('./Chain/Device')
    if len(devices) != len(expected) or tree.findtext('./CableOptions/PortAdd') != f'FTUSB-{step.port}':
        raise BuildError('Programming plan has a different chain or USB port')
    for device, firmware in zip(devices, step.firmware):
        if current[firmware.label] != (firmware.source, firmware.sha256):
            raise BuildError(f'{firmware.label}: firmware changed since planning; create a new plan')
        snapshot = step.artifact.parent / 'firmware' / f'{firmware.label}.jed'
        if (firmware.artifact != snapshot or snapshot.is_symlink() or
                snapshot.resolve() != snapshot or not snapshot.is_file() or digest(snapshot) != firmware.sha256):
            raise BuildError(f'{firmware.label}: firmware snapshot changed since planning')
        checksum, usercode = jedec_metadata(snapshot)
        device_name, idcode = (('LCMXO2-4000HC', '0x012bc043') if firmware.label == 's3c'
                              else ('LCMXO2-2000HC', '0x012bb043'))
        fields = {'Pos': str(firmware.index + 1), 'File': str(snapshot),
                  'Name': device_name, 'IDCode': idcode,
                  'JedecChecksum': f'0x{checksum}', 'Option/Usercode': f'0x{usercode}',
                  'Operation': 'FLASH Erase,Program,Verify'}
        if (any(device.findtext(key, '').lower() != value.lower() if key == 'IDCode'
                else device.findtext(key) != value for key, value in fields.items()) or
                device.find('SelectedProg') is None or device.find('SelectedProg').get('value') != 'TRUE'):
            raise BuildError(f'{firmware.label}: XCF does not match the planned firmware and position')


def diamond_plan(root, cycle, chain, builds, probe_index):
    """Create private execution inputs while holding all selected build locks."""
    port = DEFAULT_DIAMOND_PORT if probe_index is None else probe_index
    unique = {build.directory: build for _, _, build in builds}
    with ExitStack() as stack:
        for build in sorted(unique.values(), key=lambda item: str(item.directory)):
            stack.enter_context(firmware_lock(build))
        current = {label: firmware_input(build, 'jed') for label, _, build in builds}
        base = safe_directory(builds[0][2], root / 'build/programmer' / cycle / chain / 'plans')
        base.mkdir(parents=True, exist_ok=True)
        output = Path(tempfile.mkdtemp(prefix='plan-', dir=base))
        try:
            (output / 'firmware').mkdir()
            firmware = []
            for label, index, _ in builds:
                source, sha256 = current[label]
                snapshot = output / 'firmware' / f'{label}.jed'
                shutil.copy2(source, snapshot)
                firmware.append(FirmwareSnapshot(label, index, source, snapshot, sha256))
            template = S3C_TEMPLATE if chain == 's3c' else SLOT_TEMPLATE
            device, idcode = (('LCMXO2-4000HC', '0x012bc043') if chain == 's3c'
                              else ('LCMXO2-2000HC', '0x012bb043'))
            xcf = output / f'{chain}.xcf'
            xcf.write_bytes(render_xcf(template, {f.index + 1: f.artifact for f in firmware},
                                      device_name=device, idcode=idcode, port=port))
            command = diamond_command(root, xcf, '<run-log>')
            step = Step(chain, builds[0][2], xcf, digest(xcf), command, tuple(firmware), port)
            verify_diamond_plan(step, builds, current)
            write_json(output / 'selection.json', {
                'release_cycle': cycle, 'programmer_backend': 'diamond', 'build_backend': 'diamond',
                'programs': {label: build.name for label, _, build in builds}, 'port': port,
                'firmware_sha256': {f.label: f.sha256 for f in firmware},
                'usercodes': {f.label: jedec_metadata(f.artifact)[1] for f in firmware},
                'firmware': [{'label': f.label, 'index': f.index, 'source': str(f.source),
                              'snapshot': str(f.artifact), 'sha256': f.sha256} for f in firmware],
                'xcf_sha256': {xcf.name: step.sha256}, 'template_sha256': digest(template),
            })
        except BaseException:
            shutil.rmtree(output)
            raise
    return output, [step]


def plan(root: Path, selection: Path | dict, cycle_name: str | None, chain: str, programmer_backend: str,
         cable: str | None, serial: str | None, probe_index: int | None = None,
         *, build_backend: str | None = None, source='local', firmware=None):
    """Validate authored selection and existing build evidence; touch no hardware."""
    root = root.resolve()
    if source not in ('local', 'zip') or (source == 'zip') != (firmware is not None):
        raise BuildError('Use source=local without firmware, or source=zip with firmware=FILE.zip')
    if source == 'zip':
        from .release import stage
        cycle, output, builds = stage(root, selection, cycle_name, chain, programmer_backend, firmware, build_backend)
        build_backend = builds[0][2].backend
    else:
        slots, s3c, selection_release, _ = read_selection(selection, chain=chain)
        build_backend = build_backend or 'diamond'
        cycle = resolve_release(root, cycle_name if cycle_name is not None else selection_release)
        builds = selected_chain_builds(root, cycle, slots, s3c, chain, build_backend)
        output = root / 'build/programmer' / cycle
    if build_backend not in ('diamond', 'foss'):
        raise BuildError('build_backend must be diamond or foss')
    if programmer_backend == 'diamond' and build_backend != 'diamond':
        raise BuildError('Diamond programming requires Diamond JEDEC builds; '
                         'use programmer_backend=foss to program FOSS builds, or select build_backend=diamond')
    if programmer_backend == 'diamond':
        output, steps = diamond_plan(root, cycle, chain, builds, probe_index)
    else:
        steps = []
        for label, index, build in builds:
            firmware, sha256 = firmware_input(build, 'jed' if build_backend == 'diamond' else 'bit')
            identity = firmware_identity(build)
            command = (str(loader_path()), *cable_args(chain, cable, serial, probe_index),
                       '--index-chain', str(index), '--write-flash', '--verify',
                       '--usercode', identity['usercode'], str(firmware))
            steps.append(Step(label, build, firmware, sha256, command))
    return cycle, output, builds, steps


def execute(root: Path, cycle: str, chain: str, programmer_backend: str, output: Path,
            builds, steps: list[Step], cable: str | None, serial: str | None,
            probe_index: int | None = None):
    """Revalidate selected files under build locks, detect JTAG, then program."""
    if programmer_backend == 'foss' and not loader_path().is_file():
        raise BuildError(f'openFPGALoader is missing: {loader_path()}')
    from .identify import programming_preflight, identify
    programmer_provenance = programming_preflight(programmer_backend, cable, serial, probe_index)
    stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    run_dir = output / 'runs' / stamp
    unique = {build.directory: build for _, _, build in builds}
    with ExitStack() as stack:
        for build in sorted(unique.values(), key=lambda item: str(item.directory)):
            stack.enter_context(firmware_lock(build))
        current, identities = {}, {}
        for label, _, build in builds:
            extension = 'jed' if build.backend == 'diamond' else 'bit'
            current[label] = firmware_input(build, extension)
            identities[label] = firmware_identity(build, validate=True)
        if programmer_backend == 'foss':
            if [(step.label, step.build) for step in steps] != [(label, build) for label, _, build in builds]:
                raise BuildError('FOSS plan does not match the requested selection')
            for step, (label, index, build) in zip(steps, builds):
                if not step.artifact.is_file() or digest(step.artifact) != step.sha256:
                    raise BuildError(f'Firmware changed since planning: {step.artifact}')
                expected = (str(loader_path()), *cable_args(chain, cable, serial, probe_index),
                            '--index-chain', str(index), '--write-flash', '--verify',
                            '--usercode', identities[label]['usercode'], str(current[label][0]))
                if step.command != expected or (step.artifact, step.sha256) != current[label]:
                    raise BuildError('FOSS plan command or firmware does not match its registered identity')
        if programmer_backend == 'diamond':
            if len(steps) != 1:
                raise BuildError('Diamond programming requires exactly one chain plan')
            verify_diamond_plan(steps[0], builds, current)
        run_dir.mkdir(parents=True)
        record = {'release_cycle': cycle, 'chain': chain, 'programmer_backend': programmer_backend, 'mode': 'flash',
                  'build_backend': builds[0][2].backend,
                  'expected_identities': identities, 'programmer_provenance': programmer_provenance,
                  'steps': [], 'status': 'running'}
        package = builds[0][2].package if isinstance(builds[0][2], ReleaseFirmware) else None
        record['source'] = 'zip' if package else 'local'
        if package:
            record['release_package'] = dict(package.evidence,
                                            manifest=str(package.directory / 'manifest.json'),
                                            manifest_sha256=package.manifest_sha256)
            record['programs'] = {label: build.name for label, _, build in builds}
        write_json(run_dir / 'result.json', record)
        try:
            if programmer_backend == 'foss':
                from .foss import execute as execute_foss
                execute_foss(root, chain, builds, steps, identities, run_dir, record,
                             cable, serial, probe_index, package)
                record['status'] = 'success'
                return run_dir
            for step in steps:
                log = run_dir / f'{step.label}.log'
                command = (step.command[:-1] + (str(run_dir / f'{step.label}-pgrcmd.log'),)
                           if programmer_backend == 'diamond' else step.command)
                if programmer_backend == 'diamond':
                    run_diamond(command, log, step.artifact)
                else:
                    run_command(command, log)
                record['steps'].append({'label': step.label, 'artifact': str(step.artifact),
                                        'sha256': step.sha256, 'command': list(command),
                                        'firmware': [{'label': f.label, 'snapshot': str(f.artifact),
                                                      'sha256': f.sha256} for f in step.firmware],
                                        'log': str(log)})
                write_json(run_dir / 'result.json', record)
            readback_options = {'registry': package.registry} if package else {}
            record['devices'] = identify(root, chain, programmer_backend, cable, serial, probe_index,
                                         output=run_dir / 'readback', **readback_options)
            write_json(run_dir / 'result.json', record)
            for device in record['devices']:
                if device['usercode'] != identities[device['label']]['usercode']:
                    raise BuildError(f'{device["label"]}: readback USERCODE does not match the programmed firmware')
            record['status'] = 'success'
        except BaseException as exc:
            record['status'] = 'failed'
            record['error'] = str(exc)
            raise
        finally:
            write_json(run_dir / 'result.json', record)
    return run_dir


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description='Inspect and program the selected CPLD JTAG chain.')
    parser.add_argument('action', choices=('init_programmer', 'build_selection', 'scan', 'identify', 'program'))
    parser.add_argument('--root', type=Path, default=repository_root())
    parser.add_argument('--target', choices=('dslot', 's3c'), help='Physical target; scans default to dslot')
    parser.add_argument('--selection', type=Path,
                        help='Program selection file (default: selection.toml in the current directory)')
    parser.add_argument('--release', help='Release cycle for program, or initial release for init_programmer')
    parser.add_argument('--s3c-program', help='S3C firmware program (instead of a selection file)')
    parser.add_argument('--s3c', help='Initial S3C program')
    for position in range(1, 6):
        parser.add_argument(f'--dslot-{position}', dest=f'dslot_{position}', help=f'Initial program for D-slot {position}')
        parser.add_argument(f'--dslot{position}', help=f'Firmware for D-slot {position} (supply all five)')
    parser.add_argument('--release-cycle', help='Override the release in the selection file')
    parser.add_argument('--programmer-backend', choices=('diamond', 'foss'), default='diamond',
                        help='Programming/scan tool, independent of the firmware build backend')
    parser.add_argument('--build-backend', choices=('diamond', 'foss'),
                        help='Firmware build backend (default: diamond); ignored for scans')
    parser.add_argument('--source', choices=('local', 'zip'), default='local')
    parser.add_argument('--firmware', type=Path, help='Verified release ZIP (requires --source zip)')
    parser.add_argument('--cable', help=f'openFPGALoader cable name; default: {DEFAULT_FOSS_CABLE}')
    parser.add_argument('--usb-serial', help='Select one USB probe by its serial number')
    parser.add_argument('--probe-index', type=int, help='Select an FTDI USB probe by index')
    parser.add_argument('--execute', action='store_true', help='Contact hardware (scan reads IDs; program writes Flash)')
    args = parser.parse_args(argv)
    try:
        slots = {i: getattr(args, f'dslot{i}') for i in range(1, 6) if getattr(args, f'dslot{i}') is not None}
        if args.action != 'program' and (args.s3c_program is not None or slots):
            raise BuildError('Direct program assignments apply only to program')
        if args.action == 'program':
            if args.s3c is not None or any(getattr(args, f'dslot_{i}') is not None for i in range(1, 6)):
                raise BuildError('For program use s3c_program or dslot1..dslot5')
            assignments = direct_selection(args.target, args.s3c_program, slots)
            if assignments is not None and args.selection is not None:
                raise BuildError('Use selection=FILE or direct program assignments, not both')
            if args.release is not None:
                if args.release_cycle is not None and args.release_cycle != args.release:
                    raise BuildError('release and release_cycle must agree; use one release option')
                args.release_cycle = identifier(args.release)
            args.selection = assignments if assignments is not None else args.selection
        if args.selection is None:
            args.selection = Path('selection.toml')
        if args.action not in ('program', 'identify') and (args.source != 'local' or args.firmware is not None):
            raise BuildError('source and firmware options apply only to program and identify')
        if (args.source == 'zip') != (args.firmware is not None):
            raise BuildError('Use source=local without firmware, or source=zip with firmware=FILE.zip')
        if args.action == 'init_programmer':
            create_selection(args.selection, release=args.release, s3c=args.s3c,
                             slots={i: getattr(args, f'dslot_{i}') for i in range(1, 6)
                                    if getattr(args, f'dslot_{i}') is not None})
            return 0
        if args.action == 'build_selection':
            build_selection(args.root, args.selection, args.release_cycle,
                            target=args.target, backend=args.build_backend or 'diamond')
            return 0
        if args.action == 'program' and isinstance(args.selection, Path) and not args.selection.exists():
            create_selection(args.selection)
            print('Review the selection before programming; no hardware was accessed.')
            return 0
        args.chain = {'dslot': 'dslots', 's3c': 's3c'}.get(args.target)
        if not args.chain:
            if args.action == 'program':
                raise BuildError('Choose target=s3c or target=dslot; program one physical chain at a time')
            args.chain = 'dslots'
        if args.probe_index is not None and args.probe_index < 0:
            raise BuildError('--probe-index must be nonnegative')
        if args.probe_index is not None and args.usb_serial:
            raise BuildError('Select a probe using either --probe-index or --usb-serial')
        if args.programmer_backend == 'diamond' and (args.cable or args.usb_serial):
            raise BuildError('Diamond uses the USB2 cable; select its port with --probe-index')
        if args.action == 'identify':
            from .identify import identify, DIAMOND_READS
            if not args.execute:
                if args.programmer_backend == 'foss':
                    from .foss import identity_command
                    print(shlex.join(identity_command(loader_path(), args.chain, args.cable, args.usb_serial, args.probe_index)))
                else:
                    port = DEFAULT_DIAMOND_PORT if args.probe_index is None else args.probe_index
                    print(f'Diamond identify: {args.chain} on FTUSB-{port}')
                    for _, _, operation, _, _ in DIAMOND_READS:
                        print(f'  {operation}')
            else:
                identify(args.root, args.chain, args.programmer_backend, args.cable, args.usb_serial, args.probe_index,
                         **({"firmware": args.firmware} if args.source == "zip" else {}))
            return 0
        if args.action == 'scan':
            if args.programmer_backend == 'foss':
                command = scan_command(args.chain, args.cable, args.usb_serial, args.probe_index)
                if not args.execute:
                    print(shlex.join(command))
                    return 0
                if not args.cable or args.cable.startswith(('ft2232', 'ft4232')):
                    require_usb_bus()
                from .foss import run
                guard = (diamond_usb(DEFAULT_DIAMOND_PORT, serial=args.usb_serial)
                         if args.cable in (None, DEFAULT_FOSS_CABLE) and args.probe_index in (None, 0)
                         else nullcontext())
                with guard:
                    output = run(command, args.root.resolve() / 'build/programmer/scan.log')
                print('Detected:', parse_scan(output))
            else:
                port = args.probe_index if args.probe_index is not None else DEFAULT_DIAMOND_PORT
                print(f'Diamond FLASH Display ID scan: {args.chain} on FTUSB-{port}')
                if not args.execute:
                    return 0
                require_usb_bus()
                stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
                run_dir = args.root.resolve() / 'build/programmer/scans' / stamp
                run_dir.mkdir(parents=True)
                xcf = run_dir / 'scan.xcf'
                diamond_scan_xcf(args.root.resolve(), args.chain, xcf, port)
                vendor_log = run_dir / 'pgrcmd.log'
                command = diamond_command(args.root.resolve(), xcf, vendor_log)
                try:
                    output = run_diamond(command, run_dir / 'stdout.log', xcf)
                finally:
                    if vendor_log.exists():
                        print(vendor_log.read_text(errors='replace'))
                    print(f'Diamond scan logs: {run_dir}')
                if not output.strip() and not vendor_log.exists():
                    raise BuildError('Diamond produced no scan output')
            return 0
        if isinstance(args.selection, Path) and not args.selection.is_file():
            raise BuildError(f'{args.selection} is missing; run uz_cpld init_programmer, then fill in the target programs')
        cycle, output, builds, steps = plan(args.root, args.selection, args.release_cycle,
                                                  args.chain, args.programmer_backend,
                                                  args.cable, args.usb_serial, args.probe_index,
                                                  build_backend=args.build_backend, source=args.source, firmware=args.firmware)
        print(f'Programming selection (release: {cycle}):')
        for _, index, build in builds:
            target_label = 'S3C' if args.chain == 's3c' else f'D-slot {index + 1}'
            identity = firmware_identity(build)
            print(f'  {target_label}: {build.name}, revision {identity["revision"]}, USERCODE 0x{identity["usercode"]}')
        print(f'Firmware build backend: {builds[0][2].backend}; programmer backend: {args.programmer_backend}')
        if args.source == 'zip':
            evidence = builds[0][2].package.evidence
            print(f'Release ZIP: {evidence["archive"]} (sha256 {evidence["archive_sha256"]})')
            print(f'Release commit: {evidence["git_revision"]}')
        for step in steps:
            print(f'{step.label}: {step.artifact} (sha256 {step.sha256})')
            print('  ' + shlex.join(step.command))
        if args.execute:
            sys.stdout.flush()
            run_dir = execute(args.root.resolve(), cycle, args.chain, args.programmer_backend,
                              output, builds, steps, args.cable, args.usb_serial, args.probe_index)
            print(f'Programming record: {run_dir / "result.json"}')
        return 0
    except KeyboardInterrupt:
        parser.exit(130, 'programmer_helper: interrupted\n')
    except (BuildError, ET.ParseError, OSError, ValueError, KeyError, subprocess.SubprocessError) as exc:
        parser.exit(2, f'programmer_helper: {exc}\n')


if __name__ == '__main__':
    raise SystemExit(main())
