"""Exercise setup before site packages and verify download/install boundaries."""
from contextlib import redirect_stderr, redirect_stdout
import hashlib
import io
import os
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain import bootstrap
from cpld_toolchain.toolchain import commands


class VenvTests(unittest.TestCase):
    def test_old_python_setup_needs_no_site_packages_or_modern_imports(self):
        for action in ('setup',):
            script = (
                'import sys; from cpld_toolchain.__main__ import main; '
                'sys.version_info = (3, 8, 20); '
                'result = main([%r, "--dry-run", "1"]); '
                'assert "cpld_toolchain.toolchain.commands" not in sys.modules; '
                'sys.exit(result)' % action
            )
            result = subprocess.run([sys.executable, '-S', '-c', script],
                                    cwd=commands.ROOT, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('Preview only:', result.stdout)

    def test_old_python_workflows_fail_with_setup_instruction(self):
        script = ('import sys; from cpld_toolchain.__main__ import main; '
                  'sys.version_info = (3, 8, 20); sys.exit(main(["help"]))')
        result = subprocess.run([sys.executable, '-S', '-c', script],
                                cwd=commands.ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 2)
        self.assertIn('cpld_toolchain setup', result.stderr)
        self.assertNotIn('Traceback', result.stderr)

    def test_setup_is_local(self):
        for action in ('setup',):
            with patch.dict(os.environ, {'CPLD_TOOLCHAIN_CONTAINER': '1'}):
                call, = commands.plan(action, {'activate': '0'})
                self.assertEqual(call.argv[1:], ('-m', 'cpld_toolchain.bootstrap', '--activate', '0'))

    def test_dry_run_never_downloads(self):
        with patch.object(bootstrap, 'ensure_uv') as download, redirect_stdout(io.StringIO()):
            self.assertEqual(bootstrap.main(['--dry-run', '1']), 0)
        download.assert_not_called()

    def test_protects_non_venv_directory(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / '.venv').mkdir()
            with patch.object(bootstrap, 'ROOT', root), patch.object(bootstrap, 'ensure_uv') as download, redirect_stderr(io.StringIO()):
                self.assertEqual(bootstrap.main(['--activate', '0']), 1)
            download.assert_not_called()

    def test_sync_uses_lock_and_checkout_despite_active_environment(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / '.python-version').write_text('3.10.12\n')
            with patch.object(bootstrap, 'ROOT', root), patch.object(bootstrap, 'ensure_uv', return_value=root / 'uv'), patch.object(bootstrap.subprocess, 'run') as run, patch.dict(os.environ, {'VIRTUAL_ENV': '/another', 'UV_PROJECT_ENVIRONMENT': '/another', 'UV_PYTHON_DOWNLOADS': 'never'}), redirect_stdout(io.StringIO()):
                self.assertEqual(bootstrap.main(['--activate', '0']), 0)
            self.assertEqual(run.call_args.args[0][1:], ['sync', '--locked', '--all-groups', '--managed-python', '--python', '3.10.12'])
            env = run.call_args.kwargs['env']
            self.assertNotIn('VIRTUAL_ENV', env)
            self.assertEqual(env['UV_PROJECT_ENVIRONMENT'], str(root / '.venv'))
            self.assertEqual(env['UV_PYTHON_DOWNLOADS'], 'automatic')

    def test_sync_failure_does_not_open_shell(self):
        with patch.object(bootstrap, 'ensure_uv', return_value=Path('/uv')), patch.object(bootstrap.subprocess, 'run', side_effect=subprocess.CalledProcessError(1, 'uv')), patch.object(bootstrap.subprocess, 'call') as shell, redirect_stderr(io.StringIO()):
            self.assertEqual(bootstrap.main([]), 1)
        shell.assert_not_called()

    def test_verified_download_extracts_only_uv_and_reuses_cache(self):
        buffer = io.BytesIO()
        with tarfile.open(fileobj=buffer, mode='w:gz') as archive:
            for name in ('uv-platform/uv', '../../outside'):
                member = tarfile.TarInfo(name)
                member.size = 2
                archive.addfile(member, io.BytesIO(b'uv'))
        data = buffer.getvalue()
        asset = 'uv-x86_64-unknown-linux-gnu.tar.gz'
        manifest = {'version': 'test', 'sha256': {asset: hashlib.sha256(data).hexdigest()}}
        with tempfile.TemporaryDirectory() as tmp, patch.object(bootstrap, 'uv_asset', return_value=asset), patch.object(bootstrap.sys, 'platform', 'linux'), patch.object(bootstrap.json, 'loads', return_value=manifest), patch.object(bootstrap.urllib.request, 'urlopen', return_value=io.BytesIO(data)) as download, redirect_stdout(io.StringIO()):
            root = Path(tmp)
            binary = bootstrap.ensure_uv(root)
            self.assertEqual(binary.read_bytes(), b'uv')
            self.assertEqual(bootstrap.ensure_uv(root), binary)
            self.assertEqual(download.call_count, 1)
            self.assertFalse(any(p.name == 'outside' for p in root.rglob('*')))

    def test_bad_checksum_is_rejected_before_extraction(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(bootstrap.urllib.request, 'urlopen', return_value=io.BytesIO(b'corrupted')), redirect_stdout(io.StringIO()):
            with self.assertRaisesRegex(ValueError, 'SHA-256'):
                bootstrap.ensure_uv(Path(tmp))
            self.assertFalse(any(p.name in ('uv.exe', 'uv') and p.is_file() for p in Path(tmp).rglob('*')))
