"""FOSS backend boundaries, electrical constraint translation and Make selection."""
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.buildsystem import workflow
from toolchain.buildsystem.model import catalog, BuildError, load_build
from toolchain.buildsystem.backends.foss import constraints
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

    def test_make_backend_selection_and_invalid_value(self):
        result = subprocess.run(['make', 'list', 'backend=foss'], cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.count('\tfoss'), len(catalog(ROOT)))
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
        lpf, report = package_lpf('LOCATE COMP "a" SITE "PT22A"; LOCATE COMP "b" SITE "PL2A"; LOCATE COMP "absent" SITE "PR4B";', {'a', 'b'}, self.root)
        self.assertIn('SITE "78"', lpf)
        self.assertEqual(report['pins'], {'78': 'a', '1': 'b'})
        self.assertEqual(len(report['ignored']), 1)
        with self.assertRaisesRegex(BuildError, 'Unknown or unbonded'):
            package_lpf('LOCATE COMP "a" SITE "PT99A";', {'a'}, self.root)
        with self.assertRaisesRegex(BuildError, 'Conflicting package pin'):
            package_lpf('LOCATE COMP "a" SITE "78"; LOCATE COMP "b" SITE "78";', {'a', 'b'}, self.root)

    def test_config_preserves_other_tiles_and_rejects_conflicts(self):
        self.fake_database()
        config = self.root / 'routed.config'
        config.write_text('.device LCMXO2-2000HC\n\n.tile PT4:CFG0\nenum: GSR.GSRMODE NONE\n\n.tile other\nenum: setting ON\n')
        complete_config(config, {'SDM_PORT': 'DISABLE'}, self.root)
        self.assertIn('enum: SYSCONFIG.SDM_PORT DISABLE', config.read_text())
        self.assertIn('.tile other\nenum: setting ON', config.read_text())
        with self.assertRaisesRegex(BuildError, 'Conflicting synthesized'):
            complete_config(config, {'SDM_PORT': 'DONE'}, self.root)
        with self.assertRaisesRegex(BuildError, 'only MCCLK_FREQ'):
            complete_config(config, {'MCCLK_FREQ': '4.16'}, self.root)

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
