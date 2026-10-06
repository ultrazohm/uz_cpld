"""Branch selection, release pagination and verified atomic firmware downloads."""
import hashlib
import io
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from urllib.request import Request
from zipfile import ZipFile

from cpld_toolchain.toolchain import firmware_download as firmware
from cpld_toolchain.toolchain.buildsystem.model import BuildError

COMMIT = 'a' * 40


def release(number, ref='refs/heads/topic', date='2026-10-06T12:00:00Z', **changes):
    result = {'id': number, 'tag_name': f'firmware-ci-{number}-1', 'draft': False,
              'prerelease': True, 'published_at': date,
              'body': f'Source commit: {COMMIT}\nSource ref: {ref}\n',
              'assets': [{'id': number, 'name': firmware.ASSET, 'state': 'uploaded'}]}
    result.update(changes)
    return result


def archive_bytes(*, corrupt=False, commit=COMMIT, filename='original/tx30/uz_dslot_xo2/firmware.bit'):
    stream = io.BytesIO()
    payload = b'firmware'
    manifest = {'schema_version': 1, 'git_revision': commit, 'backend': 'diamond',
                'identity_registry': {}, 'builds': [{'files': {filename: hashlib.sha256(payload).hexdigest()}}]}
    with ZipFile(stream, 'w') as archive:
        archive.writestr('manifest.json', json.dumps(manifest))
        archive.writestr(filename, b'changed' if corrupt else payload)
    return stream.getvalue()


class DownloadTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)

    def test_upstream_branch_remote_and_url_forms(self):
        subprocess.run(['git', 'init', '-q', str(self.root)], check=True)
        subprocess.run(['git', '-C', str(self.root), 'symbolic-ref', 'HEAD', 'refs/heads/local-topic'], check=True)
        for key, value in [('branch.local-topic.remote', 'upstream'),
                           ('branch.local-topic.merge', 'refs/heads/topic/firmware')]:
            subprocess.run(['git', '-C', str(self.root), 'config', key, value], check=True)
        for url in ('git@github.com:owner/repo.git', 'https://github.com/owner/repo.git',
                    'ssh://git@github.com/owner/repo.git'):
            subprocess.run(['git', '-C', str(self.root), 'config', 'remote.upstream.url', url], check=True)
            self.assertEqual(firmware.source(self.root), ('owner/repo', 'refs/heads/topic/firmware'))
        subprocess.run(['git', '-C', str(self.root), 'config', 'remote.origin.url', 'https://github.com/fork/repo'], check=True)
        self.assertEqual(firmware.source(self.root, 'origin'), ('fork/repo', 'refs/heads/local-topic'))

    def test_detached_head_fails_before_network_access(self):
        with patch.object(firmware, 'git', return_value=''), patch.object(firmware, 'request') as network:
            with self.assertRaisesRegex(BuildError, 'checked-out Git branch'):
                firmware.download(self.root)
        network.assert_not_called()

    def test_origin_is_default_without_upstream(self):
        with patch.object(firmware, 'git', side_effect=['topic', '', 'git@github.com:owner/repo.git']):
            self.assertEqual(firmware.source(self.root), ('owner/repo', 'refs/heads/topic'))

    def test_newest_branch_release_includes_prereleases_and_all_pages(self):
        page1 = [release(1, date='2026-10-01T00:00:00Z')] + [release(2, 'refs/heads/master')] * 99
        page2 = [release(3), release(4, 'refs/tags/topic'), release(5, draft=True), release(6, assets=[])]
        with patch.object(firmware, 'request', side_effect=[io.BytesIO(json.dumps(page1).encode()),
                                                           io.BytesIO(json.dumps(page2).encode())]) as request:
            selected, asset, commit = firmware.latest('owner/repo', 'refs/heads/topic')
        self.assertEqual(selected['id'], 3)
        self.assertEqual(commit, COMMIT)
        self.assertIn('page=2', request.call_args.args[0])

    def test_no_branch_release_never_falls_back_to_default_branch(self):
        with patch.object(firmware, 'request', return_value=io.BytesIO(json.dumps([release(1, 'refs/heads/master')]).encode())):
            with self.assertRaisesRegex(BuildError, 'No published CI firmware'):
                firmware.latest('owner/repo', 'refs/heads/topic')

    def test_crlf_release_notes_match_exact_branch(self):
        selected = release(1)
        selected['body'] = selected['body'].replace('\n', '\r\n')
        with patch.object(firmware, 'request', return_value=io.BytesIO(json.dumps([selected]).encode())):
            self.assertEqual(firmware.latest('owner/repo', 'refs/heads/topic')[0]['id'], 1)

    def test_download_validates_and_publishes_without_extracting(self):
        payload = archive_bytes()
        selected = release(1)
        asset = dict(selected['assets'][0], size=len(payload), digest='sha256:' + hashlib.sha256(payload).hexdigest())
        with patch.object(firmware, 'source', return_value=('owner/repo', 'refs/heads/topic')), \
             patch.object(firmware, 'latest', return_value=(selected, asset, COMMIT)), \
             patch.object(firmware, 'request', return_value=io.BytesIO(payload)):
            result = firmware.download(self.root)
        self.assertEqual(result, self.root / 'build/downloads/firmware-ci-1-1' / firmware.ASSET)
        self.assertEqual(result.read_bytes(), payload)
        self.assertFalse((self.root / 'build/diamond').exists())
        self.assertEqual(list(result.parent.iterdir()), [result])

    def test_bad_download_preserves_existing_output(self):
        destination = self.root / 'download.zip'
        destination.write_bytes(b'existing')
        for payload in (archive_bytes(corrupt=True), archive_bytes(commit='b' * 40),
                        archive_bytes(filename='../outside.bit'), b'not a zip'):
            selected = release(1)
            asset = dict(selected['assets'][0], size=len(payload))
            with self.subTest(payload=payload[:10]), \
                 patch.object(firmware, 'source', return_value=('owner/repo', 'refs/heads/topic')), \
                 patch.object(firmware, 'latest', return_value=(selected, asset, COMMIT)), \
                 patch.object(firmware, 'request', return_value=io.BytesIO(payload)):
                self.assertEqual(firmware.main(['--root', str(self.root), '--output', str(destination)]), 1)
            self.assertEqual(destination.read_bytes(), b'existing')
            self.assertEqual(list(self.root.iterdir()), [destination])

    def test_asset_digest_and_size_are_checked(self):
        destination = self.root / 'firmware.zip'
        destination.write_bytes(archive_bytes())
        for asset in ({'size': 0}, {'size': destination.stat().st_size, 'digest': 'sha256:' + '0' * 64}):
            with self.assertRaises(BuildError):
                firmware.verify(destination, COMMIT, asset)

    def test_redirect_drops_api_credentials_on_storage_host(self):
        request = Request('https://api.github.com/repos/owner/repo/releases/assets/1',
                          headers={'Authorization': 'Bearer private'})
        redirect = firmware.AssetRedirect().redirect_request(request, None, 302, '', {},
                                                             'https://release-assets.githubusercontent.com/file')
        self.assertIsNone(redirect.get_header('Authorization'))
        with self.assertRaisesRegex(BuildError, 'non-HTTPS'):
            firmware.AssetRedirect().redirect_request(request, None, 302, '', {}, 'http://example.com/file')


    def test_malformed_manifest_is_a_download_error(self):
        destination = self.root / 'firmware.zip'
        for manifest in ([], {'schema_version': 1, 'git_revision': COMMIT,
                             'backend': 'diamond', 'identity_registry': {}, 'builds': ['invalid']}):
            with ZipFile(destination, 'w') as archive:
                archive.writestr('manifest.json', json.dumps(manifest))
            with self.assertRaises(BuildError):
                firmware.verify(destination, COMMIT, {'size': destination.stat().st_size})
