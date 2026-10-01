"""Public command contract shared by Make, help, and command-routing tests."""
import argparse
from dataclasses import dataclass
import os
import re
from pathlib import Path
import shlex
import subprocess
import sys
import textwrap

from toolchain.buildsystem.model import BuildError, resolve_release

ROOT = Path(__file__).resolve().parents[1]
TARGETS = {'dslot': 'uz_dslot_xo2', 's3c': 'uz_s3c_xo2'}
COMMON = {'runner', 'dry_run'}
CONTAINER = {'container_engine', 'container_platform', 'toolchain_image'}
FIRMWARE = {'backend', 'build_backend', 'target', 'release_cycle'}
PROBE = {'backend', 'programmer_backend', 'target', 'probe_index', 'cable', 'usb_serial'}

# The native Windows suite excludes Linux-only tool and shell integrations.
WINDOWS_TESTS = (
    'toolchain.tests.test_doctor', 'toolchain.tests.test_platform', 'toolchain.tests.test_commands', 'toolchain.tests.test_venv',
    'toolchain.tests.test_identity.IdentityTests.test_concurrent_allocations_are_unique_and_repeated_allocation_is_stable',
    'toolchain.tests.test_identity.IdentityTests.test_concurrent_same_build_reuses_one_revision',
    'cpld_vhdl_generator.tests.test_generator', 'programmer_helper.tests.test_program',
    'programmer_helper.tests.test_identify', 'programmer_helper.tests.test_helper',
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
    'venv': spec('Environment', 'venv [activate=0|1]', 'Install native Python dependencies and open an activated shell', {'activate'}),
    'doctor': spec('Environment', 'doctor', 'Report this environment and installed/missing tools; no hardware access', FIRMWARE),
    'docs': spec('Documentation', 'docs [release_cycle=all]', 'Generate assets and HTML; defaults to the current release', {'program', 'target', 'release_cycle', 'jobs'}),
    'docs-assets': spec('Documentation', 'docs-assets [program=NAME]', 'Generate documentation assets without rendering HTML', {'program', 'target', 'release_cycle', 'jobs'}),
    'netlist': spec('Documentation', 'netlist [program=NAME]', 'Export RTL diagrams; defaults to the current catalog', {'program', 'target', 'release_cycle'}),
    'sim': spec('Simulation', 'sim [program=NAME]', 'Simulate complete manifests in the current release', {'program', 'target', 'release_cycle', 'jobs', 'seed', 'wave_format'}),
    'list': spec('Toolchain', 'list', 'List programs in the current release catalog', FIRMWARE),
    'new': spec('Toolchain', 'new name=NAME template=tx30', 'Clone a program; template=generator creates CSV inputs', FIRMWARE | {'name', 'template', 'template_release_cycle'}, {'name'}),
    'check': spec('Toolchain', 'check program=NAME', 'Validate a program manifest and inputs', FIRMWARE | {'program'}, {'program'}),
    'project': spec('Toolchain', 'project program=NAME', 'Prepare one firmware project without compiling it', FIRMWARE | {'program'}, {'program'}),
    'build': spec('Toolchain', 'build program=NAME', 'Build one program; target is inferred when unambiguous', FIRMWARE | {'program'}, {'program'}),
    'build-all': spec('Toolchain', 'build-all', 'Build every catalog program for the selected backend', FIRMWARE),
    'gui': spec('Toolchain', 'gui program=NAME', 'Open the Diamond firmware project', FIRMWARE | {'program'}, {'program'}),
    'report': spec('Toolchain', 'report', 'Summarize existing catalog build evidence', FIRMWARE),
    'test': spec('Toolchain', 'test', 'Run Python utility tests; sim runs HDL tests'),
    'release-list': spec('Toolchain', 'release-list', 'List releases and the current selection'),
    'release-new': spec('Toolchain', 'release-new name=NAME [from=CYCLE]', 'Create a release and make it current', {'name', 'from'}, {'name'}),
    'release-select': spec('Toolchain', 'release-select release_cycle=NAME', 'Select the default release', {'release_cycle'}, {'release_cycle'}),
    'usercodes': spec('Toolchain', 'usercodes', 'List permanent program numbers and build revisions'),
    'usercodes-assign': spec('Toolchain', 'usercodes-assign', 'Register manually added programs'),
    'clean': spec('Toolchain', 'clean program=NAME', 'Remove one backend build; preserve simulation and diagrams', FIRMWARE | {'program', 'discard_project_changes'}, {'program'}),
    'clean-all': spec('Toolchain', 'clean-all', 'Remove all generated builds, assets, and caches'),
    'generate': spec('cpld_vhdl_generator', 'generate program=NAME', 'Generate VHDL and register a CSV-based program', FIRMWARE | {'program'}, {'program'}),
    'init': spec('Programmer', 'init', 'Create selection.toml; preserve an existing file', {'selection'}),
    'programmer-project': spec('Programmer', 'programmer-project', 'Export both Diamond XCFs from the edited selection', {'selection', 'release_cycle', 'backend', 'build_backend', 'programmer_backend', 'probe_index', 'rebuild'}),
    'scan': spec('Programmer', 'scan target=dslot', 'Check JTAG IDs (target defaults to dslot)', PROBE),
    'identify': spec('Programmer', 'identify target=dslot', 'Read firmware identity and silicon TraceID', PROBE),
    'program': spec('Programmer', 'program target=dslot', 'Program one physical chain from selection.toml', PROBE | {'selection', 'release_cycle', 'build_backend'}, {'target'}),
    'flasher-build': spec('Programmer', 'flasher-build', 'Compile the optional FOSS programmer utility locally', {'jobs'}),
}
ALIASES = {
    'programmer': ('init', {}), 'lattice_xcf': ('programmer-project', {}),
    'release-current': ('release-select', {}), 'flasher': ('flasher-build', {}),
    'docs-local': ('docs', {'runner': 'local'}),
    'docs-assets-local': ('docs-assets', {'runner': 'local'}),
    'netlist-local': ('netlist', {'runner': 'local'}),
    'test-container': ('test', {'runner': 'container'}), '_sim': ('sim', {'runner': 'local'}),
}


