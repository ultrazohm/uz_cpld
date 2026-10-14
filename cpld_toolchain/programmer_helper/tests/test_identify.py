"""Read-only identity command and strict readback parsing, without USB access."""
from contextlib import nullcontext, redirect_stdout
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain.programmer_helper import identify, program, foss
from cpld_toolchain.toolchain.buildsystem.identity import reserve_program
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class IdentifyTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        (self.root / 'programs').mkdir()
        (self.root / 'programs/usercodes.json').write_text('{"schema_version":1,"next_program":1,"programs":{}}')
        reserve_program(self.root, 'example', 'original')

    def test_parser_records_raw_identity_and_unknown_firmware(self):
        raw = 'UZ_IDENTITY 0 012bc043 00010001 120123456789abcd\n'
        device = identify.parse(self.root, 's3c', raw)[0]
        self.assertEqual(device['silicon_id'], '0123456789ABCD')
        self.assertEqual(device['identity']['program'], 'original/example')
        self.assertFalse(device['identity']['known_build'])
        device = identify.parse(self.root, 's3c', raw.replace('00010001', 'badc0ded'))[0]
        self.assertIsNone(device['identity'])
        for invalid in ('', raw + raw, raw.replace('012bc043', '012bb043'), raw.replace('0 012', '1 012')):
            with self.subTest(invalid=invalid), self.assertRaises(BuildError):
                identify.parse(self.root, 's3c', invalid)

    def test_readback_writes_receipt_and_uses_interface_lock(self):
        raw = 'UZ_IDENTITY_V1 0 012bc043 00010001 00010001 120123456789abcd\nUZ_IDENTITY_END_V1 1\n'
        with patch.object(identify, 'preflight'), patch.object(foss.flasher, 'verify', return_value={}), \
                patch.object(foss, 'diamond_usb', return_value=nullcontext()) as usb, \
                patch.object(foss, 'run', return_value=raw) as run:
            devices = identify.identify(self.root, 's3c', backend='foss')
        usb.assert_called_once_with(1, serial=None)
        run.assert_called_once()
        receipt = next((self.root / 'build/programmer/identification').glob('*/identity.json'))
        self.assertEqual(json.loads(receipt.read_text())['devices'], devices)

    def test_preview_never_runs_a_hardware_command(self):
        with patch.object(program, 'run_command') as run, redirect_stdout(io.StringIO()) as output:
            self.assertEqual(program.main(['identify', '--root', str(self.root), '--target', 's3c']), 0)
        run.assert_not_called()
        self.assertIn('Diamond identify: s3c on FTUSB-1', output.getvalue())
        self.assertIn('XFLASH Display USERCODE', output.getvalue())
        self.assertNotIn('irscan', output.getvalue())

    def test_identify_auto_detects_s3c_and_reads_without_a_registry(self):
        (self.root / 'programs/usercodes.json').unlink()
        raw = 'UZ_IDENTITY_V1 0 012bc043 00010001 00010001 120123456789abcd\nUZ_IDENTITY_END_V1 1\n'
        with patch.object(identify, 'preflight'), patch.object(program, 'require_usb_bus'), \
                patch.object(program, 'loader_path', return_value=Path('/loader')), \
                patch.object(foss.flasher, 'verify', return_value={}), \
                patch.object(identify, 'diamond_usb', return_value=nullcontext()), \
                patch.object(foss, 'diamond_usb', return_value=nullcontext()), \
                patch.object(foss, 'run', side_effect=['index 0:\n idcode 0x012BC043\n', raw]):
            devices = identify.identify(self.root, backend='foss')
        self.assertEqual(devices[0]['label'], 's3c')
        self.assertIsNone(devices[0]['identity'])

    def test_discovery_rejects_partial_and_unexpected_chains(self):
        for raw in ('index 0:\n idcode 0x012BB043\n', 'index 0:\n idcode 0xDEADBEEF\n'):
            with self.subTest(raw=raw), patch.object(program, 'require_usb_bus'), \
                    patch.object(program, 'loader_path', return_value=Path('/loader')), \
                    patch.object(identify, 'diamond_usb', return_value=nullcontext()), \
                    patch.object(foss, 'run', return_value=raw):
                with self.assertRaisesRegex(BuildError, 'neither S3C'):
                    identify.detect_chain(self.root, 'foss', None, None, None, self.root)

    def test_execute_identify_without_target_requests_discovery(self):
        with patch.object(identify, 'identify') as read, redirect_stdout(io.StringIO()):
            self.assertEqual(program.main(['identify', '--root', str(self.root), '--execute']), 0)
        self.assertIsNone(read.call_args.args[1])

    def test_diamond_discovery_tries_read_only_s3c_after_dslot_mismatch(self):
        raw = 'Device1 LCMXO2-4000HC: FLASH Display ID\nID: 0x012BC043\nOperation Done. No errors.\n'
        with patch.object(program, 'require_usb_bus'), \
                patch.object(program, 'run_diamond', side_effect=[BuildError('Chain mismatch'), raw]) as run:
            self.assertEqual(identify.detect_chain(self.root, 'diamond', None, None, None, self.root), 's3c')
        self.assertEqual(run.call_count, 2)
        for path in self.root.glob('detect-*.xcf'):
            self.assertIn('FLASH Display ID', path.read_text())
            self.assertNotIn('Erase,Program', path.read_text())

    def test_diamond_never_requires_or_invokes_foss(self):
        raw = 'UZ_IDENTITY 0 012bc043 00010001 120123456789abcd\n'
        with patch.object(foss, 'session', side_effect=AssertionError('FOSS tool')), \
                patch.object(identify, 'diamond_read', return_value=raw) as read:
            identify.programming_preflight('diamond')
            devices = identify.identify(self.root, 's3c')
        read.assert_called_once()
        self.assertEqual(devices[0]['usercode'], '00010001')

    def test_diamond_read_uses_vendor_logs_and_native_chain_order(self):
        root = Path(__file__).resolve().parents[3]
        expected = {'idcode': '012BB043', 'usercode': '00010001', 'traceid': '0044381228405816'}
        def run(command, stdout_log, **kwargs):
            key = Path(command[2]).stem
            _, _, operation, field, _ = next(item for item in identify.DIAMOND_READS if item[0] == key)
            text = ''.join(f'Device{i} LCMXO2-2000HC: {operation}\n'
                           f'{field} : 0x{expected[key]}.\nOperation Done. No errors.\n'
                           for i in range(1, 6))
            Path(command[-1]).write_text(text)
            return text  # Deliberately duplicated on stdout, as pgrcmd does.
        with patch.object(identify, 'diamond_usb', return_value=nullcontext()) as usb, \
                patch.object(program, 'run_command', side_effect=run) as command, \
                patch.object(foss, 'session', side_effect=AssertionError('FOSS tool')):
            raw = identify.diamond_read(root, 'dslots', self.root, None)
        usb.assert_called_once_with(1)
        self.assertEqual(command.call_count, 3)
        devices = identify.parse(self.root, 'dslots', raw)
        self.assertEqual(devices[0]['traceid'], expected['traceid'])
        self.assertEqual(devices[0]['label'], 'slot1')

    def test_diamond_parser_binds_values_to_positions(self):
        for _, _, operation, field, width in identify.DIAMOND_READS:
            value = '0' * (width - 1) + '1'
            blocks = [f'Device{i} LCMXO2-2000HC: {operation}\n{field}: 0x{value}\n'
                      'Operation Done. No errors.\n' for i in range(1, 6)]
            raw = ''.join(blocks)
            self.assertEqual(identify.parse_diamond('dslots', raw, operation, field, width), [value] * 5)
            for invalid in (''.join(blocks[:-1]), raw + blocks[-1],
                            raw.replace('Device2', 'Device1'), raw.replace('No errors.', 'Failed.')):
                with self.assertRaises(BuildError):
                    identify.parse_diamond('dslots', invalid, operation, field, width)

    def test_diamond_xcfs_use_only_transparent_display_operations(self):
        import xml.etree.ElementTree as ET
        root = Path(__file__).resolve().parents[3]
        for chain, count in (('s3c', 1), ('dslots', 5)):
            for key, mode, operation, _, _ in identify.DIAMOND_READS:
                xcf = self.root / f'{key}.xcf'
                identify.diamond_xcf(root, chain, xcf, mode, operation)
                tree = ET.parse(xcf)
                devices = tree.findall('./Chain/Device')
                self.assertEqual(len(devices), count)
                self.assertIn('<!DOCTYPE ispXCF', xcf.read_text())
                for device in devices:
                    self.assertEqual(device.findtext('Operation'), operation)
                    self.assertEqual(device.findtext('Option/AccessMode'), mode)
                    self.assertFalse(device.findtext('File'))
                self.assertNotIn('FLASH Display USERCODE</Operation>', xcf.read_text().replace('XFLASH', 'TRANSPARENT'))

    def test_explicit_foss_preview(self):
        for flag in ('--programmer-backend',):
            with redirect_stdout(io.StringIO()) as output:
                program.main(['identify', flag, 'foss'])
            self.assertIn('--read-identity', output.getvalue())

    def test_unsupported_probe_is_rejected_before_hardware(self):
        for backend, index in (('diamond', 0), ('foss', 1)):
            with self.assertRaisesRegex(BuildError, 'Identity readback supports'):
                identify.preflight(backend, probe_index=index)

    def test_foss_programming_without_usercode_support_never_reaches_hardware(self):
        with patch.object(program, 'loader_path', return_value=Path(__file__)), \
                patch.object(program, 'run_command') as run:
            with self.assertRaisesRegex(BuildError, 'verified USERCODE-capable flasher'):
                program.execute(self.root, 'original', 's3c', 'foss', self.root, [], [], None, None)
            run.assert_not_called()
