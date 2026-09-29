"""Pinned flasher provenance and parser checks without USB access."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.foss import flasher


class FlasherTests(unittest.TestCase):
    def test_installation_is_readable_and_executable_by_container_runtime_user(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            binary, license_file = root / 'built-loader', root / 'license'
            binary.write_bytes(b'compiled loader')
            license_file.write_text('license')
            output = root / 'installed'
            old_mask = os.umask(0o077)
            try:
                flasher.publish(binary, license_file, output, flasher.pin())
            finally:
                os.umask(old_mask)
            self.assertEqual((output / 'openFPGALoader').stat().st_mode & 0o777, 0o755)
            self.assertEqual((output / flasher.RECEIPT).stat().st_mode & 0o777, 0o644)
            self.assertEqual(output.stat().st_mode & 0o777, 0o755)
            self.assertEqual(flasher.verify(output / 'openFPGALoader')['binary_sha256'], flasher.digest(binary))

    def test_explicit_missing_archive_does_not_download(self):
        with tempfile.TemporaryDirectory() as directory, patch.object(flasher.subprocess, 'run') as run:
            root = Path(directory)
            with self.assertRaises(FileNotFoundError):
                flasher.build(root / 'output', archive=root / 'missing.tar.gz')
            run.assert_not_called()

    def test_tracked_patch_matches_pin(self):
        self.assertEqual(flasher.pin()['capability'], 'v1.1.1-uz-usercode1')

    def test_binary_and_pin_must_match_receipt(self):
        with tempfile.TemporaryDirectory() as directory:
            binary = Path(directory) / 'openFPGALoader'
            binary.write_bytes(b'fixture binary')
            with self.assertRaisesRegex(ValueError, 'verified USERCODE-capable'):
                flasher.verify(binary)
            record = {'pin': flasher.pin(), 'binary_sha256': flasher.digest(binary)}
            receipt = binary.parent / flasher.RECEIPT
            receipt.write_text(json.dumps(record))
            self.assertEqual(flasher.verify(binary), record)
            binary.write_bytes(b'modified binary')
            with self.assertRaisesRegex(ValueError, 'provenance does not match'):
                flasher.verify(binary)
            record['binary_sha256'] = flasher.digest(binary)
            record['pin']['capability'] = 'stale'
            receipt.write_text(json.dumps(record))
            with self.assertRaisesRegex(ValueError, 'provenance does not match'):
                flasher.verify(binary)

    def test_file_check_uses_parser_only_and_propagates_rejection(self):
        result = subprocess.CompletedProcess([], 0, 'parsed', '')
        with patch.object(flasher.subprocess, 'run', return_value=result) as run:
            self.assertEqual(flasher.check_file('/loader', '/file.jed', '00010001'), 'parsed')
            self.assertEqual(run.call_args.args[0],
                             ['/loader', '--check-file', '--usercode', '00010001', '/file.jed'])
            result.returncode = 1
            result.stderr = 'USERCODE mismatch'
            with self.assertRaisesRegex(ValueError, 'before USB access.*USERCODE mismatch'):
                flasher.check_file('/loader', '/file.jed', '00010001')


if __name__ == '__main__':
    unittest.main()
