"""FOSS backend boundaries, electrical constraint translation and Make selection."""
import json
from dataclasses import replace
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.buildsystem import workflow
from toolchain.buildsystem.report import catalog_report
from toolchain.buildsystem.model import catalog, program_backends, BuildError, load_build
from toolchain.buildsystem.backends.foss import constraints, equivalence_script, normalize_oscillator_frequency, startup_script, startup_points_script, tool, suite_root
from toolchain.buildsystem.foss_config import complete_config, package_lpf, verify_open_drain
from toolchain.foss.install import install

ROOT = Path(__file__).resolve().parents[2]


class FossTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="cpld foss ' $[test]-")
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        for folder in ('programs', 'toolchain'):
            shutil.copytree(ROOT / folder, self.root / folder, ignore=shutil.ignore_patterns('build', '__pycache__'))
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        self.build = load_build(self.root, 'tx30', backend='foss')

    def test_build_uses_plan_release_instead_of_current_cycle(self):
        from toolchain.buildsystem.backends.foss import FossBackend
        from toolchain.buildsystem.releases import create
        project = self.build.directory / 'project'
        project.mkdir(parents=True)
        metadata = project.parent / 'metadata'
        metadata.mkdir()
        (metadata / 'build-plan.json').write_text(json.dumps({
            'root': str(self.root), 'program': 'tx30', 'release_cycle': 'original',
            'target': 'uz_dslot_xo2'}))
        create(self.root, 'empty')
        with patch('toolchain.buildsystem.backends.foss.tools', side_effect=RuntimeError('reached tool check')) as tools:
            with self.assertRaisesRegex(RuntimeError, 'reached tool check'):
                FossBackend().build(project, project / 'log')
        self.assertEqual(tools.call_args.args[0].release_cycle, 'original')

    def test_empty_foss_doctor_never_invokes_diamond(self):
        from toolchain.buildsystem.releases import create
        from toolchain.buildsystem.cli import main
        create(self.root, 'empty')
        from contextlib import redirect_stdout
        import io
        from toolchain.doctor import Finding
        with patch('toolchain.doctor.probe', return_value=Finding('tool', 'MISSING', 'test')), \
                patch('toolchain.doctor.locate', return_value=None), redirect_stdout(io.StringIO()) as output:
            self.assertEqual(main(['doctor', '--root', str(self.root), '--backend', 'foss']), 0)
        self.assertIn('selection is empty', output.getvalue())

    def test_empty_foss_build_selection_fails(self):
        from toolchain.buildsystem.cli import main
        from contextlib import redirect_stderr
        import io
        with redirect_stderr(io.StringIO()) as error:
            result = main(['build-all', '--root', str(self.root), '--backend', 'foss',
                           '--release-cycle', 'heartbeat'])
        self.assertEqual(result, 1)
        self.assertIn('No programs selected', error.getvalue())

    def test_missing_build_cannot_pass_comparison(self):
        from toolchain.buildsystem.comparison import compare
        shutil.copytree(ROOT / 'xo2_library', self.root / 'xo2_library',
                        ignore=shutil.ignore_patterns('build', '__pycache__'))
        from cpld_vhdl_generator import generate
        config = self.root / 'programs/heartbeat_cvg/cvg_tx30/generator.toml'
        config.write_text(config.read_text() + 's3c_library = "../../../xo2_library/s3c"\n')
        generate(config, config.parent)
        path, passed = compare(self.root, 'cvg_tx30', release_cycle='heartbeat_cvg')
        self.assertFalse(passed)
        report = json.loads(path.read_text())
        self.assertFalse(report['diamond_foss_equivalent'])
        self.assertNotEqual(report['status'], 'passed')

    def test_nonzero_vector_offsets_and_conflicting_pin_settings(self):
        self.fake_database()
        ports = {'bus': {'bits': [10, 11], 'offset': 8}}
        lpf, report = package_lpf('LOCATE COMP "bus[8]" SITE "78"; LOCATE COMP "bus[0]" SITE "1";',
                                  ports, self.root, self.build.device, {})
        self.assertEqual(report['pins'], {'78': 'bus[8]'})
        self.assertEqual(len(report['ignored']), 1)
        for constraint in ('LOCATE COMP "a" SITE "78"; LOCATE COMP "a" SITE "1";',
                           'IOBUF PORT "a" IO_TYPE=LVCMOS18; IOBUF PORT "a" IO_TYPE=LVCMOS33;'):
            with self.subTest(constraint=constraint), self.assertRaisesRegex(BuildError, 'Conflicting'):
                package_lpf(constraint, {'a'}, self.root, self.build.device, {})
        with self.assertRaisesRegex(BuildError, 'Conflicting TRACEID'):
            constraints('TRACEID "00000001"; TRACEID "00000010";')

    def test_backend_has_independent_outputs_and_inputs(self):
        diamond = load_build(self.root, 'tx30')
        self.assertEqual(diamond.backend, 'diamond')
        self.assertNotEqual(diamond.directory, self.build.directory)
        self.assertNotIn(diamond.strategy, self.build.inputs)
        diamond.directory.mkdir(parents=True)
        diamond.firmware_path('bit').write_text('Diamond artifact')
        self.build.directory.mkdir()
        workflow.clean(self.build)
        self.assertTrue(diamond.firmware_path('bit').is_file())

    def test_stateful_and_s3c_foss_proofs_are_required(self):
        for program, top, instance, clock in (
            ('cvg_tx30_stateful', 'cvg_tx30_stateful', 'oscillator', 'oscillator_OSC'),
            ('s3c_power_on_debounce', 'Waiting_for_Powerbutton_pressed_V0', 'oscinst0', 'oscinst0_OSC'),
            ('s3c_rev6_beta', 'S3C', 's3c_clkrst.oscinst0', 'clk'),
        ):
            with self.subTest(program=program):
                build = load_build(ROOT, program, backend='foss', release_cycle='original')
                names = (build.foss_equivalence_blacklist.read_text().splitlines()
                         if build.foss_equivalence_blacklist else [])
                mapped = {'modules': {top: {
                    'cells': {instance: {'type': 'OSCH', 'connections': {'OSC': [1]}},
                              'register': {'type': 'TRELLIS_FF'}},
                    'netnames': {clock: {'bits': [1]}, **{name: {'bits': [2]} for name in names}},
                    'ports': {},
                }}}
                script, record = equivalence_script(build, mapped)
                self.assertIn('equiv_simple -undef', script)
                self.assertIn('equiv_induct -undef -seq 8', script)
                self.assertTrue(record['undefined_value_modeling'])
                self.assertIn('write_json impl/proof-copies.json', script)
                self.assertIn('equiv_status -assert', script)
                self.assertIn(f'connect -assert -port {instance} OSC {clock} {top}', script)
                self.assertIn(f'connect -nounset -set {clock} __foss_clock {top}', script)
                self.assertIn(f'delete {top}/c:{instance}', script)
                self.assertEqual(record['blacklist'], names)
                mapped['modules'][top]['netnames']['nested.clock_alias'] = {'bits': [1]}
                self.assertEqual(equivalence_script(build, mapped)[1]['clock_abstraction']['net'], clock)
                if names:
                    mapped['modules'][top]['ports'][names[0]] = {}
                    with self.assertRaisesRegex(BuildError, 'internal signal names'):
                        equivalence_script(build, mapped)

    def test_hierarchical_oscillator_keeps_clock_dependent_outputs_connected(self):
        try:
            yosys = tool('yosys')
        except BuildError:
            self.skipTest('Pinned Yosys is unavailable')
        project = self.root / 'clock-proof/project'
        (project / 'impl').mkdir(parents=True)
        (project.parent / 'metadata/reports').mkdir(parents=True)
        rtl = '''module clockgen(output clk);
OSCH oscillator(.STDBY(1'b0), .OSC(clk));
endmodule
module clock_test(input d, output probe, output reg q = 0);
wire clk;
clockgen clocks(.clk(clk));
assign probe = clk & d;
always @(posedge clk) q <= d;
endmodule
'''
        (project / 'rtl.v').write_text(rtl)
        synth = subprocess.run([yosys, '-Q', '-T', '-p',
                                f'read_verilog -lib {json.dumps(str(ROOT / "toolchain/hdl/machxo2_primitives.v"))}; '
                                'read_verilog rtl.v; synth_lattice -family xo2 -top clock_test '
                                '-json ../metadata/reports/synth.json'],
                               cwd=project, capture_output=True, text=True)
        self.assertEqual(synth.returncode, 0, synth.stderr)
        mapped = json.loads((project.parent / 'metadata/reports/synth.json').read_text())
        script, _ = equivalence_script(replace(self.build, top='clock_test'), mapped)
        (project / 'equivalence.ys').write_text(script)
        for source, expected in ((rtl, 0), (rtl.replace('clk & d', 'clk & ~d'), 1)):
            (project / 'rtl.v').write_text(source)
            proof = subprocess.run([yosys, '-Q', '-T', '-s', 'equivalence.ys'],
                                   cwd=project, capture_output=True, text=True)
            self.assertEqual(proof.returncode != 0, bool(expected), proof.stdout[-1500:] + proof.stderr)

    def test_startup_miter_rejects_mutated_initial_state(self):
        try:
            yosys = tool('yosys')
        except BuildError:
            self.skipTest('Pinned Yosys is unavailable')
        project = self.root / 'startup-proof'
        (project / 'impl').mkdir(parents=True)
        gold = '''module gold(input clk, input d, output reg q);
initial q = 1'b1;
always @(posedge clk) q <= d;
endmodule
'''
        (project / 'gold.v').write_text(gold)
        for initial, expected in (("1'b1", 0), ("1'b0", 1)):
            (project / 'gate.v').write_text(gold.replace('module gold', 'module gate').replace("1'b1", initial))
            prep = subprocess.run([yosys, '-Q', '-T', '-p',
                                   'read_verilog gold.v gate.v; proc; write_json impl/proof-copies.json'],
                                  cwd=project, capture_output=True, text=True)
            self.assertEqual(prep.returncode, 0, prep.stderr)
            script, omitted = startup_script(json.loads((project / 'impl/proof-copies.json').read_text()))
            self.assertEqual(omitted, [])
            (project / 'startup.ys').write_text(script)
            proof = subprocess.run([yosys, '-Q', '-T', '-s', 'startup.ys'],
                                   cwd=project, capture_output=True, text=True)
            self.assertEqual(proof.returncode != 0, bool(expected), proof.stdout[-1500:] + proof.stderr)

    def test_initial_match_point_check_catches_hidden_state_change(self):
        try:
            yosys = tool('yosys')
        except BuildError:
            self.skipTest('Pinned Yosys is unavailable')
        project = self.root / 'hidden-state-proof'
        (project / 'impl').mkdir(parents=True)
        for module, value in (('gold', 1), ('gate', 0)):
            (project / f'{module}.v').write_text(
                f"module {module}(input clk, input d, output o);\n"
                f"(* keep *) reg q; initial q = 1'b{value};\n"
                "always @(posedge clk) q <= d; assign o = 1'b0; endmodule\n")
        prep = subprocess.run([yosys, '-Q', '-T', '-p',
                               'read_verilog gold.v gate.v; proc; write_json impl/proof-copies.json'],
                              cwd=project, capture_output=True, text=True)
        self.assertEqual(prep.returncode, 0, prep.stderr)
        copies = json.loads((project / 'impl/proof-copies.json').read_text())
        output_script, omitted = startup_script(copies)
        (project / 'startup.ys').write_text(output_script)
        output_proof = subprocess.run([yosys, '-Q', '-T', '-s', 'startup.ys'],
                                      cwd=project, capture_output=True, text=True)
        self.assertEqual(output_proof.returncode, 0, output_proof.stderr)
        (project / 'startup-points.ys').write_text(startup_points_script(omitted, False))
        points_proof = subprocess.run([yosys, '-Q', '-T', '-s', 'startup-points.ys'],
                                      cwd=project, capture_output=True, text=True)
        self.assertNotEqual(points_proof.returncode, 0, points_proof.stdout[-1500:])

    def test_oscillator_frequency_preserves_value_and_checks_lpf(self):
        bits = ''.join(f'{byte:08b}' for byte in b'2.08')
        module = {'cells': {'clock': {'type': 'OSCH', 'parameters': {'NOM_FREQ': bits}}}}
        with self.assertRaisesRegex(BuildError, 'conflicts'):
            normalize_oscillator_frequency(module, '4.16')
        normalize_oscillator_frequency(module, '2.08')
        self.assertEqual(module['cells']['clock']['parameters']['NOM_FREQ'], '2.08')
        module['cells']['clock']['parameters'] = {}
        with self.assertRaisesRegex(BuildError, 'conflicts'):
            normalize_oscillator_frequency(module, '4.16')
        normalize_oscillator_frequency(module, '2.08')
        self.assertEqual(module['cells']['clock']['parameters']['NOM_FREQ'], '2.08')

    def test_make_backend_selection_and_invalid_value(self):
        result = subprocess.run(['make', 'list', 'backend=foss', 'release_cycle=original'], cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.count('\tfoss'),
                         sum('foss' in program_backends(ROOT, name, 'original') for name in catalog(ROOT, 'original')))
        result = subprocess.run(['make', 'list', 'backend=unknown'], cwd=ROOT, capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)

    def test_foss_clone_does_not_need_diamond_strategy(self):
        (self.root / 'toolchain/targets/uz_dslot_xo2/baseline.sty').unlink()
        workflow.scaffold(self.root, 'custom', 'tx30', backend='foss')
        self.assertEqual(load_build(self.root, 'custom', backend='foss').backend, 'foss')

    def test_lpf_fails_on_unsupported_commands_and_attributes(self):
        for text in ('SYSCONFIG CONFIG_SECURE=ON;', 'IOBUF PORT "d_00" UNKNOWN=1;', 'LOCATE COMP "a" SITE "1"', 'FREQUENCY PORT "clk" 20 MHz;'):
            with self.subTest(text=text), self.assertRaises(BuildError):
                constraints(text)
        lpf, deferred, notes = constraints('BLOCK ASYNCPATHS; TRACEID "00000001"; SYSCONFIG SDM_PORT=DISABLE MCCLK_FREQ=2.08; LOCATE COMP "fpga_00" SITE "PT22A";')
        self.assertIn('PT22A', lpf)
        self.assertEqual(deferred['SDM_PORT'], 'DISABLE')
        self.assertEqual(deferred['MCCLK_FREQ'], '2.08')
        self.assertTrue(notes)
        _, deferred, _ = constraints('USERCODE HEX "BADEAFFE"; IOBUF PORT "safe" IO_TYPE=LVCMOS18;')
        self.assertEqual(deferred['USERCODE'], 'BADEAFFE')
        _, binary_deferred, _ = constraints('USERCODE BIN "10111010110111101010111111111110";')
        self.assertEqual(binary_deferred['USERCODE'], 'BADEAFFE')
        _, deferred, _ = constraints('BANK 1 VCCIO 1.8 V;')
        self.assertEqual(deferred['BANK_1'], '1.8')

    def test_open_drain_does_not_silently_accept_unsupported_modes(self):
        for mode in ('OFF', 'PLUS', 'TRUE'):
            with self.subTest(mode=mode), self.assertRaisesRegex(BuildError, 'OPENDRAIN=ON'):
                constraints(f'IOBUF PORT "pin" IO_TYPE=LVCMOS33 OPENDRAIN={mode};')

    def test_s3c_open_drain_voltage_exception_is_explicit_and_output_only(self):
        suite = suite_root()
        if not (suite / 'share/trellis/database/MachXO2/LCMXO2-4000/iodb.json').is_file():
            self.skipTest('Pinned Trellis database is unavailable')
        for program in ('s3c_power_on_debounce', 's3c_rev6_beta'):
            build = load_build(ROOT, program, backend='foss', release_cycle='original')
            lpf, settings, _ = constraints(build.constraint.read_text())
            ports = {name: {'direction': 'output', 'bits': [i]}
                     for i, name in enumerate(('SD_SEL', 'FlexMio61ExternalStop'))}
            _, report = package_lpf(lpf, ports, suite, build.device, settings)
            self.assertEqual({entry['pin'] for entry in report['open_drain']}, {'41', '50'})
            with self.assertRaisesRegex(BuildError, 'IO_TYPE=LVCMOS18'):
                package_lpf(lpf.replace(' OPENDRAIN=ON', ''), ports, suite, build.device, settings)
            for bad_lpf, bad_ports in (
                (lpf.replace('DRIVE=12', 'DRIVE=8'), ports),
                (lpf.replace('PULLMODE=NONE', 'PULLMODE=UP'), ports),
                (lpf.replace('SITE "41"', 'SITE "40"'), ports),
                (lpf, {name: {**port, 'direction': 'input'} for name, port in ports.items()}),
            ):
                with self.subTest(program=program, lpf=bad_lpf), self.assertRaisesRegex(BuildError, 'Unsupported open-drain'):
                    package_lpf(bad_lpf, bad_ports, suite, build.device, settings)

    def test_packed_open_drain_matches_diamond_and_detects_drive_overwrite(self):
        try:
            pack, unpack = tool('ecppack'), tool('ecpunpack')
        except BuildError:
            self.skipTest('Pinned Trellis tools are unavailable')
        from toolchain.buildsystem.foss_config import S3C_BANKS
        suite = suite_root()
        outputs = [{'port': 'SD_SEL', 'pin': '41', 'tile': 'PB4:PIC_B0'},
                   {'port': 'FlexMio61ExternalStop', 'pin': '50', 'tile': 'PB13:PIC_B0'}]
        # These enum names and unknown bits are the decoder output of Diamond
        # 3.14's original LPF. INPUT_LVCMOS18 is a decoding alias: F0B18 enables
        # the output. The neighboring PIOA settings are intentionally irrelevant.
        reference = '.device LCMXO2-4000HC\n\n'
        routed = '.device LCMXO2-4000HC\n\n'
        for output in outputs:
            header = f'.tile {output["tile"]}\n'
            reference += (header + 'enum: PIOB.BASE_TYPE INPUT_LVCMOS18\n'
                          'enum: PIOB.OPENDRAIN ON\nenum: PIOB.PULLMODE NONE\n'
                          'unknown: F0B18\nunknown: F5B10\n\n')
            # nextpnr emits DRIVE after OPENDRAIN; their database fields overlap.
            routed += (header + 'enum: PIOB.BASE_TYPE OUTPUT_LVCMOS33\n'
                       'enum: PIOB.OPENDRAIN ON\nenum: PIOB.SLEWRATE SLOW\n'
                       'enum: PIOB.DRIVE 12\n\n')
        config = self.root / 'output.config'
        config.write_text(reference)
        self.assertEqual(len(verify_open_drain(config, outputs, suite)), 2)

        def roundtrip():
            for args in ([pack, str(config), str(self.root / 'output.bit')],
                         [unpack, str(self.root / 'output.bit'), str(self.root / 'unpacked.config')]):
                result = subprocess.run(args, capture_output=True, text=True)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            return self.root / 'unpacked.config'

        config.write_text(routed)
        with self.assertRaisesRegex(BuildError, 'Packed open-drain settings differ'):
            verify_open_drain(roundtrip(), outputs, suite)
        complete_config(config, {f'BANK_{bank}': voltage for bank, voltage in S3C_BANKS.items()},
                        suite, 'LCMXO2-4000HC-4TG144C', outputs)
        self.assertEqual(len(verify_open_drain(roundtrip(), outputs, suite)), 2)
        # An open-drain mode check alone would miss a changed drive encoding.
        config.write_text(config.read_text().replace('unknown: F5B12', 'unknown: F5B18'))
        with self.assertRaisesRegex(BuildError, 'Packed open-drain settings differ'):
            verify_open_drain(roundtrip(), outputs, suite)

    def fake_database(self):
        db = self.root / 'share/trellis/database/MachXO2'
        (db / 'LCMXO2-2000').mkdir(parents=True)
        data = {'packages': {'TQFP100': {'78': {'col': 21, 'row': 0, 'pio': 'A'},
                                        '1': {'col': 0, 'row': 2, 'pio': 'A'}}},
                'pio_metadata': [{'col': 25, 'row': 15}]}
        (db / 'LCMXO2-2000/iodb.json').write_text(json.dumps(data))
        (db / 'LCMXO2-2000/tilegrid.json').write_text(json.dumps({'PT4:CFG0': {'type': 'CFG0'}}))
        (db / 'tiledata/CFG0').mkdir(parents=True)
        (db / 'tiledata/CFG0/bits.db').write_text('.config_enum SYSCONFIG.SDM_PORT DISABLE\nDISABLE -\nDONE F5B4\n\n')

    def test_pin_translation_and_absent_ports_are_reported(self):
        self.fake_database()
        lpf, report = package_lpf('LOCATE COMP "a" SITE "PT22A"; LOCATE COMP "b" SITE "PL2A"; LOCATE COMP "absent" SITE "PR4B";', {'a', 'b'}, self.root, self.build.device, {})
        self.assertIn('SITE "78"', lpf)
        self.assertEqual(report['pins'], {'78': 'a', '1': 'b'})
        self.assertEqual(len(report['ignored']), 1)
        with self.assertRaisesRegex(BuildError, 'Unknown or unbonded'):
            package_lpf('LOCATE COMP "a" SITE "PT99A";', {'a'}, self.root, self.build.device, {})
        with self.assertRaisesRegex(BuildError, 'Conflicting package pin'):
            package_lpf('LOCATE COMP "a" SITE "78"; LOCATE COMP "b" SITE "78";', {'a', 'b'}, self.root, self.build.device, {})

    def test_vector_bit_pin_translation(self):
        self.fake_database()
        ports = {'bus': {'bits': [10, 11]}}
        lpf, report = package_lpf('LOCATE COMP "bus[0]" SITE "78"; LOCATE COMP "bus[2]" SITE "1";',
                                  ports, self.root, self.build.device, {})
        self.assertIn('LOCATE COMP "bus[0]" SITE "78";', lpf)
        self.assertEqual(report['pins'], {'78': 'bus[0]'})
        self.assertEqual(len(report['ignored']), 1)

    def test_s3c_pin_translation_uses_tqfp144(self):
        self.fake_database()
        db = self.root / 'share/trellis/database/MachXO2/LCMXO2-4000'
        db.mkdir()
        (db / 'iodb.json').write_text(json.dumps({
            'packages': {'TQFP144': {'93': {'col': 31, 'row': 9, 'pio': 'B'}}},
            'pio_metadata': [{'col': 31, 'row': 9, 'pio': 'B', 'bank': 1},
                             {'col': 31, 'row': 22, 'pio': 'A', 'bank': 1}],
        }))
        from toolchain.buildsystem.foss_config import S3C_BANKS, S3C_BANK_TILES
        grid = {'PT5:CFG1': {'type': 'CFG1'}}
        for tile in S3C_BANK_TILES.values():
            grid[tile] = {'type': tile.split(':')[1]}
            bank_db = self.root / 'share/trellis/database/MachXO2/tiledata' / tile.split(':')[1]
            bank_db.mkdir()
            (bank_db / 'bits.db').write_text('.config_enum BANK.VCCIO NONE\nNONE -\n1.8 F1B1\n3.3 F1B2\n\n')
        (db / 'tilegrid.json').write_text(json.dumps(grid))
        cfg = self.root / 'share/trellis/database/MachXO2/tiledata/CFG1'
        cfg.mkdir()
        (cfg / 'bits.db').write_text('.config_enum SYSCONFIG.SLAVE_SPI_PORT DISABLE\nDISABLE -\nENABLE F5B36\n\n'
                                     '.config_enum SYSCONFIG.I2C_PORT DISABLE\nDISABLE -\nENABLE F5B38\n\n')
        settings = {f'BANK_{bank}': voltage for bank, voltage in S3C_BANKS.items()}
        translated, report = package_lpf('LOCATE COMP "safe" SITE "93"; IOBUF PORT "safe" IO_TYPE=LVCMOS18;', {'safe'},
                                         self.root, 'LCMXO2-4000HC-4TG144C', settings)
        self.assertIn('SITE "93"', translated)
        self.assertEqual(report['pins'], {'93': 'safe'})
        with self.assertRaisesRegex(BuildError, 'TQFP144'):
            package_lpf('LOCATE COMP "safe" SITE "78";', {'safe'},
                        self.root, 'LCMXO2-4000HC-4TG144C', settings)
        with self.assertRaisesRegex(BuildError, 'IO_TYPE=LVCMOS18'):
            package_lpf('LOCATE COMP "safe" SITE "93"; IOBUF PORT "safe" IO_TYPE=LVCMOS33;', {'safe'},
                        self.root, 'LCMXO2-4000HC-4TG144C', settings)
        with self.assertRaisesRegex(BuildError, 'BANK VCCIO settings'):
            package_lpf('LOCATE COMP "safe" SITE "93"; IOBUF PORT "safe" IO_TYPE=LVCMOS18;', {'safe'},
                        self.root, 'LCMXO2-4000HC-4TG144C', {**settings, 'BANK_1': '3.3'})
        config = self.root / 's3c.config'
        config.write_text('.device LCMXO2-4000HC\n')
        complete_config(config, {**settings, 'SLAVE_SPI_PORT': 'ENABLE', 'I2C_PORT': 'DISABLE'},
                        self.root, 'LCMXO2-4000HC-4TG144C')
        self.assertIn('.tile PT5:CFG1', config.read_text())
        self.assertIn('SYSCONFIG.SLAVE_SPI_PORT ENABLE', config.read_text())
        for tile in S3C_BANK_TILES.values():
            self.assertIn(f'.tile {tile}\nenum: BANK.VCCIO 1.8', config.read_text())

    def test_config_preserves_other_tiles_and_rejects_conflicts(self):
        self.fake_database()
        config = self.root / 'routed.config'
        config.write_text('.device LCMXO2-2000HC\n\n.tile PT4:CFG0\nenum: GSR.GSRMODE NONE\n\n.tile other\nenum: setting ON\n')
        complete_config(config, {'SDM_PORT': 'DISABLE'}, self.root, self.build.device)
        self.assertIn('enum: SYSCONFIG.SDM_PORT DISABLE', config.read_text())
        self.assertIn('.tile other\nenum: setting ON', config.read_text())
        with self.assertRaisesRegex(BuildError, 'Conflicting synthesized'):
            complete_config(config, {'SDM_PORT': 'DONE'}, self.root, self.build.device)
        with self.assertRaisesRegex(BuildError, 'only MCCLK_FREQ'):
            complete_config(config, {'MCCLK_FREQ': '4.16'}, self.root, self.build.device)
        with self.assertRaisesRegex(BuildError, 'only for the S3C target'):
            complete_config(config, {'BANK_0': '3.3'}, self.root, self.build.device)

    def test_checksum_failure_does_not_install(self):
        archive = self.root / 'invalid.tgz'
        archive.write_bytes(b'invalid archive')
        with self.assertRaisesRegex(ValueError, 'checksum mismatch'):
            install(self.root / 'installed-suite', archive)
        self.assertFalse((self.root / 'installed-suite').exists())

    def test_failed_foss_build_removes_only_foss_artifacts(self):
        self.build.directory.mkdir(parents=True)
        self.build.firmware_path('bit').write_text('stale')
        diamond = load_build(self.root, 'tx30')
        diamond.directory.mkdir(parents=True)
        diamond.firmware_path('jed').write_text('preserve')
        def prepare(build, project, log):
            project.mkdir()
            (project / 'impl').mkdir()
            (project / 'synth.ys').write_text('synthesis plan')
        with patch('toolchain.buildsystem.backends.foss.FossBackend.prepare', side_effect=prepare), \
             patch('toolchain.buildsystem.backends.foss.FossBackend.build', side_effect=BuildError('routing failed')):
            with self.assertRaisesRegex(BuildError, 'routing failed'):
                workflow.build_program(self.build)
        self.assertFalse(self.build.firmware_path('bit').exists())
        self.assertTrue(diamond.firmware_path('jed').exists())
        self.assertEqual(json.loads((self.build.directory / 'metadata/status.json').read_text())['status'], 'failed')

    def test_foss_publishes_named_bitstream_at_build_root(self):
        def prepare(build, project, log):
            (project / 'impl').mkdir(parents=True)
            metadata = project.parent / 'metadata'
            (metadata / 'reports').mkdir(parents=True, exist_ok=True)
            (metadata / 'reports/tools.json').write_text('{}')
            (metadata / 'build-plan.json').write_text('{}')
        def build(project, log):
            (project / 'impl/firmware_impl.bit').write_bytes(b'new bitstream')
            (project / 'impl/firmware_impl.rpt').write_text('report')
            (project.parent / 'metadata/reports/timing.json').write_text('{}')
            return 'build completed'
        with patch('toolchain.buildsystem.backends.foss.FossBackend.prepare', side_effect=prepare), \
             patch('toolchain.buildsystem.backends.foss.FossBackend.build', side_effect=build):
            directory = workflow.build_program(self.build)
        self.assertEqual(directory.name, 'uz_dslot_xo2_foss')
        self.assertEqual(self.build.firmware_path('bit').read_bytes(), b'new bitstream')
        self.assertFalse(self.build.firmware_path('jed').exists())
        record = json.loads((directory / 'metadata/build.json').read_text())
        stub = self.root / 'toolchain/hdl/machxo2_empty.vhdl'
        stub_name = str(stub.relative_to(self.root))
        self.assertIn(stub_name, record['inputs'])
        stub.write_text(stub.read_text() + '\n-- changed placeholder\n')
        reported = json.loads(catalog_report([self.build]).with_suffix('.json').read_text())['builds'][0]
        self.assertEqual(reported['status'], 'stale')
        self.assertIn(stub_name, reported['changed_inputs'])
        self.assertIn(self.build.firmware_path('bit').name, record['outputs'])
        self.assertIn('reports/firmware_impl.rpt', record['outputs'])
        self.assertIn('metadata/reports/timing.json', record['outputs'])
        self.assertFalse((directory / 'reports/timing.json').exists())
        self.assertFalse(list(directory.glob('project/**/*.json')))
        self.assertEqual([p.name for p in directory.iterdir() if p.is_file()],
                         [self.build.firmware_path('bit').name])

    def test_missing_foss_export_cannot_publish_success(self):
        def prepare(build, project, log):
            project.mkdir(parents=True)
            (project / 'impl').mkdir()
        with patch('toolchain.buildsystem.backends.foss.FossBackend.prepare', side_effect=prepare), \
             patch('toolchain.buildsystem.backends.foss.FossBackend.build', return_value='tool finished'):
            with self.assertRaisesRegex(BuildError, 'Missing fresh export'):
                workflow.build_program(self.build)
        self.assertFalse(self.build.firmware_path('bit').exists())
        self.assertFalse((self.build.directory / 'metadata/build.json').exists())
