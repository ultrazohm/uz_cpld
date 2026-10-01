"""Set up the native generator, Diamond and programmer Python environment."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import venv

ROOT = Path(__file__).resolve().parents[1]


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
        venv.EnvBuilder(with_pip=True).create(environment)
        python = environment / 'bin/python'
        subprocess.run([str(python), '-m', 'pip', 'install', '-r',
                        str(ROOT / 'requirements.txt'), '-e', str(ROOT)], check=True)
        subprocess.run([str(python), '-m', 'pip', 'check'], check=True)
        print('Python environment ready. Diamond, its license and libusb-1.0 are separate system dependencies.', flush=True)
        if args.activate == '1' and sys.stdin.isatty():
            print('Opening an activated Bash shell. Use exit to return to your previous shell.', flush=True)
            os.execvp('bash', ['bash', '--noprofile', '--rcfile',
                              str(ROOT / 'toolchain/venv-shell.bash'), '-i'])
        else:
            import shlex
            print(f'To activate in your current shell: source {shlex.quote(str(environment / "bin/activate"))}')
        return 0
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'Environment setup failed: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
