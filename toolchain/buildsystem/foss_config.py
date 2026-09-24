"""Translate board LPFs to package pins and complete MachXO2 configuration enums."""
import json
import re
import shlex

from .model import BuildError


def package_lpf(lpf, ports, suite):
    """Resolve Diamond PIO site names through the pinned TQFP100 database."""
    data = json.loads((suite / 'share/trellis/database/MachXO2/LCMXO2-2000/iodb.json').read_text())
    package = data['packages']['TQFP100']
    max_row = max(p['row'] for p in data['pio_metadata'])
    max_col = max(p['col'] for p in data['pio_metadata'])
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
    lines, ignored, assigned = [], [], {}
    for command in lpf.split(';'):
        words = shlex.split(command)
        if not words:
            continue
        port = words[2]
        if port not in ports:
            ignored.append({'command': command.strip(), 'reason': 'Port absent from synthesized top-level interface'})
            continue
        if words[0] == 'LOCATE':
            site = words[4]
            pin = site if site in package else sites.get(site)
            if pin is None:
                raise BuildError(f'Unknown or unbonded TQFP100 IO site: {site}')
            if pin in assigned and assigned[pin] != port:
                raise BuildError(f'Conflicting package pin {pin}: {assigned[pin]} and {port}')
            assigned[pin] = port
            lines.append(f'LOCATE COMP "{port}" SITE "{pin}";')
        else:
            lines.append(command.strip() + ';')
    return '\n'.join(lines) + '\n', {'pins': assigned, 'ignored': ignored}


def complete_config(path, settings, suite):
    """Apply only database-verified configuration values before bit packing."""
    database = suite / 'share/trellis/database/MachXO2'
    grid = json.loads((database / 'LCMXO2-2000/tilegrid.json').read_text())
    text = path.read_text()
    additions = {}
    for key, tile_type, enum_name in [('SDM_PORT', 'CFG0', 'SYSCONFIG.SDM_PORT'),
                                      ('SLAVE_SPI_PORT', 'CFG1', 'SYSCONFIG.SLAVE_SPI_PORT'),
                                      ('MCCLK_FREQ', 'CFG1', 'OSCH.NOM_FREQ')]:
        if key not in settings:
            continue
        value = settings[key]
        # 2.08 MHz matches the default CFG1 oscillator and control-register encoding.
        # Other configuration clock encodings require separate vendor comparison.
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
    path.write_text(text)
