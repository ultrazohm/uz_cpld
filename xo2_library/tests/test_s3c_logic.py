"""Direct behavioral tests for the shared HDL, independent of generation and toolchain."""
from itertools import product
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

PACKAGE = Path(__file__).resolve().parents[1]


@unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
class S3CLogicTests(unittest.TestCase):
    def test_levels_pilot_enable_startup_and_reset(self):
        with tempfile.TemporaryDirectory(prefix='s3c logic ') as temp:
            # Exercise a copied standalone library without the generator checkout.
            standalone = Path(temp) / 'xo2_library'
            shutil.copytree(PACKAGE / 's3c', standalone / 's3c')
            bench = Path(temp) / 's3c_logic_tb.vhdl'
            shutil.copy2(PACKAGE / 'tests/hdl/s3c_logic_tb.vhdl', bench)
            def run(args):
                result = subprocess.run(['ghdl', *args], cwd=temp, capture_output=True, text=True, timeout=30)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                return result.stdout + result.stderr

            for name in ('s3c_logic.vhdl', 'level_signals.vhdl'):
                run(['-a', '--std=93', '--work=s3c', str(standalone / 's3c' / name)])
            run(['-a', '--std=93', '-P.', str(bench)])
            run(['-e', '--std=93', '-P.', 's3c_logic_tb'])
            for safe, ready, use_ready, pilot in product(('0', '1'), ('0', '1'), (False, True), (False, True)):
                with self.subTest(safe=safe, ready=ready, use_ready=use_ready, pilot=pilot):
                    output = run(['-r', '--std=93', '-P.', 's3c_logic_tb',
                                  f"-gSAFE_LEVEL='{safe}'", f"-gREADY_LEVEL='{ready}'",
                                  f'-gUSE_READY={str(use_ready).lower()}',
                                  f'-gPILOT_REQUIRED={str(pilot).lower()}', '--assert-level=error'])
                    self.assertIn('S3C LOGIC PASSED', output)
