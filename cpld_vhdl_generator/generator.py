"""Validate a small routing language and emit portable VHDL-1993 sources."""
from dataclasses import dataclass
import csv
import hashlib
import io
import json
from pathlib import Path
import re
import tempfile
try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib

from . import __version__

PACKAGE = Path(__file__).resolve().parent
CONTROLS = {'clk', 'reset', 'pilot_in', 'reqsafestate', 'carrierrdy', 'slotok', 'reqoe',
            'state_normal', 'state_safe', 'state_error', 'card_enable'}
KEYWORDS = set('''abs access after alias all and architecture array assert attribute begin block body buffer bus case component configuration constant disconnect downto else elsif end entity exit file for function generate generic group guarded if impure in inertial inout is label library linkage literal loop map mod nand new next nor not null of on open or others out package port postponed procedure process pure range record register reject rem report return rol ror select severity shared signal sla sll sra srl subtype then to transport type unaffected units until use variable wait when while with xnor xor context force parameter protected release assume cover default property restrict sequence vmode vprop vunit'''.split())
SUPPORT = ('s3c_logic.vhdl',)
RECEIPT = 'generator-output.json'


class GeneratorError(ValueError):
    """Invalid specification or an unsafe attempt to overwrite authored files."""


def identifier(value):
    if (not isinstance(value, str) or not re.fullmatch(r'[a-z][a-z0-9]*(?:_[a-z0-9]+)*', value)
            or value in KEYWORDS or value.startswith('cvg_')):
        raise GeneratorError(f'Invalid or reserved identifier: {value!r}')
    return value


def keys(data, allowed, required, label):
    if not isinstance(data, dict) or set(data) - allowed or required - set(data):
        raise GeneratorError(f'{label}: expected fields {sorted(required)}, optional {sorted(allowed-required)}')


def read_toml(path):
    try:
        return tomllib.loads(path.read_text())
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
    actions: tuple[str, str, str]


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
    fault_recovery: str
    enable: dict

    @property
    def inputs(self):
        return [self.path, self.routing, self.contract_path]


def load_config(path):
    path = Path(path).resolve()
    data = read_toml(path)
    required = {'schema_version', 'name', 'routing', 'contract', 'clock', 'pilot_policy', 'fault_recovery'}
    keys(data, required | {'enable'}, required, 'configuration')
    if type(data['schema_version']) is not int or data['schema_version'] != 1:
        raise GeneratorError('Only schema_version = 1 is supported')
    name = identifier(data['name'])
    if name == 's3c_logic':
        raise GeneratorError('Program name s3c_logic is reserved for the controller')
    for field, choices in [('clock', ('external', 'machxo2')), ('pilot_policy', ('unused', 'required')),
                           ('fault_recovery', ('safe_cycle',))]:
        if data[field] not in choices:
            raise GeneratorError(f'{field} must be one of {choices}')
    contract_ref = data['contract']
    if not isinstance(contract_ref, str):
        raise GeneratorError('contract must be a built-in ID or relative TOML path')
    builtin = PACKAGE / 'contracts' / (contract_ref + '.toml')
    contract_path = builtin if re.fullmatch(r'[a-z0-9_]+', contract_ref) and builtin.is_file() else relative(path.parent, contract_ref)
    contract = read_toml(contract_path)
    fields = {'id', 'compatible_s3c', 'request_mode', 'carrier_ready', 'slotok', 'reqoe'}
    keys(contract, fields, fields, 'contract')
    identifier(contract['id'])
    compatible = contract['compatible_s3c']
    if (not isinstance(compatible, list) or not compatible or
            any(not isinstance(item, str) for item in compatible) or len(set(compatible)) != len(compatible)):
        raise GeneratorError('compatible_s3c must list distinct program identifiers')
    for program in compatible:
        identifier(program)
    if contract['request_mode'] not in ('active_high', 'active_low'):
        raise GeneratorError('request_mode must be active_high or active_low; heartbeat is not implemented')
    if contract['carrier_ready'] not in ('unused', 'active_high', 'active_low'):
        raise GeneratorError('Invalid carrier_ready mode')
    for output in ('slotok', 'reqoe'):
        levels = contract[output]
        if not isinstance(levels, list) or len(levels) != 3 or any(type(x) is not int or x not in (0, 1) for x in levels):
            raise GeneratorError(f'{output} must contain NORMAL, SAFE, ERROR levels as three bits')
    routing = relative(path.parent, data['routing'])
    try:
        reader = csv.DictReader(io.StringIO(routing.read_text()))
        if reader.fieldnames != ['pin', 'direction', 'normal', 'safe', 'error']:
            raise GeneratorError('CSV header must be pin,direction,normal,safe,error')
        pins = []
        for line, row in enumerate(reader, 2):
            if None in row or any(v is None for v in row.values()):
                raise GeneratorError(f'CSV line {line}: expected five columns')
            p = identifier(row['pin'].strip())
            direction = row['direction'].strip()
            actions = tuple(row[s].strip().lower() for s in ('normal', 'safe', 'error'))
            if p in CONTROLS or any(old.name == p for old in pins):
                raise GeneratorError(f'CSV line {line}: duplicate or reserved pin {p}')
            if direction not in ('in', 'out'):
                raise GeneratorError(f'CSV line {line}: direction must be in or out; inout is not supported in v1')
            if direction == 'in' and any(actions):
                raise GeneratorError(f'Input {p} cannot have output actions')
            if direction == 'out' and not all(actions):
                raise GeneratorError(f'Output {p} requires an action in every state')
            pins.append(Pin(p, direction, actions))
    except OSError as exc:
        raise GeneratorError(str(exc)) from exc
    if not pins or not any(p.direction == 'out' for p in pins):
        raise GeneratorError('Routing must declare at least one output')
    inputs = {p.name for p in pins if p.direction == 'in'}
    allowed = inputs | {'0', '1', 'z'}
    for p in pins:
        if p.direction == 'out' and any(a not in allowed for a in p.actions):
            raise GeneratorError(f'{p.name}: actions must be 0, 1, Z, or a declared input')
    enable = data.get('enable', {})
    if not isinstance(enable, dict) or any(k not in inputs or type(v) is not int or v not in (0, 1) for k, v in enable.items()):
        raise GeneratorError('enable must map declared input pins to 0 or 1')
    return Config(path, name, routing, tuple(pins), contract_path, contract, data['clock'],
                  data['pilot_policy'], data['fault_recovery'], enable)


