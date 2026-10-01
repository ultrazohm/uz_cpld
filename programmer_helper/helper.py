"""Create separate D-slot and S3C XCFs from current Diamond JEDEC exports."""
import argparse
from contextlib import ExitStack
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile
import xml.etree.ElementTree as ET

from toolchain.buildsystem.model import BuildError, identifier, load_build, read_toml, resolve_release
from toolchain.buildsystem.report import _row
from toolchain.buildsystem.workflow import build_program, digest, locked, write_json


SLOT_TEMPLATE = Path('archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/Programm_All_5_Slots.xcf')
S3C_TEMPLATE = Path('archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/s3c_programmer.xcf')
DEFAULT_DIAMOND_PORT = 1


def slot_assignments(values: list[str]) -> dict[int, str]:
    """Require one explicit program for every physical D-slot chain position."""
    assignments = {}
    for value in values:
        match = re.fullmatch(r'([1-5])=([a-z][a-z0-9_]*)', value)
        if not match:
            raise BuildError(f'Invalid --slot {value!r}; expected POSITION=program, with position 1..5')
        position, program = int(match[1]), identifier(match[2])
        if position in assignments:
            raise BuildError(f'D-slot position {position} was assigned more than once')
        assignments[position] = program
    missing = sorted(set(range(1, 6)) - assignments.keys())
    if missing:
        raise BuildError(f'Assign every D-slot position; missing: {", ".join(map(str, missing))}')
    return assignments


def read_selection(path: Path, chain: str | None = None) -> tuple[dict[int, str], str, str | None, str]:
    """Read assignments, release and build backend; validate the requested chain."""
    data = read_toml(path)
    required = {'s3c'} if chain == 's3c' else {'slots'} if chain == 'dslots' else {'slots', 's3c'}
    if set(data) - {'slots', 's3c', 'release', 'build_backend'} or not required <= set(data):
        raise BuildError(f'{path}: expected [slots] and s3c for the selected target, plus optional release and build_backend')
    release = data.get('release', '')
    if not isinstance(release, str):
        raise BuildError(f'{path}: release must be a string; use "" for the current release')
    release = identifier(release) if release else None
    build_backend = data.get('build_backend', 'diamond')
    if build_backend not in ('diamond', 'foss'):
        raise BuildError(f'{path}: build_backend must be diamond or foss')
    slots, s3c = {}, ''
    if chain != 's3c':
        if not isinstance(data['slots'], dict) or any(
                not isinstance(position, str) or not isinstance(program, str)
                for position, program in data['slots'].items()):
            raise BuildError(f'{path}: slot positions and program names must be strings')
        try:
            slots = slot_assignments([f'{position}={program}' for position, program in data['slots'].items()])
        except BuildError as exc:
            raise BuildError(f'{path}: {exc}') from exc
    if chain != 'dslots':
        if not isinstance(data['s3c'], str) or not data['s3c']:
            raise BuildError(f'{path}: set s3c to a program name')
        s3c = identifier(data['s3c'])
    return slots, s3c, release, build_backend


def selected_builds(root: Path, cycle: str, slots: dict[int, str], s3c: str,
                    chain: str | None = None):
    """Resolve user selections within one release, checking board compatibility."""
    builds = {}
    if chain != 's3c':
        for position, program in slots.items():
            builds[f'slot{position}'] = load_build(root, program, 'uz_dslot_xo2', 'diamond', cycle)
    if chain != 'dslots':
        builds['s3c'] = load_build(root, identifier(s3c), 'uz_s3c_xo2', 'diamond', cycle)
    return builds


def verified_firmware(build, extension: str) -> tuple[Path, str]:
    """Accept only a published firmware file recorded by a fresh successful build."""
    row = _row(build)
    if row['status'] != 'success':
        detail = row.get('error') or ', '.join(row['changed_inputs'] + row['changed_outputs'])
        raise BuildError(f'{build.qualified_name}: {build.backend} build is {row["status"]}' +
                         (f' ({detail})' if detail else '') +
                         f'; run python -m toolchain build --program {build.name} --backend {build.backend} --release-cycle {build.release_cycle}')
    firmware = build.firmware_path(extension)
    record_path = build.directory / 'metadata/build.json'
    try:
        record = json.loads(record_path.read_text())
        expected = record['outputs'][firmware.name]
    except (OSError, ValueError, KeyError, TypeError) as exc:
        raise BuildError(f'{build.qualified_name}: {extension.upper()} is absent from successful build provenance') from exc
    if not firmware.is_file() or firmware.is_symlink() or digest(firmware) != expected:
        raise BuildError(f'{build.qualified_name}: published {extension.upper()} is missing or changed: {firmware}')
    if extension == 'jed' and jedec_metadata(firmware)[1] != record['identity']['usercode']:
        raise BuildError(f'{build.qualified_name}: JEDEC USERCODE differs from its registered build identity')
    return firmware, expected


