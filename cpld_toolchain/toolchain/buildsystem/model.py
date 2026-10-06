"""Load and validate explicit program and board manifests without running tools."""
from dataclasses import dataclass
from pathlib import Path
import re


class BuildError(Exception):
    """An actionable configuration or build failure."""


def identifier(value: str) -> str:
    """Validate a filesystem-safe program, target, or backend name."""
    if not isinstance(value, str) or not re.fullmatch(r"[a-z][a-z0-9_]*", value):
        raise BuildError(f"Invalid name: {value!r}; use lowercase letters, digits and underscores")
    if value == 'build':
        raise BuildError("Name 'build' is reserved for generated output directories")
    return value


def read_toml(path: Path) -> dict:
    """Read a manifest, reporting parse and filesystem errors consistently."""
    # Keep environment setup usable before Python 3.10 has its TOML dependency.
    try:
        import tomllib
    except ModuleNotFoundError:
        import tomli as tomllib
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


def release_cycles(root: Path) -> list[str]:
    """List explicit release catalogs, independent of directory timestamps."""
    base = root.resolve() / 'programs'
    if base.is_symlink():
        raise BuildError('Programs directory must not be a symlink')
    names = []
    for path in sorted(base.glob('*/catalog.toml')):
        name = identifier(path.parent.name)
        if path.is_symlink() or path.parent.is_symlink():
            raise BuildError(f'Release catalog must not be a symlink: {path}')
        names.append(name)
    return names


def resolve_release(root: Path, release_cycle: str | None = None) -> str:
    """Resolve an explicit cycle or the tracked current cycle."""
    if release_cycle is None:
        data = read_toml(root / 'programs/releases.toml')
        keys(data, {'current'}, {'current'}, 'releases')
        release_cycle = data['current']
    release_cycle = identifier(release_cycle)
    if release_cycle not in release_cycles(root):
        raise BuildError(f'Unknown release cycle: {release_cycle}')
    return release_cycle


def release_directory(root: Path, release_cycle: str | None = None) -> Path:
    return root.resolve() / 'programs' / resolve_release(root, release_cycle)


def resolve_program(root: Path, name: str, release_cycle: str | None = None):
    """Accept a name or an explicit cycle/name for internal multi-cycle consumers."""
    if not isinstance(name, str):
        raise BuildError(f'Invalid program name: {name!r}')
    if '/' in name:
        cycle, name = name.split('/', 1)
        if release_cycle is not None and cycle != release_cycle:
            raise BuildError('Program and release_cycle select different cycles')
        release_cycle = cycle
    return identifier(name), resolve_release(root, release_cycle)


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
    foss_equivalence_blacklist: Path | None = None
    netlist_skip_reason: str | None = None
    synthesis: str = "lse"

    @property
    def build_root(self) -> Path:
        """Shared analysis outputs for this program, separate from firmware backends."""
        return self.root / 'build/analysis' / self.release_cycle / self.name

    @property
    def release_cycle(self) -> str:
        return self.manifests[0].parent.parent.name

    @property
    def qualified_name(self) -> str:
        return f'{self.release_cycle}/{self.name}'

    @property
    def directory(self) -> Path:
        """Generated output location; never an authored source directory."""
        return self.root / 'build' / self.backend / self.release_cycle / self.name / self.target

    def firmware_path(self, extension: str) -> Path:
        """Published firmware path for this program, target and backend."""
        return self.directory / f'{self.name}_{self.target}_{self.backend}.{extension}'

    @property
    def inputs(self) -> tuple[Path, ...]:
        """All authored inputs included in provenance."""
        return (tuple(s.path for s in self.sources) + (self.constraint, self.testbench) +
                ((self.strategy,) if self.strategy else ()) + self.manifests +
                ((self.foss_equivalence_blacklist,) if self.foss_equivalence_blacklist else ()))


def discover_programs(root: Path, release_cycle: str | None = None) -> list[str]:
    """Find complete program manifests, including programs outside the firmware catalog."""
    names = sorted(p.parent.name for p in release_directory(root, release_cycle).glob('*/*.toml')
                   if p.stem == p.parent.name)
    return names


def catalog(root: Path, release_cycle: str | None = None) -> list[str]:
    """Return the explicitly supported catalog, excluding uncatalogued programs and archives."""
    data = read_toml(release_directory(root, release_cycle) / 'catalog.toml')
    keys(data, {'programs'}, {'programs'}, 'catalog')
    return [identifier(n) for n in strings(data['programs'], 'catalog.programs')]


SUPPORTED_DEVICES = {
    'LCMXO2-2000HC-4TG100C',
    'LCMXO2-4000HC-4TG144C',
}


