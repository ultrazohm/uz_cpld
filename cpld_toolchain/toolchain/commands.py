"""Public command contract shared by Make, help, and command-routing tests."""
from cpld_toolchain import repository_root
from dataclasses import dataclass
import re
from pathlib import Path
import shlex
import subprocess
import sys
import textwrap

from cpld_toolchain.toolchain.buildsystem.model import BuildError, resolve_release

ROOT = repository_root()
TARGETS = {'dslot': 'uz_dslot_xo2', 's3c': 'uz_s3c_xo2'}
COMMON = {'dry_run'}
CONTAINER = {'container_engine', 'container_platform', 'toolchain_image'}
FIRMWARE = {'backend', 'build_backend', 'target', 'release_cycle'}
SELECTION_DEFAULTS = {'release', 's3c', *(f'dslot_{i}' for i in range(1, 6))}
PROBE = {'backend', 'programmer_backend', 'target', 'probe_index', 'cable', 'usb_serial'}
DIRECT_SELECTION = {'s3c_program', *(f'dslot{i}' for i in range(1, 6))}

# The native Windows suite excludes Linux-only tool and shell integrations.
WINDOWS_TESTS = (
    'cpld_toolchain.toolchain.tests.test_firmware_download',
    'cpld_toolchain.toolchain.tests.test_capabilities', 'cpld_toolchain.toolchain.tests.test_doctor', 'cpld_toolchain.toolchain.tests.test_platform', 'cpld_toolchain.toolchain.tests.test_commands', 'cpld_toolchain.toolchain.tests.test_venv',
    'cpld_toolchain.toolchain.tests.test_identity.IdentityTests.test_concurrent_allocations_are_unique_and_repeated_allocation_is_stable',
    'cpld_toolchain.toolchain.tests.test_identity.IdentityTests.test_concurrent_same_build_reuses_one_revision',
    'cpld_toolchain.cpld_vhdl_generator.tests.test_generator', 'cpld_toolchain.programmer_helper.tests.test_program',
    'cpld_toolchain.programmer_helper.tests.test_release',
    'cpld_toolchain.programmer_helper.tests.test_identify', 'cpld_toolchain.programmer_helper.tests.test_foss', 'cpld_toolchain.programmer_helper.tests.test_helper',
)


@dataclass(frozen=True)
class Command:
    group: str
    example: str
    description: str
    options: frozenset[str]
    required: frozenset[str] = frozenset()


def spec(group, example, description, options=(), required=()):
    return Command(group, example, description, frozenset(options) | COMMON, frozenset(required))


