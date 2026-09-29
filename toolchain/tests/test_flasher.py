"""Pinned flasher provenance and parser checks without USB access."""
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.foss import flasher


class FlasherTests(unittest.TestCase):
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
