"""Validate a small routing language and emit portable VHDL-1993 sources."""
from dataclasses import dataclass
import csv
import hashlib
import io
import json
import os
from pathlib import Path
import re
import tempfile
try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib

from . import __version__
from xo2_library import S3C_DIRECTORY

PACKAGE = Path(__file__).resolve().parent
DATA_PINS = tuple(f'{bank}_{i:02d}' for bank in ('fpga', 'd') for i in range(30))
KEYWORDS = set('''abs access after alias all and architecture array assert attribute begin block body buffer bus case component configuration constant disconnect downto else elsif end entity exit file for function generate generic group guarded if impure in inertial inout is label library linkage literal loop map mod nand new next nor not null of on open or others out package port postponed procedure process pure range record register reject rem report return rol ror select severity shared signal sla sll sra srl subtype then to transport type unaffected units until use variable wait when while with xnor xor context force parameter protected release assume cover default property restrict sequence vmode vprop vunit'''.split())
RECEIPT = 'generator-output.json'
# Entity names must not hide libraries, types, literals or functions used below,
# or bind the internal oscillator component to the generated top itself.
RESERVED_PROGRAM_NAMES = {'ieee', 'std', 'work', 's3c', 's3c_logic', 'std_logic',
                          'natural', 'string', 'rising_edge', 'true', 'false', 'osch'}


class GeneratorError(ValueError):
    """Invalid specification or an unsafe attempt to overwrite authored files."""


def identifier(value):
    if (not isinstance(value, str) or not re.fullmatch(r'[a-z][a-z0-9]*(?:_[a-z0-9]+)*', value)
            or value in KEYWORDS):
        raise GeneratorError(f'Invalid or reserved identifier: {value!r}')
    return value


def program_name(value):
    """Canonical generated program name; applying the prefix twice is harmless."""
    value = identifier(value)
    if value in RESERVED_PROGRAM_NAMES or value == 'generator' or value.startswith('s3c_'):
        raise GeneratorError(f'Program name {value} is reserved by the generated VHDL')
    return value if value.startswith('cvg_') else 'cvg_' + value


def keys(data, allowed, required, label):
    if not isinstance(data, dict) or set(data) - allowed or required - set(data):
        raise GeneratorError(f'{label}: expected fields {sorted(required)}, optional {sorted(allowed-required)}')


def read_toml(path):
    try:
        return tomllib.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise GeneratorError(f'{path}: {exc}') from exc


def relative(base, value):
    if not isinstance(value, str) or not value or Path(value).is_absolute():
        raise GeneratorError(f'Expected a relative file path: {value!r}')
    return (base / value).resolve()


@dataclass(frozen=True)
class Pin:
    name: str
    direction: str
    actions: tuple[str, str]


@dataclass(frozen=True)
class Config:
    path: Path
    name: str
    routing: Path
    pins: tuple[Pin, ...]
    contract_path: Path
    contract: dict
    clock: str
    pilot_policy: str
    enable: dict
    s3c_library: Path
    target: str | None = None
    standard: str = '1993'
    synthesis: str = 'lse'

    @property
    def inputs(self):
        return [self.path, self.routing, self.contract_path]


def load_contract(path):
    """Read and validate a level-based or heartbeat S3C contract."""
    contract = read_toml(path)
    fields = {'id', 'compatible_s3c', 'request_mode', 'carrier_ready', 'slotok', 'reqoe', 'implementation'}
    keys(contract, fields | {'heartbeat'}, fields, 'contract')
    identifier(contract['id'])
    implementation = identifier(contract['implementation'])
    if implementation == 's3c_logic':
        raise GeneratorError('implementation must name an architecture source, not the entity declaration')
    compatible = contract['compatible_s3c']
    if (not isinstance(compatible, list) or not compatible or
            any(not isinstance(item, str) for item in compatible) or len(set(compatible)) != len(compatible)):
        raise GeneratorError('compatible_s3c must list distinct program identifiers')
    for program in compatible:
        identifier(program)
    if contract['request_mode'] not in ('active_high', 'active_low'):
        raise GeneratorError('request_mode must be active_high or active_low; heartbeat belongs on carrier_ready')
    if contract['carrier_ready'] not in ('unused', 'active_high', 'active_low', 'heartbeat'):
        raise GeneratorError('Invalid carrier_ready mode')
    if implementation == 'heartbeat':
        if contract['carrier_ready'] != 'heartbeat':
            raise GeneratorError('heartbeat implementation requires carrier_ready = "heartbeat"')
        timing = contract.get('heartbeat')
        timing_fields = {'timeout_clks', 'min_edge_clks', 'max_edge_clks', 'valid_edges_required'}
        keys(timing, timing_fields, timing_fields, 'heartbeat timing')
        if any(type(value) is not int or not 1 <= value <= 2_147_483_647 for value in timing.values()):
            raise GeneratorError('heartbeat timing values must be positive VHDL integers')
        if not timing['min_edge_clks'] <= timing['max_edge_clks'] < timing['timeout_clks']:
            raise GeneratorError('heartbeat requires min_edge_clks <= max_edge_clks < timeout_clks')
        if timing['valid_edges_required'] < 2:
            raise GeneratorError('heartbeat requires at least two qualifying edges')
    elif contract['carrier_ready'] == 'heartbeat' or 'heartbeat' in contract:
        raise GeneratorError('heartbeat timing and carrier_ready require implementation = "heartbeat"')
    for output in ('slotok', 'reqoe'):
        levels = contract[output]
        if not isinstance(levels, list) or len(levels) != 2 or any(type(x) is not int or x not in (0, 1) for x in levels):
            raise GeneratorError(f'{output} must contain normal_state and safe_state levels as two bits')
    return contract


