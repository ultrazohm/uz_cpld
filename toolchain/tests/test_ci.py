"""Release archives reject stale or incomplete firmware and retain identity evidence."""
import hashlib
import json
from pathlib import Path
from unittest.mock import patch
import unittest
from zipfile import ZipFile

from toolchain import ci
from toolchain.buildsystem.model import BuildError
from toolchain.tests import test_buildsystem as fixtures


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
        with patch.object(ci.subprocess, 'check_output', return_value='a' * 40):
            return ci.package(self.root, self.output)

    def test_archive_contains_verified_exports_and_registry(self):
        self.prepare()
        self.package()
        with ZipFile(self.output) as archive:
            manifest = json.loads(archive.read('manifest.json'))
            self.assertEqual(manifest['git_revision'], 'a' * 40)
            self.assertEqual(manifest['release_cycles'], ['original'])
            self.assertEqual(manifest['identity_registry'], ci.read_registry(self.root))
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
