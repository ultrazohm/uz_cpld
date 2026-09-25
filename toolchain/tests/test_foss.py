"""FOSS backend boundaries, electrical constraint translation and Make selection."""
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.buildsystem import workflow
from toolchain.buildsystem.report import catalog_report
from toolchain.buildsystem.model import catalog, program_backends, BuildError, load_build
from toolchain.buildsystem.backends.foss import constraints, equivalence_script, normalize_oscillator_frequency, startup_script, startup_points_script, tool
from toolchain.buildsystem.foss_config import complete_config, package_lpf
from toolchain.foss.install import install

ROOT = Path(__file__).resolve().parents[2]


class FossTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="cpld foss ' $[test]-")
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        for folder in ('programs', 'toolchain'):
            shutil.copytree(ROOT / folder, self.root / folder, ignore=shutil.ignore_patterns('build', '__pycache__'))
        self.build = load_build(self.root, 'tx30', backend='foss')

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
            ('tx30_stateful', 'tx30_stateful', 'oscillator', 'oscillator_OSC'),
            ('s3c_power_on_debounce', 'Waiting_for_Powerbutton_pressed_V0', 'oscinst0', 'oscinst0_OSC'),
        ):
            with self.subTest(program=program):
                build = load_build(ROOT, program, backend='foss')
                names = (build.foss_equivalence_blacklist.read_text().splitlines()
                         if build.foss_equivalence_blacklist else [])
                mapped = {'modules': {top: {
                    'cells': {instance: {'type': 'OSCH', 'connections': {'OSC': [1]}},
                              'register': {'type': 'TRELLIS_FF'}},
                    'netnames': {clock: {'bits': [1]}, **{name: {'bits': [2]} for name in names}},
                    'ports': {},
                }}}
                script, record = equivalence_script(build, mapped)
                self.assertIn('equiv_induct -seq 8', script)
                self.assertIn('write_json impl/proof-copies.json', script)
                self.assertIn('equiv_status -assert', script)
                self.assertIn(f'expose -input {top}/w:{clock}', script)
                self.assertIn(f'delete {top}/c:{instance}', script)
                self.assertEqual(record['blacklist'], names)
                if names:
                    mapped['modules'][top]['ports'][names[0]] = {}
                    with self.assertRaisesRegex(BuildError, 'internal signal names'):
                        equivalence_script(build, mapped)

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

    def test_make_backend_selection_and_invalid_value(self):
        result = subprocess.run(['make', 'list', 'backend=foss'], cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.count('\tfoss'),
                         sum('foss' in program_backends(ROOT, name) for name in catalog(ROOT)))
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
