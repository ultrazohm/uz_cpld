"""Keep physical programming behind explicit execution and Flash verification."""
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import xml.etree.ElementTree as ET

from programmer_helper import program
from toolchain.buildsystem.model import BuildError


class ProgramTests(unittest.TestCase):
    def test_scan_requires_expected_full_chain(self):
        scan = '\n'.join(f'index {index}:\n  idcode 0x012bb043' for index in range(5))
        self.assertEqual(len(program.check_chain('dslots', scan)), 5)
        with self.assertRaisesRegex(BuildError, 'does not match'):
            program.check_chain('dslots', scan.replace('0x012bb043', '0x012bc043', 1))
        with self.assertRaisesRegex(BuildError, 'does not match'):
            program.check_chain('dslots', scan.rsplit('index 4:', 1)[0])

    @patch.object(program, 'verified_firmware')
    @patch.object(program, 'selected_chain_builds')
    @patch.object(program, 'read_selection')
    @patch.object(program, 'resolve_release', return_value='original')
    def test_foss_plan_uses_flash_verify_for_all_positions(self, _, selection, builds, firmware):
        selection.return_value = ({i: 'tx30' for i in range(1, 6)}, 's3c_power_on_debounce')
        builds.return_value = [(f'slot{i}', i - 1, object()) for i in range(1, 6)]
        firmware.return_value = (Path('/tmp/firmware.bit'), 'abc')
        with tempfile.TemporaryDirectory() as directory:
            _, _, _, steps = program.plan(Path(directory), Path('selection.toml'), None,
                                           'dslots', 'foss', None, None)
        self.assertEqual(len(steps), 5)
        for index, step in enumerate(steps):
            self.assertEqual(step.command[step.command.index('--index-chain') + 1], str(index))
            self.assertIn('--write-flash', step.command)
            self.assertIn('--verify', step.command)
            self.assertNotIn('--write-sram', step.command)
        self.assertEqual(firmware.call_count, 5)

    def test_scan_plan_does_not_access_hardware(self):
        with patch.object(program, 'run_command') as run:
            self.assertEqual(program.main(['scan', '--chain', 's3c', '--backend', 'foss']), 0)
            run.assert_not_called()

    def test_diamond_scan_xcf_contains_only_read_operations(self):
        root = Path(__file__).resolve().parents[2]
        with tempfile.TemporaryDirectory() as directory:
            for chain, count, expected_id in [('dslots', 5, '0x012bb043'),
                                              ('s3c', 1, '0x012bc043')]:
                xcf = Path(directory) / f'{chain}.xcf'
                program.diamond_scan_xcf(root, chain, xcf, 3)
                project = ET.parse(xcf).getroot()
                devices = project.findall('./Chain/Device')
                self.assertEqual(len(devices), count)
                self.assertEqual([device.findtext('Operation') for device in devices],
                                 ['FLASH Display ID'] * count)
                self.assertEqual([device.findtext('IDCode') for device in devices],
                                 [expected_id] * count)
                self.assertTrue(all(not device.findtext('File') for device in devices))
                self.assertEqual(project.findtext('./CableOptions/PortAdd'), 'FTUSB-3')
                self.assertIsNone(project.find('./CableOptions/USBID'))

    def test_foss_scan_reports_unexpected_id_without_programming(self):
        output = 'index 0:\n  idcode 0x12345678\n'
        with patch.object(program, 'require_usb_bus'), patch.object(program, 'run_command', return_value=output):
            self.assertEqual(program.main(['scan', '--chain', 's3c', '--backend', 'foss', '--execute']), 0)

    def test_archived_usb_ports_select_probe_indices(self):
        self.assertEqual(program.cable_args('dslots', None, None, None)[-2:],
                         ['--cable-index', '1'])
        self.assertEqual(program.cable_args('s3c', None, None, None)[-2:],
                         ['--cable-index', '0'])
        self.assertEqual(program.cable_args('dslots', None, 'probe123', None)[-2:],
                         ['--usb-serial-num', 'probe123'])


if __name__ == '__main__':
    unittest.main()
