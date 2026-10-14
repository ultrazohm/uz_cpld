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
from cpld_toolchain.toolchain.foss.tests.fixtures import jedec


@contextmanager
def readonly_application(executable, destination, firmware):
    shutil.copytree(executable.parent, destination, symlinks=True)
    if not (destination / 'firmware').exists():
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
    parser.add_argument('executable', type=Path, nargs='?')
    parser.add_argument('--archive', type=Path, help='Directory containing the archive for this OS')
    parser.add_argument('--combined', action='store_true')
    args = parser.parse_args()
    with ExitStack() as archives:
        if args.archive:
            from distribution.archive import unpack
            suffix = '.zip' if os.name == 'nt' else '.tar.gz'
            choices = [p for p in args.archive.iterdir() if p.name.endswith(suffix)
                       and ('-with-firmware.' in p.name) == args.combined]
            if len(choices) != 1:
                parser.error('Expected exactly one archive for this OS and bundle variant')
            folder = Path(archives.enter_context(tempfile.TemporaryDirectory(prefix='uz extracted archive ')))
            application = unpack(choices[0], folder)
            executable = application / ('uz_cpld.exe' if os.name == 'nt' else 'uz_cpld')
            if args.combined:
                bundle = json.loads((application / 'bundle.json').read_text())
                from cpld_toolchain.toolchain.foss.flasher import digest
                assert digest(application / 'firmware/uz-cpld-firmware.zip') == bundle['firmware_sha256']
                from cpld_toolchain.programmer_helper.release import read_package
                manifest, _ = read_package(application / 'firmware/uz-cpld-firmware.zip')
                info = json.loads((application / 'application.json').read_text())
                assert bundle['application'] == info
                assert bundle['firmware_git_revision'] == manifest['git_revision'] == info['git_revision']
        elif args.executable:
            executable = args.executable.resolve()
        else:
            parser.error('Supply an executable or --archive')
        smoke(executable)


