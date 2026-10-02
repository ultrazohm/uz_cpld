"""Release selection, copying, isolation and Make integration regressions."""
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from cpld_vhdl_generator import check
from toolchain.buildsystem import releases, workflow
from toolchain.buildsystem.model import (BuildError, catalog, load_build, release_cycles,
                                        resolve_release)
from toolchain.buildsystem.report import catalog_report

ROOT = Path(__file__).resolve().parents[2]


class ReleaseTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for folder in ('toolchain', 'cpld_vhdl_generator', 'xo2_library'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('build', '__pycache__', '.pytest_cache'))
        shutil.copytree(ROOT / 'programs/original', self.root / 'programs/original',
                        ignore=shutil.ignore_patterns('build', '__pycache__', '.pytest_cache'))
        shutil.copy2(ROOT / 'programs/usercodes.json', self.root / 'programs/usercodes.json')
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        shutil.copy2(ROOT / 'Makefile', self.root / 'Makefile')

    def make(self, *args, success=True):
        result = subprocess.run(['make', *args], cwd=self.root, text=True,
                                capture_output=True, timeout=30)
        self.assertEqual(result.returncode == 0, success, result.stdout + result.stderr)
        return result.stdout + result.stderr

    def test_current_is_explicit_and_make_overrides_do_not_change_it(self):
        self.make('release-new', 'name=z_old')
        self.make('release-new', 'name=a_new')
        self.assertEqual(resolve_release(self.root), 'a_new')
        self.assertEqual(catalog(self.root), [])
        self.assertTrue((self.root / 'programs/a_new/description.rst').is_file())
        self.assertIn('original/tx30', self.make('list', 'release_cycle=original'))
        self.assertEqual(resolve_release(self.root), 'a_new')
        self.make('release-current', 'release_cycle=original')
        self.assertIn('original (current)', self.make('release-list'))
        self.assertEqual(release_cycles(self.root), ['a_new', 'original', 'z_old'])

    def test_cross_cycle_template_and_generator_commands(self):
        self.make('release-new', 'name=next')
        self.make('new', 'name=manual', 'template=tx30', 'template_release_cycle=original')
        manual = load_build(self.root, 'manual')
        self.assertEqual(manual.release_cycle, 'next')
        self.make('new', 'name=slot', 'template=generator', 'release_cycle=original')
        self.make('generate', 'program=cvg_slot', 'release_cycle=original')
        generated = load_build(self.root, 'cvg_slot', release_cycle='original')
        self.assertEqual(generated.top, 'cvg_slot')
        self.assertIn('s3c_normal_state', generated.sources[-1].path.read_text())
        self.assertNotIn('cvg_normal_state', generated.sources[-1].path.read_text())
        self.make('new', 'name=cvg_slot', 'template=cvg_slot', 'template_release_cycle=original')
        clone = load_build(self.root, 'cvg_slot')
        check(clone.manifests[0].parent / 'generator.toml', clone.manifests[0].parent)
        self.assertEqual(clone.name, generated.name)
        self.assertNotEqual(clone.directory, generated.directory)
        self.assertNotIn('manual', catalog(self.root, 'original'))

    def test_copy_preserves_authored_files_and_starters_without_build_outputs(self):
        original = load_build(self.root, 'tx30')
        original.build_root.mkdir()
        (original.build_root / 'old.bit').write_text('old output')
        starter = workflow.scaffold(self.root, 'unfinished', 'generator')
        cache = starter / '__pycache__'
        cache.mkdir()
        (cache / 'old.pyc').touch()
        self.make('release-new', 'name=next', 'from=original')
        self.assertEqual(catalog(self.root), catalog(self.root, 'original'))
        original_description = self.root / 'programs/original/description.rst'
        copied_description = self.root / 'programs/next/description.rst'
        self.assertEqual(copied_description.read_bytes(), original_description.read_bytes())
        copied_description.write_text('Description for the new cycle.\n')
        self.assertNotEqual(copied_description.read_bytes(), original_description.read_bytes())
        copied = load_build(self.root, 'tx30')
        self.assertEqual(copied.sources[-1].path.read_bytes(), original.sources[-1].path.read_bytes())
        self.assertFalse(copied.build_root.exists())
        self.assertTrue((self.root / 'programs/next/cvg_unfinished/generator.toml').is_file())
        self.assertFalse((self.root / 'programs/next/cvg_unfinished/__pycache__').exists())
        load_build(self.root, 'cvg_tx30_stateful')
        copied.sources[-1].path.write_text('-- independent edit\n')
        self.assertNotEqual(copied.sources[-1].path.read_bytes(), original.sources[-1].path.read_bytes())
        workflow.generate_program(self.root, 'cvg_unfinished')

    def test_copy_of_cycle_without_description_creates_starter(self):
        (self.root / 'programs/original/description.rst').unlink()
        releases.create(self.root, 'next', 'original')
        self.assertTrue((self.root / 'programs/next/description.rst').is_file())
        self.assertFalse((self.root / 'programs/original/description.rst').exists())

    def test_same_program_names_have_independent_locks_and_reports(self):
        releases.create(self.root, 'next', 'original')
        old = load_build(self.root, 'tx30', release_cycle='original')
        new = load_build(self.root, 'tx30')
        with workflow.locked(old), workflow.locked(new):
            with self.assertRaisesRegex(BuildError, 'already active'):
                releases.select(self.root, 'original')
        old_report, new_report = catalog_report([old]), catalog_report([new])
        self.assertNotEqual(old_report, new_report)
        self.assertEqual(json.loads(new_report.with_suffix('.json').read_text())['release_cycle'], 'next')
        for build in (old, new):
            build.build_root.mkdir(parents=True)
            (build.build_root / 'result').touch()
        workflow.clean_all(self.root)
        self.assertFalse(old.build_root.exists())
        self.assertFalse(new.build_root.exists())
        self.assertEqual(resolve_release(self.root), 'next')

    def test_failed_creation_and_invalid_selection_preserve_current(self):
        for name in ('../escape', 'bad/name', 'original', 'build'):
            with self.subTest(name=name), self.assertRaises(BuildError):
                releases.create(self.root, name)
        with self.assertRaises(BuildError):
            releases.select(self.root, 'missing')
        with patch('toolchain.buildsystem.releases._select', side_effect=OSError('write failed')):
            with self.assertRaisesRegex(OSError, 'write failed'):
                releases.create(self.root, 'failed', 'original')
        self.assertFalse((self.root / 'programs/failed').exists())
        self.assertEqual(resolve_release(self.root), 'original')
        self.assertTrue(load_build(self.root, 'tx30').sources[-1].path.is_file())

    def test_copy_rejects_authored_symlinks_without_following_them(self):
        (self.root / 'programs/original/link').symlink_to(self.root / 'toolchain', target_is_directory=True)
        with self.assertRaisesRegex(BuildError, 'regular authored files'):
            releases.create(self.root, 'next', 'original')
        self.assertFalse((self.root / 'programs/next').exists())
        self.assertEqual(resolve_release(self.root), 'original')

    def test_empty_cycle_report_is_valid_but_build_all_requires_programs(self):
        releases.create(self.root, 'empty')
        for backend in ('diamond', 'foss'):
            with self.subTest(backend=backend):
                output = self.make('build-all', f'backend={backend}', success=False)
                self.assertIn('No programs selected for build-all', output)
        self.make('report')
        path = self.root / 'toolchain/build/validation/empty/diamond-catalog/report.json'
        report = json.loads(path.read_text())
        self.assertEqual(report['builds'], [])
        self.assertEqual(report['release_cycle'], 'empty')

    def test_invalid_source_cycle_does_not_publish_a_copy(self):
        source = self.root / 'programs/original/tx30/tx30.toml'
        source.write_text('invalid TOML')
        with self.assertRaises(BuildError):
            releases.create(self.root, 'next', 'original')
        self.assertFalse((self.root / 'programs/next').exists())
        self.assertEqual(resolve_release(self.root), 'original')
