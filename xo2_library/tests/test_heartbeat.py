"""Exercise the standalone heartbeat architecture with real protocol defaults."""
from itertools import product
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

PACKAGE = Path(__file__).resolve().parents[1]


@unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
class HeartbeatTests(unittest.TestCase):
    def test_qualification_faults_controls_and_recovery(self):
        with tempfile.TemporaryDirectory(prefix='heartbeat logic ') as directory:
            def run(*args):
                result = subprocess.run(['ghdl', *args], cwd=directory,
                                        capture_output=True, text=True, timeout=30)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                return result.stdout + result.stderr

            for name in ('s3c_logic.vhdl', 'heartbeat.vhdl'):
                run('-a', '--std=93', '--work=s3c', str(PACKAGE / 's3c' / name))
            run('-a', '--std=93', '-P.', str(PACKAGE / 'tests/hdl/heartbeat_tb.vhdl'))
            run('-e', '--std=93', '-P.', 'heartbeat_tb')
            for level, pilot, fault in product(('0', '1'), ('false', 'true'),
                                              ('low_timeout', 'high_timeout', 'safe_timeout',
                                               'disabled_timeout', 'reset_timeout', 'short', 'long', 'unknown')):
                with self.subTest(level=level, pilot=pilot, fault=fault):
                    self.assertIn('HEARTBEAT PASSED', run(
                        '-r', '--std=93', '-P.', 'heartbeat_tb',
                        f"-gSAFE_LEVEL='{level}'", f'-gPILOT_REQUIRED={pilot}', f'-gFAULT_KIND={fault}', '--assert-level=error'))