def program_targets(root: Path, name: str, release_cycle: str | None = None) -> list[str]:
    """Read the targets declared by one catalog program."""
    name, release_cycle = resolve_program(root, name, release_cycle)
    path = input_path(root.resolve(), root.resolve(), f'programs/{release_cycle}/{name}/{name}.toml')
    return _declared_targets(read_toml(path), name)


def _declared_targets(data: dict, name: str) -> list[str]:
    targets = strings(data.get('targets'), f'{name}.targets')
    if not targets:
        raise BuildError(f'{name}: targets must not be empty')
    return [identifier(target) for target in targets]


def program_backends(root: Path, name: str, release_cycle: str | None = None) -> list[str]:
    """Return the firmware backends declared by one catalog program."""
    name, release_cycle = resolve_program(root, name, release_cycle)
    path = input_path(root.resolve(), root.resolve(), f'programs/{release_cycle}/{name}/{name}.toml')
    return _declared_backends(read_toml(path), name)


@dataclass(frozen=True)
class OutputIdentity:
    """A confined output location, independent of source/build readiness."""
    root: Path
    name: str
    target: str
    backend: str
    release_cycle: str

    @property
    def directory(self) -> Path:
        return self.root / 'build' / self.backend / self.release_cycle / self.name / self.target


def load_output(root: Path, name: str, target=None, backend=None, release_cycle=None) -> OutputIdentity:
    """Resolve cleanup without requiring present sources or fresh generated files."""
    root = root.resolve()
    name, cycle = resolve_program(root, name, release_cycle)
    expected = root / 'programs' / cycle / name / f'{name}.toml'
    manifest = input_path(root, root, str(expected.relative_to(root)))
    if manifest != expected:
        raise BuildError('Program manifests and directories must not be symlinks')
    data = read_toml(manifest)
    if data.get('name') != name:
        raise BuildError('Manifest name must match its directory')
    targets = _declared_targets(data, name)
    if target is None:
        if len(targets) != 1:
            raise BuildError(f'{name} has multiple targets; select one explicitly')
        target = targets[0]
    target = identifier(target)
    target_data = read_toml(input_path(root, root, f'cpld_toolchain/toolchain/targets/{target}/target.toml'))
    backend = backend or target_data.get('backend')
    if backend not in ('diamond', 'foss'):
        raise BuildError(f'Unimplemented backend: {backend}')
    return OutputIdentity(root, name, target, backend, cycle)


def _declared_backends(data: dict, name: str) -> list[str]:
    backends = strings(data.get('backends', ['diamond', 'foss']), f'{name}.backends')
    if not backends or any(value not in ('diamond', 'foss') for value in backends):
        raise BuildError(f'{name}: backends must list diamond and/or foss')
    return backends


