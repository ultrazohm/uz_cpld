"""Public command contract shared by Make, help, and command-routing tests."""
import argparse
from dataclasses import dataclass
import os
from pathlib import Path
import shlex
import subprocess
import sys

from toolchain.buildsystem.model import BuildError, resolve_release

ROOT = Path(__file__).resolve().parents[1]
TARGETS = {'dslot': 'uz_dslot_xo2', 's3c': 'uz_s3c_xo2'}
COMMON = {'runner', 'dry_run'}
CONTAINER = {'container_engine', 'container_platform', 'toolchain_image'}
FIRMWARE = {'backend', 'build_backend', 'target', 'release_cycle'}
PROBE = {'backend', 'programmer_backend', 'target', 'probe_index', 'cable', 'usb_serial'}


@dataclass(frozen=True)
class Command:
    group: str
    example: str
    description: str
    options: frozenset[str]
    required: frozenset[str] = frozenset()


def spec(group, example, description, options=(), required=()):
    return Command(group, example, description, frozenset(options) | COMMON, frozenset(required))


# Insertion order is the clean-clone workflow, and is also the help order.
COMMANDS = {
    'image': spec('1. Set up tools and build firmware', 'image', 'Build the container tools (optional for native Diamond)', CONTAINER),
    'doctor': spec('1. Set up tools and build firmware', 'doctor', 'Check Diamond and catalog inputs; backend=foss checks FOSS', FIRMWARE),
    'list': spec('1. Set up tools and build firmware', 'list', 'List programs in the current release catalog', FIRMWARE),
    'build-all': spec('1. Set up tools and build firmware', 'build-all', 'Build every catalog program for the selected backend', FIRMWARE),
    'report': spec('1. Set up tools and build firmware', 'report', 'Summarize existing catalog build evidence', FIRMWARE),
    'init': spec('2. Create the programmer selection and project', 'init', 'Create selection.toml; preserve an existing file', {'selection'}),
    'programmer-project': spec('2. Create the programmer selection and project', 'programmer-project', 'Export both Diamond XCFs from the edited selection', {'selection', 'release_cycle', 'backend', 'build_backend', 'programmer_backend', 'probe_index', 'rebuild'}),
    'scan': spec('3. Connect, inspect, and program hardware', 'scan target=dslot', 'Check JTAG IDs (target defaults to dslot)', PROBE),
    'identify': spec('3. Connect, inspect, and program hardware', 'identify target=dslot', 'Read firmware identity and silicon TraceID', PROBE),
    'program': spec('3. Connect, inspect, and program hardware', 'program target=dslot', 'Program one physical chain from selection.toml', PROBE | {'selection', 'release_cycle', 'build_backend'}, {'target'}),
    'new': spec('4. Create or modify a program', 'new name=NAME template=tx30', 'Clone a program; template=generator creates CSV inputs', FIRMWARE | {'name', 'template', 'template_release_cycle'}, {'name'}),
    'generate': spec('4. Create or modify a program', 'generate program=NAME', 'Generate VHDL and register a CSV-based program', FIRMWARE | {'program'}, {'program'}),
    'check': spec('4. Create or modify a program', 'check program=NAME', 'Validate a program manifest and inputs', FIRMWARE | {'program'}, {'program'}),
    'build': spec('4. Create or modify a program', 'build program=NAME', 'Build one program; target is inferred when unambiguous', FIRMWARE | {'program'}, {'program'}),
    'project': spec('4. Create or modify a program', 'project program=NAME', 'Prepare one firmware project without compiling it', FIRMWARE | {'program'}, {'program'}),
    'gui': spec('4. Create or modify a program', 'gui program=NAME', 'Open the Diamond firmware project', FIRMWARE | {'program'}, {'program'}),
    'sim': spec('5. Validate and document', 'sim [program=NAME]', 'Simulate complete manifests in the current release', {'program', 'target', 'release_cycle', 'jobs', 'seed', 'wave_format'}),
    'netlist': spec('5. Validate and document', 'netlist [program=NAME]', 'Export RTL diagrams; defaults to the current catalog', {'program', 'target', 'release_cycle'}),
    'docs': spec('5. Validate and document', 'docs [release_cycle=all]', 'Generate assets and HTML; defaults to the current release', {'program', 'target', 'release_cycle', 'jobs'}),
    'docs-assets': spec('5. Validate and document', 'docs-assets [program=NAME]', 'Generate documentation assets without rendering HTML', {'program', 'target', 'release_cycle', 'jobs'}),
    'test': spec('5. Validate and document', 'test', 'Run Python utility tests; sim runs HDL tests'),
    'release-list': spec('6. Manage releases and maintenance', 'release-list', 'List releases and the current selection'),
    'release-new': spec('6. Manage releases and maintenance', 'release-new name=NAME [from=CYCLE]', 'Create a release and make it current', {'name', 'from'}, {'name'}),
    'release-select': spec('6. Manage releases and maintenance', 'release-select release_cycle=NAME', 'Select the default release', {'release_cycle'}, {'release_cycle'}),
    'usercodes': spec('6. Manage releases and maintenance', 'usercodes', 'List permanent program numbers and build revisions'),
    'usercodes-assign': spec('6. Manage releases and maintenance', 'usercodes-assign', 'Register manually added programs'),
    'flasher-build': spec('6. Manage releases and maintenance', 'flasher-build', 'Compile the optional FOSS programmer utility locally', {'jobs'}),
    'clean': spec('6. Manage releases and maintenance', 'clean program=NAME', 'Remove one backend build; preserve simulation and diagrams', FIRMWARE | {'program', 'discard_project_changes'}, {'program'}),
    'clean-all': spec('6. Manage releases and maintenance', 'clean-all', 'Remove all generated builds, assets, and caches'),
}
ALIASES = {
    'programmer': ('init', {}), 'lattice_xcf': ('programmer-project', {}),
    'release-current': ('release-select', {}), 'flasher': ('flasher-build', {}),
    'docs-local': ('docs', {'runner': 'local'}),
    'docs-assets-local': ('docs-assets', {'runner': 'local'}),
    'netlist-local': ('netlist', {'runner': 'local'}),
    'test-container': ('test', {'runner': 'container'}), '_sim': ('sim', {'runner': 'local'}),
}


