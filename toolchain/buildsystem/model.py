"""Load and validate explicit program and board manifests without running tools."""
from dataclasses import dataclass
from pathlib import Path
import re
try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib


class BuildError(Exception):
    """An actionable configuration or build failure."""


def identifier(value: str) -> str:
    """Validate a filesystem-safe program, target, or backend name."""
    if not isinstance(value, str) or not re.fullmatch(r"[a-z][a-z0-9_]*", value):
        raise BuildError(f"Invalid name: {value!r}; use lowercase letters, digits and underscores")
    return value


def read_toml(path: Path) -> dict:
    """Read a manifest, reporting parse and filesystem errors consistently."""
    try:
        with path.open('rb') as stream:
            return tomllib.load(stream)
    except (OSError, ValueError) as exc:
        raise BuildError(f"{path}: {exc}") from exc


def keys(data: dict, allowed: set, required: set, label: str):
    """Reject unknown fields and missing required fields."""
    if not isinstance(data, dict):
        raise BuildError(f"{label}: expected a table")
    if set(data) - allowed or required - set(data):
        raise BuildError(f"{label}: unknown fields {sorted(set(data)-allowed)}, missing fields {sorted(required-set(data))}")


def input_path(root: Path, base: Path, value: str) -> Path:
    """Resolve an existing input within the checkout, including symlink checks."""
    if not isinstance(value, str) or Path(value).is_absolute():
        raise BuildError(f"Input path must be relative: {value!r}")
    path = (base / value).resolve()
    if not path.is_relative_to(root.resolve()) or not path.is_file():
        raise BuildError(f"Missing input or input outside checkout: {path}")
    return path


def strings(value, label):
    """Validate a list of distinct strings."""
    if not isinstance(value, list) or any(not isinstance(v, str) for v in value) or len(set(value)) != len(value):
        raise BuildError(f"{label}: expected a list of unique strings")
    return value


@dataclass(frozen=True)
class Source:
    """An ordered VHDL input and its compilation library."""
    path: Path
    library: str


@dataclass(frozen=True)
class Build:
    """Validated inputs for one program, board target and backend."""
    root: Path
    name: str
    target: str
    backend: str
    top: str
    standard: str
    sources: tuple[Source, ...]
    constraint: Path
    device: str
    strategy: Path | None
    options: dict
    manifests: tuple[Path, ...]
    expected_version: str
    testbench: Path

    @property
    def build_root(self) -> Path:
        """Program-local generated outputs, separate from authored inputs."""
        return self.root / 'programs' / self.name / 'build'

    @property
    def directory(self) -> Path:
        """Generated output location; never an authored source directory."""
        return self.build_root / f"{self.target}_{self.backend}"

    def firmware_path(self, extension: str) -> Path:
        """Published firmware path for this program, target and backend."""
        return self.directory / f'{self.name}_{self.target}_{self.backend}.{extension}'

    @property
    def inputs(self) -> tuple[Path, ...]:
        """All authored inputs included in provenance."""
        return tuple(s.path for s in self.sources) + (self.constraint, self.testbench) + ((self.strategy,) if self.strategy else ()) + self.manifests


def catalog(root: Path) -> list[str]:
    """Return the explicitly supported catalog, excluding uncatalogued programs and archives."""
    data = read_toml(root / 'programs/catalog.toml')
    keys(data, {'programs'}, {'programs'}, 'catalog')
    return [identifier(n) for n in strings(data['programs'], 'catalog.programs')]


SUPPORTED_DEVICES = {
    'LCMXO2-2000HC-4TG100C',
    'LCMXO2-4000HC-4TG144C',
}


def program_targets(root: Path, name: str) -> list[str]:
    """Read the targets declared by one catalog program."""
    name = identifier(name)
    path = input_path(root.resolve(), root.resolve(), f'programs/{name}/{name}.toml')
    targets = strings(read_toml(path).get('targets'), f'{name}.targets')
    if not targets:
        raise BuildError(f'{name}: targets must not be empty')
    return [identifier(target) for target in targets]


