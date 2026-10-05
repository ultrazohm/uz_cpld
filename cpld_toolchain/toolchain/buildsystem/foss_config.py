"""Translate board LPFs to package pins and complete MachXO2 configuration enums."""
import json
import re
import shlex

from .model import BuildError


DEVICE_PACKAGES = {
    'LCMXO2-2000HC-4TG100C': ('LCMXO2-2000', 'TQFP100'),
    'LCMXO2-4000HC-4TG144C': ('LCMXO2-4000', 'TQFP144'),
}

S3C_BANKS = {0: '3.3', 1: '1.8', 2: '1.8', 3: '1.8', 4: '3.3', 5: '3.3'}
# These tiles carry the three 1.8 V bank enums in the archived Diamond S3C image.
S3C_BANK_TILES = {1: 'CIB_R11C32:CIB_EBR2_END1',
                  2: 'PB16:PIC_B_DUMMY_VIQ_VREF',
                  3: 'PL21:LLC1'}
# Vendor-verified exception used by both archived S3C controllers. Diamond 3.14
# selects open drain for these LVCMOS33 outputs in the 1.8 V bank. Keep support
# narrow until other pin types and drive settings have an electrical comparison.
S3C_OPEN_DRAIN_PINS = {'41': 'PB4:PIC_B0', '50': 'PB13:PIC_B0'}
S3C_OPEN_DRAIN_BITS = {'F0B18', 'F5B10', 'F5B12', 'F5B14', 'F5B20', 'F5B24', 'F5B36'}


def device_database(suite, device):
    try:
        density, package = DEVICE_PACKAGES[device]
    except KeyError as exc:
        raise BuildError(f'Unsupported FOSS device: {device}') from exc
    return suite / 'share/trellis/database/MachXO2' / density, package


def validate_s3c_banks(settings, device):
    """Require the Rev05 S3C board's bank supplies to be stated exactly."""
    declared = {key: value for key, value in settings.items() if key.startswith('BANK_')}
    if device != 'LCMXO2-4000HC-4TG144C' and declared:
        raise BuildError('BANK VCCIO settings are supported only for the S3C target')
    if device == 'LCMXO2-4000HC-4TG144C':
        actual = {int(key[5:]): value for key, value in declared.items()}
        if actual != S3C_BANKS:
            raise BuildError(f'S3C LPF BANK VCCIO settings must be {S3C_BANKS}; got {actual}')


def package_lpf(lpf, ports, suite, device, settings):
    """Resolve Diamond PIO site names through the selected package database."""
    validate_s3c_banks(settings, device)
    device_path, package_name = device_database(suite, device)
    data = json.loads((device_path / 'iodb.json').read_text())
    package = data['packages'][package_name]
    max_row = max(p['row'] for p in data['pio_metadata'])
    max_col = max(p['col'] for p in data['pio_metadata'])
    banks = {(p['row'], p['col'], p['pio']): p['bank'] for p in data['pio_metadata'] if 'bank' in p}
    sites = {}
    for pin, pio in package.items():
        row, col, letter = pio['row'], pio['col'], pio['pio']
        if row == 0:
            site = f'PT{col + 1}{letter}'
        elif row == max_row:
            site = f'PB{col + 1}{letter}'
        elif col == 0:
            site = f'PL{row}{letter}'
        elif col == max_col:
            site = f'PR{row}{letter}'
        else:
            raise BuildError(f'Unexpected interior package IO: {pin}')
        sites[site] = pin
    lines, ignored, assigned, io_types = [], [], {}, {}
    port_pins, attributes = {}, {}
    def active_port(name):
        if name in ports:
            return True
        match = re.fullmatch(r'(.+)\[(\d+)\]', name)
        if not match or not isinstance(ports, dict) or match[1] not in ports:
            return False
        bus = ports[match[1]]
        offset = bus.get('offset', 0)
        return offset <= int(match[2]) < offset + len(bus['bits'])

    for command in lpf.split(';'):
        words = shlex.split(command)
        if not words:
            continue
        port = words[2]
        if not active_port(port):
            ignored.append({'command': command.strip(), 'reason': 'Port absent from synthesized top-level interface'})
            continue
        if words[0] == 'LOCATE':
            site = words[4]
            pin = site if site in package else sites.get(site)
            if pin is None:
                raise BuildError(f'Unknown or unbonded {package_name} IO site: {site}')
            if pin in assigned and assigned[pin] != port:
                raise BuildError(f'Conflicting package pin {pin}: {assigned[pin]} and {port}')
            if port in port_pins and port_pins[port] != pin:
                raise BuildError(f'Conflicting locations for port {port}: {port_pins[port]} and {pin}')
            port_pins[port] = pin
            assigned[pin] = port
            lines.append(f'LOCATE COMP "{port}" SITE "{pin}";')
        else:
            for attr in words[3:]:
                key, value = attr.split('=', 1)
                if (port, key) in attributes and attributes[port, key] != value:
                    raise BuildError(f'Conflicting IOBUF setting for {port}: {key}')
                attributes[port, key] = value
                if key == 'IO_TYPE':
                    io_types[port] = value
            lines.append(command.strip() + ';')
    open_drain = []
    for (port, key), value in attributes.items():
        if key != 'OPENDRAIN':
            continue
        pin = port_pins.get(port)
        direction = ports.get(port, {}).get('direction') if isinstance(ports, dict) else None
        expected_attrs = {'IO_TYPE': 'LVCMOS33', 'OPENDRAIN': 'ON', 'PULLMODE': 'NONE',
                          'DRIVE': '12', 'SLEWRATE': 'SLOW'}
        if (device != 'LCMXO2-4000HC-4TG144C' or pin not in S3C_OPEN_DRAIN_PINS or
                direction != 'output' or
                any(attributes.get((port, key)) != value for key, value in expected_attrs.items())):
            raise BuildError(f'Unsupported open-drain configuration for {port}; verified support is limited to '
                             'S3C outputs on pins 41/50 with LVCMOS33, OPENDRAIN=ON, PULLMODE=NONE, '
                             'DRIVE=12 and SLEWRATE=SLOW')
        pio = package[pin]
        if pio != {'row': 22, 'col': 3 if pin == '41' else 12, 'pio': 'B'}:
            raise BuildError(f'Unexpected package mapping for open-drain pin {pin}')
        open_drain.append({'port': port, 'pin': pin, 'tile': S3C_OPEN_DRAIN_PINS[pin]})
    if device == 'LCMXO2-4000HC-4TG144C':
        for pin, port in assigned.items():
            pio = package[pin]
            bank = banks[(pio['row'], pio['col'], pio['pio'])]
            expected = 'LVCMOS18' if settings[f'BANK_{bank}'] == '1.8' else 'LVCMOS33'
            if io_types.get(port) != expected and not any(item['port'] == port for item in open_drain):
                raise BuildError(f'{port} on S3C bank {bank} requires IO_TYPE={expected}')
    return '\n'.join(lines) + '\n', {'pins': assigned, 'ignored': ignored, 'open_drain': open_drain}


