"""Execute planned component calls lazily; keep external tools as subprocesses."""
from contextlib import contextmanager
from importlib import import_module
import os
from pathlib import Path
import subprocess
import sys

from .toolchain.buildsystem.model import BuildError

# These entry points accept argv explicitly and do not mutate sys.argv.
ENTRY_POINTS = {
    'cpld_toolchain.toolchain.buildsystem': 'cpld_toolchain.toolchain.buildsystem.cli',
    'cpld_toolchain.programmer_helper': 'cpld_toolchain.programmer_helper.helper',
}


@contextmanager
def working_directory(path):
    previous = Path.cwd()
    try:
        os.chdir(path)
        yield
    finally:
        os.chdir(previous)


def execute(call):
    if call.module is None or call.module in ('unittest', 'pytest'):
        # Test runners own process-global state and need isolated interpreters.
        # Packaging their worker runtime is a separate distribution concern.
        subprocess.run(call.argv, cwd=call.cwd, check=True)
        return
    try:
        component = import_module(ENTRY_POINTS.get(call.module, call.module))
    except ImportError as exc:
        raise BuildError(f'{call.module} could not load: {exc}. '
                         'Run python -m cpld_toolchain setup to install the full Python dependencies.') from exc
    with working_directory(call.cwd):
        try:
            code = component.main(list(call.arguments))
        except SystemExit as exc:
            code = exc.code
    if code:
        raise BuildError(f'{call.module} failed (exit {code})')
