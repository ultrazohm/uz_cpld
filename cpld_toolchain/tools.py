"""Tool discovery without importing workflows or starting external processes.

Explicit overrides are authoritative. A future distribution can populate
``bundled_tools`` with platform-specific executables and their companion files.
"""
import os
from pathlib import Path
import shutil
import sys

from cpld_toolchain import repository_root
from cpld_toolchain.toolchain.buildsystem.model import BuildError


def bundled_directory():
    return Path(os.environ.get('CPLD_BUNDLED_TOOLS', Path(__file__).with_name('bundled_tools')))


def executable(name, *, override=None, candidates=(), required=False):
    filename = name + '.exe' if sys.platform == 'win32' and not name.endswith('.exe') else name
    explicit = os.environ.get(override) if override else None
    if explicit:
        choices = [explicit]
    else:
        bundle = bundled_directory()
        choices = [bundle / filename, bundle / name / filename, *candidates, filename]
    for candidate in choices:
        found = shutil.which(str(candidate))
        if found:
            return Path(found).absolute()
    if required:
        hint = f' Set {override} to its executable.' if override else ''
        raise BuildError(f'{name} is unavailable (tried {", ".join(map(str, choices))}).{hint}')
    return Path(choices[0])


def loader_path():
    suite = Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite'))
    return executable('openFPGALoader', override='CPLD_OPENFPGALOADER', candidates=(
        repository_root() / 'build/openfpgaloader/openFPGALoader',
        suite / 'native/openfpgaloader/openFPGALoader', suite / 'bin/openFPGALoader'))


def yosys_path():
    suite = Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite'))
    filename = 'yosys.exe' if sys.platform == 'win32' else 'yosys'
    return executable('yosys', candidates=(suite / 'bin' / filename,))


def installed(path):
    return shutil.which(str(path)) is not None