def smoke(executable):
    from distribution.licensing import verify
    verify(executable.parent)
    fixture = ReleaseTests()
    fixture.setUp()
    try:
        with tempfile.TemporaryDirectory(prefix='uz standalone smoke ') as temporary, ExitStack() as stack:
            root = Path(temporary)
            executable = stack.enter_context(readonly_application(executable, root / 'read only application', fixture.zip))
            env = dict(os.environ, UZ_CPLD_CONFIG_DIR=str(root / 'config'), UZ_CPLD_DATA_DIR=str(root / 'data'),
                       PYTHONPATH='', PATH=os.environ.get('SystemRoot', 'C:\\Windows') + '\\System32' if os.name == 'nt' else '/usr/bin:/bin')
            env.pop('CPLD_PGRCMD', None)
            for variable in ('CPLD_OPENFPGALOADER', 'CPLD_BUNDLED_TOOLS', 'CPLD_DRIVER_HELPER', 'FOSS_ROOT',
                             'LD_LIBRARY_PATH', 'LD_LIBRARY_PATH_ORIG'):
                env.pop(variable, None)
            firmware = root / 'release firmware.zip'
            shutil.copy2(fixture.zip, firmware)
            def run(*arguments, success=True):
                result = subprocess.run([str(executable), *arguments], cwd=root, env=env,
                                        capture_output=True, text=True, timeout=30)
                if (result.returncode == 0) != success:
                    raise AssertionError(f'{arguments}: {result.returncode}\n{result.stdout}\n{result.stderr}')
                return result.stdout + result.stderr
            run('--version')
            run('--help')
            info = json.loads((executable.parent / 'application.json').read_text())
            if info.get('programmer_gui'):
                run('programmer_gui', '--check')
                gui = executable.with_name('uz_cpld_gui.exe' if os.name == 'nt' else 'uz_cpld_gui')
                assert gui.is_file(), 'Missing optional GUI launcher'
                result = subprocess.run([str(gui), '--check'], cwd=root, env=env,
                                        capture_output=True, text=True, timeout=30)
                assert result.returncode == 0, result.stdout + result.stderr
                request, response = root / 'gui-request.json', root / 'gui-response.json'
                request.write_text(json.dumps(dict(action='load', workspace=str(root / 'gui-workspace'), firmware=str(firmware))))
                run('--programmer-gui-worker', str(request), str(response))
                assert json.loads(response.read_text())['ok'], response.read_text()
            for action in ('setup_foss_drivers', 'setup_diamond_driver'):
                run(action, '--dry-run', '1')
                output = run(action, '--device-id', 'UZ-CPLD-SMOKE-NONEXISTENT-DEVICE', success=False)
                assert ('No matching connected' if os.name == 'nt' else 'native Windows only') in output, output
            run()  # Redirected/noninteractive no-argument launches must not open a shell.
            # Validate config without executing this stand-in programmer.
            run('programmer_path=' + str(executable))
            run('doctor')
            run('doctor', '--programmer-backend', 'diamond')
            run('programmer_path=auto')
            run('firmware_list', '--included')
            run('program', '--target', 's3c', '--dry-run', '1', success=False)
            run('firmware_select', '--included')
            run('firmware_list')
            run('firmware_list', '--firmware', str(firmware))
            run('firmware_select', '--firmware', str(firmware))
            run('firmware_list')
            run('init_programmer', '--release', 'published', '--s3c', 'controller')
            selection_path = root / 'data/workspace/selection.toml'
            selection_path.write_text('previous selection')
            run('init_programmer', '--release', 'published', '--s3c', 'controller')
            assert selection_path.read_text() == 'previous selection'
            run('init_programmer', '--override', '--release', 'published', '--s3c', 'controller')
            assert 'controller' in selection_path.read_text()
            run('program', '--target', 's3c', '--dry-run', '1')
            run('program', '--target', 's3c', '--programmer-backend', 'diamond', '--dry-run', '1')
            assert (root / 'data/workspace/selection.toml').is_file()
            firmware.unlink()
            run('firmware_list')  # Selected snapshot survives removal of the original.
            loader_dir = executable.parent / '_internal/cpld_toolchain/bundled_tools/openFPGALoader'
            loader = loader_dir / ('openFPGALoader.exe' if os.name == 'nt' else 'openFPGALoader')
            native_input = root / 'native parser fixture.jed'
            native_input.write_bytes(jedec())
            for code, success in (('89ABCDEF', True), ('00000000', False)):
                result = subprocess.run([str(loader), '--check-file', '--usercode', code, str(native_input)],
                                        cwd=root, env=env, capture_output=True, text=True, timeout=30)
                assert (result.returncode == 0) == success, result.stdout + result.stderr
                assert result.returncode in (0, 1), result.stderr
            # Synthetic package has an invalid native JEDEC body: execution must fail before USB.
            rejected = run('program', '--target', 's3c', success=False)
            assert 'Flasher rejected' in rejected and 'before USB access' in rejected, rejected
            selected = json.loads((root / 'data/workspace/firmware.json').read_text())
            (root / 'data/workspace' / selected['path']).write_bytes(b'corrupt')
            run('program', '--target', 's3c', success=False)
            # Doctor must reject changed loader/runtime bytes without starting the loader.
            changed = root / 'changed application'
            shutil.copytree(executable.parent, changed, symlinks=True)
            changed_loader = changed / '_internal/cpld_toolchain/bundled_tools/openFPGALoader'
            receipt = json.loads((changed_loader / 'usercode-support.json').read_text())
            for name in [loader.name, *receipt['runtime_sha256']]:
                path = changed_loader / name
                original = path.read_bytes()
                path.chmod(0o755)
                path.write_bytes(original + b'changed')
                result = subprocess.run([str(changed / executable.name), 'doctor'], cwd=root,
                                        env=env, capture_output=True, text=True, timeout=30)
                assert result.returncode == 1 and 'INVALID' in result.stdout, result.stdout + result.stderr
                path.write_bytes(original)
            for resource in ('templates/s3c.xcf', 'templates/dslots.xcf', 'diamond_program.sh'):
                assert (executable.parent / '_internal/cpld_toolchain/programmer_helper' / resource).is_file(), resource
            print('Frozen CLI and portable loader smoke checks passed; no USB access was required.')
    finally:
        fixture.doCleanups()


if __name__ == '__main__':
    main()
