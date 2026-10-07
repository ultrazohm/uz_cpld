"""Typer frontend for the shared command contract.

The registry supplies signatures so Make, Python callers, and Typer cannot drift
into different option sets. Importing this module never imports a workflow.
"""
from enum import Enum
from inspect import Parameter, Signature
from pathlib import Path
import sys
from typing import Optional

import typer

from .toolchain import commands
from .toolchain.buildsystem.model import BuildError


class Backend(str, Enum):
    diamond = 'diamond'
    foss = 'foss'


class FirmwareSource(str, Enum):
    local = 'local'
    zip = 'zip'


class Target(str, Enum):
    dslot = 'dslot'
    s3c = 's3c'
    uz_dslot_xo2 = 'uz_dslot_xo2'
    uz_s3c_xo2 = 'uz_s3c_xo2'


class WaveFormat(str, Enum):
    vcd = 'vcd'
    ghw = 'ghw'
    fst = 'fst'


def option(key, required):
    annotation, settings = str, {}
    if key in ('backend', 'build_backend', 'programmer_backend'):
        annotation = Backend
    elif key == 'source':
        annotation = FirmwareSource
    elif key == 'target':
        annotation = Target
    elif key == 'wave_format':
        annotation = WaveFormat
    elif key in ('jobs', 'seed', 'probe_index'):
        annotation, settings = int, {'min': 1 if key == 'jobs' else 0}
    elif key in ('dry_run', 'rebuild', 'discard_project_changes', 'activate'):
        annotation, settings = int, {'min': 0, 'max': 1}
    elif key in ('selection', 'output', 'firmware'):
        annotation = Path
    return Parameter('from_' if key == 'from' else key, Parameter.KEYWORD_ONLY,
                     annotation=annotation if required else Optional[annotation],
                     default=typer.Option(... if required else None,
                                          '--' + key.replace('_', '-'), **settings))


def make_app(style='python'):
    app = typer.Typer(no_args_is_help=False, pretty_exceptions_enable=False,
                      help='Build, simulate, document and program UltraZohm CPLDs.')

    @app.callback(invoke_without_command=True)
    def root(ctx: typer.Context):
        if ctx.invoked_subcommand is None:
            print(commands.help_text(style))

    @app.command('help')
    def help_command(command: Optional[str] = typer.Option(None, '--command')):
        if command is None:
            print(commands.help_text(style))
            return
        name = command
        if name not in commands.COMMANDS:
            raise BuildError(f'Unknown action {command}')
        print(commands.COMMANDS[name].group)
        print(commands.command_help(name, style))
        print('\n' + commands.shared_help(style))

    def register(name, contract):
        def callback(**values):
            options = {('from' if key == 'from_' else key):
                       str(value.value if isinstance(value, Enum) else value)
                       for key, value in values.items() if value is not None}
            commands.run(name, options)
        callback.__signature__ = Signature(
            [option(key, key in contract.required) for key in commands.ARGUMENT_VALUES
             if key in contract.options])
        callback.__name__ = name
        app.command(name, help=contract.description, rich_help_panel=contract.group)(callback)

    for name, contract in commands.COMMANDS.items():
        register(name, contract)

    @app.command('generator', help='Generate VHDL from a standalone config; no catalog needed.')
    def generator(config: Path, output: Path = typer.Option(..., '--output'),
                  check: bool = typer.Option(False, '--check')):
        from .cpld_vhdl_generator.__main__ import main as generate
        raise typer.Exit(generate([str(config), '--output', str(output), *(['--check'] if check else [])]))

    return app


def translate_make_options(argv):
    """Translate the existing Make protocol without a second argument parser."""
    result, seen = [], set()
    iterator = iter(argv)
    for item in iterator:
        if item == '--option':
            assignment = next(iterator, '')
            key, separator, value = assignment.partition('=')
            if not separator:
                raise BuildError('Options must have the form key=value')
            flag = '--' + key.replace('_', '-')
            if flag in seen or flag in argv:
                raise BuildError(f'Duplicate option {key}')
            seen.add(flag)
            result += [flag, value]
        else:
            result.append(item)
    return result


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    style = 'make' if '--make-help' in args else 'python'
    args = [arg for arg in args if arg != '--make-help']
    try:
        app = make_app(style)
        app(translate_make_options(args), prog_name='uz_cpld', standalone_mode=True)
        return 0
    except SystemExit as exc:
        return exc.code or 0
    except (BuildError, OSError, ValueError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 2