# Tool groups and command order are shared by overview and focused help.
COMMANDS = {
    'image': spec('Environment', 'image', 'Build the container tools (optional for native Diamond)', CONTAINER),
    'setup': spec('Environment', 'setup [activate=0|1]', 'Create the locked Python environment, downloading Python as needed', {'activate'}),
    'doctor': spec('Environment', 'doctor', 'Report this environment and installed/missing tools; no hardware access', FIRMWARE),
    'docs': spec('Documentation', 'docs [release_cycle=all]', 'Generate assets and HTML; defaults to all releases', {'program', 'target', 'release_cycle', 'jobs'}),
    'docs_assets': spec('Documentation', 'docs_assets [program=NAME]', 'Generate documentation assets without rendering HTML', {'program', 'target', 'release_cycle', 'jobs'}),
    'netlist': spec('Documentation', 'netlist [program=NAME]', 'Export RTL diagrams; defaults to the current catalog', {'program', 'target', 'release_cycle'}),
    'sim': spec('Simulation', 'sim [program=NAME]', 'Simulate complete manifests in the current release', {'program', 'target', 'release_cycle', 'jobs', 'seed', 'wave_format'}),
    'list': spec('Toolchain', 'list', 'List programs in the current release catalog', FIRMWARE),
    'new': spec('Toolchain', 'new name=NAME template=tx30', 'Clone a program; template=generator creates CSV inputs', FIRMWARE | {'name', 'template', 'template_release_cycle'}, {'name'}),
    'check': spec('Toolchain', 'check program=NAME', 'Validate a program manifest and inputs', FIRMWARE | {'program'}, {'program'}),
    'project': spec('Toolchain', 'project program=NAME', 'Prepare one firmware project without compiling it', FIRMWARE | {'program'}, {'program'}),
    'build': spec('Toolchain', 'build program=NAME', 'Build one program; target is inferred when unambiguous', FIRMWARE | {'program'}, {'program'}),
    'compare': spec('Toolchain', 'compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss', 'Compare FOSS mapped logic with the VHDL reference; Diamond is unsupported', {'program', 'target', 'release_cycle', 'backend'}, {'program', 'backend'}),
    'build_selection': spec('Toolchain', 'build_selection', 'Build each distinct program in selection.toml', FIRMWARE | {'selection'}),
    'build_all': spec('Toolchain', 'build_all', 'Build every catalog program for the selected backend', FIRMWARE),
    'gui': spec('Toolchain', 'gui program=NAME', 'Open the Diamond firmware project', FIRMWARE | {'program'}, {'program'}),
    'firmware_download': spec('Toolchain', 'firmware_download', 'Download the latest GitHub CI firmware for the selected repository and branch', {'remote', 'output', 'git_url', 'branch'}),
    'report': spec('Toolchain', 'report', 'Summarize existing catalog build evidence', FIRMWARE),
    'test': spec('Toolchain', 'test', 'Run Python utility tests; sim runs HDL tests'),
    'release_list': spec('Toolchain', 'release_list', 'List releases and the current selection'),
    'release_new': spec('Toolchain', 'release_new name=NAME [from=CYCLE]', 'Create a release and make it current', {'name', 'from'}, {'name'}),
    'release_select': spec('Toolchain', 'release_select release_cycle=NAME', 'Select the default release', {'release_cycle'}, {'release_cycle'}),
    'usercodes': spec('Toolchain', 'usercodes', 'List permanent program numbers and build revisions'),
    'usercodes_assign': spec('Toolchain', 'usercodes_assign', 'Register manually added programs'),
    'clean': spec('Toolchain', 'clean program=NAME', 'Remove one backend build; preserve simulation and diagrams', FIRMWARE | {'program', 'discard_project_changes'}, {'program'}),
    'clean_all': spec('Toolchain', 'clean_all', 'Remove all generated builds, assets, and caches'),
    'generate': spec('cpld_vhdl_generator', 'generate program=NAME', 'Generate VHDL and register a CSV-based program', FIRMWARE | {'program'}, {'program'}),
    'init_programmer': spec('Programmer', 'init_programmer', 'Create selection.toml; preserve an existing file', {'selection'} | SELECTION_DEFAULTS),
    'diamond_xcf_programming_chain': spec('Programmer', 'diamond_xcf_programming_chain', 'Export both Diamond XCFs from the edited selection', {'selection', 'release_cycle', 'backend', 'build_backend', 'programmer_backend', 'probe_index', 'rebuild'}),
    'scan': spec('Programmer', 'scan target=dslot', 'Check JTAG IDs (target defaults to dslot)', PROBE),
    'identify': spec('Programmer', 'identify target=dslot', 'Read firmware identity and silicon TraceID', PROBE | {'source', 'firmware'}),
    'program': spec('Programmer', 'program target=dslot', 'Program one physical chain from a selection file or explicit program assignments', PROBE | DIRECT_SELECTION | {'selection', 'release', 'release_cycle', 'build_backend', 'source', 'firmware'}, {'target'}),
    'flasher_build': spec('Programmer', 'flasher_build', 'Compile the optional FOSS programmer utility locally', {'jobs'}),
}



