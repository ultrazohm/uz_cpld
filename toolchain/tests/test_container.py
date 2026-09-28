"""Container startup reports optional Diamond without changing command behavior."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ENTRYPOINT = Path(__file__).resolve().parents[2] / '.devcontainer/container-entrypoint'


class ContainerStartupTests(unittest.TestCase):
    def run_entrypoint(self, root, *command, override=None):
        env = dict(os.environ, DIAMOND_ROOT=str(root))
        env.pop('DIAMOND_CLI', None)
        if override is not None:
            env['DIAMOND_CLI'] = str(override)
        return subprocess.run(['bash', str(ENTRYPOINT), *command], env=env,
                              capture_output=True, text=True, timeout=10)

    def test_missing_diamond_does_not_block_command_or_change_exit_code(self):
        with tempfile.TemporaryDirectory() as temp:
            result = self.run_entrypoint(temp, 'bash', '-c', 'printf "%s" "$1"; exit 7',
                                         'test', 'argument with spaces')
        self.assertEqual(result.returncode, 7)
        self.assertEqual(result.stdout, 'argument with spaces')
        self.assertIn('Diamond not found:', result.stderr)

    def test_found_diamond_is_not_executed(self):
        with tempfile.TemporaryDirectory(prefix='diamond install ') as temp:
            launcher = Path(temp) / 'bin/lin64/diamondc'
            launcher.parent.mkdir(parents=True)
            launcher.write_text('#!/bin/sh\necho "unexpected license check" >&2\nexit 1\n')
            launcher.chmod(0o755)
            result = self.run_entrypoint(temp, 'true')
        self.assertEqual(result.returncode, 0)
        self.assertIn('Diamond found:', result.stderr)
        self.assertNotIn('unexpected license check', result.stderr)

    def test_executable_override_matches_backend_lookup(self):
        with tempfile.TemporaryDirectory() as temp:
            result = self.run_entrypoint(temp, 'true', override='true')
        self.assertEqual(result.returncode, 0)
        self.assertIn('Diamond found: true', result.stderr)
