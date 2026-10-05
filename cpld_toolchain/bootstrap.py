"""Standard-library-only setup entry point, compatible with Python 3.8+."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import shutil
import subprocess
import sys
import tarfile
import tempfile
import urllib.request
import zipfile

from cpld_toolchain import repository_root

ROOT = repository_root()


def uv_asset():
    machine = platform.machine().lower()
    arch = {'amd64': 'x86_64', 'x86_64': 'x86_64',
            'arm64': 'aarch64', 'aarch64': 'aarch64'}.get(machine)
    target = {'linux': 'unknown-linux-gnu.tar.gz', 'darwin': 'apple-darwin.tar.gz',
              'win32': 'pc-windows-msvc.zip'}.get(sys.platform)
    if not arch or not target:
        raise ValueError('Automatic setup supports Linux, macOS and Windows on x86_64 or ARM64')
    return 'uv-{}-{}'.format(arch, target)


def ensure_uv(root):
    manifest = json.loads(Path(__file__).with_name('uv-bootstrap.json').read_text())
    asset = uv_asset()
    cache = root / '.tools' / 'uv' / manifest['version'] / asset
    binary = cache / ('uv.exe' if sys.platform == 'win32' else 'uv')
    if binary.is_file():
        return binary
    cache.mkdir(parents=True, exist_ok=True)
    url = 'https://github.com/astral-sh/uv/releases/download/{}/{}'.format(manifest['version'], asset)
    print('Downloading uv {}...'.format(manifest['version']), flush=True)
    with tempfile.TemporaryDirectory(dir=str(cache)) as temporary:
        archive = Path(temporary) / asset
        with urllib.request.urlopen(url, timeout=60) as response, archive.open('wb') as output:
            shutil.copyfileobj(response, output)
        if hashlib.sha256(archive.read_bytes()).hexdigest() != manifest['sha256'][asset]:
            raise ValueError('Downloaded uv archive failed SHA-256 verification')
        staged = Path(temporary) / binary.name
        # Extract only the executable, never archive-controlled paths or links.
        if asset.endswith('.zip'):
            with zipfile.ZipFile(archive) as bundle:
                members = [n for n in bundle.namelist() if Path(n).name == binary.name]
                if len(members) != 1:
                    raise ValueError('uv archive must contain exactly one executable')
                with bundle.open(members[0]) as source, staged.open('wb') as output:
                    shutil.copyfileobj(source, output)
        else:
            with tarfile.open(archive) as bundle:
                members = [m for m in bundle.getmembers() if m.isfile() and Path(m.name).name == binary.name]
                if len(members) != 1:
                    raise ValueError('uv archive must contain exactly one executable')
                with bundle.extractfile(members[0]) as source, staged.open('wb') as output:
                    shutil.copyfileobj(source, output)
        staged.chmod(0o755)
        staged.replace(binary)
    return binary


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--activate', choices=('0', '1'), default='1')
    parser.add_argument('--dry-run', choices=('0', '1'), default='0')
    args = parser.parse_args(argv)
    try:
        if args.dry_run == '1':
            print('Preview only: no commands will be executed.')
            command = [sys.executable, '-m', 'cpld_toolchain.toolchain.venv',
                       '--activate', args.activate]
            print('[{}] {}'.format(ROOT, shlex.join(command)))
            return 0
        environment = ROOT / '.venv'
        if environment.exists() and not (environment / 'pyvenv.cfg').is_file():
            raise ValueError('{} exists but is not a virtual environment'.format(environment))
        uv = ensure_uv(ROOT)
        env = os.environ.copy()
        # Do not let an active Conda/venv or user uv settings change the destination.
        env.pop('VIRTUAL_ENV', None)
        env['UV_PROJECT_ENVIRONMENT'] = str(environment)
        env['UV_PYTHON_DOWNLOADS'] = 'automatic'
        subprocess.run([str(uv), 'sync', '--locked', '--all-groups', '--managed-python', '--python',
                        (ROOT / '.python-version').read_text().strip()],
                       cwd=str(ROOT), env=env, check=True)
        from .toolchain.venv import activation_command, shell_command
        print('Python environment ready. Native HDL tools, Diamond and drivers are installed separately.', flush=True)
        if args.activate == '1' and sys.stdin.isatty():
            print('Opening an activated shell. Use exit to return.', flush=True)
            return subprocess.call(shell_command(environment), cwd=str(ROOT))
        print('To activate: {}'.format(activation_command(environment)))
        return 0
    except (OSError, ValueError, subprocess.CalledProcessError, tarfile.TarError, zipfile.BadZipFile) as exc:
        print('Environment setup failed: {}'.format(exc), file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
