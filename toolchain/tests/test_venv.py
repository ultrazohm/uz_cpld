"""Native setup must bootstrap before third-party Python dependencies exist."""
import subprocess
import sys
import unittest

from toolchain import commands


class VenvTests(unittest.TestCase):
    def test_clean_python_can_preview_setup_without_site_packages(self):
        result = subprocess.run([sys.executable, '-S', '-m', 'toolchain.commands',
                                 'venv', '--dry-run', '1'], cwd=commands.ROOT,
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('-m toolchain.venv --activate 1', result.stdout)

    def test_setup_remains_local_on_host_and_in_container(self):
        for environment in ({}, {'CPLD_TOOLCHAIN_CONTAINER': '1'}):
            call, = commands.plan('venv', {'activate': '0'}, environ=environment)
            self.assertEqual(call.argv[1:], ('-m', 'toolchain.venv', '--activate', '0'))