def load_routing(path):
    """Read output actions and infer directions for the complete data interface."""
    try:
        reader = csv.DictReader(io.StringIO(path.read_text(encoding="utf-8")))
        if reader.fieldnames != ['output', 'normal_state', 'safe_state']:
            raise GeneratorError('CSV header must be output,normal_state,safe_state')
        outputs = {}
        for line, row in enumerate(reader, 2):
            if None in row or any(v is None for v in row.values()):
                raise GeneratorError(f'CSV line {line}: expected three columns')
            output = row['output'].strip()
            if output not in DATA_PINS:
                raise GeneratorError(f'CSV line {line}: output must be d_00..d_29 or fpga_00..fpga_29: {output!r}')
            if output in outputs:
                raise GeneratorError(f'CSV line {line}: duplicate output {output}')
            actions = tuple(row[state].strip() for state in ('normal_state', 'safe_state'))
            if any(value not in DATA_PINS and value not in ('0', '1', 'Z') for value in actions):
                raise GeneratorError(f'CSV line {line}: actions must be d_00..d_29, fpga_00..fpga_29, 0, 1, or Z')
            outputs[output] = actions
    except OSError as exc:
        raise GeneratorError(str(exc)) from exc
    for output, actions in outputs.items():
        if any(value in outputs for value in actions):
            raise GeneratorError(f'{output}: an output cannot also be used as an input')
    # Preserve every data pin in the interface; omitted pins have no HDL driver.
    return tuple(Pin(pin, 'out', outputs[pin]) if pin in outputs else Pin(pin, 'in', ('', ''))
                 for pin in DATA_PINS)


def load_config(path):
    """Load configuration and validate its contract, routing and shared sources."""
    path = Path(path).resolve()
    data = read_toml(path)
    required = {'schema_version', 'name', 'routing', 'contract', 'clock', 'pilot_policy'}
    keys(data, required | {'enable', 's3c_library', 'target', 'standard', 'synthesis'}, required, 'configuration')
    if type(data['schema_version']) is not int or data['schema_version'] != 3:
        raise GeneratorError('Only schema_version = 3 is supported')
    name = program_name(data['name'])
    for field, choices in [('clock', ('external', 'machxo2')), ('pilot_policy', ('unused', 'required'))]:
        if data[field] not in choices:
            raise GeneratorError(f'{field} must be one of {choices}')
    target = data.get('target')
    standard = data.get('standard', '1993')
    synthesis = data.get('synthesis', 'lse')
    if standard not in ('1993', '2008'):
        raise GeneratorError('standard must be "1993" or "2008"')
    if synthesis not in ('lse', 'synplify'):
        raise GeneratorError('synthesis must be "lse" or "synplify"')
    if not target and ('standard' in data or 'synthesis' in data):
        raise GeneratorError('standard and synthesis require project target')
    if 'target' in data:
        if target != 'uz_dslot_xo2':
            raise GeneratorError('Project generation supports target = "uz_dslot_xo2"')
        if data['clock'] != 'machxo2':
            raise GeneratorError('The uz_dslot_xo2 pin map requires clock = "machxo2"')
    contract_ref = data['contract']
    if not isinstance(contract_ref, str):
        raise GeneratorError('contract must be a built-in ID or relative TOML path')
    builtin = PACKAGE / 'contracts' / (contract_ref + '.toml')
    contract_path = builtin if re.fullmatch(r'[a-z0-9_]+', contract_ref) and builtin.is_file() else relative(path.parent, contract_ref)
    contract = load_contract(contract_path)
    s3c_library = relative(path.parent, data['s3c_library']) if 's3c_library' in data else S3C_DIRECTORY
    for filename in ('s3c_logic.vhdl', contract['implementation'] + '.vhdl'):
        if not (s3c_library / filename).is_file():
            raise GeneratorError(f'Missing shared S3C source: {s3c_library / filename}')
    routing = relative(path.parent, data['routing'])
    pins = load_routing(routing)
    inputs = {pin.name for pin in pins if pin.direction == 'in'}
    enable = data.get('enable', {})
    if not isinstance(enable, dict) or any(k not in inputs or type(v) is not int or v not in (0, 1) for k, v in enable.items()):
        raise GeneratorError('enable must map input pins from d_00..d_29 or fpga_00..fpga_29 to 0 or 1')
    return Config(path, name, routing, pins, contract_path, contract, data['clock'],
                  data['pilot_policy'], enable, s3c_library, target, standard, synthesis)


