"""Regression checks for waveform meaning and failed netlist exports."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.analysis.netlist import export_netlist
from toolchain.analysis.rtl_viewer import write_rtl_viewer
from toolchain.analysis.state_diagram import extract_state_machines
from toolchain.analysis.waveform import read_vcd, write_waveform
from toolchain.buildsystem.model import BuildError, load_build

ROOT = Path(__file__).resolve().parents[2]
VCD = b'''$timescale 10 ps $end
$scope module dut $end
$var reg 1 ! data $end
$var reg 1 ! alias $end
$var reg 4 " bus [3:0] $end
$var reg 1 # undriven $end
$upscope $end
$enddefinitions $end
#0
0!
b0011 "
U#
#100
1!
b10XZ "
#200
0!
1!
Z#
#300
'''


class AnalysisTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.vcd = self.root / 'wave.vcd'
        self.vcd.write_bytes(VCD)

    def test_vcd_units_aliases_vectors_and_unknown_states(self):
        signals, duration = read_vcd(self.vcd)
        signals = {s.name: s for s in signals}
        self.assertEqual(duration, 3)
        self.assertEqual(signals['dut.data'].values, signals['dut.alias'].values)
        self.assertEqual(signals['dut.data'].times, [0, 1, 2, 3])
        self.assertEqual(signals['dut.data'].values, ['0', '1', '1', '1'])
        self.assertEqual(signals['dut.bus'].values, ['0011', '10XZ', '10XZ'])
        self.assertEqual(signals['dut.undriven'].values, ['U', 'Z', 'Z'])

    def test_simulation_end_extends_final_stable_value(self):
        signals, duration = read_vcd(self.vcd, end_time_ns=4)
        self.assertEqual(duration, 4)
        self.assertTrue(all(s.times[-1] == 4 for s in signals))
        with self.assertRaisesRegex(ValueError, 'precedes'):
            read_vcd(self.vcd, end_time_ns=2)

    def test_no_timescale_is_rejected(self):
        self.vcd.write_bytes(VCD.replace(b'$timescale 10 ps $end', b''))
        with self.assertRaisesRegex(ValueError, 'timescale'):
            read_vcd(self.vcd)

    def test_viewer_is_offline_and_keeps_original_states(self):
        output = self.root / 'viewer.html'
        info = write_waveform(self.vcd, output, '<test>')
        text = output.read_text()
        self.assertEqual(info['duration_ns'], 3)
        self.assertNotIn('<script src=', text)
        self.assertIn('&lt;test&gt;', text)
        self.assertIn('"U", "Z", "Z"', text)
        self.assertIn("shape:'hv'", text)
        self.assertIn('id="channels"', text)

    def test_rtl_viewer_embeds_svg_and_controls(self):
        svg = self.root / 'netlist.svg'
        svg.write_text('<?xml version="1.0"?><svg viewBox="0 0 100 50">'
                       '<g class="node"><text>signal</text></g></svg>')
        output = self.root / 'netlist-viewer.html'
        write_rtl_viewer(svg, output, '<test>')
        page = output.read_text()
        self.assertIn('&lt;test&gt;', page)
        self.assertIn('id="search"', page)
        self.assertIn('svg.setAttribute(\'viewBox\'', page)
        self.assertIn('<text>signal</text>', page)

    def test_failed_netlist_does_not_leave_previous_exports(self):
        for folder in ('programs', 'toolchain'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('build', '__pycache__'))
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        build = load_build(self.root, 'tx30')
        output = build.build_root / 'netlist'
        output.mkdir(parents=True)
        (output / 'metadata').mkdir()
        for name in ('netlist.svg', 'netlist.pdf', 'metadata/netlist.json'):
            (output / name).write_text('stale')
        with patch('toolchain.analysis.netlist.shutil.which', return_value='/bin/true'), \
             patch('toolchain.analysis.netlist.subprocess.run',
                   side_effect=subprocess.CalledProcessError(1, 'ghdl')):
            with self.assertRaises(BuildError):
                export_netlist(build)
        self.assertTrue((output / 'ghdl.log').exists())
        self.assertFalse((output / 'netlist.svg').exists())
        self.assertFalse((output / 'netlist.pdf').exists())
        self.assertFalse((output / 'metadata/netlist.json').exists())

    def test_s3c_state_diagram_tracks_vhdl_transitions(self):
        source = (ROOT / 'programs/original/s3c_power_on_debounce/s3c_power_on_debounce.vhdl').read_text()
        machines = extract_state_machines(source)
        self.assertEqual(len(machines), 1)
        name, states, initial, transitions = machines[0]
        self.assertEqual(name, 'next_state')
        self.assertEqual(len(states), 12)
        self.assertEqual(initial, 'Waiting_for_Powerbutton_pressed')
        self.assertIn(('Ready_State', 'Harderror', "externstop_falling = '1'"), transitions)
        self.assertIn(('Ready_State', 'Softerror',
                       "not (externstop_falling = '1') and stop = '1'"), transitions)
        self.assertIn(('Wait_State', 'EthernetPhy_Reset', 'not (counter > 0)'), transitions)
        self.assertIn(('Waiting_for_Powerbutton_pressed_2sec', 'sleep_for_dslot_down',
                       "not (counter > 0) and power = '1'"), transitions)
        self.assertIn(('EthernetPhy_Reset', 'Ready_State',
                       "not (counter > 0) and not (extern_connected='1' AND stopextern = '1')"),
                      transitions)
        self.assertFalse(any(origin == 'Harderror' and target == 'Ready_State'
                             for origin, target, _ in transitions))

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
    def test_grouped_vendor_library_clause_is_analyzed(self):
        from toolchain.buildsystem.ghdl import analyze_sources
        from toolchain.buildsystem.model import Source
        source = self.root / 'grouped.vhdl'
        source.write_text('library ieee, MACHXO2;\nuse ieee.std_logic_1164.all;\n'
                          'entity grouped is port (i: in std_logic; o: out std_logic); end;\n'
                          'architecture rtl of grouped is begin o <= i; end;\n')
        analyze_sources(ROOT, [Source(source, 'work')], self.root, '93')
        self.assertTrue((self.root / 'machxo2-obj93.cf').is_file())

    def test_netlist_rejects_explicit_program_with_wrong_target(self):
        from toolchain.analysis.netlist import main
        with patch('sys.argv', ['netlist', '--program', 'tx30', '--release-cycle', 'original',
                                '--target', 'uz_s3c_xo2']), \
             patch('toolchain.analysis.netlist.export_netlist') as export:
            self.assertEqual(main(), 1)
        export.assert_not_called()

    def test_ghdl_rejects_double_quoted_paths_before_running_tools(self):
        from toolchain.buildsystem.ghdl import analyze_sources
        from toolchain.buildsystem.model import Source
        source = self.root / 'quoted"source.vhdl'
        with patch('toolchain.buildsystem.ghdl.subprocess.run') as run:
            with self.assertRaisesRegex(BuildError, 'double quotes'):
                analyze_sources(ROOT, [Source(source, 'work')], self.root, '93')
        run.assert_not_called()