def verified_jed(build) -> tuple[Path, str]:
    return verified_firmware(build, 'jed')


def jedec_metadata(jed: Path) -> tuple[str, str]:
    """Read the fuse checksum and usercode embedded in a Diamond JEDEC file."""
    data = jed.read_bytes()
    checksums = re.findall(rb'(?m)^C([0-9A-Fa-f]{4})\*\r?$', data)
    usercodes = re.findall(rb'(?m)^UH([0-9A-Fa-f]{8})\*\r?$', data)
    if len(checksums) != 1 or len(usercodes) != 1:
        raise BuildError(f'{jed}: expected one JEDEC fuse checksum and one usercode')
    return checksums[0].decode().upper(), usercodes[0].decode().upper()


def render_xcf(template: Path, entries: dict[int, Path], *, device_name: str, idcode: str,
               port: int | None = None) -> bytes:
    """Keep the known chain definition and replace its machine-specific data."""
    if template.is_symlink() or not template.is_file():
        raise BuildError(f'Missing regular XCF template: {template}')
    tree = ET.parse(template)
    root = tree.getroot()
    devices = root.findall('./Chain/Device')
    found = {}
    for device in devices:
        position = int(device.findtext('Pos', '0'))
        if position in found:
            raise BuildError(f'{template}: duplicate JTAG position {position}')
        found[position] = device
    if set(found) != set(entries):
        raise BuildError(f'{template}: expected chain positions {sorted(entries)}, found {sorted(found)}')
    for position, jed in entries.items():
        device = found[position]
        selected = device.find('SelectedProg')
        if (device.findtext('Name') != device_name or
                device.findtext('IDCode', '').lower() != idcode.lower() or
                selected is None or selected.get('value') != 'TRUE'):
            raise BuildError(f'{template}: unexpected device or disabled position {position}')
        checksum, usercode = jedec_metadata(jed)
        device.find('File').text = str(jed.resolve())
        device.find('FileTime').text = datetime.fromtimestamp(jed.stat().st_mtime).strftime('%m/%d/%y %H:%M:%S')
        device.find('JedecChecksum').text = f'0x{checksum}'
        device.find('./Option/Usercode').text = f'0x{usercode}'
        if device.findtext('Operation') != 'FLASH Erase,Program,Verify':
            raise BuildError(f'{template}: position {position} does not use verified Flash programming')
    # Cable serial numbers belong to a programming station, not the source tree.
    cable = root.find('CableOptions')
    if cable is not None:
        for item in cable.findall('USBID'):
            cable.remove(item)
    port = DEFAULT_DIAMOND_PORT if port is None else port
    port_address = root.find('./CableOptions/PortAdd')
    if port < 0 or port_address is None or root.findtext('./CableOptions/CableName') != 'USB2':
        raise BuildError(f'{template}: cannot select USB2 port {port}')
    port_address.text = f'FTUSB-{port}'
    ET.indent(tree, space='\t')
    return (b"<?xml version='1.0' encoding='utf-8' ?>\n"
            b'<!DOCTYPE ispXCF SYSTEM "IspXCF.dtd" >\n' +
            ET.tostring(root, encoding='utf-8') + b'\n')


def _atomic_bytes(path: Path, payload: bytes):
    fd, temporary = tempfile.mkstemp(prefix=f'.{path.name}-', dir=path.parent)
    try:
        with os.fdopen(fd, 'wb') as stream:
            stream.write(payload)
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