def ports(config, clock=False):
    result = [('clk', 'in'), ('reset', 'in')] if clock else []
    result += [('pilot_in', 'in'), ('reqsafestate', 'in'), ('carrierrdy', 'in'), ('slotok', 'out'), ('reqoe', 'out'),
               ('i2c_scl', 'in'), ('i2c_sda', 'in')]
    return result + [(p.name, p.direction) for p in config.pins]


def entity(name, declarations):
    return (f'entity {name} is\n    port (\n' +
            ';\n'.join(f'        {n} : {d} std_logic' for n, d in declarations) +
            f'\n    );\nend entity;\n')


HEADER = '-- Generated by cpld_vhdl_generator; regenerate instead of editing.\nlibrary ieee;\nuse ieee.std_logic_1164.all;\n\n'


def action(value):
    if value in ('0', '1', 'Z'):
        return "'" + value.upper() + "'"
    return value


def mapping(pairs):
    return ',\n'.join(f'            {a} => {b}' for a, b in pairs)


def render(config, output=None):
    """Emit routing that instantiates the selected shared S3C architecture."""
    c = config.contract
    external = config.clock == 'external'
    text = HEADER + 'library s3c;\n\n' + entity(config.name, ports(config, external))
    text += f'\narchitecture rtl of {config.name} is\n'
    text += '    signal s3c_normal_state, s3c_card_enable : std_logic;\n'
    text += '    signal s3c_system_error : std_logic;\n'
    if not external:
        text += '''    signal s3c_clk : std_logic;
    component OSCH
        generic (NOM_FREQ : string := "2.08");
        port (STDBY : in std_logic; OSC, SEDSTDBY : out std_logic);
    end component;
'''
    text += 'begin\n'
    if not external:
        text += '''    oscillator: OSCH generic map (NOM_FREQ => "2.08")
        port map (STDBY => '0', OSC => s3c_clk, SEDSTDBY => open);
'''
    condition = ' and '.join(f"{pin} = '{value}'" for pin, value in sorted(config.enable.items()))
    text += f"    s3c_card_enable <= '1' when {condition} else '0';\n" if condition else "    s3c_card_enable <= '1';\n"
    pairs = [('clk', 'clk' if external else 's3c_clk'), ('reset', 'reset' if external else "'0'")]
    pairs += [(name, name) for name in ('pilot_in', 'reqsafestate', 'carrierrdy', 'slotok', 'reqoe')]
    pairs += [('card_enable', 's3c_card_enable'), ('state_normal', 's3c_normal_state'),
              ('state_safe', 'open'), ('state_system_error', 's3c_system_error')]
    generics = [('REQUIRE_PILOT', str(config.pilot_policy == 'required').lower()),
                ('REQUEST_SAFE_LEVEL', "'1'" if c['request_mode'] == 'active_high' else "'0'"),
                ('USE_CARRIER_READY', str(c['carrier_ready'] != 'unused').lower()),
                ('CARRIER_READY_LEVEL', "'0'" if c['carrier_ready'] == 'active_low' else "'1'")]
    if c['implementation'] == 'heartbeat':
        generics.extend(('HB_' + key.upper(), str(value)) for key, value in sorted(c['heartbeat'].items()))
    for pin in ('slotok', 'reqoe'):
        for state, level in zip(('NORMAL', 'SAFE'), c[pin]):
            generics.append((pin.upper() + '_' + state, f"'{level}'"))
    text += f"    controller: entity s3c.s3c_logic({c['implementation']})\n"
    text += '        generic map (\n' + mapping(generics) + '\n        )\n'
    text += '        port map (\n' + mapping(pairs) + '\n        );\n'
    for p in config.pins:
        if p.direction == 'out':
            normal, safe = map(action, p.actions)
            text += f"    {p.name} <= '0' when s3c_system_error = '1' else {normal} when s3c_normal_state = '1' else {safe};\n"
    text += 'end architecture;\n'
    files = {config.name + '.vhdl': text}
    if config.target:
        from .project import render_project
        files.update(render_project(config, Path(output or config.path.parent).resolve()))
    return files


