"""Test the shared controller and generated routing against the actual S3C firmware."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from cpld_toolchain.toolchain.buildsystem.ghdl import analyze_sources
from cpld_toolchain.toolchain.buildsystem.model import Source, load_build

ROOT = Path(__file__).resolve().parents[3]
HDL = Path(__file__).parent / 'hdl'
# Real firmware startup requires millions of clock cycles. Allow slower CI CPUs
# enough wall time while retaining the simulated-time limits and pass markers.
SIMULATION_TIMEOUT = 300


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
                timeout = SIMULATION_TIMEOUT if command[1] == '-r' else 60
                result = subprocess.run(command, cwd=output, capture_output=True, text=True, timeout=timeout)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('S3C PAIR PASSED', result.stdout + result.stderr)

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
    def test_heartbeat_s3c_with_generated_slot(self):
        from cpld_toolchain.cpld_vhdl_generator import generate, load_config, source_entries
        controller = load_build(ROOT, 's3c_heartbeat', release_cycle='heartbeat')
        with tempfile.TemporaryDirectory(prefix='heartbeat slot pair ') as temp:
            output = Path(temp)
            config = output / 'generator.toml'
            config.write_text('schema_version = 3\nname = "heartbeat_pair"\n'
                              'routing = "routing.csv"\ncontract = "s3c_heartbeat_v1"\n'
                              'clock = "machxo2"\npilot_policy = "unused"\n')
            (output / 'routing.csv').write_text('output,normal_state,safe_state\n' +
                ''.join(f'd_{i:02d},fpga_{i:02d},0\n' for i in range(30)))
            generate(config, output)
            sources = [Source(HDL / 'osch_simulation.vhdl', 'work'), *controller.sources,
                       *[Source(s.path, s.library) for s in source_entries(load_config(config), output)],
                       Source(HDL / 'heartbeat_interaction_tb.vhdl', 'work')]
            search = analyze_sources(ROOT, sources, output, '08')
            for command in (['ghdl', '-e', '--std=08', *search, 'heartbeat_pair'],
                            ['ghdl', '-r', '--std=08', *search, 'heartbeat_pair',
                             '--assert-level=error', '--stop-time=25ms']):
                timeout = SIMULATION_TIMEOUT if command[1] == '-r' else 60
                result = subprocess.run(command, cwd=output, capture_output=True, text=True, timeout=timeout)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('HEARTBEAT PAIR PASSED', result.stdout + result.stderr)
