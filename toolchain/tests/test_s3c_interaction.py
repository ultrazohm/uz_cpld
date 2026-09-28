"""Test the shared controller and generated routing against the actual S3C firmware."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from toolchain.buildsystem.ghdl import analyze_sources
from toolchain.buildsystem.model import Source, load_build

ROOT = Path(__file__).resolve().parents[2]
HDL = Path(__file__).parent / 'hdl'


class S3CInteractionTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
    def test_actual_s3c_startup_soft_stop_and_enable(self):
        s3c = load_build(ROOT, 's3c_power_on_debounce', release_cycle='original')
        slot = load_build(ROOT, 'cvg_tx30_stateful', release_cycle='original')
        with tempfile.TemporaryDirectory(prefix='s3c slot pair ') as temp:
            output = Path(temp)
            sources = [Source(HDL / 'osch_simulation.vhdl', 'work'), *s3c.sources,
                       *slot.sources, Source(HDL / 's3c_interaction_tb.vhdl', 'work')]
            search = analyze_sources(ROOT, sources, output, '93')
            for command in (['ghdl', '-e', '--std=93', *search, 'pair'],
                            ['ghdl', '-r', '--std=93', *search, 'pair',
                             '--assert-level=error', '--stop-time=23ms']):
                result = subprocess.run(command, cwd=output, capture_output=True, text=True, timeout=60)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('S3C PAIR PASSED', result.stdout + result.stderr)