# Argument spellings are shared by overview and focused help; applicability and
# required/optional status always come from the command's validated option sets.
ARGUMENT_VALUES = {
    's3c_program': 'NAME', **{f'dslot{i}': 'NAME' for i in range(1, 6)},
    'source': 'local|zip', 'firmware': 'FILE.zip',
    'remote': 'NAME', 'output': 'FILE', 'git_url': 'URL', 'branch': 'NAME',
    'release': 'NAME', 's3c': 'NAME', **{f'dslot_{i}': 'NAME' for i in range(1, 6)},
    'program': 'NAME', 'name': 'NAME', 'template': 'NAME|generator',
    'target': 'dslot|s3c', 'release_cycle': 'NAME', 'template_release_cycle': 'NAME',
    'from': 'CYCLE', 'backend': 'diamond|foss', 'build_backend': 'diamond|foss',
    'programmer_backend': 'diamond|foss', 'selection': 'FILE', 'probe_index': 'N',
    'cable': 'NAME', 'usb_serial': 'SERIAL', 'rebuild': '0|1',
    'jobs': 'N', 'seed': 'N', 'wave_format': 'vcd|ghw|fst',
    'discard_project_changes': '0|1', 'dry_run': '0|1',
    'container_engine': 'docker|podman', 'container_platform': 'OS/ARCH',
    'toolchain_image': 'NAME', 'activate': '0|1',
}


def argument_text(action, keys, style='make'):
    return ' '.join((f'{key}=' if style == 'make' else '--' + key.replace('_', '-') + ' ') + ('foss' if action == 'compare' and key == 'backend' else 'NAME|all' if key == 'release_cycle' and
                        action in ('docs', 'docs_assets') else values)
                    for key, values in ARGUMENT_VALUES.items() if key in keys) or 'none'


def example_text(example, style):
    if style == 'make':
        return 'make ' + example
    return 'uz_cpld ' + re.sub(r'([a-z_]+)=',
        lambda match: '--' + match[1].replace('_', '-') + ' ', example)


def command_help(action, style='make'):
    command = COMMANDS[action]
    lines = ['  ' + example_text(command.example, style), f'    {command.description}']
    for label, keys in [('Required', command.required), ('Optional', command.options - command.required)]:
        lines += textwrap.wrap(f'{label}: {argument_text(action, keys, style)}', width=100,
                               initial_indent='    ', subsequent_indent='      ',
                               break_long_words=False, break_on_hyphens=False)
    return '\n'.join(lines)


def shared_help(style='make'):
    return '\n'.join([
        'Argument defaults and rules:',
        '  backend=diamond; build_backend and programmer_backend inherit backend.',
        '  compare requires explicit backend=foss; Diamond and combined comparisons are unsupported.',
        '  release_cycle defaults to the current release (docs default to all); programmer actions consult',
        '  the selection file first. selection=selection.toml; template=tx30.',
        '  init_programmer: omitted assignments keep template defaults; release="" uses the current release.',
        '  jobs=4; seed=1; wave_format=vcd; dry_run=0; rebuild=0;',
        '  discard_project_changes=0; setup activate=1. Omit an option to use its default.',
        '  Build targets are inferred when unambiguous; scan/identify default to dslot.',
        '  program requires target. probe_index: Diamond defaults to 1, FOSS to 0.',
        '  program accepts selection=FILE or s3c_program=NAME / all dslot1..dslot5 assignments.',
        '  Direct assignments do not read or create selection.toml; do not combine them with selection.',
        '  program release=NAME is an alias for release_cycle=NAME.',
        '  program and identify use source=local by default; source=zip requires firmware=FILE.zip.',
        '  ZIP firmware backend comes from its manifest; explicit build_backend must match.',
        '  jobs must be positive; seed and probe_index must be nonnegative.',
        '  gui requires Diamond builds; diamond_xcf_programming_chain requires both backends to be Diamond.',
        '  Diamond programming requires Diamond builds. cable and usb_serial are FOSS-only.',
        '  FOSS cable defaults to ft4232_b; usb_serial selects a probe instead of probe_index.',
        '  Long target names remain accepted aliases. Selection files do not select backends.',
        '  docs/docs_assets accept release_cycle=all; other actions use one release.',
        '  dry_run=1 previews without writes, tool startup, or hardware access.',
        '  Commands use tools installed in the calling environment; no containers are launched.',
        '',
        'Image build arguments (image only):',
        '  ' + argument_text('image', CONTAINER, style),
        '  Defaults: container_engine=docker; container_platform=linux/amd64;',
        '  toolchain_image=uz-cpld-toolchain. Enter the container explicitly to use its tools.',
        '',
        'Use ' + example_text('help command=ACTION', style) + ' to focus on one command. Unsupported options are errors.',
        'Run one action per invocation. Make remains an optional Linux convenience wrapper.',
    ])