# Argument spellings are shared by overview and focused help; applicability and
# required/optional status always come from the command's validated option sets.
ARGUMENT_VALUES = {
    'program': 'NAME', 'name': 'NAME', 'template': 'NAME|generator',
    'target': 'dslot|s3c', 'release_cycle': 'NAME', 'template_release_cycle': 'NAME',
    'from': 'CYCLE', 'backend': 'diamond|foss', 'build_backend': 'diamond|foss',
    'programmer_backend': 'diamond|foss', 'selection': 'FILE', 'probe_index': 'N',
    'cable': 'NAME', 'usb_serial': 'SERIAL', 'rebuild': '0|1',
    'jobs': 'N', 'seed': 'N', 'wave_format': 'vcd|ghw|fst',
    'discard_project_changes': '0|1', 'runner': 'auto|local|container', 'dry_run': '0|1',
    'container_engine': 'docker|podman', 'container_platform': 'OS/ARCH',
    'toolchain_image': 'NAME', 'activate': '0|1',
}


def argument_text(action, keys, style='make'):
    return ' '.join((f'{key}=' if style == 'make' else '--' + key.replace('_', '-') + ' ') + ('NAME|all' if key == 'release_cycle' and
                        action in ('docs', 'docs-assets') else values)
                    for key, values in ARGUMENT_VALUES.items() if key in keys) or 'none'


