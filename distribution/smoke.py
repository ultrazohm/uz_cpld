"""Exercise the frozen CLI in an unrelated directory without Python on PATH."""
import argparse
from contextlib import contextmanager, ExitStack
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpld_toolchain.programmer_helper.tests.test_release import ReleaseTests


@contextmanager
def readonly_application(executable, destination, firmware):
    shutil.copytree(executable.parent, destination, symlinks=True)
    (destination / 'firmware').mkdir()
    shutil.copy2(firmware, destination / 'firmware/uz-cpld-firmware.zip')
    paths = [destination, *destination.rglob('*')]
    try:
        for path in paths:
            if not path.is_symlink():
                path.chmod(0o555 if path.is_dir() or os.access(path, os.X_OK) else 0o444)
        yield destination / executable.name
        assert set(destination.rglob('*')) == set(paths[1:]), 'Application wrote files into its installation'
    finally:
        for path in paths:
            if not path.is_symlink():
                path.chmod(0o755 if path.is_dir() else 0o644)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('executable', type=Path)
    args = parser.parse_args()
    executable = args.executable.resolve()
    fixture = ReleaseTests()
    fixture.setUp()
    try:
        with tempfile.TemporaryDirectory(prefix='uz standalone smoke ') as temporary, ExitStack() as stack:
            root = Path(temporary)
            executable = stack.enter_context(readonly_application(executable, root / 'read only application', fixture.zip))
            env = dict(os.environ, UZ_CPLD_CONFIG_DIR=str(root / 'config'), UZ_CPLD_DATA_DIR=str(root / 'data'),
                       PYTHONPATH='', PATH=os.environ.get('SystemRoot', 'C:\\Windows') + '\\System32' if os.name == 'nt' else '/usr/bin:/bin')
            env.pop('CPLD_PGRCMD', None)
            firmware = root / 'release firmware.zip'
            shutil.copy2(fixture.zip, firmware)
            def run(*arguments, success=True):
                result = subprocess.run([str(executable), *arguments], cwd=root, env=env,
                                        capture_output=True, text=True, timeout=30)
                if (result.returncode == 0) != success:
                    raise AssertionError(f'{arguments}: {result.returncode}\n{result.stdout}\n{result.stderr}')
                return result.stdout
            run('--version')
            run('--help')
            # Validate config without executing this stand-in programmer.
            run('programmer_path=' + str(executable))
            run('doctor')
            run('programmer_path=auto')
            run('firmware_list', '--included')
            run('program', '--target', 's3c', '--dry-run', '1', success=False)
            run('firmware_select', '--included')
            run('firmware_list')
            run('firmware_list', '--firmware', str(firmware))
            run('firmware_select', '--firmware', str(firmware))
            run('firmware_list')
            run('init_programmer', '--release', 'published', '--s3c', 'controller')
            run('program', '--target', 's3c', '--dry-run', '1')
            assert (root / 'data/workspace/selection.toml').is_file()
            firmware.unlink()
            run('firmware_list')  # Selected snapshot survives removal of the original.
            selected = json.loads((root / 'data/workspace/firmware.json').read_text())
            Path(selected['path']).write_bytes(b'corrupt')
            run('program', '--target', 's3c', success=False)
            for resource in ('templates/s3c.xcf', 'templates/dslots.xcf', 'diamond_program.sh'):
                assert (executable.parent / '_internal/cpld_toolchain/programmer_helper' / resource).is_file(), resource
            print('Frozen CLI smoke checks passed; no USB or vendor process was started.')
    finally:
        fixture.doCleanups()


if __name__ == '__main__':
    main()
