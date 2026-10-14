"""Build headless nextpnr with the XO2-2000 and XO2-4000 device databases."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


def build(suite, jobs=2, archives=None):
    suite = Path(suite).resolve()
    pin = json.loads(Path(__file__).with_name('sources.json').read_text())
    output = suite / 'native'
    if output.exists():
        raise ValueError(f'Native tool destination already exists: {output}')
    cmake = shutil.which('cmake')
    if not cmake:
        raise ValueError('CMake >=3.25 is required; install cmake==3.31.6')
    with tempfile.TemporaryDirectory(prefix='cpld-nextpnr-') as tmp:
        tmp = Path(tmp)
        for name, source in pin.items():
            archive = Path(archives) / f'{name}.tar.gz' if archives else tmp / f'{name}.tar.gz'
            if not archives:
                subprocess.run(['curl', '-fL', '--retry', '3', source['url'], '-o', str(archive)], check=True)
            if hashlib.sha256(archive.read_bytes()).hexdigest() != source['sha256']:
                raise ValueError(f'{name} source checksum mismatch')
            (tmp / name).mkdir()
            subprocess.run(['tar', '-xzf', str(archive), '--strip-components=1', '--no-same-owner',
                            '-C', str(tmp / name)], check=True)
        def run(*args):
            subprocess.run([cmake, *map(str, args)], check=True)
        trellis = tmp / 'trellis-build'
        run('-S', tmp / 'trellis/libtrellis', '-B', trellis,
            '-DPYBIND11_INCLUDE_DIR=/usr/include', f'-DPython3_EXECUTABLE={sys.executable}',
            '-DCURRENT_GIT_VERSION=' + pin['trellis']['revision'])
        run('--build', trellis, '--target', 'pytrellis', '-j', jobs)
        nextpnr = tmp / 'nextpnr-build'
        run('-S', tmp / 'nextpnr', '-B', nextpnr, '-DARCH=machxo2', '-DMACHXO2_DEVICES=2000;4000',
            '-DBUILD_GUI=OFF', '-DBUILD_PYTHON=OFF', '-DUSE_IPO=OFF', '-DBoost_USE_STATIC_LIBS=ON',
            '-DTRELLIS_LIBDIR=' + str(trellis), '-DTRELLIS_DATADIR=' + str(suite / 'share/trellis'),
            f'-DPython3_EXECUTABLE={sys.executable}', '-DCURRENT_GIT_VERSION=' + pin['nextpnr']['revision'])
        run('--build', nextpnr, '-j', jobs)
        binary = nextpnr / 'nextpnr-machxo2'
        devices = subprocess.check_output([str(binary), '--list-devices'], stderr=subprocess.STDOUT, text=True)
        required = ('LCMXO2-2000HC-4TG100C', 'LCMXO2-4000HC-4TG144C')
        if any(device not in devices for device in required):
            raise ValueError('Built nextpnr does not include both required devices')
        output.mkdir()
        try:
            shutil.copy2(binary, output / binary.name)
            subprocess.run(['strip', '--strip-debug', str(output / binary.name)], check=True)
            # Retain the source licenses alongside the binary.
            for name in pin:
                shutil.copy2(tmp / name / 'COPYING', output / f'{name}-COPYING')
            (output / 'sources.json').write_text(json.dumps(pin, indent=2) + '\n')
        except Exception:
            shutil.rmtree(output)
            raise
    print(output)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--suite', type=Path, required=True)
    parser.add_argument('--jobs', type=int, default=2)
    parser.add_argument('--archives', type=Path, help='Directory containing nextpnr.tar.gz and trellis.tar.gz')
    args = parser.parse_args()
    if args.jobs < 1:
        parser.error('--jobs must be positive')
    try:
        build(args.suite, args.jobs, args.archives)
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f'{exc}\n')
