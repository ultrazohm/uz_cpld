"""Run the generated project's own cocotb testbench, not a handwritten substitute."""
from pathlib import Path
import shutil
import tempfile
import sys
from unittest.mock import patch
import unittest
import xml.etree.ElementTree as ET

from cpld_toolchain.cpld_vhdl_generator import generate, load_config, source_entries
from cpld_toolchain.toolchain.buildsystem.ghdl import analyze_sources

ROOT = Path(__file__).resolve().parents[3]


@unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
class HeartbeatGenerationTests(unittest.TestCase):
    def test_generated_project_testbench(self):
        from cocotb_tools.runner import get_runner
        with tempfile.TemporaryDirectory(prefix='generated heartbeat ') as temp:
            output = Path(temp)
            config = output / 'generator.toml'
            config.write_text('schema_version = 3\nname = "heartbeat_test"\n'
                              'routing = "routing.csv"\ncontract = "s3c_heartbeat_v1"\n'
                              'clock = "machxo2"\npilot_policy = "required"\n'
                              'target = "uz_dslot_xo2"\nenable = {fpga_29 = 1}\n')
            (output / 'routing.csv').write_text('output,normal_state,safe_state\n'
                                              'd_00,fpga_00,0\nfpga_01,d_01,d_01\n'
                                              'd_02,1,Z\n')
            generate(config, output)
            build = output / 'build'
            build.mkdir()
            search = analyze_sources(ROOT, source_entries(load_config(config), output), build, '93')
            runner = get_runner('ghdl')
            runner.build(sources=[], hdl_library='work', hdl_toplevel='cvg_heartbeat_test',
                         build_args=['--std=93', *search], build_dir=build,
                         log_file=build / 'compile.log')
            with patch.object(sys, 'path', [str(output), *sys.path]):
                result = runner.test(hdl_toplevel='cvg_heartbeat_test', hdl_toplevel_library='work',
                                     hdl_toplevel_lang='vhdl', test_module='cvg_heartbeat_test_tb',
                                     test_args=['--std=93', *search], test_dir=build,
                                     log_file=build / 'simulation.log')
            cases = ET.parse(result).findall('.//testcase')
            self.assertTrue(cases)
            self.assertFalse(any(case.find('failure') is not None or case.find('error') is not None
                                 for case in cases), (build / 'simulation.log').read_text())
