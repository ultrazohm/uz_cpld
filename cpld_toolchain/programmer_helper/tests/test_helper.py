"""Check chain selection, release isolation, and stale firmware refusal."""
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch
import xml.etree.ElementTree as ET

from cpld_toolchain.programmer_helper.helper import generate, main as project_main, read_selection, slot_assignments
from cpld_toolchain.programmer_helper import program as programmer
from cpld_toolchain.programmer_helper.program import plan
from cpld_toolchain.toolchain.buildsystem.model import BuildError, load_build
from cpld_toolchain.toolchain.buildsystem.workflow import digest, hashes


ROOT = Path(__file__).resolve().parents[3]
PROGRAMS = ('tx30', 'rx30', 'uz_d_resolver_d4_4inverter_sdifix',
            'uz_d_resolver_d5_4inverter_sdifix', 's3c_power_on_debounce')
SLOTS = {1: 'rx30', 2: 'tx30', 3: 'tx30',
         4: 'uz_d_resolver_d5_4inverter_sdifix',
         5: 'uz_d_resolver_d4_4inverter_sdifix'}


class ProgrammerHelperTests(unittest.TestCase):
    def test_xcf_export_honors_probe_index_for_both_chains(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c="s3c_power_on_debounce"\n[slots]\n' +
                             ''.join(f'"{i}"="tx30"\n' for i in range(1, 6)))
        self.assertEqual(project_main(['--root', str(self.root), '--selection', str(selection),
                                       '--probe-index', '3']), 0)
        for chain in ('s3c', 'dslots'):
            xcf = self.root / 'build/programmer/original' / f'{chain}.xcf'
            self.assertEqual(ET.parse(xcf).findtext('./CableOptions/PortAdd'), 'FTUSB-3')

    def test_diamond_plans_are_private_and_preserve_each_selection(self):
        selection = self.root / 'selection.toml'
        plans = []
        for name in ('tx30', 'rx30'):
            selection.write_text('[slots]\n' + ''.join(f'"{i}"="{name}"\n' for i in range(1, 6)))
            plans.append(plan(self.root, selection, None, 'dslots', 'diamond', None, None))
        self.assertNotEqual(plans[0][1], plans[1][1])
        # Stable exports must not overwrite either execution plan.
        generate(self.root, {i: 'rx30' for i in range(1, 6)}, '', chain='dslots')
        for expected, (cycle, output, builds, steps) in zip(('tx30', 'rx30'), plans):
            step = steps[0]
            self.assertEqual([b.name for _, _, b in builds], [expected] * 5)
            self.assertEqual([f.source for f in step.firmware], [b.firmware_path('jed') for _, _, b in builds])
            self.assertEqual([Path(d.findtext('File')) for d in ET.parse(step.artifact).findall('./Chain/Device')],
                             [f.artifact for f in step.firmware])
            with patch.object(programmer, 'run_diamond', return_value='mock') as run:
                programmer.execute(self.root, cycle, 'dslots', 'diamond', output, builds, steps, None, None)
                run.assert_called_once()

    def test_diamond_rejects_rebuild_and_snapshot_changes_before_hardware(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c="s3c_power_on_debounce"\n')
        for changed in ('publication', 'snapshot'):
            cycle, output, builds, steps = plan(self.root, selection, None, 's3c', 'diamond', None, None)
            build = builds[0][2]
            path = build.firmware_path('jed') if changed == 'publication' else steps[0].firmware[0].artifact
            path.write_bytes(path.read_bytes().replace(b'C1234', b'C4321'))
            if changed == 'publication':
                record_path = build.directory / 'metadata/build.json'
                record = json.loads(record_path.read_text())
                record['outputs'][path.name] = digest(path)
                record_path.write_text(json.dumps(record))
            with patch.object(programmer, 'run_diamond') as run:
                with self.assertRaisesRegex(BuildError, 'changed since planning'):
                    programmer.execute(self.root, cycle, 's3c', 'diamond', output, builds, steps, None, None)
                run.assert_not_called()
            self.publish('original', 's3c_power_on_debounce')

    def test_diamond_rejects_other_selections_plan_before_hardware(self):
        selection = self.root / 'selection.toml'
        selection.write_text('[slots]\n' + ''.join(f'"{i}"="tx30"\n' for i in range(1, 6)))
        cycle, output, builds, _ = plan(self.root, selection, None, 'dslots', 'diamond', None, None)
        selection.write_text(selection.read_text().replace('tx30', 'rx30'))
        _, _, _, other_steps = plan(self.root, selection, None, 'dslots', 'diamond', None, None)
        with patch.object(programmer, 'run_diamond') as run:
            with self.assertRaisesRegex(BuildError, 'does not match the requested selection'):
                programmer.execute(self.root, cycle, 'dslots', 'diamond', output, builds, other_steps, None, None)
            run.assert_not_called()

    def test_wrong_embedded_usercode_is_rejected_before_planning(self):
        build = load_build(self.root, 'tx30')
        jed = build.firmware_path('jed')
        import re
        jed.write_bytes(re.sub(rb'UH[0-9A-F]{8}', b'UH00000000', jed.read_bytes()))
        record_path = build.directory / 'metadata/build.json'
        record = json.loads(record_path.read_text())
        record['outputs'][jed.name] = digest(jed)
        record_path.write_text(json.dumps(record))
        selection = self.root / 'selection.toml'
        selection.write_text('[slots]\n' + ''.join(f'"{i}"="tx30"\n' for i in range(1, 6)))
        with self.assertRaisesRegex(BuildError, 'JEDEC USERCODE differs'):
            plan(self.root, selection, None, 'dslots', 'diamond', None, None)

    def test_readback_mismatch_records_failure_after_programming(self):
        selection = self.root / 'selection.toml'
        selection.write_text('s3c="s3c_power_on_debounce"\n')
        cycle, output, builds, steps = plan(self.root, selection, None, 's3c', 'diamond', None, None)
        with patch.object(programmer, 'run_diamond', return_value='success') as run, \
                patch('cpld_toolchain.programmer_helper.identify.identify', return_value=[
                    {'label': 's3c', 'usercode': '00000000', 'traceid': '0100000000000001'}]):
            with self.assertRaisesRegex(BuildError, 'readback USERCODE'):
                programmer.execute(self.root, cycle, 's3c', 'diamond', output, builds, steps, None, None)
        run.assert_called_once()
        record = json.loads(next((output / 'runs').glob('*/result.json')).read_text())
        self.assertEqual(record['status'], 'failed')
        self.assertEqual(record['devices'][0]['usercode'], '00000000')
        self.assertIn('s3c', record['expected_identities'])

    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix='cpld programmer ')
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for folder in ('cpld_toolchain/toolchain/buildsystem', 'cpld_toolchain/toolchain/targets', 'cpld_toolchain/toolchain/foss'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('__pycache__'))
        for name in ('diamond.py', 'locking.py'):
            shutil.copy2(ROOT / 'cpld_toolchain/toolchain' / name, self.root / 'cpld_toolchain/toolchain' / name)
        (self.root / 'programs').mkdir()
        shutil.copy2(ROOT / 'programs/usercodes.json', self.root / 'programs/usercodes.json')
        def mock_readback(root, chain, backend, cable, serial, probe_index, *, output):
            expected = json.loads((output.parent / 'result.json').read_text())['expected_identities']
            return [{'label': label, 'usercode': identity['usercode'], 'traceid': '0100000000000001'}
                    for label, identity in expected.items()]
        reader = patch('cpld_toolchain.programmer_helper.identify.identify', side_effect=mock_readback)
        reader.start()
        self.addCleanup(reader.stop)
        # These orchestration fixtures contain synthetic firmware; real parser
        # and binary provenance checks have separate integration regressions.
        checker = patch('cpld_toolchain.toolchain.foss.flasher.check_file')
        checker.start()
        self.addCleanup(checker.stop)
        gate = patch('cpld_toolchain.programmer_helper.identify.programming_preflight', return_value=None)
        gate.start()
        self.addCleanup(gate.stop)
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        for cycle in ('original', 'old'):
            directory = self.root / 'programs' / cycle
            directory.mkdir()
            (directory / 'catalog.toml').write_text('programs = []\n')
            for name in PROGRAMS:
                shutil.copytree(ROOT / 'programs/original' / name, directory / name,
                                ignore=shutil.ignore_patterns('build', '__pycache__'))
                self.publish(cycle, name)

    def publish(self, cycle, name, backend='diamond'):
        build = load_build(self.root, name, backend=backend, release_cycle=cycle)
        jed = build.firmware_path('jed' if backend == 'diamond' else 'bit')
        jed.parent.mkdir(parents=True, exist_ok=True)
        from cpld_toolchain.toolchain.buildsystem.identity import reserve_build
        identity = reserve_build(build)
        checksum = '1234' if cycle == 'original' else '5678'
        jed.write_bytes(f'\x02\nC{checksum}*\nUH{identity["usercode"]}*\n\x03'.encode())
        metadata = jed.parent / 'metadata'
        metadata.mkdir(exist_ok=True)
        (metadata / 'status.json').write_text('{"status":"success"}\n')
        (metadata / 'build.json').write_text(json.dumps({
            'status': 'success', 'identity': identity, 'inputs': hashes(build),
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
        self.assertEqual(read_selection(selection), (SLOTS, 's3c_power_on_debounce', None, 'diamond'))

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
                output = self.root / 'build/programmer' / expected
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

    def write_backend_selection(self, backend, chain='dslots'):
        selection = self.root / 'selection.toml'
        selection.write_text(f'build_backend = "{backend}"\nrelease = "old"\n' +
                             ('s3c = "s3c_power_on_debounce"\n' if chain == 's3c' else
                              '[slots]\n' + ''.join(f'"{i}" = "tx30"\n' for i in range(1, 6))))
        return selection

    def test_foss_programmer_uses_selected_build_backend_for_either_chain(self):
        for name in ('tx30', 's3c_power_on_debounce'):
            self.publish('old', name, 'foss')
        for backend, extension in [('diamond', '.jed'), ('foss', '.bit')]:
            for chain in ('s3c', 'dslots'):
                with self.subTest(backend=backend, chain=chain):
                    selection = self.write_backend_selection(backend, chain)
                    cycle, _, builds, steps = plan(self.root, selection, None, chain, 'foss', None, None, build_backend=backend)
                    self.assertEqual(cycle, 'old')
                    self.assertEqual(len(steps), 1 if chain == 's3c' else 5)
                    for step, (_, index, build) in zip(steps, builds):
                        self.assertEqual(build.backend, backend)
                        self.assertEqual(step.artifact.suffix, extension)
                        self.assertEqual(step.artifact.parent, build.directory)
                        self.assertEqual(step.command[-1], str(step.artifact))
                        self.assertEqual(step.command[step.command.index('--index-chain') + 1], str(index))
                        self.assertIn('--write-flash', step.command)
                        self.assertIn('--verify', step.command)

    def test_build_backend_override_and_missing_field_default(self):
        selection = self.write_backend_selection('foss')
        _, _, builds, _ = plan(self.root, selection, None, 'dslots', 'foss', None, None,
                                build_backend='diamond')
        self.assertTrue(all(build.backend == 'diamond' for _, _, build in builds))
        _, _, builds, _ = plan(self.root, selection, None, 'dslots', 'foss', None, None)
        self.assertTrue(all(build.backend == 'diamond' for _, _, build in builds))
        selection.write_text(selection.read_text().replace('build_backend = "foss"\n', ''))
        _, _, builds, _ = plan(self.root, selection, None, 'dslots', 'foss', None, None)
        self.assertTrue(all(build.backend == 'diamond' for _, _, build in builds))
        self.publish('old', 'tx30', 'foss')
        _, _, builds, _ = plan(self.root, selection, None, 'dslots', 'foss', None, None,
                                build_backend='foss')
        self.assertTrue(all(build.backend == 'foss' for _, _, build in builds))

    def test_invalid_build_backend_is_rejected(self):
        selection = self.root / 'selection.toml'
        for value in ('"other"', '""', '123', 'true', '[]', '{}'):
            selection.write_text(f'build_backend = {value}\ns3c = "s3c_power_on_debounce"\n')
            with self.subTest(value=value), self.assertRaisesRegex(BuildError, 'build_backend'):
                read_selection(selection, chain='s3c')

    def test_diamond_rejects_foss_builds_and_xcf_honors_override(self):
        selection = self.write_backend_selection('foss')
        with self.assertRaisesRegex(BuildError, 'requires Diamond JEDEC'):
            plan(self.root, selection, None, 'dslots', 'diamond', None, None, build_backend='foss')
        selection.write_text(selection.read_text().replace('[slots]',
                             's3c = "s3c_power_on_debounce"\n[slots]'))
        with self.assertRaises(SystemExit) as error:
            project_main(['--root', str(self.root), '--selection', str(selection), '--build-backend', 'foss'])
        self.assertEqual(error.exception.code, 2)
        self.assertFalse((self.root / 'build/programmer').exists())
        self.assertEqual(project_main(['--root', str(self.root), '--selection', str(selection),
                                       '--build-backend', 'diamond']), 0)
        receipt = json.loads((self.root / 'build/programmer/old/selection.json').read_text())
        self.assertEqual(receipt['build_backend'], 'diamond')

    def test_foss_execution_revalidates_selected_build_and_records_both_backends(self):
        scan = '\n'.join(f'index {i}:\n  idcode 0x012bb043' for i in range(5))
        for backend in ('diamond', 'foss'):
            with self.subTest(backend=backend):
                if backend == 'foss':
                    self.publish('old', 'tx30', backend)
                selection = self.write_backend_selection(backend)
                with patch.object(programmer, 'loader_path', return_value=Path(__file__)), \
                        patch.object(programmer, 'run_command', return_value=scan) as run:
                    cycle, output, builds, steps = plan(self.root, selection, None, 'dslots', 'foss', None, None, build_backend=backend)
                    result = programmer.execute(self.root, cycle, 'dslots', 'foss', output,
                                                builds, steps, None, None)
                self.assertEqual(run.call_count, 6)
                self.assertIn('--detect', run.call_args_list[0].args[0])
                self.assertEqual([call.args[0] for call in run.call_args_list[1:]],
                                 [step.command for step in steps])
                receipt = json.loads((result / 'result.json').read_text())
                self.assertEqual(receipt['status'], 'success')
                self.assertEqual(receipt['programmer_backend'], 'foss')
                self.assertEqual(receipt['build_backend'], backend)
                self.assertEqual(receipt['steps'][0]['sha256'], digest(steps[0].artifact))

    def test_s3c_programs_without_qualification_override(self):
        self.publish('old', 's3c_power_on_debounce', 'foss')
        for build_backend, programmer_backend in [('diamond', 'diamond'),
                                                   ('diamond', 'foss'), ('foss', 'foss')]:
            with self.subTest(build=build_backend, programmer=programmer_backend):
                selection = self.write_backend_selection(build_backend, 's3c')
                with patch.object(programmer, 'loader_path', return_value=Path(__file__)), \
                        patch.object(programmer, 'run_command',
                                     return_value='index 0:\n  idcode 0x012bc043\n') as run, \
                        patch.object(programmer, 'run_diamond', return_value='success') as diamond:
                    self.assertEqual(programmer.main([
                        'program', '--root', str(self.root), '--selection', str(selection),
                        '--target', 's3c', '--programmer-backend', programmer_backend, '--build-backend', build_backend, '--execute',
                    ]), 0)
                if programmer_backend == 'diamond':
                    diamond.assert_called_once()
                    run.assert_not_called()
                else:
                    diamond.assert_not_called()
                    self.assertEqual(run.call_count, 2)
                    self.assertIn('--detect', run.call_args_list[0].args[0])
                    self.assertIn('--write-flash', run.call_args_list[1].args[0])
                    self.assertIn('--verify', run.call_args_list[1].args[0])

    def test_foss_refuses_stale_diamond_build_and_changed_plan_before_usb(self):
        selection = self.write_backend_selection('diamond')
        cycle, output, builds, steps = plan(self.root, selection, None, 'dslots', 'foss', None, None)
        # Simulate a new valid publication after planning. The planned hash must still match.
        build = builds[0][2]
        steps[0].artifact.write_bytes(steps[0].artifact.read_bytes() + b'changed')
        record_path = build.directory / 'metadata/build.json'
        record = json.loads(record_path.read_text())
        record['outputs'][steps[0].artifact.name] = digest(steps[0].artifact)
        record_path.write_text(json.dumps(record))
        with patch.object(programmer, 'loader_path', return_value=Path(__file__)), \
                patch.object(programmer, 'run_command') as run:
            with self.assertRaisesRegex(BuildError, 'changed since planning'):
                programmer.execute(self.root, cycle, 'dslots', 'foss', output, builds, steps, None, None)
            run.assert_not_called()
        source = self.root / 'programs/old/tx30/tx30.vhdl'
        source.write_text(source.read_text() + '\n-- changed\n')
        with self.assertRaisesRegex(BuildError, 'stale'):
            plan(self.root, selection, None, 'dslots', 'foss', None, None)

    def test_selected_release_populates_both_chains(self):
        output = generate(self.root, SLOTS, 's3c_power_on_debounce', 'old')
        slot_tree = ET.parse(output / 'dslots.xcf')
        devices = slot_tree.findall('./Chain/Device')
        self.assertEqual([int(item.findtext('Pos')) for item in devices], [1, 2, 3, 4, 5])
        self.assertEqual([Path(item.findtext('File')).parents[1].name for item in devices],
                         [SLOTS[position] for position in range(1, 6)])
        self.assertEqual([Path(item.findtext('File')).parents[2].name for item in devices],
                         ['old'] * 5)
        self.assertTrue(all(item.findtext('JedecChecksum') == '0x5678' for item in devices))
        self.assertIsNone(slot_tree.find('./CableOptions/USBID'))
        self.assertEqual(slot_tree.findtext('./CableOptions/PortAdd'), 'FTUSB-1')
        self.assertEqual(ET.parse(output / 's3c.xcf').findtext('./CableOptions/PortAdd'), 'FTUSB-1')
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
        self.assertFalse((self.root / 'build/programmer/original/dslots.xcf').exists())

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