def ports(config, clock=False):
    result = [('clk', 'in'), ('reset', 'in')] if clock else []
    result += [('pilot_in', 'in'), ('reqsafestate', 'in'), ('carrierrdy', 'in'), ('slotok', 'out'), ('reqoe', 'out')]
    return result + [(p.name, p.direction) for p in config.pins]


def entity(name, declarations):
    return (f'entity {name} is\n    port (\n' +
            ';\n'.join(f'        {n} : {d} std_logic' for n, d in declarations) +
            f'\n    );\nend entity;\n')


HEADER = '-- Generated by cpld_vhdl_generator; regenerate instead of editing.\nlibrary ieee;\nuse ieee.std_logic_1164.all;\n\n'


def action(value):
    if value in ('0', '1', 'z'):
        return "'" + value.upper() + "'"
    return value


def mapping(pairs):
    return ',\n'.join(f'            {a} => {b}' for a, b in pairs)


def render(config):
    """Emit the selected S3C controller and a top level containing CSV routing."""
    c = config.contract
    request_level = '1' if c['request_mode'] == 'active_high' else '0'
    declarations, reset_lines, sampling = [], [], []
    for name, source, initial in [('request', 'reqsafestate', request_level),
                                  ('enable', 'card_enable', '0')]:
        declarations.append(f"    signal {name}_meta, {name}_sync : std_logic := '{initial}';")
        reset_lines.append(f"                {name}_meta <= '{initial}'; {name}_sync <= '{initial}';")
        sampling.append(f"                {name}_meta <= {source}; {name}_sync <= {name}_meta;")
    ready = "true"
    if c['carrier_ready'] != 'unused':
        level = '1' if c['carrier_ready'] == 'active_high' else '0'
        initial = '0' if level == '1' else '1'
        declarations.append(f"    signal ready_meta, ready_sync : std_logic := '{initial}';")
        reset_lines.append(f"                ready_meta <= '{initial}'; ready_sync <= '{initial}';")
        sampling.append('                ready_meta <= carrierrdy; ready_sync <= ready_meta;')
        ready = f"ready_sync = '{level}'"
    fault = "'0'"
    if config.pilot_policy == 'required':
        declarations.append("    signal pilot_meta, pilot_sync : std_logic := '0';")
        reset_lines.append("                pilot_meta <= '0'; pilot_sync <= '0';")
        sampling.append('                pilot_meta <= pilot_in; pilot_sync <= pilot_meta;')
        fault = "'1' when permit_normal = '1' and pilot_sync /= '1' else '0'"
    status = []
    for pin in ('slotok', 'reqoe'):
        normal, safe, error = c[pin]
        status.append(f"    {pin} <= '{normal}' when state = NORMAL and reset = '0' else "
                      f"'{error}' when state = ERROR and reset = '0' else '{safe}';")
    from string import Template
    logic = Template((PACKAGE / 'hdl' / SUPPORT[0]).read_text()).substitute(
        contract=c['id'], request_mode=c['request_mode'], carrier_ready=c['carrier_ready'],
        declarations='\n'.join(declarations), reset_lines='\n'.join(reset_lines),
        sampling='\n'.join(sampling), ready=ready, normal_level='0' if request_level == '1' else '1',
        fault=fault, status='\n'.join(status))
    external = config.clock == 'external'
    text = HEADER + entity(config.name, ports(config, external))
    text += f'\narchitecture rtl of {config.name} is\n'
    text += '    signal cvg_normal, cvg_error, cvg_card_enable : std_logic;\n'
    if not external:
        text += '''    signal cvg_clk : std_logic;
    signal cvg_reset : std_logic := '1';
    signal cvg_startup : natural range 0 to 3 := 0;
    component OSCH
        generic (NOM_FREQ : string := "2.08");
        port (STDBY : in std_logic; OSC, SEDSTDBY : out std_logic);
    end component;
'''
    text += 'begin\n'
    if not external:
        text += '''    oscillator: OSCH generic map (NOM_FREQ => "2.08")
        port map (STDBY => '0', OSC => cvg_clk, SEDSTDBY => open);
    process(cvg_clk)
    begin
        if rising_edge(cvg_clk) then
            if cvg_startup < 3 then
                cvg_startup <= cvg_startup + 1;
                cvg_reset <= '1';
            else
                cvg_reset <= '0';
            end if;
        end if;
    end process;
'''
    condition = ' and '.join(f"{pin} = '{value}'" for pin, value in sorted(config.enable.items()))
    text += f"    cvg_card_enable <= '1' when {condition} else '0';\n" if condition else "    cvg_card_enable <= '1';\n"
    pairs = [('clk', 'clk' if external else 'cvg_clk'), ('reset', 'reset' if external else 'cvg_reset')]
    pairs += [(name, name) for name in ('pilot_in', 'reqsafestate', 'carrierrdy', 'slotok', 'reqoe')]
    pairs += [('card_enable', 'cvg_card_enable'), ('state_normal', 'cvg_normal'),
              ('state_safe', 'open'), ('state_error', 'cvg_error')]
    text += '    controller: entity work.s3c_logic\n        port map (\n' + mapping(pairs) + '\n        );\n'
    for p in config.pins:
        if p.direction == 'out':
            normal, safe, error = map(action, p.actions)
            text += f"    {p.name} <= {normal} when cvg_normal = '1' else {error} when cvg_error = '1' else {safe};\n"
    text += 'end architecture;\n'
    return {'s3c_logic.vhdl': logic, config.name + '.vhdl': text}