def load_build(root: Path, name: str, target: str | None = None, backend: str | None = None, release_cycle: str | None = None) -> Build:
    """Validate manifests and return a build model; no vendor tools are needed."""
    root = root.resolve()
    name, release_cycle = resolve_program(root, name, release_cycle)
    pm = input_path(root, root, f'programs/{release_cycle}/{name}/{name}.toml')
    if pm != root / 'programs' / release_cycle / name / f'{name}.toml':
        raise BuildError('Program manifests and directories must not be symlinks')
    p = read_toml(pm)
    declared_targets = _declared_targets(p, name)
    if target is None:
        if len(declared_targets) != 1:
            raise BuildError(f'{name} has multiple targets; select one explicitly')
        target = declared_targets[0]
    target = identifier(target)
    tm = input_path(root, root, f'cpld_toolchain/toolchain/targets/{target}/target.toml')
    t = read_toml(tm)
    pf = {'name', 'top', 'standard', 'sources', 'targets', 'backends', 'constraints',
          'foss_constraints', 'foss_equivalence_blacklist', 'testbench', 'generator', 'netlist_skip_reason', 'synthesis'}
    tf = {'name', 'device', 'backend', 'diamond', 'foss'}
    keys(p, pf, pf - {'foss_constraints', 'foss_equivalence_blacklist', 'backends', 'generator', 'netlist_skip_reason', 'synthesis'}, str(pm)); keys(t, tf, {'name', 'device', 'backend'}, str(tm))
    synthesis = p.get('synthesis', 'lse')
    if synthesis not in ('lse', 'synplify'):
        raise BuildError('synthesis must be "lse" or "synplify"')
    netlist_skip_reason = p.get('netlist_skip_reason')
    if 'netlist_skip_reason' in p and (not isinstance(netlist_skip_reason, str) or not netlist_skip_reason.strip()):
        raise BuildError('netlist_skip_reason must be a nonempty explanation')
    if p['name'] != name or t['name'] != target:
        raise BuildError('Manifest name must match its directory')
    if target not in declared_targets:
        raise BuildError(f'{name} does not support {target}')
    backend = identifier(backend or t['backend'])
    if backend not in ('diamond', 'foss') or t['backend'] not in ('diamond', 'foss'):
        raise BuildError(f'Unimplemented backend: {backend}')
    if backend not in _declared_backends(p, name):
        raise BuildError(f'{name} does not support the {backend} firmware backend')
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
    generator_inputs = ()
    if 'generator' in p:
        from cpld_toolchain.cpld_vhdl_generator.generator import check, dependencies, source_entries, GeneratorError, RECEIPT, PACKAGE
        if p['generator'] != 'generator.toml':
            raise BuildError('Repository generator must be program-local generator.toml')
        config_path = input_path(root, pm.parent, p['generator'])
        generation_output = sources[-1].path.parent
        if config_path != pm.parent / 'generator.toml' or generation_output != pm.parent:
            raise BuildError('Repository generator configuration and outputs must be program-local')
        try:
            generated = check(config_path, generation_output)
        except (GeneratorError, OSError) as exc:
            raise BuildError(f'{name}: {exc}') from exc
        if generated.name != p['top'] or p['standard'] != generated.standard:
            raise BuildError('Generated top and VHDL standard must match the generator')
        if [(s.path, s.library) for s in sources] != [(s.path, s.library) for s in source_entries(generated, generation_output)]:
            raise BuildError('Manifest sources must match generator-output.json paths, order, and libraries')
        generator_inputs = tuple(input_path(root, root, str(path.relative_to(root)))
                                 for path in dependencies(generated) + [generation_output / RECEIPT]
                                 if path.is_relative_to(root) or not path.is_relative_to(PACKAGE))
    constraints = strings(p['constraints'], 'constraints')
    if len(constraints) != 1:
        raise BuildError('Exactly one authored LPF is required')
    constraint = input_path(root, pm.parent, constraints[0])
    if constraint.suffix.lower() != '.lpf':
        raise BuildError('Constraint must be an LPF')
    if 'foss_constraints' in p:
        foss_constraints = strings(p['foss_constraints'], 'foss_constraints')
        if len(foss_constraints) != 1:
            raise BuildError('Exactly one FOSS LPF is required')
        foss_constraint = input_path(root, pm.parent, foss_constraints[0])
        if foss_constraint.suffix.lower() != '.lpf':
            raise BuildError('FOSS constraint must be an LPF')
        if backend == 'foss':
            constraint = foss_constraint
    equivalence_blacklist = (input_path(root, pm.parent, p['foss_equivalence_blacklist'])
                             if 'foss_equivalence_blacklist' in p else None)
    testbench = input_path(root, pm.parent, p['testbench'])
    if testbench != pm.parent / f'{name}_tb.py':
        raise BuildError('Testbench must be named <program>_tb.py in the program directory')
    if not isinstance(t['device'], str) or t['device'] not in SUPPORTED_DEVICES:
        raise BuildError(f'Unsupported device: {t["device"]}')
    if backend == 'foss':
        f = t.get('foss', {})
        keys(f, {'version', 'seed'}, {'version', 'seed'}, 'foss')
        if not isinstance(f['version'], str) or not re.fullmatch(r'\d{4}-\d{2}-\d{2}', f['version']):
            raise BuildError('foss.version must specify the pinned OSS CAD Suite release date')
        if type(f['seed']) is not int or not 1 <= f['seed'] <= 2147483647:
            raise BuildError('foss.seed must be a positive 32-bit integer')
        pin = input_path(root, root, 'cpld_toolchain/toolchain/foss/toolchain.json')
        return Build(root, name, target, backend, p['top'], p['standard'], tuple(sources), constraint,
                     t['device'], None, {'seed': f['seed']}, (pm, tm, pin, input_path(root, root, 'cpld_toolchain/toolchain/foss/sources.json'), *generator_inputs), f['version'], testbench, equivalence_blacklist, netlist_skip_reason, synthesis=synthesis)
    d = t.get('diamond', {})
    keys(d, {'strategy', 'version', 'options'}, {'strategy', 'version', 'options'}, 'diamond')
    if not isinstance(d['options'], dict) or any(not isinstance(v, str) for v in d['options'].values()):
        raise BuildError('Diamond options must be a table of string values')
    if any(not re.fullmatch(r'[a-z][a-z0-9_]*', k) for k in d['options']):
        raise BuildError('Invalid Diamond strategy option name')
    if {'lse_vhdl2008', 'syn_vhdl2008'} & d['options'].keys():
        raise BuildError('Use program.standard instead of lse_vhdl2008/syn_vhdl2008')
    if not isinstance(d['version'], str) or not d['version']:
        raise BuildError('diamond.version must specify the required tool version')
    return Build(root, name, target, backend, p['top'], p['standard'], tuple(sources), constraint,
                 t['device'], input_path(root, tm.parent, d['strategy']), d['options'], (pm, tm, *generator_inputs), d['version'], testbench, netlist_skip_reason=netlist_skip_reason, synthesis=synthesis)