def example_text(example, style):
    if style == 'make':
        return 'make ' + example
    return 'python -m toolchain ' + re.sub(r'([a-z_]+)=',
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
        '  release_cycle defaults to the current release; programmer actions first consult',
        '  the selection file. selection=selection.toml; template=tx30.',
        '  jobs=4; seed=1; wave_format=vcd; runner=auto; dry_run=0; rebuild=0;',
        '  discard_project_changes=0; venv activate=1. Omit an option to use its default.',
        '  Build targets are inferred when unambiguous; scan/identify default to dslot.',
        '  program requires target. probe_index: Diamond defaults to 1, FOSS to 0.',
        '  jobs must be positive; seed and probe_index must be nonnegative.',
        '  gui requires Diamond builds; programmer-project requires both backends to be Diamond.',
        '  Diamond programming requires Diamond builds. cable and usb_serial are FOSS-only.',
        '  FOSS cable defaults to ft4232_b; usb_serial selects a probe instead of probe_index.',
        '  Long target names remain accepted aliases. Selection files do not select backends.',
        '  docs/docs-assets accept release_cycle=all; other actions use one release.',
        '  dry_run=1 previews without writes, tool startup, or hardware access.',
        '  Auto runner: configured Dev Container stays local; host FOSS builds/sim/netlist/docs',
        '  use the image. Run ' + example_text('image', style) + ' first. Diamond and USB commands run locally.',
        '',
        'Host-container arguments (image, or supported commands with runner=container):',
        '  ' + argument_text('image', CONTAINER, style),
        '  Defaults: container_engine=docker; container_platform=linux/amd64;',
        '  toolchain_image=uz-cpld-toolchain. Container execution supports sim, netlist,',
        '  docs, docs-assets, test, doctor, and FOSS build/build-all/project.',
        '',
        'Use ' + example_text('help command=ACTION', style) + ' to focus on one command. Unsupported options are errors.',
        'Run one action per invocation. Make remains an optional Linux convenience wrapper.',
    ])


def help_text(style='make'):
    lines = ['Usage: ' + ('make ACTION [key=value ...]' if style == 'make' else
                                 'python -m toolchain ACTION [--option value ...]'),
             'All commands below; ' + example_text('help command=ACTION', style) + ' shows arguments and defaults.']
    group = None
    for command in COMMANDS.values():
        if command.group != group:
            group = command.group
            lines += ['', group]
        lines.append(f'  {example_text(command.example, style):<65} {command.description}')
    lines += ['', 'Common options: backend=diamond|foss (default: diamond), target=dslot|s3c,',
              '  release_cycle=NAME, runner=auto|local|container, dry_run=1 (preview).',
              'Options vary by command; use ' + example_text('help command=ACTION', style) + ' for the complete list.']
    return '\n'.join(lines)


def normalize(action, options):
    options = dict(options)
    if action in ALIASES:
        action, defaults = ALIASES[action]
        options = {**defaults, **options}
    if action not in COMMANDS:
        raise BuildError(f'Unknown action {action!r}; run python -m toolchain help')
    unsupported = set(options) - COMMANDS[action].options - CONTAINER
    if unsupported:
        raise BuildError(f'{action} does not accept {", ".join(sorted(unsupported))}; run python -m toolchain help --command {action}')
    for key in COMMANDS[action].required:
        if not options.get(key):
            raise BuildError(f'{action} requires {key}=' + ('dslot|s3c' if key == 'target' else 'NAME'))
    for key, value in options.items():
        if not value:
            raise BuildError(f'{key} must not be empty; omit it to use the default')
    for key in ('backend', 'build_backend', 'programmer_backend'):
        if key in options and options[key] not in ('diamond', 'foss'):
            raise BuildError(f'{key} must be diamond or foss')
    if options.get('runner', 'auto') not in ('auto', 'local', 'container'):
        raise BuildError('runner must be auto, local or container')
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
    if options.get('release_cycle') == 'all' and action not in ('docs', 'docs-assets'):
        raise BuildError('release_cycle=all is only supported for docs and docs-assets')
    backend = options.get('backend', 'diamond')
    build_backend = options.get('build_backend', backend)
    programmer_backend = options.get('programmer_backend', backend)
    if action == 'gui' and build_backend != 'diamond':
        raise BuildError('gui requires build_backend=diamond')
    if action == 'programmer-project' and (build_backend != 'diamond' or programmer_backend != 'diamond'):
        raise BuildError('programmer-project exports Diamond XCFs; both backends must be diamond')
    if action == 'program' and programmer_backend == 'diamond' and build_backend != 'diamond':
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


