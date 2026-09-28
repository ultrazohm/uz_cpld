"""Check chain selection, release isolation, and stale firmware refusal."""
import json
from pathlib import Path
import shutil
import tempfile
import unittest
import xml.etree.ElementTree as ET

from programmer_helper.helper import generate, read_selection, slot_assignments
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
        self.assertEqual(read_selection(selection), (SLOTS, 's3c_power_on_debounce'))

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


if __name__ == '__main__':
    unittest.main()