def help_text(style='make'):
    lines = ['Usage: ' + ('make ACTION [key=value ...]' if style == 'make' else
                                 'uz_cpld ACTION [--option value ...]'),
             'All commands below; ' + example_text('help command=ACTION', style) + ' shows arguments and defaults.']
    group = None
    for command in COMMANDS.values():
        if command.group != group:
            group = command.group
            lines += ['', group]
        lines.append(f'  {example_text(command.example, style):<65} {command.description}')
    lines += ['', 'Common options: backend=diamond|foss (default: diamond), target=dslot|s3c,',
              '  release_cycle=NAME, dry_run=1 (preview).',
              'Options vary by command; use ' + example_text('help command=ACTION', style) + ' for the complete list.']
    if style != 'make':
        lines += ['', 'Standalone generation: uz_cpld generator CONFIG --output DIRECTORY [--check]']
    return '\n'.join(lines)


def normalize(action, options):
    options = dict(options)
    if action not in COMMANDS:
        raise BuildError(f'Unknown action {action!r}; run uz_cpld help')
    unsupported = set(options) - COMMANDS[action].options
    if unsupported:
        raise BuildError(f'{action} does not accept {", ".join(sorted(unsupported))}; run uz_cpld help --command {action}')
    if action == 'compare':
        from .buildsystem.comparison import require_foss_backend
        require_foss_backend(options.get('backend'))
    for key in COMMANDS[action].required:
        if not options.get(key):
            raise BuildError(f'{action} requires {key}=' + ('dslot|s3c' if key == 'target' else 'NAME'))
    for key, value in options.items():
        if not value and not (action == 'init_programmer' and key == 'release'):
            raise BuildError(f'{key} must not be empty; omit it to use the default')
    if action == 'program' and 'release' in options:
        if 'release_cycle' in options and options['release_cycle'] != options['release']:
            raise BuildError('release and release_cycle must agree; use one release option')
        options['release_cycle'] = options.pop('release')
    if action == 'firmware_download':
        from .firmware_download import github_repository, branch_ref
        if 'git_url' in options and 'remote' in options:
            raise BuildError('Use git_url or remote, not both')
        if 'git_url' in options:
            github_repository(options['git_url'])
        if 'branch' in options:
            branch_ref(options['branch'])
    for key in ('backend', 'build_backend', 'programmer_backend'):
        if key in options and options[key] not in ('diamond', 'foss'):
            raise BuildError(f'{key} must be diamond or foss')
    for key in ('dry_run', 'rebuild', 'discard_project_changes', 'activate'):
        if key in options and options[key] not in ('0', '1'):
            raise BuildError(f'{key} must be 0 or 1')
    for key in ('jobs', 'seed', 'probe_index'):
        if key in options:
            try:
                value = int(options[key])
            except ValueError:
                raise BuildError(f'{key} must be an integer') from None
            if value < (1 if key == 'jobs' else 0):
                raise BuildError(f'{key} must be {"positive" if key == "jobs" else "nonnegative"}')
    if options.get('wave_format', 'vcd') not in ('vcd', 'ghw', 'fst'):
        raise BuildError('wave_format must be vcd, ghw or fst')
    if 'target' in options:
        reverse = {value: key for key, value in TARGETS.items()}
        options['target'] = reverse.get(options['target'], options['target'])
        if options['target'] not in TARGETS:
            raise BuildError('target must be dslot or s3c')
    if options.get('release_cycle') == 'all' and action not in ('docs', 'docs_assets'):
        raise BuildError('release_cycle=all is only supported for docs and docs_assets')
    backend = options.get('backend', 'diamond')
    build_backend = options.get('build_backend', backend)
    programmer_backend = options.get('programmer_backend', backend)
    if action == 'program':
        from cpld_toolchain.programmer_helper.helper import direct_selection
        assignments = direct_selection(options['target'], options.get('s3c_program'),
                                       {i: options[f'dslot{i}'] for i in range(1, 6) if f'dslot{i}' in options})
        if assignments is not None and 'selection' in options:
            raise BuildError('Use selection=FILE or direct program assignments, not both')
    if action in ('program', 'identify'):
        source = options.get('source', 'local')
        if source not in ('local', 'zip'):
            raise BuildError('source must be local or zip')
        if source == 'zip' and not options.get('firmware'):
            raise BuildError('source=zip requires firmware=FILE.zip')
        if source == 'local' and 'firmware' in options:
            raise BuildError('firmware requires source=zip')
    if action == 'gui' and build_backend != 'diamond':
        raise BuildError('gui requires build_backend=diamond')
    if action == 'diamond_xcf_programming_chain' and (build_backend != 'diamond' or programmer_backend != 'diamond'):
        raise BuildError('diamond_xcf_programming_chain exports Diamond XCFs; both backends must be diamond')
    if action == 'program' and programmer_backend == 'diamond' and build_backend != 'diamond' and (
            options.get('source', 'local') == 'local' or 'build_backend' in options):
        raise BuildError('Diamond programming requires Diamond builds; choose programmer_backend=foss')
    if action in ('scan', 'identify', 'program'):
        if 'usb_serial' in options and 'probe_index' in options:
            raise BuildError('Use usb_serial or probe_index, not both')
        if programmer_backend == 'diamond' and ('cable' in options or 'usb_serial' in options):
            raise BuildError('Diamond uses USB2; select its port with probe_index')
    return action, options


