"""Regression tests for destructive boundaries, failure reporting and manifests."""
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from toolchain.buildsystem.model import BuildError, catalog, load_build
from toolchain.buildsystem import workflow
from toolchain.buildsystem.backends.diamond import tcl

ROOT = Path(__file__).resolve().parents[2]


class FrontendTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="cpld space ' $[test]-")
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        for folder in ('programs', 'toolchain'):
            shutil.copytree(ROOT / folder, self.root / folder, ignore=shutil.ignore_patterns('build', '__pycache__'))
        self.build = load_build(self.root, 'tx30')

    def fake_prepare(self, build, project, log):
        project.mkdir(parents=True)
        (project / 'firmware.ldf').write_text('<project/>')
        (project / 'impl').mkdir()
        log.write_text('prepared')

    def fake_build(self, project, log):
        for suffix in ('jed', 'bit'):
            (project / 'impl' / f'firmware_impl.{suffix}').write_text('new firmware')
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

    def test_failed_catalog_update_removes_clone(self):
        path = self.root / 'programs/catalog.toml'
        original = path.read_bytes()
        with patch('toolchain.buildsystem.workflow.os.replace', side_effect=OSError('catalog update failed')):
            with self.assertRaisesRegex(OSError, 'catalog update failed'):
                workflow.scaffold(self.root, 'custom', 'tx30')
        self.assertEqual(path.read_bytes(), original)
        self.assertFalse((self.root / 'programs/custom').exists())
        self.assertEqual(list((self.root / 'programs').glob('.catalog-*.tmp')), [])

    def test_make_without_program_shows_commands(self):
        result = subprocess.run(['make'], cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('make build program=NAME', result.stdout)
        self.assertIn('make clean-all', result.stdout)
        explicit = subprocess.run(['make', 'help', 'program=tx30'], cwd=ROOT,
                                  capture_output=True, text=True)
        self.assertEqual(explicit.returncode, 0, explicit.stderr)
        self.assertEqual(explicit.stdout, result.stdout)

    def test_make_uses_lowercase_arguments(self):
        result = subprocess.run(['make', '-n', 'program=tx30'], cwd=ROOT,
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--program 'tx30'", result.stdout)
        result = subprocess.run(['make', '-n', 'new', 'name=custom', 'template=tx30'],
                                cwd=ROOT, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--name 'custom' --template 'tx30'", result.stdout)

    def test_invalid_manifests(self):
        path = self.build.manifests[0]
        original = path.read_text()
        for text in (original + '\ntyop = 1\n', original.replace('standard = "1993"', 'standard = "1987"'),
                     original.replace('tx30.vhdl', 'missing.vhdl'),
                     original.replace('library = "work"', 'library = "bad__name"')):
            path.write_text(text)
            with self.assertRaises(BuildError):
                load_build(self.root, 'tx30')
        path.write_text(original)
        with self.assertRaises(BuildError):
            load_build(self.root, '../tx30')
        with self.assertRaises(BuildError):
            load_build(self.root, 'tx30', backend='trellis')

    def test_duplicate_catalog(self):
        (self.root / 'programs/catalog.toml').write_text('programs = ["tx30", "tx30"]')
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
                         '.venv', 'programs/tx30/build', '.pytest_cache',
                         'toolchain/buildsystem/__pycache__'):
            path = self.root / relative
            path.mkdir(parents=True, exist_ok=True)
            (path / 'generated.txt').write_text('generated')
        (self.root / 'toolchain/buildsystem/loose.pyc').write_bytes(b'cache')
        archive = self.root / 'archive'; archive.mkdir()
        (archive / 'retained.pyc').write_bytes(b'archived input')
        workflow.clean_all(self.root)
        for relative in ('toolchain/build', 'docs/_build', 'docs/_generated',
                         '.venv', 'programs/tx30/build', '.pytest_cache',
                         'toolchain/buildsystem/__pycache__',
                         'toolchain/buildsystem/loose.pyc'):
            self.assertFalse((self.root / relative).exists(), relative)
        self.assertTrue(self.build.sources[0].path.is_file())
        self.assertTrue((self.root / 'programs/catalog.toml').is_file())
        self.assertEqual((archive / 'retained.pyc').read_bytes(), b'archived input')

    def test_clean_all_rejects_generated_symlink_before_deleting(self):
        target = self.root / 'keep'; target.mkdir()
        (target / 'important.txt').write_text('keep')
        (self.root / 'programs/tx30/build').symlink_to(target, target_is_directory=True)
        output = self.root / 'toolchain/build'; output.mkdir()
        with self.assertRaisesRegex(BuildError, 'symlink'):
            workflow.clean_all(self.root)
        self.assertTrue((target / 'important.txt').is_file())
        self.assertTrue(output.is_dir())

    def test_lock_excludes_clean(self):
        with workflow.locked(self.build):
            with self.assertRaisesRegex(BuildError, 'already active'):
                workflow.clean(self.build)

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