def load_build(root: Path, name: str, target: str | None = None, backend: str | None = None) -> Build:
    """Validate manifests and return a build model; no vendor tools are needed."""
    root = root.resolve()
    name = identifier(name)
    declared_targets = program_targets(root, name)
    if target is None:
        if len(declared_targets) != 1:
            raise BuildError(f'{name} has multiple targets; select one explicitly')
        target = declared_targets[0]
    target = identifier(target)
    pm = input_path(root, root, f'programs/{name}/{name}.toml')
    tm = input_path(root, root, f'toolchain/targets/{target}/target.toml')
    p, t = read_toml(pm), read_toml(tm)
    pf = {'name', 'top', 'standard', 'sources', 'targets', 'constraints', 'testbench'}
    tf = {'name', 'device', 'backend', 'diamond', 'foss'}
    keys(p, pf, pf, str(pm)); keys(t, tf, {'name', 'device', 'backend'}, str(tm))
    if p['name'] != name or t['name'] != target:
        raise BuildError('Manifest name must match its directory')
    if target not in declared_targets:
        raise BuildError(f'{name} does not support {target}')
    backend = identifier(backend or t['backend'])
    if backend not in ('diamond', 'foss') or t['backend'] not in ('diamond', 'foss'):
        raise BuildError(f'Unimplemented backend: {backend}')
    if p['standard'] not in ('1993', '2008'):
        raise BuildError('VHDL standard must be "1993" or "2008"')
    hdl_id = r'[A-Za-z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*'
    if not isinstance(p['top'], str) or not re.fullmatch(hdl_id, p['top']):
        raise BuildError('Invalid VHDL top entity')
    if not isinstance(p['sources'], list) or not p['sources']:
        raise BuildError('sources must be a nonempty ordered list')
    sources = []
    for s in p['sources']:
        keys(s, {'path', 'library'}, {'path', 'library'}, 'source')
        if not isinstance(s['library'], str) or not re.fullmatch(hdl_id, s['library']):
            raise BuildError('Invalid VHDL library')
        sources.append(Source(input_path(root, pm.parent, s['path']), s['library']))
    if len({s.path for s in sources}) != len(sources):
        raise BuildError('Duplicate source path')
    constraints = strings(p['constraints'], 'constraints')
    if len(constraints) != 1:
        raise BuildError('Exactly one authored LPF is required')
    constraint = input_path(root, pm.parent, constraints[0])
    if constraint.suffix.lower() != '.lpf':
        raise BuildError('Constraint must be an LPF')
    testbench = input_path(root, pm.parent, p['testbench'])
    if testbench != pm.parent / f'{name}_tb.py':
        raise BuildError('Testbench must be named <program>_tb.py in the program directory')
    if t['device'] not in SUPPORTED_DEVICES:
        raise BuildError(f'Unsupported device: {t["device"]}')
    if backend == 'foss':
        f = t.get('foss', {})
        keys(f, {'version', 'seed'}, {'version', 'seed'}, 'foss')
        if not isinstance(f['version'], str) or not re.fullmatch(r'\d{4}-\d{2}-\d{2}', f['version']):
            raise BuildError('foss.version must specify the pinned OSS CAD Suite release date')
        if type(f['seed']) is not int or not 1 <= f['seed'] <= 2147483647:
            raise BuildError('foss.seed must be a positive 32-bit integer')
        pin = input_path(root, root, 'toolchain/foss/toolchain.json')
        return Build(root, name, target, backend, p['top'], p['standard'], tuple(sources), constraint,
                     t['device'], None, {'seed': f['seed']}, (pm, tm, pin, input_path(root, root, 'toolchain/foss/sources.json')), f['version'], testbench)
    d = t.get('diamond', {})
    keys(d, {'strategy', 'version', 'options'}, {'strategy', 'version', 'options'}, 'diamond')
    if not isinstance(d['options'], dict) or any(not isinstance(v, str) for v in d['options'].values()):
        raise BuildError('Diamond options must be a table of string values')
    if any(not re.fullmatch(r'[a-z][a-z0-9_]*', k) for k in d['options']):
        raise BuildError('Invalid Diamond strategy option name')
    if 'lse_vhdl2008' in d['options']:
        raise BuildError('Use program.standard instead of lse_vhdl2008')
    if not isinstance(d['version'], str) or not d['version']:
        raise BuildError('diamond.version must specify the required tool version')
    return Build(root, name, target, backend, p['top'], p['standard'], tuple(sources), constraint,
                 t['device'], input_path(root, tm.parent, d['strategy']), d['options'], (pm, tm), d['version'], testbench)