def complete_config(path, settings, suite, device, open_drain=()):
    """Apply only database-verified configuration values before bit packing."""
    validate_s3c_banks(settings, device)
    database = suite / 'share/trellis/database/MachXO2'
    device_path, _ = device_database(suite, device)
    grid = json.loads((device_path / 'tilegrid.json').read_text())
    text = path.read_text()
    additions = {}
    for key, tile_type, enum_name in [('SDM_PORT', 'CFG0', 'SYSCONFIG.SDM_PORT'),
                                      ('SLAVE_SPI_PORT', 'CFG1', 'SYSCONFIG.SLAVE_SPI_PORT'),
                                      ('I2C_PORT', 'CFG1', 'SYSCONFIG.I2C_PORT'),
                                      ('MCCLK_FREQ', 'CFG1', 'OSCH.NOM_FREQ')]:
        if key not in settings:
            continue
        value = settings[key]
        # 2.08 MHz matches the default CFG1 encoding checked against Diamond.
        # Other clock settings require a device-specific vendor comparison.
        if key == 'MCCLK_FREQ' and value != '2.08':
            raise BuildError('FOSS packing currently supports only MCCLK_FREQ=2.08')
        bits = (database / f'tiledata/{tile_type}/bits.db').read_text()
        match = re.search(r'^\.config_enum ' + re.escape(enum_name) + r' [^\n]*\n(.*?)(?:\n\n|\Z)', bits, re.M | re.S)
        if not match or value not in [line.split()[0] for line in match[1].splitlines() if line.strip()]:
            raise BuildError(f'Trellis database does not support {enum_name}={value}')
        tiles = [name for name, tile in grid.items() if tile['type'] == tile_type]
        if len(tiles) != 1:
            raise BuildError(f'Expected one {tile_type} tile')
        additions.setdefault(tiles[0], {})[enum_name] = value
    if device == 'LCMXO2-4000HC-4TG144C':
        for bank, tile in S3C_BANK_TILES.items():
            key = f'BANK_{bank}'
            if key not in settings:
                continue
            if tile not in grid:
                raise BuildError(f'Missing S3C bank {bank} tile in Trellis database: {tile}')
            bits = (database / f'tiledata/{grid[tile]["type"]}/bits.db').read_text()
            value = settings[key]
            match = re.search(r'^\.config_enum BANK\.VCCIO [^\n]*\n(.*?)(?:\n\n|\Z)', bits, re.M | re.S)
            if not match or value not in [line.split()[0] for line in match[1].splitlines() if line.strip()]:
                raise BuildError(f'Trellis database does not support S3C bank {bank} VCCIO={value}')
            additions.setdefault(tile, {})['BANK.VCCIO'] = value
    for tile, enums in additions.items():
        pattern = r'(^\.tile ' + re.escape(tile) + r'\n)(.*?)(?=^\.|\Z)'
        match = re.search(pattern, text, re.M | re.S)
        content = match[2] if match else ''
        for name, value in enums.items():
            existing = re.search(r'^enum: ' + re.escape(name) + r' (\S+)', content, re.M)
            if existing and existing[1] != value:
                raise BuildError(f'Conflicting synthesized setting {name}: {existing[1]} versus {value}')
            if not existing:
                content += f'enum: {name} {value}\n'
        replacement = f'.tile {tile}\n{content}\n'
        if match:
            text = text[:match.start()] + replacement + text[match.end():]
        else:
            text += '\n' + replacement
    for output in open_drain:
        tile = output['tile']
        pattern = r'(^\.tile ' + re.escape(tile) + r'\n)(.*?)(?=^\.|\Z)'
        match = re.search(pattern, text, re.M | re.S)
        required = {'PIOB.BASE_TYPE': 'OUTPUT_LVCMOS33', 'PIOB.OPENDRAIN': 'ON',
                    'PIOB.DRIVE': '12', 'PIOB.SLEWRATE': 'SLOW'}
        if not match or any(not re.search(r'^enum: ' + re.escape(key) + ' ' + value + r'$',
                                         match[2], re.M) for key, value in required.items()):
            raise BuildError(f'Missing routed open-drain settings for {output["port"]}')
        # The pinned Trellis DRIVE enum was characterized at 3.3 V. It overlaps
        # OPENDRAIN and overwrites that setting when packed after it. Use the
        # 1.8 V / 12 mA encoding measured from Diamond instead: retain BASE_TYPE,
        # OPENDRAIN and SLEWRATE, replace DRIVE by its three remaining set bits.
        # The full electrical field is checked again after packing and decoding.
        content = re.sub(r'^enum: PIOB.DRIVE 12\n', '', match[2], flags=re.M)
        content = content.rstrip() + '\nunknown: F5B10\nunknown: F5B12\nunknown: F5B36\n\n'
        text = text[:match.start()] + match[1] + content + text[match.end():]
    path.write_text(text)