def help_text():
    lines = ['Usage: make ACTION [key=value ...]',
             'Defaults: backend=diamond; current release; selection=selection.toml.',
             'From a clean clone: configure Diamond, build-all, init, edit selection.toml,',
             'then programmer-project and the hardware commands. XCF export is optional',
             'for command-line programming, which creates its own verified project.', '']
    group = None
    for name, command in COMMANDS.items():
        if command.group != group:
            group = command.group
            lines += [group]
        lines.append(f'  make {command.example:<43} {command.description}')
    lines += ['', 'Shared rules:',
              '  target=dslot|s3c everywhere; long target names remain accepted aliases.',
              '  backend=diamond|foss sets both defaults; build_backend and programmer_backend override each part.',
              '  Selection files hold assignments and release, not backend defaults.',
              '  dry_run=1 prints the resolved commands without writes or tool/hardware execution.',
              '  runner=auto|local|container selects the environment independently of the backend.',
              '  Auto: configured Dev Container stays local; host FOSS builds/sim/netlist/docs use the image.',
              '  Run make image first for container execution. Diamond and USB actions run locally.',
              '  Unsupported options are errors. Use make help command=ACTION for allowed options.',
              '  Run actions separately and in order; make -j is not a workflow scheduler.']
    return '\n'.join(lines)


def normalize(action, options):
    options = dict(options)
    if action in ALIASES:
        action, defaults = ALIASES[action]
        options = {**defaults, **options}
    if action not in COMMANDS:
        raise BuildError(f'Unknown action {action!r}; run make help')
    unsupported = set(options) - COMMANDS[action].options - CONTAINER
    if unsupported:
        raise BuildError(f'{action} does not accept {", ".join(sorted(unsupported))}; run make help command={action}')
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
    for key in ('dry_run', 'rebuild', 'discard_project_changes'):
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
    firmware_tools = {'build', 'build-all', 'project', 'doctor'}
    analysis_tools = {'sim', 'netlist', 'docs', 'docs-assets'}
    container_capable = analysis_tools | {'test'} | (firmware_tools if build_backend == 'foss' else set())
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
    if runner == 'container':
        forwarded = {k: v for k, v in options.items() if k not in CONTAINER | {'runner', 'dry_run'}}
        command = [engine, 'run', '--rm', '--platform', platform]
        if Path(engine).name == 'podman':
            command += ['--userns=keep-id']
        command += ['--user', f'{os.getuid()}:{os.getgid()}', '--mount',
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
                    raise BuildError('program requires target=dslot or target=s3c; use make init to create a selection')
            args += ['--target', options.get('target', 'dslot')]
            args += flags('cable', 'usb_serial')
            args += ['--execute']
        return [invoke('programmer_helper.program', [action, *args])]
    if action == 'flasher-build':
        return [invoke('toolchain.foss.flasher', ['--jobs', options.get('jobs', '4')])]
    if action == 'test':
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
    parser.add_argument('--option', action='append', default=[], metavar='KEY=VALUE')
    names = set().union(*(s.options for s in COMMANDS.values())) | CONTAINER | {'command'}
    for key in sorted(names):
        parser.add_argument('--' + key.replace('_', '-'), dest=key)
    args = parser.parse_args(argv)
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
                spec = COMMANDS[action]
                print(f'make {spec.example}\n{spec.description}\nOptions: ' + ', '.join(sorted(spec.options)))
                print('Required: ' + (', '.join(sorted(spec.required)) or 'none'))
                if action != 'image':
                    print('Container options (when using a host runner=container): ' + ', '.join(sorted(CONTAINER)))
            else:
                print(help_text())
            return 0
        if args.action in ALIASES:
            print(f'Compatibility alias: use make {ALIASES[args.action][0]} instead.', file=sys.stderr)
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
