"""Firmware discovery and prompting without programmer or network access."""
from contextlib import redirect_stdout
import io
import json
import os
from pathlib import Path
import shutil
import unittest
from unittest.mock import patch

from cpld_toolchain import firmware_choice as choice
from cpld_toolchain.programmer_helper.tests import test_release
from cpld_toolchain.toolchain import commands
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class FirmwareChoiceTests(unittest.TestCase):
    def setUp(self):
        self.fixture = test_release.ReleaseTests()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)
        # Windows temp paths may use an 8.3 alias; match the CLI's resolved paths.
        self.root = self.fixture.root.resolve() / 'workspace'
        self.root.mkdir()
        self.output = redirect_stdout(io.StringIO())
        self.output.__enter__()
        self.addCleanup(self.output.__exit__, None, None, None)

    def download(self, name, date, branch='master'):
        path = self.root / 'build/downloads' / name / choice.downloads.ASSET
        path.parent.mkdir(parents=True)
        shutil.copyfile(self.fixture.zip, path)
        _, evidence = choice.release.read_package(path)
        path.with_name(path.name + '.json').write_text(json.dumps(dict(
            schema_version=1, repository='ultrazohm/uz_cpld', ref='refs/heads/' + branch,
            release_id=1, published_at=date, sha256=evidence['archive_sha256'],
            git_revision=self.fixture.manifest['git_revision'])))
        return path

    def test_latest_uses_publication_and_branch_not_mtime(self):
        older = self.download('old', '2026-01-01T00:00:00Z')
        newer = self.download('new', '2026-02-01T00:00:00Z')
        self.download('other', '2026-03-01T00:00:00Z', 'topic')
        os.utime(older, (2000000000, 2000000000))
        with patch.object(choice, 'interactive', return_value=False):
            self.assertEqual(choice.resolve(self.root, 'latest-downloaded'), newer)
        self.assertFalse((self.root / 'firmware.json').exists())

    def test_old_download_is_listed_but_not_automatically_ranked(self):
        path = self.download('old', '2026-01-01T00:00:00Z')
        path.with_name(path.name + '.json').unlink()
        self.assertEqual(len(choice.candidates(self.root)), 1)
        with self.assertRaisesRegex(BuildError, 'No recorded download'):
            choice.resolve(self.root, 'latest-downloaded')

    def test_modified_receipt_or_payload_is_excluded(self):
        path = self.download('old', '2026-01-01T00:00:00Z')
        receipt = path.with_name(path.name + '.json')
        data = json.loads(receipt.read_text())
        data['sha256'] = 'wrong'
        receipt.write_text(json.dumps(data))
        self.assertEqual(choice.candidates(self.root), [])

    def test_missing_noninteractive_does_not_download_or_prompt(self):
        with patch.object(choice, 'interactive', return_value=False), patch('builtins.input') as prompt, \
                patch.object(choice.downloads, 'download') as download:
            with self.assertRaisesRegex(BuildError, 'No firmware selected'):
                choice.resolve(self.root)
        prompt.assert_not_called()
        download.assert_not_called()

    def test_choice_is_saved_and_survives_original_deletion(self):
        path = self.download('old', '2026-01-01T00:00:00Z')
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', return_value='1'):
            saved = choice.resolve(self.root)
        path.unlink()
        with patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            self.assertEqual(choice.resolve(self.root), saved)
        saved.write_bytes(b'bad')
        with self.assertRaises(BuildError):
            choice.resolve(self.root)

    def test_cancel_and_dry_run_never_select(self):
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', return_value='q'):
            with self.assertRaisesRegex(BuildError, 'cancelled'):
                choice.resolve(self.root)
        with patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            with self.assertRaises(BuildError):
                choice.resolve(self.root, prompt=False)
        self.assertFalse((self.root / 'firmware.json').exists())

    def test_included_selection_and_manual_path(self):
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', return_value='1'):
            self.assertTrue(choice.resolve(self.root, included=self.fixture.zip).is_file())
        (self.root / 'firmware.json').unlink()
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['2', str(self.fixture.zip)]):
            self.assertTrue(choice.resolve(self.root).is_file())

    def test_guided_program_assignments_require_explicit_continue(self):
        options = dict(target='s3c', firmware=str(self.fixture.zip))
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1', '2']):
            result = choice.guide_program(self.root, options)
        self.assertEqual(result['s3c_program'], 'controller')
        self.assertEqual(result['release_cycle'], 'published')
        self.assertFalse((self.root / 'selection.toml').exists())
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1', '']):
            with self.assertRaisesRegex(BuildError, 'cancelled'):
                choice.guide_program(self.root, options)

    def test_existing_valid_selection_is_reused_without_questions(self):
        (self.root / 'selection.toml').write_text('release = "published"\ns3c = "controller"\n')
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            result = choice.guide_program(self.root, dict(target='s3c', firmware=str(self.fixture.zip)))
        self.assertEqual(result['s3c_program'], 'controller')

    def test_shared_command_uses_saved_zip_noninteractively(self):
        saved = choice.select(self.root, self.fixture.zip)
        with patch.object(choice, 'interactive', return_value=False), \
                patch('cpld_toolchain.runtime.execute') as execute, patch('cpld_toolchain.capabilities.require'):
            commands.run('program', dict(target='s3c', source='zip', release='published',
                         s3c_program='controller'), workspace=self.root)
        self.assertIn(str(saved), execute.call_args.args[0].argv)

    def test_download_choice_uses_selected_branch_and_saves(self):
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', 'topic']), \
                patch.object(choice.downloads, 'download', return_value=self.fixture.zip) as download:
            choice.resolve(self.root)
        self.assertEqual(download.call_args.kwargs['branch'], 'topic')
        self.assertTrue((self.root / 'firmware.json').is_file())

    def test_guided_dslots_fill_all_five_positions(self):
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1'] * 5 + ['2']):
            result = choice.guide_program(self.root, dict(target='dslot', firmware=str(self.fixture.zip)))
        self.assertEqual([result[f'dslot{i}'] for i in range(1, 6)], ['adapter'] * 5)

    def test_standalone_latest_reaches_shared_runner_as_absolute_path(self):
        from cpld_toolchain import standalone
        path = self.download('new', '2026-02-01T00:00:00Z')
        with patch.object(commands, 'run', return_value=0) as run:
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'program',
                             '--target', 's3c', '--firmware', 'latest-downloaded']), 0)
        self.assertEqual(run.call_args.args[1]['firmware'], str(path))

    def test_repository_cli_cancellation_never_reaches_executor(self):
        from cpld_toolchain.__main__ import main
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', return_value='q'), patch('cpld_toolchain.runtime.execute') as execute:
            self.assertNotEqual(main(['--workspace', str(self.root), 'program', '--target', 's3c', '--source', 'zip']), 0)
        execute.assert_not_called()

    def local_catalog(self):
        programs = self.root / 'programs'
        cycle = programs / 'published'
        cycle.mkdir(parents=True)
        (programs / 'releases.toml').write_text('current = "published"\n')
        (cycle / 'catalog.toml').write_text('programs = ["controller", "adapter"]\n')
        for name, target in [('controller', 's3c'), ('adapter', 'dslot')]:
            folder = cycle / name
            folder.mkdir()
            (folder / f'{name}.toml').write_text(f'targets = ["uz_{target}_xo2"]\n')

    def test_interactive_init_creates_all_assignments_from_catalog(self):
        from cpld_toolchain.__main__ import main
        self.local_catalog()
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1'] * 7):
            self.assertEqual(main(['--workspace', str(self.root), 'init_programmer']), 0)
        selection = choice.read_toml(self.root / 'selection.toml')
        self.assertEqual(selection['release'], 'published')
        self.assertEqual(selection['s3c'], 'controller')
        self.assertEqual(selection['slots'], {str(i): 'adapter' for i in range(1, 6)})

    def test_standalone_init_uses_selected_package_without_checkout(self):
        from cpld_toolchain import standalone
        choice.select(self.root, self.fixture.zip)
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1'] * 7):
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'init_programmer']), 0)
        self.assertEqual(choice.read_toml(self.root / 'selection.toml')['s3c'], 'controller')

    def test_init_preserves_existing_file_and_scripted_defaults(self):
        path = self.root / 'selection.toml'
        path.write_text('keep existing contents')
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            self.assertEqual(choice.guide_init(self.root, {}), {})
            path.unlink()
            self.assertEqual(choice.guide_init(self.root, {'s3c': 'controller'}), {'s3c': 'controller'})
        with patch.object(choice, 'interactive', return_value=False):
            self.assertEqual(choice.guide_init(self.root, {}), {})

    def test_override_reopens_wizard_and_cancellation_keeps_the_selection(self):
        from cpld_toolchain import standalone
        choice.select(self.root, self.fixture.zip)
        path = self.root / 'selection.toml'
        path.write_text('previous selection')
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1', 'q']):
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'init_programmer', '--override']), 2)
        self.assertEqual(path.read_text(), 'previous selection')
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1'] * 7):
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'init_programmer', '--override']), 0)
        selection = choice.read_toml(path)
        self.assertEqual(selection['s3c'], 'controller')
        self.assertEqual(selection['slots'], {str(i): 'adapter' for i in range(1, 6)})

    def test_repository_and_make_override_flags_reach_the_writer(self):
        from cpld_toolchain.__main__ import main
        path = self.root / 'custom.toml'
        for flags in (['--override'], ['--option', 'override=1']):
            path.write_text('previous selection')
            with patch.object(choice, 'interactive', return_value=False):
                self.assertEqual(main(['--workspace', str(self.root), 'init_programmer',
                    '--selection', str(path), '--s3c', 'controller', *flags]), 0)
            self.assertEqual(choice.read_toml(path)['s3c'], 'controller')
        before = path.read_bytes()
        with patch.object(choice, 'interactive', return_value=False):
            self.assertEqual(main(['--workspace', str(self.root), 'init_programmer',
                '--selection', str(path), '--s3c', 'other', '--option', 'override=0']), 0)
        self.assertEqual(path.read_bytes(), before)
        # A disabled flag still must not silently pass through an unsupported command.
        self.assertEqual(main(['scan', '--option', 'override=0', '--dry-run', '1']), 2)

    def test_init_cancel_does_not_create_selection(self):
        self.local_catalog()
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['1', 'q']):
            with self.assertRaisesRegex(BuildError, 'cancelled'):
                commands.run('init_programmer', {}, workspace=self.root)
        self.assertFalse((self.root / 'selection.toml').exists())

    def test_bare_program_guides_target_source_and_assignments(self):
        from cpld_toolchain.__main__ import main
        choice.select(self.root, self.fixture.zip)
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', '2', '1', '1', '1', '2']), \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute') as execute:
            self.assertEqual(main(['--workspace', str(self.root), 'program']), 0)
        arguments = execute.call_args.args[0].arguments
        self.assertEqual(arguments[arguments.index('--target') + 1], 's3c')
        self.assertEqual(arguments[arguments.index('--s3c-program') + 1], 'controller')

    def test_local_program_guidance_uses_catalog(self):
        self.local_catalog()
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', '2', '2', '1', '1', '2']), \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute') as execute:
            commands.run('program', {}, workspace=self.root)
        arguments = execute.call_args.args[0].arguments
        self.assertNotIn('--firmware', arguments)
        self.assertEqual(arguments[arguments.index('--s3c-program') + 1], 'controller')

    def test_bare_program_noninteractive_or_preview_never_prompts(self):
        with patch.object(choice, 'interactive', return_value=False), \
                patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            with self.assertRaisesRegex(BuildError, 'requires --target'):
                commands.run('program', {}, workspace=self.root)
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
            with self.assertRaisesRegex(BuildError, 'requires --target'):
                commands.run('program', {'dry_run': '1'}, workspace=self.root)

    def test_standalone_bare_program_guides_with_saved_firmware(self):
        from cpld_toolchain import standalone
        choice.select(self.root, self.fixture.zip)
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', '2', '1', '1', '1', '2']), \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute') as execute:
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'program']), 0)
        arguments = execute.call_args.args[0].arguments
        self.assertEqual(arguments[arguments.index('--target') + 1], 's3c')

    def test_bare_program_cancel_keeps_existing_selection(self):
        choice.select(self.root, self.fixture.zip)
        path = self.root / 'selection.toml'
        contents = 'release = "published"\ns3c = "controller"\n'
        path.write_text(contents)
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['2', '2', '1', '']), \
                patch('cpld_toolchain.runtime.execute') as execute:
            with self.assertRaisesRegex(BuildError, 'cancelled'):
                commands.run('program', {}, workspace=self.root)
        execute.assert_not_called()
        self.assertEqual(path.read_text(), contents)

    def test_file_mode_reuses_release_and_all_dslots_without_assignment_prompts(self):
        choice.select(self.root, self.fixture.zip)
        path = self.root / 'selection.toml'
        contents = 'release = "published"\ns3c = "controller"\n[slots]\n' + ''.join(
            f'"{i}" = "adapter"\n' for i in range(1, 6))
        path.write_text(contents)
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['2', '1', '1', '2']) as prompt, \
                patch.object(choice, 'choose', wraps=choice.choose) as choose, \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute') as execute:
            commands.run('program', {}, workspace=self.root)
        self.assertEqual(prompt.call_count, 4)
        self.assertEqual([call.args[0] for call in choose.call_args_list], [
            'How would you like to select programs?', 'What would you like to program?',
            'Choose firmware source:', 'Continue with erase, program and verify?'])
        arguments = execute.call_args.args[0].arguments
        self.assertEqual(arguments[arguments.index('--release-cycle') + 1], 'published')
        for i in range(1, 6):
            self.assertEqual(arguments[arguments.index(f'--dslot{i}') + 1], 'adapter')
        self.assertEqual(path.read_text(), contents)

    def test_missing_or_incompatible_file_does_not_fall_back_to_manual(self):
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['2']), \
                patch('cpld_toolchain.runtime.execute') as execute:
            with self.assertRaisesRegex(BuildError, 'missing'):
                commands.run('program', {}, workspace=self.root)
        execute.assert_not_called()
        choice.select(self.root, self.fixture.zip)
        (self.root / 'selection.toml').write_text('release = "unavailable"\ns3c = "controller"\n')
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', side_effect=['2', '2', '1']), \
                patch('cpld_toolchain.runtime.execute') as execute:
            with self.assertRaisesRegex(BuildError, 'no release cycle unavailable'):
                commands.run('program', {}, workspace=self.root)
        execute.assert_not_called()

    def test_manual_mode_ignores_malformed_selection_file(self):
        choice.select(self.root, self.fixture.zip)
        (self.root / 'selection.toml').write_text('not valid TOML')
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', '2', '1', '1', '1', '2']), \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute') as execute:
            commands.run('program', {}, workspace=self.root)
        execute.assert_called_once()

    def test_standalone_asks_mode_target_source_before_package(self):
        from cpld_toolchain import standalone
        with patch.object(choice, 'interactive', return_value=True), \
                patch('builtins.input', side_effect=['1', '2', '1', '1', '1', '1', '2']), \
                patch.object(choice, 'choose', wraps=choice.choose) as choose, \
                patch.object(standalone, 'included_firmware', return_value=self.fixture.zip), \
                patch('cpld_toolchain.capabilities.require'), patch('cpld_toolchain.runtime.execute'):
            self.assertEqual(standalone.main(['--workspace', str(self.root), 'program']), 0)
        self.assertEqual([call.args[0] for call in choose.call_args_list[:4]], [
            'How would you like to select programs?', 'What would you like to program?',
            'Choose firmware source:', 'Choose firmware package:'])

    def test_saved_selection_is_portable_to_another_mount(self):
        original = choice.select(self.root, self.fixture.zip)
        data = json.loads((self.root / 'firmware.json').read_text())
        self.assertEqual(data['schema_version'], 2)
        self.assertFalse(Path(data['path']).is_absolute())
        moved = self.fixture.root.resolve() / 'container mount'
        shutil.copytree(self.root, moved)
        # Even while the old native path exists, use the current workspace.
        self.assertEqual(choice.selected_firmware(moved), moved / data['path'])
        original.unlink()
        self.assertEqual(choice.selected_firmware(moved), moved / data['path'])

    def test_legacy_linux_and_windows_paths_resolve_current_snapshot(self):
        snapshot = choice.select(self.root, self.fixture.zip)
        receipt = self.root / 'firmware.json'
        data = json.loads(receipt.read_text())
        data['schema_version'] = 1
        for old in ('/native/checkout/firmware/old.zip', 'C:\\native\\checkout\\firmware\\old.zip'):
            with self.subTest(old=old):
                data['path'] = old
                receipt.write_text(json.dumps(data))
                with patch('builtins.input', side_effect=AssertionError('Unexpected prompt')):
                    self.assertEqual(choice.resolve(self.root), snapshot)

    def test_missing_snapshot_reopens_chooser_only_interactively(self):
        snapshot = choice.select(self.root, self.fixture.zip)
        snapshot.unlink()
        with patch.object(choice, 'interactive', return_value=False), patch('builtins.input') as prompt:
            with self.assertRaisesRegex(BuildError, 'unavailable'):
                choice.resolve(self.root)
        prompt.assert_not_called()
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input') as prompt:
            with self.assertRaisesRegex(BuildError, 'unavailable'):
                choice.resolve(self.root, prompt=False)
        prompt.assert_not_called()
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input', return_value='1'):
            self.assertTrue(choice.resolve(self.root, included=self.fixture.zip).is_file())

    def test_corrupt_snapshot_and_invalid_relative_path_never_open_chooser(self):
        snapshot = choice.select(self.root, self.fixture.zip)
        snapshot.write_bytes(b'corrupt')
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input') as prompt:
            with self.assertRaises(BuildError):
                choice.resolve(self.root)
        prompt.assert_not_called()
        receipt = self.root / 'firmware.json'
        data = json.loads(receipt.read_text())
        data['path'] = '../outside.zip'
        receipt.write_text(json.dumps(data))
        with patch.object(choice, 'interactive', return_value=True), patch('builtins.input') as prompt:
            with self.assertRaisesRegex(BuildError, 'relative to this workspace'):
                choice.resolve(self.root)
        prompt.assert_not_called()
