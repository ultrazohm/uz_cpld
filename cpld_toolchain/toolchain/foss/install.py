"""Install the checksum-pinned Linux amd64 OSS CAD Suite into an explicit prefix."""
import argparse
import hashlib
import json
from pathlib import Path
import platform
import subprocess
import tempfile


def install(prefix, archive=None):
    pin = json.loads(Path(__file__).with_name('toolchain.json').read_text())
    prefix = Path(prefix).absolute()
    if platform.system() != 'Linux' or platform.machine() not in ('x86_64', 'amd64'):
        raise ValueError('OSS CAD Suite setup requires Linux amd64; use the container on other hosts')
    if prefix.exists() or prefix.is_symlink():
        raise ValueError(f'Install prefix already exists: {prefix}; select an empty destination')
    prefix.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='cpld-foss-', dir=prefix.parent) as tmp:
        tmp = Path(tmp)
        if archive is None:
            archive = tmp / 'suite.tgz'
            subprocess.run(['curl', '-fL', '--retry', '3', pin['url'], '-o', str(archive)], check=True)
        sha = hashlib.sha256()
        with Path(archive).open('rb') as stream:
            for chunk in iter(lambda: stream.read(1024 * 1024), b''):
                sha.update(chunk)
        if sha.hexdigest() != pin['sha256']:
            raise ValueError('OSS CAD Suite archive checksum mismatch')
        subprocess.run(['tar', '-xzf', str(Path(archive).resolve()), '--no-same-owner', '-C', str(tmp)], check=True)
        extracted = tmp / 'oss-cad-suite'
        for tool in ('yosys', 'nextpnr-machxo2', 'ecppack', 'ecpunpack', 'openFPGALoader'):
            if not (extracted / 'bin' / tool).is_file():
                raise ValueError(f'Archive is missing {tool}')
        (extracted / 'cpld-toolchain.json').write_text(json.dumps(pin, indent=2) + '\n')
        extracted.rename(prefix)
    print(prefix)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--prefix', type=Path, required=True)
    parser.add_argument('--archive', type=Path, help='Use a previously downloaded archive with the pinned checksum')
    args = parser.parse_args()
    try:
        install(args.prefix, args.archive)
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f'{exc}\n')