def generate(root: Path, slots: dict[int, str], s3c: str,
             release_cycle: str | None = None, *, rebuild: bool = False,
             chain: str | None = None, port: int | None = None,
             build_backend: str = 'diamond') -> Path:
    """Generate selected XCFs, optionally rebuilding the Diamond firmware."""
    if build_backend != 'diamond':
        raise BuildError('Diamond programming and programmer-project require Diamond JEDEC builds; '
                         'use programmer_backend=foss to program FOSS builds, or select build_backend=diamond')
    root = root.resolve()
    cycle = resolve_release(root, release_cycle)
    if chain not in (None, 's3c', 'dslots'):
        raise BuildError(f'Unknown programmer chain: {chain}')
    if chain != 's3c' and set(slots) != set(range(1, 6)):
        raise BuildError('Exactly D-slot positions 1 through 5 are required')
    builds = selected_builds(root, cycle, slots, s3c, chain)
    unique = {build.directory: build for build in builds.values()}
    if rebuild:
        for build in sorted(unique.values(), key=lambda item: str(item.directory)):
            build_program(build)
    with ExitStack() as stack:
        for build in sorted(unique.values(), key=lambda item: str(item.directory)):
            stack.enter_context(locked(build))
        jed_paths = {}
        hashes = {}
        for label, build in builds.items():
            jed, sha256 = verified_jed(build)
            jed_paths[label] = jed
            hashes[label] = sha256
        xcfs, templates = {}, {}
        if chain != 's3c':
            templates['dslots'] = digest(root / SLOT_TEMPLATE)
            xcfs['dslots.xcf'] = render_xcf(root / SLOT_TEMPLATE,
                              {position: jed_paths[f'slot{position}'] for position in range(1, 6)},
                              device_name='LCMXO2-2000HC', idcode='0x012bb043', port=port)
        if chain != 'dslots':
            templates['s3c'] = digest(root / S3C_TEMPLATE)
            xcfs['s3c.xcf'] = render_xcf(root / S3C_TEMPLATE, {1: jed_paths['s3c']},
                             device_name='LCMXO2-4000HC', idcode='0x012bc043', port=port)
        output = root / 'toolchain/build/programmer' / cycle
        if chain:
            output /= chain
        for parent in (output, *output.parents):
            if parent == root:
                break
            if parent.is_symlink():
                raise BuildError(f'Programmer output path must not be a symlink: {parent}')
        output.mkdir(parents=True, exist_ok=True)
        for name, payload in xcfs.items():
            _atomic_bytes(output / name, payload)
        write_json(output / 'selection.json', {
            'release_cycle': cycle,
            'programmer_backend': 'diamond',
            'build_backend': build_backend,
            'slots': {str(position): name for position, name in slots.items()},
            's3c': s3c,
            'firmware_sha256': hashes,
            'usercodes': {label: jedec_metadata(path)[1] for label, path in jed_paths.items()},
            'template_sha256': templates,
            'xcf_sha256': {name: hashlib.sha256(payload).hexdigest() for name, payload in xcfs.items()},
        })
    return output


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description='Generate separate D-slot and S3C Lattice Programmer XCF files.')
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--release-cycle', help='Override selection release; otherwise use the current cycle')
    parser.add_argument('--build-backend', choices=('diamond', 'foss'),
                        help='Firmware build backend (default: diamond; XCF export requires diamond)')
    parser.add_argument('--selection', type=Path, help='TOML file containing all five slot programs and S3C')
    parser.add_argument('--slot', action='append', metavar='POSITION=PROGRAM',
                        help='Repeat once for each D-slot position 1 through 5')
    parser.add_argument('--s3c', help='Program for the separate S3C chain')
    parser.add_argument('--build', action='store_true', help='Rebuild selected Diamond programs before generating XCFs')
    parser.add_argument('--probe-index', type=int, help='Diamond USB2 port number (FTUSB-N) for both exported chains')
    args = parser.parse_args(argv)
    try:
        if args.probe_index is not None and args.probe_index < 0:
            raise BuildError('--probe-index must be nonnegative')
        if args.selection:
            if args.slot or args.s3c:
                raise BuildError('Use either --selection or all --slot/--s3c arguments')
            slots, s3c, selection_release, _ = read_selection(args.selection)
            if args.release_cycle is None:
                args.release_cycle = selection_release
        else:
            if not args.s3c:
                raise BuildError('Provide --s3c and all five --slot assignments, or --selection')
            slots, s3c = slot_assignments(args.slot or []), identifier(args.s3c)
        output = generate(args.root, slots, s3c, args.release_cycle, rebuild=args.build,
                          build_backend=args.build_backend or 'diamond', port=args.probe_index)
    except (BuildError, ET.ParseError, OSError) as exc:
        parser.exit(2, f'programmer_helper: {exc}\n')
    print(output / 'dslots.xcf')
    print(output / 's3c.xcf')
    return 0
