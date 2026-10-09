"""Comparison failures must remain visible, including initialization errors."""
import json
import io
from contextlib import redirect_stderr
from unittest.mock import patch
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from cpld_toolchain.toolchain import commands
from cpld_toolchain.toolchain.buildsystem.comparison import device_settings, formal, normalize, simulate
from cpld_toolchain.toolchain.buildsystem.backends.foss import tool
from cpld_toolchain.toolchain.buildsystem.ghdl import analyze_sources
from cpld_toolchain.toolchain.buildsystem.model import BuildError, load_build

ROOT = Path(__file__).resolve().parents[3]


class ComparisonTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='comparison space ')
        self.addCleanup(self.temp.cleanup)
        self.directory = Path(self.temp.name)
        try:
            for name in ('yosys', 'iverilog', 'vvp'):
                tool(name)
        except BuildError as exc:
            self.skipTest(str(exc))

    def normalize_small(self, name, expression='q', initial=0, cell=False):
        source = self.directory / f'{name}.v'
        logic = (f'FD1S3DX ff(.D(a), .CK(clk), .CD(1\'b0), .Q(q)); wire q;'
                 if cell else f"reg q=1'b{initial}; always @(posedge clk) q<=a;")
        source.write_text(f'''module example(input a, output y);
wire clk;
OSCH #(.NOM_FREQ("2.08")) osc(.STDBY(1'b0), .OSC(clk), .SEDSTDBY());
{logic}
assign y={expression};
endmodule
''')
        return normalize(source, 'example', self.directory / name, ROOT)

    def test_vendor_flip_flop_matches_reference(self):
        reference = self.normalize_small('reference')
        diamond = self.normalize_small('vendor', cell=True)
        proof = formal(reference.with_suffix('.json'), diamond.with_suffix('.json'), diamond.parent)
        self.assertEqual(proof, {'induction': 'proven', 'startup': 'proven'})

    def test_wrong_output_is_not_equivalent(self):
        reference = self.normalize_small('reference')
        wrong = self.normalize_small('wrong', expression='~q')
        proof = formal(reference.with_suffix('.json'), wrong.with_suffix('.json'), wrong.parent)
        self.assertNotEqual(proof['startup'], 'proven')
        self.assertNotEqual(proof['induction'], 'proven')

    def test_initialization_mismatch_fails_even_if_induction_passes(self):
        reference = self.normalize_small('reference')
        wrong = self.normalize_small('wrong', initial=1)
        proof = formal(reference.with_suffix('.json'), wrong.with_suffix('.json'), wrong.parent)
        self.assertEqual(proof['induction'], 'proven')
        self.assertNotEqual(proof['startup'], 'proven')

    def test_unknown_primitive_fails_closed(self):
        source = self.directory / 'unknown.v'
        source.write_text('module example(input a, output y); UNSUPPORTED x(a,y); endmodule')
        with self.assertRaises(BuildError):
            normalize(source, 'example', self.directory / 'bad', ROOT)

    def test_startup_alias_survives_simulation_export(self):
        netlist = self.normalize_small('reference')
        tb = netlist.parent / 'tb.v'
        tb.write_text("module tb; reg a=0, clk=0; wire y; dut d(a,clk,y); "
                      "initial begin #1; if(y !== 0) $fatal; $finish; end endmodule")
        # Named connections avoid depending on Yosys port ordering.
        tb.write_text(tb.read_text().replace('dut d(a,clk,y)',
                     'dut d(.a(a), .__comparison_clock(clk), .y(y))'))
        subprocess.run([tool('iverilog'), '-g2012', '-s', 'tb', '-o', str(netlist.parent / 'sim'),
                        str(netlist), str(tb)], check=True, capture_output=True)
        subprocess.run([tool('vvp'), str(netlist.parent / 'sim')], check=True, capture_output=True)

    def test_pilot_simulation_and_stuck_output_detection(self):
        if not shutil.which('ghdl'):
            self.skipTest('GHDL unavailable')
        build = load_build(ROOT, 'cvg_tx30', release_cycle='heartbeat_cvg')
        with (self.directory / 'ghdl.log').open('w') as log:
            search = analyze_sources(ROOT, build.sources, self.directory, '08', log)
            source = self.directory / 'rtl.v'
            with source.open('w') as out:
                subprocess.run(['ghdl', '--synth', '--std=08', *search, '--out=verilog', build.top],
                               cwd=self.directory, stdout=out, stderr=log, check=True)
        netlist = normalize(source, build.top, self.directory / 'pilot', ROOT)
        self.assertEqual(len(simulate(netlist, netlist.parent)), 6)
        # Corrupt ReqOE without changing any internal state or data routes.
        design = json.loads(netlist.with_suffix('.json').read_text())
        design['modules']['dut']['ports']['reqoe']['bits'] = ['0']
        damaged = self.directory / 'damaged'
        damaged.mkdir()
        (damaged / 'damaged.json').write_text(json.dumps(design))
        subprocess.run([tool('yosys'), '-Q', '-T', '-p',
                        'read_json damaged.json; opt; write_verilog -noattr damaged.v'],
                       cwd=damaged, check=True, capture_output=True)
        with self.assertRaises(BuildError):
            simulate(damaged / 'damaged.v', damaged)


class ComparisonCommandTests(unittest.TestCase):
    def test_device_settings_include_electrical_changes_but_ignore_routing(self):
        decoded = device_settings('.device LCMXO2-2000\n.tile PT1:PIC_T0\n'
                                  'enum: PIOA.DRIVE 8\nunknown: F1B2\narc: X Y\n'
                                  'enum: SLICEA.MODE LOGIC\n')
        self.assertEqual(decoded['PT1:PIC_T0/PIOA.DRIVE'], '8')
        self.assertIn('PT1:PIC_T0/unknown: F1B2', decoded)
        self.assertEqual(len(decoded), 3)

    def test_diamond_and_combined_requests_fail_before_loading_builds(self):
        from cpld_toolchain.toolchain.buildsystem.comparison import compare
        from cpld_toolchain.toolchain.buildsystem.cli import main
        for backend in (None, 'diamond'):
            with self.subTest(backend=backend), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                options = {'program': 'cvg_tx30'}
                cli_args = ['compare', '--root', str(root), '--program', 'cvg_tx30']
                if backend:
                    options['backend'] = backend
                    cli_args += ['--backend', backend]
                with self.assertRaisesRegex(BuildError, 'only backend=foss'):
                    commands.plan('compare', options)
                with patch('cpld_toolchain.toolchain.buildsystem.comparison.load_build') as load:
                    with self.assertRaisesRegex(BuildError, 'only backend=foss'):
                        compare(root, 'cvg_tx30', release_cycle='heartbeat_cvg', backend=backend)
                    load.assert_not_called()
                with redirect_stderr(io.StringIO()) as error:
                    self.assertEqual(main(cli_args), 1)
                self.assertIn('only backend=foss', error.getvalue())
                self.assertEqual(list(root.iterdir()), [])

    def test_explicit_foss_selection_is_preserved(self):
        args = commands.plan('compare', {'program': 'cvg_tx30', 'backend': 'foss'})[0].argv
        self.assertEqual(args[args.index('--backend') + 1], 'foss')
