"""Build and verify the pinned MachXO2 USERCODE-capable openFPGALoader."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

BASE = Path(__file__).resolve().parent
# Also runs as a standalone Docker build script under /tmp/foss-setup.
ROOT = next((parent for parent in BASE.parents
             if (parent / 'programs/releases.toml').is_file()), BASE.parent)
RECEIPT = 'usercode-support.json'


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def pin():
    data = json.loads((BASE / 'openfpgaloader.json').read_text())
    if digest(BASE / 'openfpgaloader-usercode.patch') != data['patch_sha256']:
        raise ValueError('openFPGALoader patch checksum differs from its tracked pin')
    return data


def verify(binary):
    """Reject unpatched, modified or stale loader binaries before any USB access."""
    binary = Path(binary)
    try:
        record = json.loads((binary.parent / RECEIPT).read_text())
        if record['pin'] != pin() or record['binary_sha256'] != digest(binary):
            raise ValueError('flasher provenance does not match the current pin and binary')
    except (OSError, ValueError, KeyError, TypeError) as exc:
        raise ValueError(f'{binary}: a verified USERCODE-capable flasher is required; run make flasher_build or rebuild the container ({exc})') from exc
    return record


def check_file(binary, firmware, usercode):
    """Use the actual patched parsers without creating a JTAG connection."""
    result = subprocess.run([str(binary), '--check-file', '--usercode', usercode, str(firmware)],
                            capture_output=True, text=True, timeout=30)
    if result.returncode:
        raise ValueError(f'Flasher rejected {firmware} before USB access: {result.stdout}{result.stderr}')
    return result.stdout


def publish(binary, license_file, output, data):
    """Serialize installation and make the receipt readable by runtime users."""
    output.mkdir(parents=True, exist_ok=True)
    output.chmod(0o755)
    import fcntl  # Only the Linux source-build publisher uses directory flock.
    fd = os.open(output, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
    try:
        fcntl.flock(fd, fcntl.LOCK_EX)
        for name, source, mode in (('openFPGALoader', binary, 0o755), ('LICENSE', license_file, 0o644)):
            handle, staged = tempfile.mkstemp(prefix='.install-', dir=output)
            os.close(handle)
            try:
                shutil.copyfile(source, staged)
                os.chmod(staged, mode)
                os.replace(staged, output / name)
            finally:
                if os.path.exists(staged):
                    os.unlink(staged)
        handle, staged = tempfile.mkstemp(prefix='.receipt-', dir=output)
        try:
            with os.fdopen(handle, 'w') as stream:
                stream.write(json.dumps({'pin': data, 'binary_sha256': digest(binary)}, indent=2) + '\n')
            os.chmod(staged, 0o644)
            os.replace(staged, output / RECEIPT)
        finally:
            if os.path.exists(staged):
                os.unlink(staged)
        verify(output / 'openFPGALoader')
    finally:
        os.close(fd)


def build(output, jobs=2, archive=None):
    data = pin()
    output = Path(output).absolute()
    if jobs < 1:
        raise ValueError('jobs must be positive')
    for path in (output, *output.parents):
        if path.is_symlink():
            raise ValueError(f'Flasher output must not traverse a symlink: {path}')
    with tempfile.TemporaryDirectory(prefix='uz-flasher-') as temporary:
        work = Path(temporary)
        source = work / 'source'
        source.mkdir()
        if archive is None:
            archive = work / 'source.tar.gz'
            subprocess.run(['curl', '-fL', '--retry', '3', data['url'], '-o', str(archive)], check=True)
        else:
            archive = Path(archive).resolve()
        if digest(archive) != data['sha256']:
            raise ValueError('openFPGALoader source checksum mismatch')
        subprocess.run(['tar', '-xzf', str(archive), '--strip-components=1', '--no-same-owner', '-C', str(source)], check=True)
        subprocess.run(['patch', '-p1', '--batch', '--forward', '-i', str(BASE / 'openfpgaloader-usercode.patch')], cwd=source, check=True)
        subprocess.run(['c++', '-std=c++11', '-I', str(source / 'src'), str(BASE / 'tests/usercode.cpp'),
                        '-o', str(work / 'usercode-test')], check=True)
        subprocess.run([str(work / 'usercode-test')], check=True)
        build_dir = work / 'build'
        subprocess.run(['cmake', '-S', str(source), '-B', str(build_dir), '-DENABLE_CABLE_ALL=OFF',
                        '-DENABLE_FTDI_BASED_CABLE=ON', '-DENABLE_VENDORS_ALL=OFF',
                        '-DENABLE_LATTICE_SUPPORT=ON', '-DENABLE_UDEV=OFF'], check=True)
        subprocess.run(['cmake', '--build', str(build_dir), '-j', str(jobs)], check=True)
        binary = build_dir / 'openFPGALoader'
        version = subprocess.check_output([str(binary), '--Version'], text=True)
        if data['capability'] not in version:
            raise ValueError('Compiled flasher does not report the required capability version')
        # Readers reject a replaced binary until its matching receipt is installed.
        publish(binary, source / 'LICENSE', output, data)
    print(output / 'openFPGALoader')


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'cpld_toolchain/toolchain/build/openfpgaloader')
    parser.add_argument('--jobs', type=int, default=2)
    parser.add_argument('--archive', type=Path)
    args = parser.parse_args(argv)
    try:
        build(args.output, args.jobs, args.archive)
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f'{exc}\n')


if __name__ == '__main__':
    main()