def plan(action, options, *, root=ROOT, cwd=None, environ=None):
    """Resolve a command without writes, tool startup, or hardware access."""
    action, options = normalize(action, options)
    root = Path(root).resolve()
    cwd = Path(cwd or Path.cwd()).resolve()
    environ = os.environ if environ is None else environ
    backend = options.get('backend', 'diamond')
    build_backend = options.get('build_backend', backend)
    programmer_backend = options.get('programmer_backend', backend)
    runner = options.get('runner', 'auto')
    inside = environ.get('CPLD_TOOLCHAIN_CONTAINER') == '1'
    firmware_tools = {'build', 'build-all', 'project'}
    analysis_tools = {'sim', 'netlist', 'docs', 'docs-assets'}
    container_capable = analysis_tools | {'test', 'doctor'} | (firmware_tools if build_backend == 'foss' else set())
    if runner == 'auto':
        runner = 'container' if not inside and (action in analysis_tools or
                    action in firmware_tools and build_backend == 'foss') else 'local'
    if runner == 'container' and inside:
        runner = 'local'
    if runner == 'container' and action not in container_capable:
        raise BuildError(f'{action} with this backend requires runner=local (or a configured Dev Container)')
    if CONTAINER & options.keys() and action != 'image' and runner != 'container':
        raise BuildError('Container options require runner=container outside the Dev Container, or action image')
    if action == 'image' and options.get('runner', 'auto') == 'container':
        raise BuildError('image builds on the host; use runner=local')
    engine = options.get('container_engine', 'docker')
    platform = options.get('container_platform', 'linux/amd64')
    image = options.get('toolchain_image', 'uz-cpld-toolchain')
    if sys.platform == 'win32' and action == 'flasher-build':
        raise BuildError('The pinned FOSS source build requires Linux; use the toolchain container or WSL')
    if runner == 'container':
        forwarded = {k: v for k, v in options.items() if k not in CONTAINER | {'runner', 'dry_run'}}
        command = [engine, 'run', '--rm', '--platform', platform]
        if sys.platform != 'win32' and Path(engine).name == 'podman':
            command += ['--userns=keep-id']
        if sys.platform != 'win32':
            command += ['--user', f'{os.getuid()}:{os.getgid()}']
        command += ['--mount',
                    f'type=bind,source={root},target=/work', '-w', '/work', image,
                    'python3', '-m', 'toolchain.commands', action, '--runner', 'local']
        for key, value in sorted(forwarded.items()):
            command += ['--option', f'{key}={value}']
        return [Invocation(tuple(command), root)]
    if action == 'image':
        return [Invocation((engine, 'build', '--platform', platform, '--target', 'toolchain',
                            '-f', '.devcontainer/Dockerfile', '-t', image, '.'), root)]
    python = sys.executable
    def invoke(module, args, working=root):
        return Invocation(tuple([python, '-m', module, *args]), working)
    def flags(*keys):
        result = []
        for key in keys:
            if key in options:
                value = options[key]
                if key == 'target':
                    value = TARGETS[value]
                result += ['--' + key.replace('_', '-'), value]
        return result
    if action == 'doctor':
        return [invoke('toolchain.doctor', ['--backend', build_backend, *flags('target', 'release_cycle')])]
    if action == 'venv':
        return [invoke('toolchain.venv', ['--activate', options.get('activate', '1')])]
    if action in ('init', 'scan', 'identify', 'program', 'programmer-project'):
        selection = Path(options.get('selection', 'selection.toml'))
        if not selection.is_absolute():
            selection = cwd / selection
        args = []
        if action in ('init', 'program', 'programmer-project'):
            args += ['--selection', str(selection)]
        args += flags('release_cycle', 'probe_index')
        if action == 'programmer-project':
            args += ['--build-backend', build_backend]
            if options.get('rebuild') == '1':
                args += ['--build']
            return [invoke('programmer_helper', args)]
        if action != 'init':
            args += ['--programmer-backend', programmer_backend]
            if action == 'program':
                args += ['--build-backend', build_backend]
                if 'target' not in options:
                    raise BuildError('program requires target=dslot or target=s3c; use python -m toolchain init to create a selection')
            args += ['--target', options.get('target', 'dslot')]
            args += flags('cable', 'usb_serial')
            args += ['--execute']
        return [invoke('programmer_helper.program', [action, *args])]
    if action == 'flasher-build':
        return [invoke('toolchain.foss.flasher', ['--jobs', options.get('jobs', '4')])]
    if action == 'test':
        if sys.platform == 'win32':
            return [invoke('unittest', [*WINDOWS_TESTS, '-v'])]
        return [invoke('unittest', ['discover', '-s', f'{folder}/tests', '-v'])
                for folder in ('xo2_library', 'cpld_vhdl_generator', 'toolchain', 'programmer_helper')]
    if action == 'sim':
        cycle = resolve_release(root, options.get('release_cycle'))
        args = ['toolchain/simulation/test_simulation.py', '-v', '-n', options.get('jobs', '4'),
                f'--junitxml=toolchain/build/simulation/{cycle}/junit.xml', '--release-cycle', cycle,
                '--seed', options.get('seed', '1'), '--wave-format', options.get('wave_format', 'vcd')]
        return [invoke('pytest', args + flags('program', 'target'))]
    if action == 'netlist':
        return [invoke('toolchain.analysis.netlist', flags('program', 'target', 'release_cycle'))]
    if action in ('docs', 'docs-assets'):
        cycle = options.get('release_cycle') or resolve_release(root)
        args = ['--jobs', options.get('jobs', '4'), '--release-cycle', cycle]
        args += flags('program', 'target')
        if action == 'docs':
            args += ['--build-site']
        return [invoke('toolchain.analysis.documentation', args)]
    args = flags('program', 'target', 'release_cycle', 'name', 'template', 'template_release_cycle', 'from')
    if 'backend' in COMMANDS[action].options:
        args += ['--backend', build_backend]
    if options.get('discard_project_changes') == '1':
        args += ['--discard-project-changes']
    internal = 'release-current' if action == 'release-select' else action
    return [invoke('toolchain.buildsystem', [internal, *args])]


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', nargs='?', default='help')
    parser.add_argument('--make-help', action='store_true', help=argparse.SUPPRESS)
    parser.add_argument('--option', action='append', default=[], metavar='KEY=VALUE')
    names = set().union(*(s.options for s in COMMANDS.values())) | CONTAINER | {'command'}
    for key in sorted(names):
        parser.add_argument('--' + key.replace('_', '-'), dest=key)
    args = parser.parse_args(argv)
    style = 'make' if args.make_help else 'python'
    try:
        options = {key: getattr(args, key) for key in names if getattr(args, key) is not None}
        for item in args.option:
            key, separator, value = item.partition('=')
            if not separator:
                raise BuildError('Options must have the form key=value')
            if key in options:
                raise BuildError(f'Duplicate option {key}')
            options[key] = value
        if args.action == 'help':
            if set(options) - {'command'}:
                raise BuildError('help accepts only command=ACTION')
            if 'command' in options:
                action = ALIASES.get(options['command'], (options['command'], {}))[0]
                if action not in COMMANDS:
                    raise BuildError(f'Unknown action {action}')
                print(COMMANDS[action].group)
                print(command_help(action, style))
                print('\n' + shared_help(style))
            else:
                print(help_text(style))
            return 0
        if args.action in ALIASES:
            print(f'Compatibility alias: use python -m toolchain {ALIASES[args.action][0]} instead.', file=sys.stderr)
        calls = plan(args.action, options)
        if options.get('dry_run') == '1':
            print('Preview only: no commands will be executed.')
        for call in calls:
            print(f'[{call.cwd}] {shlex.join(call.argv)}', flush=True)
            if options.get('dry_run') != '1':
                subprocess.run(call.argv, cwd=call.cwd, check=True)
        return 0
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
