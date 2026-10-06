"""Release archives reject stale or incomplete firmware and retain identity evidence."""
import hashlib
import json
from pathlib import Path
from unittest.mock import patch
import unittest
from types import SimpleNamespace
from zipfile import ZipFile

from cpld_toolchain.toolchain import ci
from cpld_toolchain.toolchain.buildsystem import publication
from cpld_toolchain.toolchain.buildsystem.identity import read_registry
from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.tests import test_buildsystem as fixtures


class FirmwareArchiveTests(unittest.TestCase):
    setUp = fixtures.FrontendTests.setUp
    fake_prepare = fixtures.FrontendTests.fake_prepare
    fake_build = fixtures.FrontendTests.fake_build
    run_build = fixtures.FrontendTests.run_build

    def prepare(self):
        for path in (self.root / 'programs').glob('*/catalog.toml'):
            if path.parent.name != 'original':
                path.unlink()
        (self.root / 'programs/original/catalog.toml').write_text('programs = ["tx30"]\n')
        self.run_build()
        self.record_path = self.build.directory / 'metadata/build.json'
        self.record = json.loads(self.record_path.read_text())
        self.record['git_revision'] = 'a' * 40
        self.record_path.write_text(json.dumps(self.record))
        self.output = self.root / 'firmware.zip'

    def package(self):
        with patch.object(publication.subprocess, 'run', return_value=SimpleNamespace(returncode=0, stdout='a' * 40)):
            return ci.package(self.root, self.output)

    def test_archive_contains_verified_exports_and_registry(self):
        self.prepare()
        self.package()
        with ZipFile(self.output) as archive:
            manifest = json.loads(archive.read('manifest.json'))
            self.assertEqual(manifest['git_revision'], 'a' * 40)
            self.assertEqual(manifest['release_cycles'], ['original'])
            self.assertEqual(manifest['identity_registry'], read_registry(self.root))
            entry, = manifest['builds']
            self.assertEqual(entry['identity'], self.record['identity'])
            self.assertEqual(len(archive.namelist()), 3)
            self.assertEqual(len(entry['files']), 2)
            for name, digest in entry['files'].items():
                self.assertTrue(name.startswith('original/tx30/uz_dslot_xo2/'))
                self.assertEqual(hashlib.sha256(archive.read(name)).hexdigest(), digest)

    def test_missing_tampered_and_unrecorded_exports_are_rejected(self):
        self.prepare()
        path = self.build.firmware_path('bit')
        original = path.read_bytes()
        for variant in ('missing', 'tampered', 'unrecorded'):
            with self.subTest(variant=variant):
                path.write_bytes(original)
                record = json.loads(json.dumps(self.record))
                if variant == 'missing':
                    path.unlink()
                elif variant == 'tampered':
                    path.write_bytes(b'wrong firmware')
                else:
                    record['outputs'].pop(path.name)
                self.record_path.write_text(json.dumps(record))
                with self.assertRaises(BuildError):
                    self.package()
                self.assertFalse(self.output.exists())

    def test_stale_sources_and_other_commit_are_rejected(self):
        self.prepare()
        self.record['git_revision'] = 'b' * 40
        self.record_path.write_text(json.dumps(self.record))
        with self.assertRaisesRegex(BuildError, 'another Git revision'):
            self.package()
        self.record['git_revision'] = 'a' * 40
        self.record_path.write_text(json.dumps(self.record))
        source = self.build.sources[0].path
        source.write_text(source.read_text() + '\n-- changed\n')
        with self.assertRaisesRegex(BuildError, 'stale'):
            self.package()
        self.assertFalse(self.output.exists())

    def test_incomplete_catalog_does_not_publish_partial_archive(self):
        self.prepare()
        (self.root / 'programs/original/catalog.toml').write_text('programs = ["tx30", "rx30"]\n')
        with self.assertRaisesRegex(BuildError, 'missing'):
            self.package()
        self.assertFalse(self.output.exists())

    def test_existing_archive_is_not_overwritten(self):
        self.prepare()
        self.output.write_bytes(b'existing release')
        with self.assertRaisesRegex(BuildError, 'already exists'):
            self.package()
        self.assertEqual(self.output.read_bytes(), b'existing release')

    def test_build_all_attempts_later_releases_after_failure(self):
        with patch.object(ci, 'release_cycles', return_value=['first', 'second']), \
                patch.object(ci, 'build_cli', side_effect=[1, 0]) as build:
            with self.assertRaisesRegex(BuildError, 'first'):
                ci.build_all(Path('/checkout'))
        self.assertEqual(build.call_count, 2)
        self.assertIn('second', build.call_args.args[0])

    def test_empty_repository_cannot_build_or_publish(self):
        with patch.object(ci, 'release_cycles', return_value=[]):
            with self.assertRaisesRegex(BuildError, 'No release catalogs'):
                ci.build_all(self.root)
            with self.assertRaisesRegex(BuildError, 'No release catalogs'):
                ci.package(self.root, self.root / 'firmware.zip')


    def test_local_snapshot_matches_ci_archive_byte_for_byte(self):
        self.prepare()
        with patch.object(publication.subprocess, 'run',
                          return_value=SimpleNamespace(returncode=0, stdout='a' * 40)):
            snapshot = publication.publish(self.root, [self.build])
        self.package()
        with ZipFile(self.output) as archive:
            self.assertEqual(len(archive.namelist()), 3)
            self.assertEqual(self.build.firmware_path('bit').relative_to(snapshot).as_posix(),
                             next(name for name in archive.namelist() if name.endswith('.bit')))
            for name in archive.namelist():
                self.assertEqual((snapshot / name).read_bytes(), archive.read(name))

    def test_failed_publication_invalidates_manifest(self):
        self.run_build()
        snapshot = publication.publish(self.root, [self.build])
        self.build.firmware_path('bit').write_bytes(b'tampered')
        with self.assertRaises(BuildError):
            publication.publish(self.root, [self.build])
        self.assertFalse((snapshot / 'manifest.json').exists())

    def test_republication_does_not_index_unverified_files(self):
        self.run_build()
        snapshot = publication.publish(self.root, [self.build])
        extra = snapshot / 'unselected.bit'
        extra.write_bytes(b'old')
        publication.publish(self.root, [self.build])
        self.assertTrue(extra.exists())
        manifest = json.loads((snapshot / 'manifest.json').read_text())
        self.assertEqual([entry['program'] for entry in manifest['builds']], ['tx30'])

    def test_catalog_command_publishes_only_selected_target(self):
        from cpld_toolchain.toolchain.buildsystem.cli import main
        from cpld_toolchain.toolchain.buildsystem import workflow
        from cpld_toolchain.toolchain.buildsystem.model import load_build
        (self.root / 'programs/original/catalog.toml').write_text(
            'programs = ["tx30", "s3c_power_on_debounce"]\n')
        self.build = load_build(self.root, 's3c_power_on_debounce')
        with patch.object(workflow.DiamondBackend, 'prepare', side_effect=self.fake_prepare), \
             patch.object(workflow.DiamondBackend, 'build', side_effect=self.fake_build), \
             patch.object(workflow, 'launcher', return_value=Path('/bin/true')):
            self.assertEqual(main(['build-all', '--root', str(self.root),
                                   '--target', 'uz_s3c_xo2', '--backend', 'diamond']), 0)
        path = self.root / 'build/diamond/manifest.json'
        manifest = json.loads(path.read_text())
        self.assertEqual([entry['program'] for entry in manifest['builds']], ['s3c_power_on_debounce'])

    def test_foss_publication_contains_only_bitstream(self):
        from cpld_toolchain.toolchain.buildsystem.model import load_build
        self.build = load_build(self.root, 'tx30', backend='foss')
        self.build.directory.mkdir(parents=True)
        metadata = self.build.directory / 'metadata'
        metadata.mkdir()
        firmware = self.build.firmware_path('bit')
        firmware.write_bytes(b'foss firmware')
        record = {'git_revision': None, 'outputs': {firmware.name: hashlib.sha256(firmware.read_bytes()).hexdigest()}}
        (metadata / 'build.json').write_text(json.dumps(record))
        with patch.object(publication, '_row', return_value={'status': 'success', 'identity': {'usercode': '00010001'}}):
            snapshot = publication.publish(self.root, [self.build])
        manifest = json.loads((snapshot / 'manifest.json').read_text())
        self.assertEqual(manifest['backend'], 'foss')
        self.assertEqual(len(manifest['builds'][0]['files']), 1)
        self.assertEqual(len(list(snapshot.rglob('*.bit'))), 1)
        self.assertEqual(list(snapshot.rglob('*.jed')), [])


    def test_single_build_command_publishes_manifest(self):
        from cpld_toolchain.toolchain.buildsystem.cli import main
        from cpld_toolchain.toolchain.buildsystem import workflow
        with patch.object(workflow.DiamondBackend, 'prepare', side_effect=self.fake_prepare), \
             patch.object(workflow.DiamondBackend, 'build', side_effect=self.fake_build), \
             patch.object(workflow, 'launcher', return_value=Path('/bin/true')):
            self.assertEqual(main(['build', '--root', str(self.root), '--program', 'tx30']), 0)
        manifest = json.loads((self.root / 'build/diamond/manifest.json').read_text())
        self.assertEqual([entry['program'] for entry in manifest['builds']], ['tx30'])

    def test_publication_rejects_symlinked_ancestor(self):
        self.run_build()
        outside = self.root / 'outside'
        outside.mkdir()
        output = self.root / 'build/diamond'
        output.rename(self.root / 'saved-diamond')
        output.parent.mkdir(parents=True, exist_ok=True)
        output.symlink_to(outside, target_is_directory=True)
        with self.assertRaisesRegex(BuildError, 'symlink'):
            publication.publish(self.root, [self.build])
        self.assertEqual(list(outside.iterdir()), [])


    def test_manifest_accumulates_valid_builds_without_copying_firmware(self):
        from cpld_toolchain.toolchain.buildsystem.model import load_build
        self.run_build()
        first = self.build
        snapshot = publication.publish(self.root, [first])
        self.build = load_build(self.root, 'rx30')
        self.run_build()
        self.assertFalse((snapshot / 'manifest.json').exists())
        publication.publish(self.root, [self.build])
        manifest = json.loads((snapshot / 'manifest.json').read_text())
        self.assertEqual({entry['program'] for entry in manifest['builds']}, {'tx30', 'rx30'})
        for build in (first, self.build):
            paths = list((self.root / 'build').rglob(build.firmware_path('bit').name))
            self.assertEqual(paths, [build.firmware_path('bit')])
        first.sources[0].path.write_text(first.sources[0].path.read_text() + '\n-- changed\n')
        publication.publish(self.root, [self.build])
        manifest = json.loads((snapshot / 'manifest.json').read_text())
        self.assertEqual([entry['program'] for entry in manifest['builds']], ['rx30'])

    def test_failed_rebuild_invalidates_manifest_and_removes_firmware(self):
        self.run_build()
        snapshot = publication.publish(self.root, [self.build])
        with self.assertRaises(BuildError):
            self.run_build(action=lambda project, log: 'wrong tool version')
        self.assertFalse((snapshot / 'manifest.json').exists())
        self.assertFalse(self.build.firmware_path('bit').exists())


    def test_manifest_accumulates_releases_and_clean_invalidates_it(self):
        from cpld_toolchain.toolchain.buildsystem.model import load_build
        from cpld_toolchain.toolchain.buildsystem.releases import create
        from cpld_toolchain.toolchain.buildsystem.workflow import clean
        self.run_build()
        first = self.build
        create(self.root, 'next', 'original')
        self.build = load_build(self.root, 'tx30', release_cycle='next')
        self.run_build()
        output = publication.publish(self.root, [self.build])
        manifest = json.loads((output / 'manifest.json').read_text())
        self.assertEqual(manifest['release_cycles'], ['next', 'original'])
        self.assertEqual(len(manifest['builds']), 2)
        clean(self.build)
        self.assertFalse((output / 'manifest.json').exists())
        self.assertTrue(first.firmware_path('bit').is_file())
        publication.publish(self.root, [first])
        manifest = json.loads((output / 'manifest.json').read_text())
        self.assertEqual(manifest['release_cycles'], ['original'])
