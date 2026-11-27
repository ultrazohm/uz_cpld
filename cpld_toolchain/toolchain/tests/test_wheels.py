"""Public package boundaries, release policy and native asset ownership."""
import json
import os
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from zipfile import ZipFile

from distribution import wheels
from cpld_toolchain.toolchain import firmware_download as downloads
from cpld_toolchain.toolchain.buildsystem.model import BuildError


def publication_wheel(directory, platform, *, version='0.6.0.dev123001', commit='a' * 40):
    path = directory / f'ultrazohm_cpld_user-{version}-py3-none-{platform}.whl'
    with ZipFile(path, 'w') as archive:
        base = f'ultrazohm_cpld_user-{version}.dist-info'
        archive.writestr(f'{base}/METADATA', f'Name: ultrazohm-cpld-user\nVersion: {version}\n')
        archive.writestr(f'{base}/WHEEL', f'Tag: py3-none-{platform}\n')
        archive.writestr('cpld_toolchain/application.json', json.dumps(dict(version=version, git_revision=commit)))
        archive.writestr('cpld_toolchain/bundled_tools/release.json', json.dumps(
            dict(version=version, git_revision=commit, platform=platform)))
    return path


class WheelTests(unittest.TestCase):
    def test_user_stage_has_only_runtime_dependencies_and_programmer_entrypoints(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            wheels.stage_user(root, '0.6.0.dev42', 'a' * 40)
            from cpld_toolchain.toolchain.buildsystem.model import read_toml
            project = read_toml(root / 'pyproject.toml')['project']
            self.assertEqual(project['name'], 'ultrazohm-cpld-user')
            self.assertEqual(project['dependencies'], ['certifi==2026.7.22'])
            self.assertEqual(project['scripts'], {'uz_cpld': 'cpld_toolchain.user:main'})
            self.assertEqual(project['gui-scripts'], {'uz_cpld_gui': 'cpld_toolchain.user:gui'})
            self.assertFalse(list(root.rglob('test_*.py')))
            self.assertFalse((root / 'programs').exists())
            self.assertIn('0.6.0.dev42', (root / 'cpld_toolchain/__init__.py').read_text())

    def test_prerelease_versions_are_distinct_on_reruns(self):
        with patch.dict(os.environ, GITHUB_RUN_ID='123', GITHUB_RUN_ATTEMPT='1'):
            first = wheels.release_version()
        with patch.dict(os.environ, GITHUB_RUN_ID='123', GITHUB_RUN_ATTEMPT='2'):
            second = wheels.release_version()
        self.assertNotEqual(first, second)
        self.assertTrue(first.startswith('0.6.0.dev'))

    def test_publication_retry_uses_the_artifact_version(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for platform in wheels.PLATFORMS:
                publication_wheel(root, platform)
            with patch.dict(os.environ, GITHUB_RUN_ID='123', GITHUB_RUN_ATTEMPT='2'):
                self.assertNotEqual(wheels.release_version(), '0.6.0.dev123001')
                self.assertEqual(wheels.publication_version(root, 'a' * 40), '0.6.0.dev123001')

    def test_publication_rejects_missing_platform_and_mixed_versions(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            publication_wheel(root, wheels.PLATFORMS[0])
            with self.assertRaisesRegex(ValueError, 'each supported platform'):
                wheels.publication_version(root, 'a' * 40)
            publication_wheel(root, wheels.PLATFORMS[1], version='0.6.0.dev123002')
            with self.assertRaisesRegex(ValueError, 'same version'):
                wheels.publication_version(root, 'a' * 40)

    def test_publication_rejects_another_commit_and_stable_versions(self):
        for version, expected in [('0.6.0.dev123001', 'workflow commit'), ('0.6.0', 'prerelease')]:
            with self.subTest(version=version), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                for platform in wheels.PLATFORMS:
                    publication_wheel(root, platform, version=version, commit='b' * 40)
                with self.assertRaisesRegex(ValueError, expected):
                    wheels.publication_version(root, 'a' * 40)

    def test_stable_download_never_falls_back_to_testing(self):
        testing = ({'id': 1, 'prerelease': True}, {}, 'a' * 40)
        stable = ({'id': 2, 'tag_name': 'v1', 'body': '', 'prerelease': False}, {}, 'b' * 40)
        with patch.object(downloads, 'published', return_value=[testing, stable]), \
                patch.object(downloads, 'download_asset', return_value=Path('firmware.zip')) as download:
            downloads.download_stable(Path('/workspace'))
            self.assertEqual(download.call_args.args[3], stable[0])
        with patch.object(downloads, 'published', return_value=[testing]), \
                patch.object(downloads, 'download_asset') as download:
            with self.assertRaisesRegex(BuildError, 'No stable firmware'):
                downloads.download_stable(Path('/workspace'))
            download.assert_not_called()

    def test_user_wheel_cannot_be_built_without_a_bundled_programmer(self):
        import types
        args = types.SimpleNamespace(version='0.6.0.dev42', platform=None, loader=None)
        with self.assertRaisesRegex(ValueError, 'bundle its programmer'):
            wheels.build(args)
