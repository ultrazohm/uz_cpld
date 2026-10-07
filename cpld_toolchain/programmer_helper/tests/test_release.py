"""Release packages program through the shared executor without local builds."""
from cpld_toolchain.programmer_helper import foss
from cpld_toolchain.programmer_helper.tests.foss_fixture import loader_output
from contextlib import nullcontext, redirect_stdout
import copy
import hashlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from zipfile import ZipFile, ZipInfo

from cpld_toolchain.programmer_helper import identify, program, release
from cpld_toolchain.runtime import working_directory
from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.buildsystem.workflow import digest

COMMIT = 'a' * 40


class ReleaseTests(unittest.TestCase):
    def test_top_level_workspace_stages_zip_without_using_checkout(self):
        from cpld_toolchain.__main__ import main
        workspace = self.root / 'standalone workspace'
        with working_directory(self.root), \
                patch('cpld_toolchain.capabilities.require'), \
                patch.object(program, 'execute') as execute, redirect_stdout(io.StringIO()):
            self.assertEqual(main(['--workspace', str(workspace), 'program', '--target', 's3c',
                '--source', 'zip', '--firmware', self.zip.name, '--release', 'published',
                '--s3c-program', 'controller', '--programmer-backend', 'foss']), 0)
        self.assertEqual(execute.call_args.args[0], workspace)
        self.assertTrue(list((workspace / 'build/programmer/packages').glob('package-*/s3c.jed')))
        self.assertFalse((self.root / 'build').exists())
        self.assertFalse((workspace / 'programs').exists())

    def test_direct_cli_selection_uses_zip_without_reading_or_creating_a_file(self):
        for target, assignments in [('s3c', ['--s3c-program', 'controller']),
                                    ('dslot', [arg for i in range(1, 6) for arg in (f'--dslot{i}', 'adapter')])]:
            for existing in (False, True):
                with self.subTest(target=target, existing=existing):
                    self.selection.unlink(missing_ok=True)
                    if existing:
                        self.selection.write_text('invalid TOML: must not be read')
                    with working_directory(self.root), \
                            patch.object(program, 'execute') as execute, redirect_stdout(io.StringIO()):
                        self.assertEqual(program.main(['program', '--root', str(self.root), '--target', target,
                            '--release', 'published', '--source', 'zip', '--firmware', str(self.zip),
                            '--programmer-backend', 'foss', *assignments]), 0)
                    execute.assert_not_called()
                    self.assertEqual(self.selection.exists(), existing)
                    if existing:
                        self.assertEqual(self.selection.read_text(), 'invalid TOML: must not be read')

    def test_identify_uses_zip_registry_and_records_source(self):
        raw = 'UZ_IDENTITY 0 012BC043 00010001 0100000000000001'
        # A conflicting local label must not affect the ZIP interpretation.
        local = copy.deepcopy(self.manifest['identity_registry'])
        local['programs']['local/controller'] = local['programs'].pop('published/controller')
        path = self.root / 'programs/usercodes.json'
        path.parent.mkdir()
        path.write_text(json.dumps(local))
        original = path.read_bytes()
        with patch.object(identify, 'preflight'), patch.object(identify, 'diamond_read', return_value=raw), \
                redirect_stdout(io.StringIO()):
            result = program.main(['identify', '--root', str(self.root), '--target', 's3c',
                                   '--source', 'zip', '--firmware', str(self.zip), '--execute'])
        self.assertEqual(result, 0)
        receipt, = self.root.glob('build/programmer/identification/read-*/identity.json')
        record = json.loads(receipt.read_text())
        self.assertEqual(record['devices'][0]['identity']['program'], 'published/controller')
        self.assertEqual(record['source'], 'zip')
        self.assertEqual(record['archive_sha256'], digest(self.zip))
        self.assertEqual(record['git_revision'], COMMIT)
        self.assertEqual(json.loads(receipt.with_name('manifest.json').read_text()), self.manifest)
        self.assertEqual(path.read_bytes(), original)

    def test_foss_identify_needs_no_local_registry(self):
        raw = 'UZ_IDENTITY_V1 0 012BC043 00010001 00010001 0100000000000001\nUZ_IDENTITY_END_V1 1'
        with patch.object(identify, 'preflight'), patch.object(foss.flasher, 'verify', return_value={}), \
                patch.object(foss, 'diamond_usb', return_value=nullcontext()), \
                patch.object(foss, 'run', return_value=raw), redirect_stdout(io.StringIO()):
            devices = identify.identify(self.root, 's3c', 'foss', firmware=self.zip)
        self.assertEqual(devices[0]['identity']['program'], 'published/controller')
        self.assertFalse((self.root / 'programs/usercodes.json').exists())

    def test_identify_rejects_corrupt_zip_before_hardware(self):
        self.payloads[next(iter(self.payloads))] = b'corrupt firmware'
        self.write_zip()
        with patch.object(identify, 'preflight') as preflight, patch.object(identify, 'diamond_read') as read:
            with self.assertRaises(BuildError):
                identify.identify(self.root, 's3c', firmware=self.zip)
        preflight.assert_not_called()
        read.assert_not_called()
        self.assertFalse((self.root / 'build/programmer/identification').exists())

    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix='release programmer ')
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.selection = self.root / 'selection.toml'
        self.selection.write_text('release="published"\ns3c="controller"\n[slots]\n' +
                                  ''.join(f'"{i}"="adapter"\n' for i in range(1, 6)))
        self.zip = self.root / 'release firmware.zip'
        self.manifest, self.payloads = self.package()
        self.write_zip()

    def package(self, backend='diamond'):
        registry = {'schema_version': 1, 'next_program': 3, 'programs': {}}
        manifest = {'schema_version': 1, 'git_revision': COMMIT, 'backend': backend,
                    'release_cycles': ['published'], 'builds': [], 'identity_registry': registry}
        payloads = {}
        for number, (name, target) in enumerate((('controller', 'uz_s3c_xo2'),
                                                ('adapter', 'uz_dslot_xo2')), start=1):
            qualified = f'published/{name}'
            inputs = {'source.vhd': 'b' * 64}
            fingerprint = hashlib.sha256(json.dumps(dict(program=qualified, target=target,
                                         backend=backend, inputs=inputs), sort_keys=True).encode()).hexdigest()
            identity = dict(program=qualified, program_number=number, revision=1,
                            usercode=f'{number:04X}0001', fingerprint=fingerprint)
            files, outputs, checksums = {}, {}, {}
            for extension in (('jed', 'bit') if backend == 'diamond' else ('bit',)):
                filename = f'{name}_{target}_{backend}.{extension}'
                member = f'{qualified}/{target}/{filename}'
                payload = (f'\x02\nC1234*\nUH{identity["usercode"]}*\n\x03'.encode()
                           if extension == 'jed' else b'synthetic bitstream')
                checksum = hashlib.sha256(payload).hexdigest()
                files[member] = outputs[filename] = checksums[extension] = checksum
                payloads[member] = payload
            registry['programs'][qualified] = {'number': number, 'next_revision': 2, 'builds': {
                '1': dict(fingerprint=fingerprint, target=target, backend=backend,
                          artifacts=[{'firmware_sha256': checksums}])}}
            manifest['builds'].append(dict(release_cycle='published', program=name, target=target,
                device=release.DEVICES[target], identity=identity, files=files,
                provenance=dict(status='success', git_revision=COMMIT, inputs=inputs,
                                program=name, release_cycle='published', target=target,
                                backend=backend, device=release.DEVICES[target],
                                identity=identity, outputs=outputs)))
        return manifest, payloads

    def write_zip(self):
        with ZipFile(self.zip, 'w') as archive:
            archive.writestr('manifest.json', json.dumps(self.manifest))
            for name, payload in self.payloads.items():
                archive.writestr(name, payload)

    def plan(self, backend='foss', chain='s3c', **kwargs):
        return program.plan(self.root, self.selection, None, chain, backend, None, None,
                            source='zip', firmware=self.zip, **kwargs)

    def execute(self, planned, backend='foss', chain='s3c', mismatch=False):
        cycle, output, builds, steps = planned
        def readback(root, chain, backend, cable, serial, probe, *, output, registry):
            expected = json.loads((output.parent / 'result.json').read_text())['expected_identities']
            self.assertEqual(registry, self.manifest['identity_registry'])
            idcode = '012BC043' if chain == 's3c' else '012BB043'
            raw = ''.join(f'UZ_IDENTITY {i} {idcode} '
                          f'{"00000000" if mismatch else identity["usercode"]} 0100000000000001\n'
                          for i, identity in enumerate(expected.values()))
            return identify.parse(root, chain, raw, registry=registry)
        scan = ''.join(f'index {i}:\n  idcode 0x{code}\n' for i, code in enumerate(
                      ['012bc043'] if chain == 's3c' else ['012bb043'] * 5))
        with patch.object(program, 'loader_path', return_value=Path(__file__)), \
                patch('cpld_toolchain.programmer_helper.identify.programming_preflight', return_value=None), \
                patch('cpld_toolchain.toolchain.foss.flasher.check_file') as check, \
                patch.object(foss.flasher, 'verify', return_value={}), \
                patch.object(foss, 'diamond_usb', return_value=nullcontext()), \
                patch.object(foss, 'run', side_effect=lambda *a, **k: loader_output(*a, **k).replace('00010001', '00000000') if mismatch else loader_output(*a, **k)) as run, \
                patch.object(program, 'run_diamond', return_value='success') as diamond, \
                patch.object(identify, 'identify', side_effect=readback):
            directory = program.execute(self.root, cycle, chain, backend, output, builds, steps, None, None)
        return directory, check.call_count, run.call_count, diamond.call_count

    def test_both_chains_and_backends_without_local_sources_or_registry(self):
        for backend in ('diamond', 'foss'):
            for chain, count in (('s3c', 1), ('dslots', 5)):
                with self.subTest(backend=backend, chain=chain), \
                        patch.object(program, 'loader_path', return_value=Path(__file__)):
                    planned = self.plan(backend, chain)
                    builds = planned[2]
                    self.assertEqual(len(builds), count)
                    directory, checks, runs, diamonds = self.execute(planned, backend, chain)
                    self.assertEqual((checks, runs, diamonds),
                                     (count, count + 2, 0) if backend == 'foss' else (0, 0, 1))
                    record = json.loads((directory / 'result.json').read_text())
                    self.assertEqual(record['status'], 'success')
                    self.assertEqual(record['source'], 'zip')
                    self.assertEqual(record['release_package']['archive_sha256'], digest(self.zip))
                    self.assertEqual(record['release_package']['git_revision'], COMMIT)
                    self.assertTrue(all(d['identity']['known_build'] for d in record['devices']))
                    staged = builds[0][2].directory
                    self.assertEqual(len(list(staged.glob('*.jed'))), count)
                    self.assertFalse(list(staged.glob('*.bit')))
        self.assertFalse((self.root / 'programs').exists())
        self.assertFalse((self.root / 'build/diamond').exists())

    def test_foss_bitstream_package_and_diamond_refusal(self):
        self.manifest, self.payloads = self.package('foss')
        self.write_zip()
        with patch.object(program, 'loader_path', return_value=Path(__file__)):
            planned = self.plan()
            self.assertEqual(planned[3][0].artifact.suffix, '.bit')
            self.execute(planned)
        with self.assertRaisesRegex(BuildError, 'Diamond JEDEC'):
            self.plan('diamond')

    def test_wrong_backend_selection_target_and_release_fail_before_staging(self):
        for options, selection in [({'build_backend': 'foss'}, None),
                                   ({}, 'release="other"\ns3c="controller"'),
                                   ({}, 'release="published"\ns3c="adapter"')]:
            with self.subTest(options=options, selection=selection):
                if selection:
                    self.selection.write_text(selection)
                with self.assertRaises(BuildError), patch.object(program, 'run_command') as run:
                    self.plan(**options)
                run.assert_not_called()
                self.assertFalse((self.root / 'build').exists())

    def test_release_default_and_override_do_not_require_local_catalog(self):
        self.selection.write_text('s3c="controller"')
        self.assertEqual(self.plan()[0], 'published')
        (self.root / 'programs').mkdir()
        (self.root / 'programs/releases.toml').write_text('current="other"')
        with self.assertRaisesRegex(BuildError, 'ZIP has no firmware'):
            self.plan()
        self.assertEqual(program.plan(self.root, self.selection, 'published', 's3c', 'foss', None, None,
                                     source='zip', firmware=self.zip)[0], 'published')

    def test_invalid_manifest_and_payloads_never_reach_hardware(self):
        original = copy.deepcopy(self.manifest)
        original_payloads = dict(self.payloads)
        for mutation in ('checksum', 'device', 'identity', 'history', 'provenance', 'fingerprint',
                         'duplicate', 'registry', 'path', 'extra', 'usercode'):
            with self.subTest(mutation=mutation):
                self.manifest = copy.deepcopy(original)
                self.payloads = dict(original_payloads)
                entry = self.manifest['builds'][0]
                if mutation == 'checksum':
                    self.payloads[next(iter(entry['files']))] = b'corrupt'
                elif mutation == 'device':
                    entry['device'] = release.DEVICES['uz_dslot_xo2']
                elif mutation == 'identity':
                    entry['identity']['usercode'] = '00020001'
                elif mutation == 'history':
                    self.manifest['identity_registry']['programs']['published/controller']['builds']['1']['artifacts'] = []
                elif mutation == 'provenance':
                    entry['provenance']['git_revision'] = 'c' * 40
                elif mutation == 'fingerprint':
                    entry['provenance']['inputs'] = {}
                elif mutation == 'duplicate':
                    self.manifest['builds'].append(copy.deepcopy(entry))
                elif mutation == 'registry':
                    self.manifest['identity_registry']['programs']['published/adapter']['number'] = 1
                elif mutation == 'path':
                    entry['files']['../escape.jed'] = entry['files'].pop(next(iter(entry['files'])))
                elif mutation == 'extra':
                    self.payloads['extra.txt'] = b'undeclared'
                elif mutation == 'usercode':
                    member = next(name for name in entry['files'] if name.endswith('.jed'))
                    self.payloads[member] = self.payloads[member].replace(b'UH00010001', b'UH00020001')
                    checksum = hashlib.sha256(self.payloads[member]).hexdigest()
                    entry['files'][member] = entry['provenance']['outputs'][Path(member).name] = checksum
                    self.manifest['identity_registry']['programs']['published/controller']['builds']['1']['artifacts'][0]['firmware_sha256']['jed'] = checksum
                self.write_zip()
                with patch.object(program, 'run_command') as run, self.assertRaises(BuildError):
                    self.plan()
                run.assert_not_called()
                self.assertFalse(list((self.root / 'build/programmer/packages').glob('package-*')))

    def test_symlink_duplicate_json_and_nonzip_are_rejected(self):
        self.zip.write_bytes(b'not a zip')
        with self.assertRaisesRegex(BuildError, 'Invalid firmware ZIP'):
            self.plan()
        with ZipFile(self.zip, 'w') as archive:
            archive.writestr('manifest.json', '{"schema_version":1,"schema_version":1}')
        with self.assertRaisesRegex(BuildError, 'Duplicate'):
            self.plan()
        with ZipFile(self.zip, 'w') as archive:
            member = ZipInfo('manifest.json')
            member.external_attr = 0o120777 << 16
            archive.writestr(member, 'target')
        with self.assertRaisesRegex(BuildError, 'regular files'):
            self.plan()

    def test_manifest_and_snapshot_tampering_fail_before_hardware(self):
        for change in ('manifest', 'snapshot'):
            with self.subTest(change=change), patch.object(program, 'loader_path', return_value=Path(__file__)):
                planned = self.plan()
                build = planned[2][0][2]
                path = build.directory / 'manifest.json' if change == 'manifest' else build.artifact
                path.write_bytes(b'changed')
                with patch.object(program, 'run_command') as run, \
                        patch.object(identify, 'programming_preflight'), self.assertRaisesRegex(BuildError, 'changed'):
                    program.execute(self.root, planned[0], 's3c', 'foss', *planned[1:], None, None)
                run.assert_not_called()

    def test_conflicting_registry_is_reported_and_never_overwritten(self):
        local = copy.deepcopy(self.manifest['identity_registry'])
        local['programs']['published/controller']['builds']['1']['fingerprint'] = 'e' * 64
        path = self.root / 'programs/usercodes.json'
        path.parent.mkdir()
        path.write_text(json.dumps(local))
        before = path.read_bytes()
        with redirect_stdout(io.StringIO()) as output, patch.object(program, 'loader_path', return_value=Path(__file__)):
            planned = self.plan()
            directory, *_ = self.execute(planned)
        self.assertIn('Local registry conflicts', output.getvalue())
        record = json.loads((directory / 'result.json').read_text())
        self.assertTrue(record['release_package']['registry_conflicts'])
        self.assertEqual(path.read_bytes(), before)
        self.assertEqual(record['devices'][0]['identity']['build']['fingerprint'],
                         self.manifest['builds'][0]['identity']['fingerprint'])

    def test_readback_mismatch_marks_run_failed(self):
        with patch.object(program, 'loader_path', return_value=Path(__file__)):
            planned = self.plan()
            with self.assertRaisesRegex(BuildError, 'Flash USERCODE'):
                self.execute(planned, mismatch=True)
        record = json.loads(next((planned[1] / 'runs').glob('*/result.json')).read_text())
        self.assertEqual(record['status'], 'failed')


if __name__ == '__main__':
    unittest.main()
