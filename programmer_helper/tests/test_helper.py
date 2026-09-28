"""Check chain selection, release isolation, and stale firmware refusal."""
import json
from pathlib import Path
import shutil
import tempfile
import unittest
import xml.etree.ElementTree as ET

from programmer_helper.helper import generate, main as project_main, read_selection, slot_assignments
from programmer_helper.program import plan
from toolchain.buildsystem.model import BuildError, load_build
from toolchain.buildsystem.workflow import digest, hashes


ROOT = Path(__file__).resolve().parents[2]
PROGRAMS = ('tx30', 'rx30', 'uz_d_resolver_d4_4inverter_sdifix',
            'uz_d_resolver_d5_4inverter_sdifix', 's3c_power_on_debounce')
SLOTS = {1: 'rx30', 2: 'tx30', 3: 'tx30',
         4: 'uz_d_resolver_d5_4inverter_sdifix',
         5: 'uz_d_resolver_d4_4inverter_sdifix'}


class ProgrammerHelperTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix='cpld programmer ')
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for folder in ('toolchain/buildsystem', 'toolchain/targets'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('__pycache__'))
        for template in (
            'archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/Programm_All_5_Slots.xcf',
            'archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/s3c_programmer.xcf',
        ):
            destination = self.root / template
            destination.parent.mkdir(parents=True)
            shutil.copy2(ROOT / template, destination)
        (self.root / 'programs').mkdir()
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        for cycle in ('original', 'old'):
            directory = self.root / 'programs' / cycle
            directory.mkdir()
            (directory / 'catalog.toml').write_text('programs = []\n')
            for name in PROGRAMS:
                shutil.copytree(ROOT / 'programs/original' / name, directory / name,
                                ignore=shutil.ignore_patterns('build', '__pycache__'))
                self.publish(cycle, name)

    def publish(self, cycle, name):
        build = load_build(self.root, name, backend='diamond', release_cycle=cycle)
        jed = build.firmware_path('jed')
        jed.parent.mkdir(parents=True, exist_ok=True)
        checksum = '1234' if cycle == 'original' else '5678'
        jed.write_bytes(f'\x02\nC{checksum}*\nUH00000000*\n\x03'.encode())
        metadata = jed.parent / 'metadata'
        metadata.mkdir()
        (metadata / 'status.json').write_text('{"status":"success"}\n')
        (metadata / 'build.json').write_text(json.dumps({
            'status': 'success', 'inputs': hashes(build),
            'outputs': {jed.name: digest(jed)}, 'warnings': [],
        }))

    def test_all_positions_are_user_supplied(self):
        with self.assertRaisesRegex(BuildError, 'missing: 5'):
            slot_assignments(['1=tx30', '2=tx30', '3=rx30', '4=tx30'])
        with self.assertRaisesRegex(BuildError, 'more than once'):
            slot_assignments(['1=tx30', '1=rx30'])

    def test_selection_file_requires_all_programs(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c = "s3c_power_on_debounce"\n[slots]\n"1" = "tx30"\n')
        with self.assertRaisesRegex(BuildError, 'missing: 2, 3, 4, 5'):
            read_selection(selection)
        selection.write_text('s3c = "s3c_power_on_debounce"\n[slots]\n' +
                             ''.join(f'"{position}" = "{program}"\n'
                                     for position, program in SLOTS.items()))
        self.assertEqual(read_selection(selection), (SLOTS, 's3c_power_on_debounce', None))

    def test_programming_uses_selection_release_with_cli_override(self):
        selection = self.root / 'selection.toml'
        for value, override, expected in [('old', None, 'old'), ('', None, 'original'),
                                           ('old', 'original', 'original')]:
            with self.subTest(value=value, override=override):
                selection.write_text(f'release = "{value}"\ns3c = "s3c_power_on_debounce"\n')
                cycle, _, builds, _ = plan(self.root, selection, override, 's3c', 'diamond', None, None)
                self.assertEqual(cycle, expected)
                self.assertEqual(builds[0][2].release_cycle, expected)
        selection.write_text('release = "missing"\ns3c = "s3c_power_on_debounce"\n')
        with self.assertRaisesRegex(BuildError, 'Unknown release cycle'):
            plan(self.root, selection, None, 's3c', 'diamond', None, None)

    def test_project_uses_selection_release_with_cli_override(self):
        selection = self.root / 'selection.toml'
        selection.write_text('release = "old"\ns3c = "s3c_power_on_debounce"\n[slots]\n' +
                             ''.join(f'"{i}" = "tx30"\n' for i in range(1, 6)))
        for extra, expected in [([], 'old'), (['--release-cycle', 'original'], 'original')]:
            with self.subTest(expected=expected):
                self.assertEqual(project_main(['--root', str(self.root), '--selection', str(selection),
                                               *extra]), 0)
                output = self.root / 'toolchain/build/programmer' / expected
                receipt = json.loads((output / 'selection.json').read_text())
                self.assertEqual(receipt['release_cycle'], expected)
                self.assertTrue((output / 'dslots.xcf').is_file())
                self.assertTrue((output / 's3c.xcf').is_file())

    def test_selection_rejects_invalid_release(self):
        selection = self.root / 'selection.toml'
        for value in ['123', 'false', '[]', '"../old"']:
            with self.subTest(value=value):
                selection.write_text(f'release = {value}\ns3c = "s3c_power_on_debounce"\n')
                with self.assertRaises(BuildError):
                    read_selection(selection, chain='s3c')

    def test_selected_release_populates_both_chains(self):
        output = generate(self.root, SLOTS, 's3c_power_on_debounce', 'old')
        slot_tree = ET.parse(output / 'dslots.xcf')
        devices = slot_tree.findall('./Chain/Device')
        self.assertEqual([int(item.findtext('Pos')) for item in devices], [1, 2, 3, 4, 5])
        self.assertEqual([Path(item.findtext('File')).parent.parent.parent.name for item in devices],
                         [SLOTS[position] for position in range(1, 6)])
        self.assertEqual([Path(item.findtext('File')).parent.parent.parent.parent.name for item in devices],
                         ['old'] * 5)
        self.assertTrue(all(item.findtext('JedecChecksum') == '0x5678' for item in devices))
        self.assertIsNone(slot_tree.find('./CableOptions/USBID'))
        s3c = ET.parse(output / 's3c.xcf').find('./Chain/Device')
        self.assertEqual(s3c.findtext('Name'), 'LCMXO2-4000HC')
        self.assertEqual(s3c.findtext('JedecChecksum'), '0x5678')
        receipt = json.loads((output / 'selection.json').read_text())
        self.assertEqual(receipt['release_cycle'], 'old')
        self.assertEqual(receipt['slots']['4'], SLOTS[4])
        current = generate(self.root, SLOTS, 's3c_power_on_debounce')
        self.assertEqual(current.name, 'original')
        self.assertEqual(ET.parse(current / 's3c.xcf').findtext('./Chain/Device/JedecChecksum'), '0x1234')

    def test_stale_build_is_rejected_before_writing_xcf(self):
        source = self.root / 'programs/original/tx30/tx30.vhdl'
        source.write_text(source.read_text() + '\n-- changed\n')
        with self.assertRaisesRegex(BuildError, 'stale'):
            generate(self.root, SLOTS, 's3c_power_on_debounce')
        self.assertFalse((self.root / 'toolchain/build/programmer/original/dslots.xcf').exists())

    def test_wrong_target_is_rejected(self):
        with self.assertRaisesRegex(BuildError, 'does not support'):
            generate(self.root, {**SLOTS, 1: 's3c_power_on_debounce'}, 's3c_power_on_debounce')

    def test_s3c_plan_needs_no_slot_builds_and_honors_usb_port(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c = "s3c_power_on_debounce"\n[slots]\n"1" = ""\n')
        # Unrelated D-slot firmware is stale and must not prevent an S3C plan.
        source = self.root / 'programs/original/tx30/tx30.vhdl'
        source.write_text(source.read_text() + '\n-- changed\n')
        _, output, builds, steps = plan(self.root, selection, None, 's3c', 'diamond',
                                        None, None, 1)
        self.assertEqual([label for label, _, _ in builds], ['s3c'])
        self.assertFalse((output / 'dslots.xcf').exists())
        project = ET.parse(steps[0].artifact)
        self.assertEqual(project.findtext('./CableOptions/PortAdd'), 'FTUSB-1')
        self.assertEqual(project.findtext('./Chain/Device/Operation'), 'FLASH Erase,Program,Verify')
        receipt = json.loads((output / 'selection.json').read_text())
        self.assertEqual(set(receipt['firmware_sha256']), {'s3c'})
        self.assertEqual(receipt['xcf_sha256']['s3c.xcf'], steps[0].sha256)

    def test_dslot_plan_needs_all_slots_but_no_s3c(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c = ""\n[slots]\n' + ''.join(
            f'"{position}" = "{name}"\n' for position, name in SLOTS.items()))
        _, output, builds, steps = plan(self.root, selection, None, 'dslots', 'diamond',
                                        None, None, 0)
        self.assertEqual(len(builds), 5)
        self.assertFalse((output / 's3c.xcf').exists())
        project = ET.parse(steps[0].artifact)
        self.assertEqual(project.findtext('./CableOptions/PortAdd'), 'FTUSB-0')
        self.assertEqual(len(project.findall('./Chain/Device')), 5)
        selection.write_text('s3c = ""\n[slots]\n"1" = "tx30"\n')
        with self.assertRaisesRegex(BuildError, 'missing: 2, 3, 4, 5'):
            plan(self.root, selection, None, 'dslots', 'diamond', None, None)


if __name__ == '__main__':
    unittest.main()
