"""Keep physical programming behind explicit execution and Flash verification."""
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch
import xml.etree.ElementTree as ET

from cpld_toolchain.programmer_helper import program
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class ProgramTests(unittest.TestCase):
    def test_initial_selection_overrides_defaults_and_preserves_existing_file(self):
        from cpld_toolchain.programmer_helper.helper import read_selection
        with tempfile.TemporaryDirectory() as directory:
            selection = Path(directory) / 'selection.toml'
            self.assertEqual(program.main(['init_programmer', '--selection', str(selection),
                                          '--release', 'heartbeat_cvg', '--s3c', 's3c_heartbeat',
                                          '--dslot-1', 'cvg_tx30', '--dslot-5', 'cvg_rx30']), 0)
            slots, s3c, release, _ = read_selection(selection)
            self.assertEqual(slots, {1: 'cvg_tx30', 2: 'tx30', 3: 'tx30', 4: 'tx30', 5: 'cvg_rx30'})
            self.assertEqual((s3c, release), ('s3c_heartbeat', 'heartbeat_cvg'))
            before = selection.read_bytes()
            program.create_selection(selection, release='', s3c='other')
            self.assertEqual(selection.read_bytes(), before)
            empty = Path(directory) / 'current.toml'
            program.create_selection(empty, release='')
            self.assertIsNone(read_selection(empty)[2])
            invalid = Path(directory) / 'invalid.toml'
            with self.assertRaises(BuildError):
                program.create_selection(invalid, slots={1: '../bad'})
            self.assertFalse(invalid.exists())

    def test_build_selection_deduplicates_and_honors_release_backend_and_target(self):
        root = Path(__file__).resolve().parents[3]
        with tempfile.TemporaryDirectory() as directory:
            selection = Path(directory) / 'selection.toml'
            program.create_selection(selection, release='original', s3c='s3c_power_on_debounce',
                                     slots={i: 'tx30' for i in range(1, 6)})
            with patch.object(program, 'build_program') as build, patch(
                    'cpld_toolchain.toolchain.buildsystem.backends.diamond.preflight'), patch(
                    'cpld_toolchain.toolchain.buildsystem.publication.publish') as publish:
                program.build_selection(root, selection, backend='foss')
                configs = [call.args[0] for call in build.call_args_list]
                self.assertEqual([b.name for b in configs], ['tx30', 's3c_power_on_debounce'])
                self.assertTrue(all(b.release_cycle == 'original' and b.backend == 'foss' for b in configs))
                self.assertEqual(publish.call_args.args, (root, configs))
                build.reset_mock()
                selection.write_text('release="missing_release"\ns3c="s3c_power_on_debounce"\n')
                program.build_selection(root, selection, 'original', target='s3c')
                build.assert_called_once()
                self.assertEqual(build.call_args.args[0].target, 'uz_s3c_xo2')
                self.assertEqual(build.call_args.args[0].backend, 'diamond')

    def test_build_selection_validates_every_assignment_before_building(self):
        root = Path(__file__).resolve().parents[3]
        with tempfile.TemporaryDirectory() as directory:
            selection = Path(directory) / 'selection.toml'
            program.create_selection(selection, release='heartbeat_cvg', s3c='missing_program',
                                     slots={i: 'cvg_tx30' for i in range(1, 6)})
            with patch.object(program, 'build_program') as build:
                with self.assertRaises(BuildError):
                    program.build_selection(root, selection)
                build.assert_not_called()

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
        selection.return_value = ({i: 'tx30' for i in range(1, 6)}, 's3c_power_on_debounce', None, 'foss')
        # Each mocked build still supplies the identity used by the plan.
        builds.return_value = []
        firmware.return_value = (Path('/tmp/firmware.bit'), 'abc')
        with tempfile.TemporaryDirectory() as directory:
            metadata = Path(directory) / 'metadata'
            metadata.mkdir()
            (metadata / 'build.json').write_text('{"identity": {"usercode": "000B0001"}}')
            builds.return_value = [(f'slot{i}', i - 1, SimpleNamespace(directory=Path(directory))) for i in range(1, 6)]
            _, _, _, steps = program.plan(Path(directory), Path('selection.toml'), None,
                                           'dslots', 'foss', None, None)
        self.assertEqual(len(steps), 5)
        for index, step in enumerate(steps):
            self.assertEqual(step.command[step.command.index('--cable') + 1], 'ft4232_b')
            self.assertEqual(step.command[step.command.index('--cable-index') + 1], '0')
            self.assertEqual(step.command[step.command.index('--index-chain') + 1], str(index))
            self.assertIn('--write-flash', step.command)
            self.assertIn('--verify', step.command)
            self.assertNotIn('--write-sram', step.command)
        self.assertEqual(firmware.call_count, 5)

    def test_scan_plan_does_not_access_hardware(self):
        with patch.object(program, 'run_command') as run:
            self.assertEqual(program.main(['scan', '--chain', 's3c', '--programmer-backend', 'foss']), 0)
            run.assert_not_called()

    def test_blank_selection_cannot_reach_hardware(self):
        with tempfile.TemporaryDirectory() as directory:
            selection = Path(directory) / 'selection.toml'
            selection.write_text('release = ""\ns3c = ""\n[slots]\n' +
                                 ''.join(f'"{i}" = ""\n' for i in range(1, 6)))
            for target in ('s3c', 'dslot'):
                with self.subTest(target=target), patch.object(program, 'run_command') as run:
                    with self.assertRaises(SystemExit) as error:
                        program.main(['program', '--target', target, '--selection', str(selection),
                                      '--execute'])
                    self.assertEqual(error.exception.code, 2)
                    run.assert_not_called()

    def test_diamond_scan_xcf_contains_only_read_operations(self):
        root = Path(__file__).resolve().parents[3]
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
                program.diamond_scan_xcf(root, chain, xcf)
                self.assertEqual(ET.parse(xcf).findtext('./CableOptions/PortAdd'), 'FTUSB-1')

    def test_foss_scan_reports_unexpected_id_without_programming(self):
        output = 'index 0:\n  idcode 0x12345678\n'
        with patch.object(program, 'require_usb_bus'), patch.object(program, 'run_command', return_value=output):
            self.assertEqual(program.main(['scan', '--chain', 's3c', '--programmer-backend', 'foss', '--execute']), 0)

    def test_foss_targets_use_same_ft4232_channel_and_first_probe(self):
        for chain in ('s3c', 'dslots'):
            command = program.scan_command(chain, None, None)
            self.assertEqual(command[command.index('--cable') + 1], 'ft4232_b')
            self.assertEqual(command[command.index('--cable-index') + 1], '0')
            self.assertIn('--detect', command)

    def test_foss_probe_overrides_are_preserved(self):
        self.assertEqual(program.cable_args('dslots', 'ft2232', None, 2),
                         ['--cable', 'ft2232', '--freq', '1000000', '--cable-index', '2'])
        self.assertEqual(program.cable_args('dslots', None, 'probe123', None)[-2:],
                         ['--usb-serial-num', 'probe123'])


if __name__ == '__main__':
    unittest.main()