def dependencies(config):
    """Authored and generator inputs required to reproduce the emitted files."""
    return config.inputs + sorted(PACKAGE.glob('*.py')) + [PACKAGE / 'hdl' / name for name in SUPPORT]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_paths(config, output):
    return [output / 's3c_logic.vhdl', output / (config.name + '.vhdl')]


def receipt(config, output, files):
    # Relative names keep specifications relocatable; hashes identify the contents.
    import os
    return {
        'generator_version': __version__, 'schema_version': 1, 'name': config.name,
        'contract': config.contract,
        'inputs': {('generator/' + str(p.relative_to(PACKAGE)) if p.is_relative_to(PACKAGE)
                    else 'spec/' + os.path.relpath(p, config.path.parent)): digest(p) for p in dependencies(config)},
        'sources': [os.path.relpath(p, output) for p in source_paths(config, output)],
        'files': {name: hashlib.sha256(value.encode()).hexdigest() for name, value in files.items()},
    }


def check(config_path, output):
    """Fail if generated files or provenance differ from the current specification."""
    config = load_config(config_path)
    output = Path(output).resolve()
    files = render(config)
    for name, value in files.items():
        p = output / name
        if not p.is_file() or p.read_bytes() != value.encode():
            raise GeneratorError(f'Stale or missing generated file: {p}; run the generator')
    try:
        actual = json.loads((output / RECEIPT).read_text())
        expected = receipt(config, output, files)
    except (OSError, ValueError) as exc:
        raise GeneratorError(f'Invalid generation receipt: {exc}') from exc
    if actual != expected:
        raise GeneratorError('Generation inputs changed; run the generator to refresh provenance')
    return config


def write_atomic(path, value):
    with tempfile.NamedTemporaryFile(mode='w', dir=path.parent, delete=False) as stream:
        temporary = Path(stream.name)
        stream.write(value)
    try:
        temporary.replace(path)
    finally:
        temporary.unlink(missing_ok=True)


def generate(config_path, output):
    """Emit owned VHDL files; never overwrite manually edited or unowned files."""
    config = load_config(config_path)
    output = Path(output).resolve()
    files = render(config)
    if set(output / n for n in (*files, RECEIPT)) & set(config.inputs):
        raise GeneratorError('Generated output would overwrite a specification')
    old_files = {}
    record = output / RECEIPT
    if record.is_symlink():
        raise GeneratorError('Generation receipt must not be a symlink')
    if record.exists():
        try:
            old_files = json.loads(record.read_text())['files']
        except (OSError, ValueError, KeyError) as exc:
            raise GeneratorError(f'Invalid generation receipt: {exc}') from exc
        if not isinstance(old_files, dict) or any(Path(n).name != n for n in old_files):
            raise GeneratorError('Invalid generated filenames in receipt')
    if {output / name for name in old_files} & set(config.inputs):
        raise GeneratorError('A specification input conflicts with a previously generated file')
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