@dataclass(frozen=True)
class Invocation:
    argv: tuple[str, ...]
    cwd: Path
    module: str | None = None
    arguments: tuple[str, ...] = ()


def plan(action, options, *, root=ROOT, cwd=None):
    """Resolve a command without writes, tool startup, or hardware access."""
    action, options = normalize(action, options)
    root = Path(root).resolve()
    cwd = Path(cwd or Path.cwd()).resolve()
    backend = options.get('backend', 'diamond')
    build_backend = options.get('build_backend', backend)
    programmer_backend = options.get('programmer_backend', backend)
    if sys.platform == 'win32' and action == 'flasher_build':
        raise BuildError('The pinned FOSS source build requires Linux; use the toolchain container or WSL')
    if action == 'image':
        return [Invocation((options.get('container_engine', 'docker'), 'build',
                            '--platform', options.get('container_platform', 'linux/amd64'),
                            '--target', 'toolchain', '-f', '.devcontainer/Dockerfile',
                            '-t', options.get('toolchain_image', 'uz-cpld-toolchain'), '.'), root)]
    python = sys.executable
    def invoke(module, args, working=root):
        return Invocation(tuple([python, '-m', module, *args]), working, module, tuple(args))
    def flags(*keys):
        result = []
        for key in keys:
            if key in options:
                value = options[key]
                if key == 'target':
                    value = TARGETS[value]
                result += ['--' + key.replace('_', '-'), value]
        return result
    if action == 'firmware_download':
        args = ['--root', str(root), *flags('remote', 'git_url', 'branch')]
        if 'output' in options:
            args += ['--output', str((cwd / options['output']).absolute())]
        return [invoke('cpld_toolchain.toolchain.firmware_download', args)]
    if action == 'doctor':
        return [invoke('cpld_toolchain.toolchain.doctor', ['--backend', build_backend, *flags('target', 'release_cycle')])]
    if action == 'setup':
        return [invoke('cpld_toolchain.bootstrap', ['--activate', options.get('activate', '1')])]
    if action in ('init_programmer', 'build_selection', 'scan', 'identify', 'program', 'diamond_xcf_programming_chain'):
        selection = Path(options.get('selection', 'selection.toml'))
        if not selection.is_absolute():
            selection = cwd / selection
        args = []
        if action in ('init_programmer', 'build_selection', 'program', 'diamond_xcf_programming_chain') and not (
                action == 'program' and DIRECT_SELECTION.intersection(options)):
            args += ['--selection', str(selection)]
        args += flags('release_cycle', 'probe_index')
        if action == 'init_programmer':
            args += flags('release', 's3c', *(f'dslot_{i}' for i in range(1, 6)))
        if action == 'build_selection':
            args += ['--build-backend', build_backend]
            if 'target' in options:
                args += ['--target', options['target']]
            return [invoke('cpld_toolchain.programmer_helper.program', [action, *args])]
        if action == 'diamond_xcf_programming_chain':
            args += ['--build-backend', build_backend]
            if options.get('rebuild') == '1':
                args += ['--build']
            return [invoke('cpld_toolchain.programmer_helper', args)]
        if action != 'init_programmer':
            args += ['--programmer-backend', programmer_backend]
            if action == 'program':
                args += flags('s3c_program', *(f'dslot{i}' for i in range(1, 6)))
                if options.get('source', 'local') == 'local' or 'build_backend' in options:
                    args += ['--build-backend', build_backend]
                if 'target' not in options:
                    raise BuildError('program requires target=dslot or target=s3c; use uz_cpld init_programmer to create a selection')
            if action in ('program', 'identify'):
                args += flags('source')
                if 'firmware' in options:
                    args += ['--firmware', str((cwd / options['firmware']).absolute())]
            args += ['--target', options.get('target', 'dslot')]
            args += flags('cable', 'usb_serial')
            args += ['--execute']
        return [invoke('cpld_toolchain.programmer_helper.program', [action, *args])]
    if action == 'flasher_build':
        return [invoke('cpld_toolchain.toolchain.foss.flasher', ['--jobs', options.get('jobs', '4')])]
    if action == 'test':
        if sys.platform == 'win32':
            return [invoke('unittest', [*WINDOWS_TESTS, '-v'])]
        return [invoke('unittest', ['discover', '-s', f'{folder}/tests', '-v'])
                for folder in ('xo2_library', 'cpld_toolchain/cpld_vhdl_generator', 'cpld_toolchain/toolchain', 'cpld_toolchain/programmer_helper')]
    if action == 'sim':
        cycle = resolve_release(root, options.get('release_cycle'))
        args = ['cpld_toolchain/toolchain/simulation/test_simulation.py', '-v', '-n', options.get('jobs', '4'),
                f'--junitxml=build/simulation/{cycle}/junit.xml', '--release-cycle', cycle,
                '--seed', options.get('seed', '1'), '--wave-format', options.get('wave_format', 'vcd')]
        return [invoke('pytest', args + flags('program', 'target'))]
    if action == 'netlist':
        return [invoke('cpld_toolchain.toolchain.analysis.netlist', flags('program', 'target', 'release_cycle'))]
    if action in ('docs', 'docs_assets'):
        cycle = options.get('release_cycle') or 'all'
        args = ['--jobs', options.get('jobs', '4'), '--release-cycle', cycle]
        args += flags('program', 'target')
        if action == 'docs':
            args += ['--build-site']
        return [invoke('cpld_toolchain.toolchain.analysis.documentation', args)]
    args = flags('program', 'target', 'release_cycle', 'name', 'template', 'template_release_cycle', 'from')
    if action == 'compare':
        args += flags('backend')
    elif 'backend' in COMMANDS[action].options:
        args += ['--backend', build_backend]
    if options.get('discard_project_changes') == '1':
        args += ['--discard-project-changes']
    return [invoke('cpld_toolchain.toolchain.buildsystem', [action, *args])]


def run(action, options):
    """Plan, check only this command's dependencies, then execute lazily."""
    from cpld_toolchain import capabilities, runtime
    canonical, normalized = normalize(action, options)
    calls = plan(canonical, normalized)
    preview = normalized.get('dry_run') == '1'
    if preview:
        print('Preview only: no commands will be executed.')
    else:
        capabilities.require(canonical, normalized)
    for call in calls:
        print(f'[{call.cwd}] {shlex.join(call.argv)}', flush=True)
        if not preview:
            try:
                runtime.execute(call)
            except subprocess.CalledProcessError as exc:
                raise BuildError(str(exc)) from exc
    return 0


def main(argv=None):
    try:
        from cpld_toolchain.cli import main as cli
    except ImportError as exc:
        print(f'error: CLI dependencies are unavailable: {exc}. '
              'Run python -m cpld_toolchain setup.', file=sys.stderr)
        return 2
    return cli(argv)


if __name__ == '__main__':
    raise SystemExit(main())