def verify_open_drain(path, outputs, suite):
    """Check packed I/O electrical bits against the Diamond reference encoding.

    Decode aliases overlap (an output can be printed as INPUT_LVCMOS18 plus an
    unknown output-enable bit), so compare electrical bits, not enum names.
    This verifies only the two supported output buffers, not the entire design.
    """
    if not outputs:
        return []
    database = suite / 'share/trellis/database/MachXO2/tiledata/PIC_B0/bits.db'
    definitions, mask = {}, set()
    fields = ('BASE_TYPE', 'CLAMP', 'DRIVE', 'HYSTERESIS', 'OPENDRAIN', 'PULLMODE', 'SLEWRATE')
    for field in fields:
        key = 'PIOB.' + field
        match = re.search(r'^\.config_enum ' + re.escape(key) + r'[^\n]*\n(.*?)(?=^\.|\Z)',
                          database.read_text(), re.M | re.S)
        if not match:
            raise BuildError(f'Trellis database lacks {key}')
        for line in match[1].splitlines():
            words = line.split()
            if not words:
                continue
            bits = [bit for bit in words[1:] if re.fullmatch(r'!?F\d+B\d+', bit)]
            definitions[key, words[0]] = {bit for bit in bits if not bit.startswith('!')}
            mask.update(bit.lstrip('!') for bit in bits)
    text, verified = path.read_text(), []
    for output in outputs:
        match = re.search(r'^\.tile ' + re.escape(output['tile']) + r'\n(.*?)(?=^\.|\Z)',
                          text, re.M | re.S)
        if not match:
            raise BuildError(f'Missing packed tile for {output["port"]}')
        bits = set()
        for line in match[1].splitlines():
            words = line.split()
            if len(words) == 3 and words[0] == 'enum:' and words[1] in {'PIOB.' + f for f in fields}:
                if (words[1], words[2]) not in definitions:
                    raise BuildError(f'Unknown decoded electrical setting: {line}')
                bits.update(definitions[words[1], words[2]])
            elif len(words) == 2 and words[0] == 'unknown:' and words[1] in mask:
                bits.add(words[1])
        if bits != S3C_OPEN_DRAIN_BITS:
            raise BuildError(f'Packed open-drain settings differ from Diamond for {output["port"]}: '
                             f'missing {sorted(S3C_OPEN_DRAIN_BITS - bits)}, '
                             f'unexpected {sorted(bits - S3C_OPEN_DRAIN_BITS)}')
        verified.append({**output, 'reference': 'Diamond 3.14, bank 2 at 1.8 V, LVCMOS33 open drain, 12 mA',
                         'electrical_bits': sorted(bits), 'result': 'matched'})
    return verified
