"""Regression tests for destructive boundaries, failure reporting and manifests."""
from contextlib import redirect_stdout
import io
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from toolchain.buildsystem.model import BuildError, catalog, load_build
from toolchain.buildsystem import workflow
from toolchain.buildsystem.report import catalog_report
from toolchain.buildsystem.cli import main as cli_main
from toolchain.buildsystem.backends.diamond import DiamondBackend, tcl

ROOT = Path(__file__).resolve().parents[2]


class FrontendTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="cpld space ' $[test]-")
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        for folder in ('programs', 'toolchain', 'cpld_vhdl_generator', 'xo2_library'):
            shutil.copytree(ROOT / folder, self.root / folder, ignore=shutil.ignore_patterns('build', '__pycache__'))
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        self.build = load_build(self.root, 'tx30')

    def test_clean_works_with_stale_generator_and_missing_sources(self):
        generated = load_build(self.root, 'cvg_tx30_stateful')
        generated.directory.mkdir(parents=True)
        other = generated.build_root / 'simulation'
        other.mkdir()
        routing = generated.manifests[0].parent / 'routing.csv'
        routing.write_text(routing.read_text().replace('d_00,fpga_00,0', 'd_00,fpga_01,0'))
        self.assertEqual(cli_main(['clean', '--root', str(self.root), '--program', generated.name]), 0)
        self.assertFalse(generated.directory.exists())
        self.assertTrue(other.is_dir())
        self.build.directory.mkdir(parents=True)
        project = self.build.directory / 'project'
        project.mkdir()
        (project / 'edited.sty').write_text('unrecorded GUI change')
        self.build.sources[0].path.unlink()
        args = ['clean', '--root', str(self.root), '--program', 'tx30']
        self.assertEqual(cli_main(args), 1)
        self.assertTrue(project.is_dir())
        self.assertEqual(cli_main(args + ['--discard-project-changes']), 0)
        self.assertFalse(self.build.directory.exists())

    def test_handwritten_clone_keeps_shared_sources_in_both_cycles(self):
        from toolchain.buildsystem.releases import create
        source = self.root / 'programs/original/cvg_tx30_stateful'
        manifest = source / 'cvg_tx30_stateful.toml'
        manifest.write_text(manifest.read_text().replace('generator = "generator.toml"\n', ''))
        create(self.root, 'next')
        for cycle in ('original', 'next'):
            clone = workflow.scaffold(self.root, 'manual_copy', 'cvg_tx30_stateful',
                                      release_cycle=cycle, template_release_cycle='original')
            build = load_build(self.root, 'manual_copy', release_cycle=cycle)
            self.assertEqual([s.library for s in build.sources], ['s3c', 's3c', 'work'])
            self.assertEqual([s.path for s in build.sources[:2]],
                             [self.root / 'xo2_library/s3c/s3c_logic.vhdl',
                              self.root / 'xo2_library/s3c/level_signals.vhdl'])
            self.assertEqual(build.sources[-1].path, clone / 'manual_copy.vhdl')
            self.assertFalse((clone / 's3c_logic.vhdl').exists())
            shared = build.sources[0].path
            before = workflow.hashes(build)
            shared.write_text(shared.read_text() + '\n-- shared change\n')
            self.assertNotEqual(before, workflow.hashes(build))

    def test_scaffold_respects_workspace_lock(self):
        with workflow.locked(self.build):
            with self.assertRaisesRegex(BuildError, 'already active'):
                workflow.scaffold(self.root, 'custom', 'tx30')
        self.assertNotIn('custom', catalog(self.root))
        self.assertFalse((self.root / 'programs/original/custom').exists())

    def test_clone_finds_top_source_when_filename_differs(self):
        for template in ('template_dslots', 'uz_d_voltage_003_5v_tx30', 'uz_d_voltage_013_tx30'):
            with self.subTest(template=template):
                original = load_build(self.root, template)
                name = template + '_copy'
                destination = workflow.scaffold(self.root, name, template)
                clone = load_build(self.root, name)
                self.assertEqual(clone.top, original.top)
                self.assertEqual(clone.sources[-1].path, destination / (name + '.vhdl'))
                self.assertEqual(clone.sources[-1].path.read_bytes(), original.sources[-1].path.read_bytes())

    def test_changed_manifest_cannot_be_built_with_stale_model(self):
        path = self.build.manifests[0]
        path.write_text(path.read_text().replace('standard = "1993"', 'standard = "2008"'))
        with self.assertRaisesRegex(BuildError, 'configuration changed'):
            self.run_build()
        self.assertFalse(self.build.directory.exists())

    def test_manifest_symlink_cannot_redirect_build_outputs(self):
        path = self.build.manifests[0]
        copy = self.root / 'elsewhere'
        copy.mkdir()
        destination = copy / path.name
        path.rename(destination)
        path.symlink_to(destination)
        with self.assertRaisesRegex(BuildError, 'must not be symlinks'):
            load_build(self.root, 'tx30')

    def test_corrupt_build_record_does_not_abort_other_report_rows(self):
        self.run_build()
        path = self.build.directory / 'metadata/build.json'
        record = json.loads(path.read_text())
        record['warnings'] = None
        path.write_text(json.dumps(record))
        report = catalog_report([self.build, load_build(self.root, 'rx30')])
        rows = json.loads(report.with_suffix('.json').read_text())['builds']
        self.assertEqual([row['status'] for row in rows], ['invalid', 'missing'])

    def test_cloning_cannot_create_an_ignored_build_program(self):
        with self.assertRaisesRegex(BuildError, 'reserved'):
            workflow.scaffold(self.root, 'build', 'tx30')
        self.assertFalse((self.root / 'programs/original/build').exists())

    def fake_prepare(self, build, project, log):
        project.mkdir(parents=True)
        (project / 'firmware.ldf').write_text('<project/>')
        (project / 'impl').mkdir()
        log.write_text('prepared')

    def fake_build(self, project, log):
        for suffix in ('jed', 'bit'):
            identity = json.loads((project.parent / 'metadata/identity.json').read_text())
            (project / 'impl' / f'firmware_impl.{suffix}').write_text(
                f'UH{identity["usercode"]}*\n' if suffix == 'jed' else 'new firmware')
        log.write_text('Diamond 3.14.0.75.2')
        return log.read_text()

    def run_build(self, action=None):
        with patch('toolchain.buildsystem.workflow.DiamondBackend.prepare', side_effect=self.fake_prepare), \
             patch('toolchain.buildsystem.workflow.DiamondBackend.build', side_effect=action or self.fake_build), \
             patch('toolchain.buildsystem.workflow.launcher', return_value=Path('/bin/true')):
            return workflow.build_program(self.build)

    def test_scaffold_registers_catalog_program(self):
        # Clones use current authored content, including edits after migration.
        with self.build.sources[0].path.open('a') as stream:
            stream.write('\n-- current program edit\n')
        self.build.build_root.mkdir()
        (self.build.build_root / 'old-firmware.bit').write_text('generated output')
        result = workflow.scaffold(self.root, 'custom', 'tx30')
        custom = load_build(self.root, 'custom')
        self.assertEqual(custom.sources[0].path.read_bytes(), self.build.sources[0].path.read_bytes())
        self.assertEqual(custom.constraint.read_bytes(), self.build.constraint.read_bytes())
        self.assertEqual(catalog(self.root)[-1], 'custom')
        with self.assertRaises(BuildError):
            workflow.scaffold(self.root, 'custom', 'rx30')
        self.assertEqual({p.name for p in result.iterdir()},
                         {'custom.toml', 'custom.vhdl', 'custom_constraints.lpf', 'custom_tb.py', 'description.rst'})
        self.assertEqual(custom.testbench.read_bytes(), self.build.testbench.read_bytes())
        workflow.scaffold(self.root, 'second', 'custom')
        second = load_build(self.root, 'second')
        self.assertEqual(second.sources[0].path.read_bytes(), custom.sources[0].path.read_bytes())
        self.assertEqual(second.top, custom.top)
        self.assertEqual(catalog(self.root)[-2:], ['custom', 'second'])

    def test_s3c_target_and_scaffold_keep_device_selection(self):
        diamond = load_build(self.root, 's3c_toolchain_test_program')
        foss = load_build(self.root, 's3c_toolchain_test_program', backend='foss')
        self.assertEqual(diamond.target, 'uz_s3c_xo2')
        self.assertEqual(diamond.device, 'LCMXO2-4000HC-4TG144C')
        self.assertEqual(foss.device, diamond.device)
        self.assertNotEqual(foss.directory, diamond.directory)
        with self.assertRaisesRegex(BuildError, 'does not support'):
            load_build(self.root, 's3c_toolchain_test_program', 'uz_dslot_xo2')
        workflow.scaffold(self.root, 's3c_clone', 's3c_toolchain_test_program')
        self.assertEqual(load_build(self.root, 's3c_clone').target, 'uz_s3c_xo2')

    def test_diamond_s3c_project_requests_4000hc(self):
        build = load_build(self.root, 's3c_toolchain_test_program')
        project = build.directory / 'project'
        from toolchain.buildsystem.identity import reserve_build
        (project.parent / 'metadata').mkdir(parents=True)
        workflow.write_json(project.parent / 'metadata/identity.json', reserve_build(build))
        def fake_run(script, log):
            (project / 'firmware.ldf').write_text('<BaliProject><Implementation><Options/></Implementation></BaliProject>')
            return 'prepared'
        with patch('toolchain.buildsystem.backends.diamond.run', side_effect=fake_run):
            DiamondBackend().prepare(build, project, project / 'prepare.log')
        script = (project / 'prepare.tcl').read_text()
        self.assertIn('-dev "LCMXO2-4000HC-4TG144C"', script)
        self.assertIn('-lpf constraints.lpf', script)
        self.assertIn('USERCODE HEX', (project / 'constraints.lpf').read_text())
        self.assertIn('s3c_toolchain_test_program.vhdl', script)
        self.assertIn('def_top="S3CToolchainTestProgram"', (project / 'firmware.ldf').read_text())

    def test_imported_s3c_selects_backend_constraints(self):
        diamond = load_build(self.root, 's3c_power_on_debounce', backend='diamond')
        self.assertIn('JTAG_PORT=DISABLE', diamond.constraint.read_text())
        foss = load_build(self.root, 's3c_power_on_debounce', backend='foss')
        self.assertFalse(any('JTAG_PORT=DISABLE' in line for line in foss.constraint.read_text().splitlines()
                             if not line.lstrip().startswith('#')))
        self.assertEqual(diamond.target, 'uz_s3c_xo2')

    def test_s3c_clone_preserves_foss_equivalence_input(self):
        cloned = workflow.scaffold(self.root, 's3c_copy', 's3c_power_on_debounce', backend='foss')
        build = load_build(self.root, 's3c_copy', backend='foss')
        self.assertEqual(build.foss_equivalence_blacklist,
                         cloned / 's3c_copy_foss_equivalence_blacklist.txt')
        self.assertEqual(build.foss_equivalence_blacklist.read_bytes(),
                         (ROOT / 'programs/original/s3c_power_on_debounce/s3c_power_on_debounce_foss_equivalence_blacklist.txt').read_bytes())

    def test_clone_preserves_legacy_encoded_multifile_program(self):
        original = load_build(self.root, 's3c_rev6_beta')
        workflow.scaffold(self.root, 'rev6_copy', 's3c_rev6_beta')
        clone = load_build(self.root, 'rev6_copy')
        self.assertEqual(clone.top, original.top)
        self.assertEqual(clone.netlist_skip_reason, original.netlist_skip_reason)
        for old, new in zip(original.sources, clone.sources):
            self.assertEqual(old.path.read_bytes(), new.path.read_bytes())
        self.assertEqual(original.constraint.read_bytes(), clone.constraint.read_bytes())

    def test_build_all_selects_each_program_target(self):
        selected = []
        def capture(build):
            selected.append((build.name, build.target))
            return build.directory
        with patch('toolchain.buildsystem.cli.workflow.build_program', side_effect=capture), redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['build-all', '--root', str(self.root)]), 0)
        self.assertEqual(len(selected), len(catalog(self.root)))
        self.assertTrue((self.root / 'toolchain/build/validation/original/diamond-catalog/report.md').is_file())
        self.assertIn(('s3c_toolchain_test_program', 'uz_s3c_xo2'), selected)
        selected.clear()
        with patch('toolchain.buildsystem.cli.workflow.build_program', side_effect=capture), redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['build-all', '--root', str(self.root), '--target', 'uz_s3c_xo2']), 0)
        self.assertEqual(selected, [('s3c_toolchain_test_program', 'uz_s3c_xo2'),
                                    ('s3c_power_on_debounce', 'uz_s3c_xo2'),
                                    ('s3c_rev6_beta', 'uz_s3c_xo2')])
        self.assertTrue((self.root / 'toolchain/build/validation/original/diamond-uz_s3c_xo2-catalog/report.json').is_file())
        selected.clear()
        with patch('toolchain.buildsystem.cli.workflow.build_program', side_effect=capture), redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['build-all', '--root', str(self.root), '--target', 'uz_s3c_xo2', '--backend', 'foss']), 0)
        self.assertEqual(selected, [('s3c_toolchain_test_program', 'uz_s3c_xo2'),
                                    ('s3c_power_on_debounce', 'uz_s3c_xo2'),
                                    ('s3c_rev6_beta', 'uz_s3c_xo2')])

    def test_build_all_continues_after_tool_failure_and_reports_it(self):
        attempted = []
        def capture(build):
            attempted.append(build.name)
            if build.name == 'tx30':
                raise subprocess.CalledProcessError(1, 'ghdl')
            return build.directory
        with patch('toolchain.buildsystem.cli.workflow.build_program', side_effect=capture), \
             redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['build-all', '--root', str(self.root)]), 1)
        self.assertEqual(len(attempted), len(catalog(self.root)))
        report = self.root / 'toolchain/build/validation/original/diamond-catalog/report.json'
        rows = json.loads(report.read_text())['builds']
        failed = next(row for row in rows if row['program'] == 'tx30')
        self.assertEqual(failed['status'], 'failed')
        self.assertIn('ghdl', failed['error'])

    def test_build_all_reports_invalid_manifest_and_builds_others(self):
        manifest = self.root / 'programs/original/tx30/tx30.toml'
        manifest.write_text(manifest.read_text() + '\nunknown_field = true\n')
        attempted = []
        with patch('toolchain.buildsystem.cli.workflow.build_program',
                   side_effect=lambda build: attempted.append(build.name) or build.directory), \
             redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['build-all', '--root', str(self.root)]), 1)
        self.assertNotIn('tx30', attempted)
        self.assertEqual(len(attempted), len(catalog(self.root)) - 1)
        report = self.root / 'toolchain/build/validation/original/diamond-catalog/report.json'
        row = next(row for row in json.loads(report.read_text())['builds'] if row['program'] == 'tx30')
        self.assertEqual(row['status'], 'failed')
        self.assertIn('unknown fields', row['error'])

    def test_input_hash_failure_sets_failed_status(self):
        with patch('toolchain.buildsystem.workflow.hashes', side_effect=FileNotFoundError('missing input')):
            with self.assertRaisesRegex(FileNotFoundError, 'missing input'):
                workflow.build_program(self.build)
        status = json.loads((self.build.directory / 'metadata/status.json').read_text())
        self.assertEqual(status, {'status': 'failed', 'error': 'missing input'})

    def test_failed_catalog_update_removes_clone(self):
        path = self.root / 'programs/original/catalog.toml'
        original = path.read_bytes()
        with patch('toolchain.buildsystem.workflow.os.replace', side_effect=OSError('catalog update failed')):
            with self.assertRaisesRegex(OSError, 'catalog update failed'):
                workflow.scaffold(self.root, 'custom', 'tx30')
        self.assertEqual(path.read_bytes(), original)
        self.assertFalse((self.root / 'programs/original/custom').exists())
        self.assertEqual(list((self.root / 'programs').glob('.catalog-*.tmp')), [])

    def test_make_without_program_shows_commands(self):
        result = subprocess.run(['make'], cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('make build program=NAME', result.stdout)
        self.assertIn('make clean-all', result.stdout)
        explicit = subprocess.run(['make', 'help'], cwd=ROOT,
                                  capture_output=True, text=True)
        self.assertEqual(explicit.returncode, 0, explicit.stderr)
        self.assertEqual(explicit.stdout, result.stdout)

    def test_make_uses_lowercase_arguments(self):
        result = subprocess.run(['make', '-n', 'program=tx30'], cwd=ROOT,
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--option 'program=tx30'", result.stdout)
        result = subprocess.run(['make', '-n', 'new', 'name=custom', 'template=tx30'],
                                cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--option 'name=custom'", result.stdout)
        self.assertIn("--option 'template=tx30'", result.stdout)

    def test_invalid_manifests(self):
        path = self.build.manifests[0]
        original = path.read_text()
        for text in (original + '\ntyop = 1\n', original.replace('standard = "1993"', 'standard = "1987"'),
                     original.replace('tx30.vhdl', 'missing.vhdl'),
                     original.replace('library = "work"', 'library = "bad__name"'),
                     original.replace('targets = ["uz_dslot_xo2"]', 'targets = []'),
                     original.replace('targets = ["uz_dslot_xo2"]', 'targets = ["../outside"]'),
                     original + '\nbackends = []\n', original + '\nbackends = ["unknown"]\n'):
            path.write_text(text)
            with self.assertRaises(BuildError):
                load_build(self.root, 'tx30')
        path.write_text(original)
        with self.assertRaises(BuildError):
            load_build(self.root, '../tx30')
        with self.assertRaises(BuildError):
            load_build(self.root, 'tx30', backend='trellis')

    def test_duplicate_catalog(self):
        (self.root / 'programs/original/catalog.toml').write_text('programs = ["tx30", "tx30"]')
        with self.assertRaises(BuildError):
            catalog(self.root)

    def test_success_provenance_and_clean_scope(self):
        directory = self.run_build()
        record = json.loads((directory / 'metadata/build.json').read_text())
        self.assertEqual(record['status'], 'success')
        self.assertEqual(directory, self.build.directory)
        self.assertEqual(directory.name, 'uz_dslot_xo2_diamond')
        self.assertIn(self.build.firmware_path('jed').name, record['outputs'])
        self.assertIn(self.build.firmware_path('bit').name, record['outputs'])
        self.assertTrue(self.build.firmware_path('jed').is_file())
        self.assertTrue(self.build.firmware_path('bit').is_file())
        self.assertFalse((directory / 'artifacts').exists())
        self.assertEqual({p.name for p in directory.iterdir() if p.is_file()},
                         {self.build.firmware_path('jed').name, self.build.firmware_path('bit').name})
        self.assertTrue((directory / 'metadata/configuration.json').is_file())
        self.assertTrue((self.root / 'toolchain/build/locks').is_dir())
        self.assertFalse((self.build.build_root / '.locks').exists())
        self.assertEqual(len(record['inputs']), len(workflow.hashes(self.build)))
        untouched = self.build.build_root / 'simulation'; untouched.mkdir()
        workflow.clean(self.build)
        self.assertTrue(untouched.exists())
        self.assertTrue(self.build.sources[0].path.exists())

    def test_failed_build_cannot_leave_stale_firmware(self):
        directory = self.run_build()
        def failure(project, log):
            log.write_text('failure log')
            raise BuildError('tool failure')
        with self.assertRaises(BuildError):
            self.run_build(failure)
        self.assertTrue(directory.exists())
        self.assertFalse(self.build.firmware_path('jed').exists())
        self.assertFalse((directory / 'metadata/build.json').exists())
        self.assertEqual(json.loads((self.build.directory / 'metadata/status.json').read_text())['status'], 'failed')
        self.assertTrue(any('failure log' in p.read_text() for p in (self.build.directory / 'logs').glob('*')))

    def test_missing_export_and_changed_input_are_failures(self):
        def partial(project, log):
            self.fake_build(project, log)
            (project / 'impl/firmware_impl.bit').unlink()
            return log.read_text()
        with self.assertRaisesRegex(BuildError, 'Missing fresh export'):
            self.run_build(partial)
        def changed(project, log):
            output = self.fake_build(project, log)
            self.build.sources[0].path.write_text('changed during build')
            return output
        with self.assertRaisesRegex(BuildError, 'Inputs changed'):
            self.run_build(changed)
        self.assertFalse(self.build.firmware_path('jed').exists())
        self.assertFalse(self.build.firmware_path('bit').exists())
        self.assertFalse((self.build.directory / 'metadata/build.json').exists())

    def test_wrong_version_is_failure(self):
        def version(project, log):
            self.fake_build(project, log)
            return 'Diamond 3.13'
        with self.assertRaisesRegex(BuildError, 'Expected Diamond'):
            self.run_build(version)

    def test_catalog_report_detects_changed_inputs_and_outputs(self):
        report = catalog_report([self.build])
        first = json.loads(report.with_suffix('.json').read_text())['builds'][0]
        self.assertEqual(first['status'], 'missing')
        self.run_build()
        fresh = json.loads(catalog_report([self.build]).with_suffix('.json').read_text())['builds'][0]
        self.assertEqual(fresh['status'], 'success')
        self.build.sources[0].path.write_text(self.build.sources[0].path.read_text() + '\n-- changed\n')
        self.build.firmware_path('bit').write_text('changed firmware')
        stale = json.loads(catalog_report([self.build]).with_suffix('.json').read_text())['builds'][0]
        self.assertEqual(stale['status'], 'stale')
        self.assertIn(str(self.build.sources[0].path.relative_to(self.root)), stale['changed_inputs'])
        self.assertIn(self.build.firmware_path('bit').name, stale['changed_outputs'])

    def test_foss_code_change_does_not_invalidate_diamond_evidence(self):
        before = workflow.hashes(self.build)
        path = self.root / 'toolchain/buildsystem/backends/foss.py'
        path.write_text(path.read_text() + '\n# unrelated backend edit\n')
        self.assertEqual(before, workflow.hashes(self.build))

    def test_gui_changes_are_protected(self):
        self.run_build()
        (self.build.directory / 'project/firmware.ldf').write_text('GUI experiment')
        with self.assertRaisesRegex(BuildError, 'Generated configuration changed'):
            self.run_build()
        with self.assertRaises(BuildError):
            workflow.clean(self.build)
        workflow.clean(self.build, discard_project_changes=True)

    def test_clean_all_removes_generated_files_and_keeps_sources(self):
        for relative in ('toolchain/build', 'docs/_build', 'docs/_generated',
                         '.venv', 'programs/original/tx30/build', '.pytest_cache',
                         'toolchain/buildsystem/__pycache__'):
            path = self.root / relative
            path.mkdir(parents=True, exist_ok=True)
            (path / 'generated.txt').write_text('generated')
        (self.root / 'toolchain/buildsystem/loose.pyc').write_bytes(b'cache')
        archive = self.root / 'archive'; archive.mkdir()
        (archive / 'retained.pyc').write_bytes(b'archived input')
        workflow.clean_all(self.root)
        for relative in ('toolchain/build', 'docs/_build', 'docs/_generated',
                         '.venv', 'programs/original/tx30/build', '.pytest_cache',
                         'toolchain/buildsystem/__pycache__',
                         'toolchain/buildsystem/loose.pyc'):
            self.assertFalse((self.root / relative).exists(), relative)
        self.assertTrue(self.build.sources[0].path.is_file())
        self.assertTrue((self.root / 'programs/original/catalog.toml').is_file())
        self.assertEqual((archive / 'retained.pyc').read_bytes(), b'archived input')

    def test_clean_all_rejects_generated_symlink_before_deleting(self):
        target = self.root / 'keep'; target.mkdir()
        (target / 'important.txt').write_text('keep')
        (self.root / 'programs/original/tx30/build').symlink_to(target, target_is_directory=True)
        output = self.root / 'toolchain/build'; output.mkdir()
        with self.assertRaisesRegex(BuildError, 'symlink'):
            workflow.clean_all(self.root)
        self.assertTrue((target / 'important.txt').is_file())
        self.assertTrue(output.is_dir())

    def test_lock_excludes_clean(self):
        with workflow.locked(self.build):
            with self.assertRaisesRegex(BuildError, 'already active'):
                workflow.clean(self.build)

    def test_clean_all_preserves_active_build_and_lock(self):
        self.run_build()
        with workflow.locked(self.build):
            lock = self.root / 'toolchain/build/locks/original.tx30.uz_dslot_xo2.diamond.lock'
            inode = lock.stat().st_ino
            with self.assertRaisesRegex(BuildError, 'already active'):
                workflow.clean_all(self.root)
            self.assertTrue(self.build.firmware_path('bit').is_file())
            self.assertEqual(lock.stat().st_ino, inode)
            with self.assertRaisesRegex(BuildError, 'already active'):
                with workflow.locked(self.build):
                    self.fail('Acquired a competing build lock')
        workflow.clean_all(self.root)
        self.assertFalse(self.build.build_root.exists())
        with workflow.locked(self.build):
            pass

    def test_cleanup_excludes_new_operations_even_after_removing_lock_files(self):
        self.run_build()
        cleanup = workflow._clean_all

        def during_cleanup(root):
            cleanup(root)
            self.assertFalse((root / 'toolchain/build').exists())
            for build in (self.build, load_build(root, 'rx30')):
                with self.assertRaisesRegex(BuildError, 'already active'):
                    with workflow.locked(build):
                        self.fail('Started an operation during cleanup')
            with self.assertRaisesRegex(BuildError, 'already active'):
                workflow.clean_all(root)

        with patch('toolchain.buildsystem.workflow._clean_all', side_effect=during_cleanup):
            workflow.clean_all(self.root)
        with workflow.locked(self.build), workflow.locked(load_build(self.root, 'rx30')):
            pass

    def test_clean_all_rejects_operation_in_another_process(self):
        command = ['python3', '-c',
                   'from pathlib import Path; from toolchain.buildsystem.workflow import clean_all; '
                   'import sys; clean_all(Path(sys.argv[1]))', str(self.root)]
        with workflow.locked(self.build):
            result = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('already active', result.stderr)

    def test_report_records_stale_generator_and_continues(self):
        self.run_build()
        config = self.root / 'programs/original/cvg_tx30_stateful/generator.toml'
        config.write_text(config.read_text() + '\n# changed generation input\n')
        with redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['report', '--root', str(self.root), '--backend', 'diamond']), 1)
        report = self.root / 'toolchain/build/validation/original/diamond-catalog/report.json'
        rows = {row['program']: row for row in json.loads(report.read_text())['builds']}
        self.assertEqual(rows['tx30']['status'], 'success')
        self.assertEqual(rows['cvg_tx30_stateful']['status'], 'failed')
        self.assertIn('inputs changed', rows['cvg_tx30_stateful']['error'])
        self.assertEqual(len(rows), len(catalog(self.root)))

    def test_report_is_written_when_every_selected_program_is_invalid(self):
        (self.root / 'programs/original/catalog.toml').write_text('programs = ["tx30"]\n')
        manifest = self.build.manifests[0]
        manifest.write_text(manifest.read_text() + '\nunknown_field = true\n')
        with redirect_stdout(io.StringIO()):
            self.assertEqual(cli_main(['report', '--root', str(self.root), '--backend', 'diamond',
                                       '--target', self.build.target]), 1)
        report = self.root / 'toolchain/build/validation/original/diamond-uz_dslot_xo2-catalog/report.json'
        row, = json.loads(report.read_text())['builds']
        self.assertEqual(row['program'], 'tx30')
        self.assertEqual(row['status'], 'failed')
        self.assertIn('unknown fields', row['error'])

    def test_symlink_cannot_redirect_clean(self):
        self.build.build_root.symlink_to(self.root / 'programs', target_is_directory=True)
        with self.assertRaisesRegex(BuildError, 'symlink'):
            workflow.clean(self.build, True)
        self.assertTrue(self.build.manifests[0].exists())

    def test_tcl_quoting_roundtrips_without_substitution(self):
        import tkinter
        interpreter = tkinter.Tcl()
        value = 'spaces " braces {} $env(HOME) [error injected] \\ newline\n'
        self.assertEqual(interpreter.eval('set value ' + tcl(value)), value)


if __name__ == '__main__':
    unittest.main()
