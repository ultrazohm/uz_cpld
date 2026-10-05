"""Set up the native generator, Diamond and programmer Python environment."""
from cpld_toolchain import repository_root
import argparse
from pathlib import Path
import shlex
import shutil
import subprocess
import sys
import venv

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


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--activate', choices=('0', '1'), default='1')
    args = parser.parse_args(argv)
    if sys.version_info < (3, 10):
        parser.error('Python 3.10 or later is required')
    environment = ROOT / '.venv'
    try:
        if environment.exists() and not (environment / 'pyvenv.cfg').is_file():
            raise ValueError(f'{environment} exists but is not a virtual environment')
        python = environment_python(environment)
        if not (environment / 'pyvenv.cfg').is_file():
            venv.EnvBuilder(with_pip=True).create(environment)
        elif not python.is_file():
            raise ValueError(f'{environment} has no interpreter for this platform; recreate it')
        # Reuse an existing interpreter: Windows cannot replace a running .exe.
        pip = subprocess.run([str(python), '-m', 'pip', '--version'],
                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if pip.returncode:
            subprocess.run([str(python), '-m', 'ensurepip', '--upgrade'], check=True)
        subprocess.run([str(python), '-m', 'pip', 'install', '-r',
                        str(ROOT / 'requirements.txt'), '-e', str(ROOT)], check=True)
        subprocess.run([str(python), '-m', 'pip', 'check'], check=True)
        print('Python environment ready. Diamond, its license and programmer drivers are installed separately.', flush=True)
        if args.activate == '1' and sys.stdin.isatty():
            print('Opening an activated shell. Use exit to return to your previous shell.', flush=True)
            return subprocess.call(shell_command(environment))
        else:
            print(f'To activate in your current shell: {activation_command(environment)}')
        return 0
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'Environment setup failed: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
