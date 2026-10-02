"""Native portability: real process locks and mocked Windows tool dispatch."""
from contextlib import redirect_stdout
import io
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from toolchain import commands, diamond, venv
from toolchain.locking import file_lock, directory_lock
from toolchain.buildsystem.model import BuildError
from programmer_helper import diamond as programmer, program, usb

ROOT = Path(__file__).resolve().parents[2]


class LockTests(unittest.TestCase):
    def child_lock(self, path, exclusive):
        script = '''
import sys
from pathlib import Path
from toolchain.locking import file_lock
try:
    with file_lock(Path(sys.argv[1]), exclusive=sys.argv[2] == '1'):
        pass
except BlockingIOError:
    sys.exit(3)
'''
        return subprocess.run([sys.executable, '-c', script, str(path), str(int(exclusive))],
                              cwd=ROOT, capture_output=True, text=True, timeout=15)

    def test_shared_locks_coexist_and_exclude_cleanup_across_processes(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / 'concurrent.lock'
            with file_lock(path, exclusive=False):
                result = self.child_lock(path, False)
                self.assertEqual(result.returncode, 0, result.stderr)
                result = self.child_lock(path, True)
                self.assertEqual(result.returncode, 3, result.stderr)
            self.assertEqual(self.child_lock(path, True).returncode, 0)

    def test_exclusive_lock_rejects_readers_and_releases_after_error(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / 'exclusive.lock'
            with self.assertRaisesRegex(ValueError, 'operation failed'):
                with file_lock(path):
                    self.assertEqual(self.child_lock(path, False).returncode, 3)
                    raise ValueError('operation failed')
            self.assertEqual(self.child_lock(path, True).returncode, 0)

    def test_directory_lock_excludes_cleanup_and_survives_use(self):
        with tempfile.TemporaryDirectory() as tmp:
            with directory_lock(Path(tmp), exclusive=False):
                with directory_lock(Path(tmp), exclusive=False):
                    with self.assertRaises(BlockingIOError):
                        with directory_lock(Path(tmp)):
                            self.fail('cleanup must not run while workspace is used')
            with directory_lock(Path(tmp)):
                pass


class WindowsDispatchTests(unittest.TestCase):
    def test_windows_diamond_paths_environment_and_overrides(self):
        with tempfile.TemporaryDirectory(prefix='Diamond space ') as tmp:
            root = Path(tmp).resolve()
            for name in ('bin/nt64/pnmainc.exe', 'bin/nt64/pnmain.exe',
                         'programmer/bin/nt64/pgrcmd.exe', 'license/license.dat'):
                path = root / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(b'fake executable')
                path.chmod(0o755)
            with patch.object(sys, 'platform', 'win32'), patch.dict(os.environ,
                    {'DIAMOND_ROOT': str(root), 'PATH': 'original', 'LM_LICENSE_FILE': '27000@server'}, clear=True):
                binary = diamond.executable()
                self.assertEqual(binary, root / 'bin/nt64/pnmainc.exe')
                self.assertEqual(diamond.executable('gui').name, 'pnmain.exe')
                self.assertEqual(diamond.executable('programmer').name, 'pgrcmd.exe')
                env = diamond.environment(binary)
                self.assertEqual(env['FOUNDRY'], str(root / 'ispfpga'))
                self.assertIn(str(root / 'ispfpga/bin/nt64'), env['PATH'])
                self.assertTrue(env['PATH'].endswith(';original'))
                self.assertEqual(env['LM_LICENSE_FILE'], str(root / 'license/license.dat') + ';27000@server')
                with patch.dict(os.environ, {'DIAMOND_CLI': str(root / 'missing.exe')}):
                    with self.assertRaises(BuildError):
                        diamond.executable()

    def test_windows_programmer_runs_directly_without_an_intermediate_shell(self):
        with patch.object(sys, 'platform', 'win32'), \
                patch.object(programmer, 'executable', return_value=Path('vendor/pgrcmd.exe')):
            command = programmer.command(ROOT, 'path with spaces/chain.xcf', 'run log.txt')
            self.assertEqual(command, (str(Path('vendor/pgrcmd.exe')), '-infile',
                                       'path with spaces/chain.xcf', '-logfile', 'run log.txt'))
            self.assertNotIn('bash', command)
            self.assertNotIn(sys.executable, command)

    def test_windows_venv_uses_scripts_and_quotes_powershell_literals(self):
        with patch.object(sys, 'platform', 'win32'), patch.object(venv.shutil, 'which', return_value='pwsh'):
            root = Path("workspace's files") / '.venv'
            self.assertEqual(venv.environment_python(root), root / 'Scripts/python.exe')
            argv = venv.shell_command(root)
            self.assertIn('-NoExit', argv)
            self.assertIn("workspace''s files", argv[-1])
            self.assertIn('Activate.ps1', argv[-1])

    def test_windows_usb_uses_vendor_driver_without_linux_sysfs(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(sys, 'platform', 'win32'), \
                patch.object(usb.tempfile, 'gettempdir', return_value=tmp), \
                patch.object(usb, 'diamond_interface') as inspect, \
                patch.object(usb, 'LibUSB') as library:
            # Lock semantics are exercised separately on the actual host OS.
            from contextlib import nullcontext
            with patch.object(usb, 'file_lock', return_value=nullcontext()):
                program.require_usb_bus()
                with usb.diamond_usb(1):
                    pass
            inspect.assert_not_called()
            library.assert_not_called()

    def test_windows_foss_build_uses_native_python(self):
        with patch.object(sys, 'platform', 'win32'):
            call, = commands.plan('build-all', {'backend': 'foss'})
            self.assertEqual(call.argv[:3], (sys.executable, '-m', 'toolchain.buildsystem'))
            self.assertNotIn('--user', call.argv)
            self.assertNotIn('--mount', call.argv)

    def test_clean_all_keeps_the_running_environment_and_its_caches(self):
        from toolchain.buildsystem.workflow import clean_all
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            environment = root / '.venv'
            cache = environment / 'lib/__pycache__/installed.pyc'
            cache.parent.mkdir(parents=True)
            cache.write_bytes(b'active environment')
            generated = root / 'toolchain/build'
            generated.mkdir(parents=True)
            with patch.object(sys, 'prefix', str(environment)), redirect_stdout(io.StringIO()):
                clean_all(root)
            self.assertTrue(cache.is_file())
            self.assertFalse(generated.exists())

    def test_windows_test_action_selects_the_native_suite(self):
        with patch.object(sys, 'platform', 'win32'):
            calls = commands.plan('test', {})
            self.assertEqual(len(calls), 1)
            self.assertIn('toolchain.tests.test_platform', calls[0].argv)
            self.assertNotIn('discover', calls[0].argv)

    def test_primary_entrypoint_previews_without_make_or_vendor_tools(self):
        result = subprocess.run([sys.executable, '-m', 'toolchain', 'build-all', '--dry-run', '1'],
                                cwd=ROOT, capture_output=True, text=True, timeout=15)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('toolchain.buildsystem build-all --backend diamond', result.stdout)
        with redirect_stdout(io.StringIO()) as output:
            self.assertEqual(commands.main(['help', '--command', 'program']), 0)
        self.assertIn('python -m toolchain program --target', output.getvalue())
        self.assertIn('--programmer-backend diamond|foss', output.getvalue())