def dependencies(config):
    """Authored and generator inputs required to reproduce the emitted files."""
    return (config.inputs + sorted(PACKAGE.glob('*.py')) + shared_sources(config) +
            ([PACKAGE / 'targets' / (config.target + '.lpf')] if config.target else []))


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


@dataclass(frozen=True)
class Source:
    path: Path
    library: str


def shared_sources(config):
    return [config.s3c_library / 's3c_logic.vhdl',
            config.s3c_library / (config.contract['implementation'] + '.vhdl')]


def source_entries(config, output):
    """Ordered sources and libraries for any consuming build tool."""
    return [Source(p, 's3c') for p in shared_sources(config)] + [Source(Path(output) / (config.name + '.vhdl'), 'work')]


def source_paths(config, output):
    return [s.path for s in source_entries(config, output)]


def receipt(config, output, files):
    # Relative names keep specifications relocatable; hashes identify the contents.
    return {
        'generator_version': __version__, 'schema_version': 1, 'name': config.name,
        'contract': config.contract,
        'inputs': {('s3c_library/' + p.name if p in shared_sources(config) else
                    'generator/' + p.relative_to(PACKAGE).as_posix() if p.is_relative_to(PACKAGE)
                    else 'spec/' + Path(os.path.relpath(p, config.path.parent)).as_posix()): digest(p) for p in dependencies(config)},
        'sources': [{'path': p.name, 'library': 's3c', 'base': 's3c_library'} for p in shared_sources(config)] +
                   [{'path': config.name + '.vhdl', 'library': 'work', 'base': 'output'}],
        'files': {name: hashlib.sha256(value.encode()).hexdigest() for name, value in files.items()},
    }


def check(config_path, output):
    """Fail if generated files or provenance differ from the current specification."""
    config = load_config(config_path)
    output = Path(output).resolve()
    files = render(config, output)
    for name, value in files.items():
        p = output / name
        if not p.is_file() or p.read_bytes() != value.encode():
            raise GeneratorError(f'Stale or missing generated file: {p}; run the generator')
    try:
        actual = json.loads((output / RECEIPT).read_text(encoding="utf-8"))
        expected = receipt(config, output, files)
    except (OSError, ValueError) as exc:
        raise GeneratorError(f'Invalid generation receipt: {exc}') from exc
    if actual != expected:
        raise GeneratorError('Generation inputs changed; run the generator to refresh provenance')
    return config


def write_atomic(path, value):
    fd, filename = tempfile.mkstemp(dir=path.parent)
    temporary = Path(filename)
    try:
        with os.fdopen(fd, 'w', encoding='utf-8', newline='\n') as stream:
            stream.write(value)
        temporary.replace(path)
    finally:
        temporary.unlink(missing_ok=True)


def generate(config_path, output):
    """Emit owned VHDL files; never overwrite manually edited or unowned files."""
    config = load_config(config_path)
    output = Path(output).resolve()
    files = render(config, output)
    protected = set(config.inputs + shared_sources(config))
    if set(output / n for n in (*files, RECEIPT)) & protected:
        raise GeneratorError('Generated output would overwrite a specification or shared source')
    old_files = {}
    record = output / RECEIPT
    if record.is_symlink():
        raise GeneratorError('Generation receipt must not be a symlink')
    if record.exists():
        try:
            old_files = json.loads(record.read_text(encoding="utf-8"))['files']
        except (OSError, ValueError, KeyError, TypeError) as exc:
            raise GeneratorError(f'Invalid generation receipt: {exc}') from exc
        if (not isinstance(old_files, dict) or
                any(not isinstance(n, str) or n in ('.', '..', RECEIPT) or Path(n).name != n
                    or not isinstance(value, str) or re.fullmatch(r'[0-9a-f]{64}', value) is None
                    for n, value in old_files.items())):
            raise GeneratorError('Invalid generated filenames or hashes in receipt')
    if {output / name for name in old_files} & protected:
        raise GeneratorError('A specification or shared source conflicts with a previously generated file')
    for name in set(files) | set(old_files):
        p = output / name
        if p.is_symlink():
            raise GeneratorError(f'Refusing to overwrite symlink: {p}')
        if p.exists() and (name not in old_files or digest(p) != old_files[name]):
            raise GeneratorError(f'Refusing to overwrite edited or unowned file: {p}')
    try:
        record_text = json.dumps(receipt(config, output, files), indent=2, sort_keys=True) + '\n'
    except OSError as exc:
        raise GeneratorError(str(exc)) from exc
    output.mkdir(parents=True, exist_ok=True)
    for name, value in files.items():
        write_atomic(output / name, value)
    for name in set(old_files) - set(files):
        (output / name).unlink(missing_ok=True)
    write_atomic(record, record_text)
    return source_paths(config, output)
