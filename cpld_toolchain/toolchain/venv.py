"""Shell activation helpers for repository setup."""
from cpld_toolchain import repository_root
import shlex
import shutil
import sys

ROOT = repository_root()


def environment_python(environment):
    return environment / ('Scripts/python.exe' if sys.platform == 'win32' else 'bin/python')


def activation_command(environment):
    if sys.platform == 'win32':
        script = str(environment / 'Scripts/Activate.ps1').replace("'", "''")
        return "& '" + script + "'"
    return 'source ' + shlex.quote(str(environment / 'bin/activate'))


def shell_command(environment):
    if sys.platform == 'win32':
        shell = shutil.which('pwsh') or shutil.which('powershell.exe')
        if not shell:
            raise OSError('PowerShell not found; use --activate 0 and the venv Python directly')
        return [shell, '-NoLogo', '-NoProfile', '-NoExit', '-Command', activation_command(environment)]
    return ['bash', '--noprofile', '--rcfile', str(ROOT / 'cpld_toolchain/toolchain/venv-shell.bash'), '-i']
