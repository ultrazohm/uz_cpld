"""Native setup must bootstrap before third-party Python dependencies exist."""
from contextlib import redirect_stdout
import io
import os
from pathlib import Path
import tempfile
from unittest.mock import patch, Mock
import subprocess
import sys
import unittest

from cpld_toolchain.toolchain import commands, venv


class VenvTests(unittest.TestCase):
    def test_clean_python_can_preview_setup_without_site_packages(self):
        result = subprocess.run([sys.executable, '-S', '-m', 'cpld_toolchain.toolchain.commands',
                                 'venv', '--dry-run', '1'], cwd=commands.ROOT,
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('-m cpld_toolchain.toolchain.venv --activate 1', result.stdout)

    def test_setup_remains_local_on_host_and_in_container(self):
        for environment in ({}, {'CPLD_TOOLCHAIN_CONTAINER': '1'}):
            with patch.dict(os.environ, environment, clear=True):
                call, = commands.plan('venv', {'activate': '0'})
                self.assertEqual(call.argv[1:], ('-m', 'cpld_toolchain.toolchain.venv', '--activate', '0'))

    def test_existing_environment_keeps_its_interpreter_while_updating_packages(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            environment = root / '.venv'
            python = venv.environment_python(environment)
            python.parent.mkdir(parents=True)
            python.write_bytes(b'existing interpreter')
            (environment / 'pyvenv.cfg').write_text('home = existing\n')
            with patch.object(venv, 'ROOT', root), patch.object(venv.venv, 'EnvBuilder') as builder, \
                    patch.object(venv.subprocess, 'run', return_value=Mock(returncode=0)) as run, \
                    redirect_stdout(io.StringIO()):
                self.assertEqual(venv.main(['--activate', '0']), 0)
            builder.assert_not_called()
            self.assertEqual(python.read_bytes(), b'existing interpreter')
            self.assertTrue(any('install' in call.args[0] for call in run.call_args_list))
