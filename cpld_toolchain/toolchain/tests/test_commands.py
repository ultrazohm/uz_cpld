"""Shared command contract: defaults, filtering, execution, and environments."""
from contextlib import redirect_stdout, redirect_stderr
import io
import sys
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain.toolchain import commands
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class CommandTests(unittest.TestCase):
    def test_download_source_flags_forward_and_reject_conflicts(self):
        call, = commands.plan('firmware_download', {'git_url': 'https://github.com/owner/repo',
                                                  'branch': 'feature/programmer'})
        self.assertEqual(call.arguments[call.arguments.index('--git-url') + 1], 'https://github.com/owner/repo')
        self.assertEqual(call.arguments[call.arguments.index('--branch') + 1], 'feature/programmer')
        with self.assertRaisesRegex(BuildError, 'git_url or remote'):
            commands.plan('firmware_download', {'git_url': 'https://github.com/owner/repo', 'remote': 'origin'})

    def test_direct_program_selection_routes_without_a_selection_file(self):
        for target, assignments in [('s3c', {'s3c_program': 's3c_heartbeat'}),
                                    ('dslot', {f'dslot{i}': 'cvg_tx30' for i in range(1, 6)})]:
            options = dict(target=target, release='heartbeat_cvg', **assignments)
            call, = commands.plan('program', options)
            self.assertNotIn('--selection', call.arguments)
            self.assertEqual(call.arguments[call.arguments.index('--release-cycle') + 1], 'heartbeat_cvg')
            for key, value in assignments.items():
                self.assertEqual(call.arguments[call.arguments.index('--' + key.replace('_', '-')) + 1], value)
            with patch('cpld_toolchain.runtime.execute') as run, redirect_stdout(io.StringIO()):
                args = ['--make-help', 'program', '--option', 'dry_run=1']
                for key, value in options.items():
                    args += ['--option', f'{key}={value}']
                self.assertEqual(commands.main(args), 0)
            run.assert_not_called()

    def test_direct_selection_rejects_partial_mixed_or_wrong_target_assignments(self):
        for options in ({'target': 'dslot', 'dslot1': 'tx30'},
                        {'target': 's3c', 'dslot1': 'tx30'},
                        {'target': 'dslot', 's3c_program': 's3c_heartbeat'},
                        {'target': 's3c', 's3c_program': 's3c_heartbeat', 'selection': 'custom.toml'},
                        {'target': 's3c', 's3c_program': '../invalid'},
                        {'target': 's3c', 'release': 'original', 'release_cycle': 'heartbeat'}):
            with self.subTest(options=options), self.assertRaises(BuildError):
                commands.plan('program', options)

    def test_zip_source_routes_explicit_path_and_infers_build_backend(self):
        with tempfile.TemporaryDirectory(prefix='ZIP command ') as tmp:
            cwd = Path(tmp).resolve()
            options = {'target': 's3c', 'source': 'zip', 'firmware': 'release package.zip', 'backend': 'foss'}
            call, = commands.plan('program', options, cwd=cwd)
            self.assertIn(str(cwd / 'release package.zip'), call.arguments)
            self.assertNotIn('--build-backend', call.arguments)
            self.assertEqual(call.arguments[call.arguments.index('--programmer-backend') + 1], 'foss')
            call, = commands.plan('program', dict(options, build_backend='diamond'), cwd=cwd)
            self.assertEqual(call.arguments[call.arguments.index('--build-backend') + 1], 'diamond')
            for invalid in ({'source': 'zip'}, {'firmware': 'x.zip'}, {'source': 'invalid'}):
                with self.assertRaises(BuildError):
                    commands.plan('program', dict(target='s3c', **invalid), cwd=cwd)
            for argv in (['program', '--target', 's3c', '--source', 'zip', '--firmware', str(cwd / 'missing.zip'), '--dry-run', '1'],
                         ['--make-help', 'program', '--option', 'target=s3c', '--option', 'source=zip',
                          '--option', 'firmware=' + str(cwd / 'missing.zip'), '--option', 'dry_run=1']):
                with patch('cpld_toolchain.runtime.execute') as run, redirect_stdout(io.StringIO()):
                    self.assertEqual(commands.main(argv), 0)
                run.assert_not_called()
            self.assertEqual(list(cwd.iterdir()), [])

    def test_identify_source_routes_and_validates(self):
        with tempfile.TemporaryDirectory() as tmp:
            cwd = Path(tmp).resolve()
            call, = commands.plan('identify', {'target': 's3c', 'source': 'zip',
                                               'firmware': 'release.zip'}, cwd=cwd)
            self.assertIn(str(cwd / 'release.zip'), call.arguments)
            self.assertIn('--source', call.arguments)
            self.assertNotIn('--selection', call.arguments)
            self.assertNotIn('--build-backend', call.arguments)
            call, = commands.plan('identify', {'source': 'local'})
            self.assertNotIn('--firmware', call.arguments)
            for options in ({'source': 'zip'}, {'firmware': 'x.zip'}, {'source': 'invalid'},
                            {'source': 'local', 'firmware': 'x.zip'}):
                with self.assertRaises(BuildError):
                    commands.plan('identify', options)
            with self.assertRaises(BuildError):
                commands.plan('scan', {'source': 'zip', 'firmware': 'x.zip'})
            with patch('cpld_toolchain.runtime.execute') as run, redirect_stdout(io.StringIO()):
                self.assertEqual(commands.main(['identify', '--source', 'zip', '--firmware',
                                                str(cwd / 'missing.zip'), '--dry-run', '1']), 0)
            run.assert_not_called()

    def calls(self, action, **options):
        return commands.plan(action, options)

    def test_command_names_use_lowercase_underscores(self):
        for name in commands.COMMANDS:
            self.assertRegex(name, r'^[a-z_]+$')

    def test_selection_commands_forward_options_without_accessing_files(self):
        options = {'release': '', 's3c': 's3c_heartbeat',
                   **{f'dslot_{i}': 'cvg_tx30' for i in range(1, 6)}}
        args = self.calls('init_programmer', **options)[0].argv
        for key, value in options.items():
            self.assertEqual(args[args.index('--' + key.replace('_', '-')) + 1], value)
        with tempfile.TemporaryDirectory() as tmp:
            cwd = Path(tmp).resolve()
            args = commands.plan('build_selection', {'selection': 'custom.toml', 'target': 's3c',
                                 'backend': 'foss', 'release_cycle': 'heartbeat_cvg'}, cwd=cwd)[0].argv
            self.assertIn(str(cwd / 'custom.toml'), args)
        self.assertEqual(args[args.index('--build-backend') + 1], 'foss')
        self.assertEqual(args[args.index('--target') + 1], 's3c')
        self.assertNotIn('--execute', args)

    def test_every_documented_action_has_a_make_target(self):
        text = (commands.ROOT / 'Makefile').read_text()
        line = next(line for line in text.splitlines() if line.startswith('commands :='))
        self.assertEqual(set(line.split()[2:]), set(commands.COMMANDS) | {'help'})

    def test_target_translation_is_identical_across_utilities(self):
        for action in ('build', 'check', 'project', 'sim', 'netlist', 'docs'):
            for target, internal in commands.TARGETS.items():
                for alias in (target, internal):
                    with self.subTest(action=action, target=alias):
                        args = self.calls(action, program='tx30', target=alias)[0].argv
                        self.assertEqual(args[args.index('--target') + 1], internal)

    def test_default_and_overridden_backends(self):
        for action in ('build', 'build_all', 'doctor', 'check', 'clean', 'report'):
            extra = {'program': 'tx30'} if 'program' in commands.COMMANDS[action].required else {}
            args = self.calls(action, **extra)[0].argv
            self.assertEqual(args[args.index('--backend') + 1], 'diamond')
            args = self.calls(action, backend='foss', build_backend='diamond', **extra)[0].argv
            self.assertEqual(args[args.index('--backend') + 1], 'diamond')

    def test_invalid_combinations_fail_before_execution(self):
        for action, options in [('program', {'target': 'dslot', 'build_backend': 'foss'}),
                                ('gui', {'program': 'tx30', 'backend': 'foss'}),
                                ('sim', {'backend': 'diamond'}),
                                ('scan', {'usb_serial': 'x', 'probe_index': '1', 'backend': 'foss'})]:
            with self.assertRaises(BuildError):
                self.calls(action, **options)

    def test_all_workflows_use_the_current_python(self):
        for action, options in [('build', {'program': 'tx30', 'backend': 'foss'}),
                                ('build_all', {'backend': 'diamond'}), ('sim', {}),
                                ('docs', {}), ('netlist', {}), ('test', {}),
                                ('doctor', {}), ('program', {'target': 'dslot'})]:
            with self.subTest(action=action):
                for call in commands.plan(action, options):
                    self.assertEqual(call.argv[0], sys.executable)
                    self.assertNotIn('docker', call.argv)
                    self.assertNotIn('podman', call.argv)

    def test_runner_and_container_options_are_rejected_for_workflows(self):
        for option in ('runner', 'container_engine', 'container_platform', 'toolchain_image'):
            with self.subTest(option=option), self.assertRaises(BuildError):
                commands.plan('sim', {option: 'container'})
        with self.assertRaises(BuildError):
            commands.plan('test-container', {})

    def test_image_build_remains_explicit_and_configurable(self):
        call, = commands.plan('image', {'container_engine': 'podman', 'toolchain_image': 'custom'})
        self.assertEqual(call.argv[:2], ('podman', 'build'))
        self.assertIn('custom', call.argv)

    def test_dry_run_never_invokes_any_subprocess(self):
        with tempfile.TemporaryDirectory() as tmp:
            selection = str(Path(tmp) / 'new.toml')
            with patch.object(commands.subprocess, 'run') as run, redirect_stdout(io.StringIO()):
                for action, opts in [('init_programmer', ['--selection', selection]),
                                     ('program', ['--target', 'dslot', '--selection', selection]),
                                     ('clean_all', []), ('image', []), ('setup', []),
                                     ('build', ['--program', 'tx30'])]:
                    self.assertEqual(commands.main([action, '--dry-run', '1', *opts]), 0)
            run.assert_not_called()
            self.assertFalse(Path(selection).exists())

    def test_failed_stage_stops_test_suite(self):
        import subprocess
        with patch.object(commands.subprocess, 'run', side_effect=subprocess.CalledProcessError(1, 'test')) as run, \
                redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
            self.assertNotEqual(commands.main(['test']), 0)
        run.assert_called_once()

    def test_docs_scope_is_all_unless_a_release_is_explicit(self):
        with patch.object(commands, 'resolve_release', return_value='selected'):
            args = self.calls('docs')[0].argv
            self.assertIn('all', args)
            args = self.calls('docs_assets')[0].argv
            self.assertIn('all', args)
            args = self.calls('docs', release_cycle='heartbeat')[0].argv
            self.assertIn('heartbeat', args)
        with self.assertRaises(BuildError):
            self.calls('build_all', release_cycle='all')

    def test_relative_selection_uses_caller_not_repository(self):
        args = commands.plan('diamond_xcf_programming_chain', {'selection': 'my file.toml'}, cwd='/tmp')[0].argv
        self.assertIn(str(Path('/tmp').resolve() / 'my file.toml'), args)

    def test_unknown_options_and_conflicting_duplicate_syntax_are_errors(self):
        with redirect_stderr(io.StringIO()), patch.object(commands.subprocess, 'run') as run:
            self.assertEqual(commands.main(['scan', '--option', 'typo=value']), 2)
            self.assertEqual(commands.main(['scan', '--backend', 'diamond', '--option', 'backend=foss']), 2)
            self.assertEqual(commands.main(['help', '--option', 'typo=value']), 2)
        run.assert_not_called()


class UnifiedEntryPointTests(unittest.TestCase):
    def test_workspace_selection_is_written_outside_checkout_and_does_not_leak(self):
        from cpld_toolchain.runtime import working_directory
        from cpld_toolchain.workspace import current
        with tempfile.TemporaryDirectory() as tmp:
            caller = Path(tmp)
            workspace = caller / 'new workspace'
            previous = current()
            with working_directory(caller), redirect_stdout(io.StringIO()):
                self.assertEqual(commands.main(['--workspace', 'new workspace', 'init_programmer']), 0)
                self.assertTrue((workspace / 'selection.toml').is_file())
                self.assertFalse((caller / 'selection.toml').exists())
                self.assertEqual(current(), previous)
                self.assertEqual(commands.main(['init_programmer']), 0)
                self.assertTrue((caller / 'selection.toml').is_file())

    def test_workspace_preview_preserves_explicit_paths_and_creates_nothing(self):
        from cpld_toolchain.runtime import working_directory
        with tempfile.TemporaryDirectory() as tmp:
            caller = Path(tmp).resolve()
            workspace = caller / 'absent'
            with working_directory(caller), redirect_stdout(io.StringIO()) as output:
                self.assertEqual(commands.main(['--workspace', 'absent', 'program', '--target', 's3c',
                    '--source', 'zip', '--firmware', 'firmware.zip', '--selection', 'custom.toml',
                    '--dry-run', '1']), 0)
            self.assertIn(str(workspace), output.getvalue())
            self.assertIn(str(caller / 'firmware.zip'), output.getvalue())
            self.assertIn(str(caller / 'custom.toml'), output.getvalue())
            self.assertEqual(list(caller.iterdir()), [])

    def test_workspace_is_forwarded_to_workflows_and_loader_lookup(self):
        from cpld_toolchain import tools
        from cpld_toolchain.workspace import use
        with tempfile.TemporaryDirectory() as tmp:
            workspace = Path(tmp).resolve()
            for action, options in [('program', {'target': 's3c'}), ('identify', {}), ('scan', {}),
                                    ('doctor', {}), ('build_all', {}), ('firmware_download', {})]:
                call, = commands.plan(action, options, workspace=workspace)
                self.assertEqual(call.arguments[call.arguments.index('--root') + 1], str(workspace))
                self.assertEqual(call.cwd, workspace)
            with use(workspace), patch.object(tools, 'executable') as resolve:
                tools.loader_path()
                self.assertIn(workspace / 'build/openfpgaloader/openFPGALoader',
                              resolve.call_args.kwargs['candidates'])

    def test_invalid_or_unwritable_workspace_stops_before_hardware(self):
        from cpld_toolchain import workspace
        with tempfile.TemporaryDirectory() as tmp:
            invalid = Path(tmp) / 'file'
            invalid.write_text('occupied')
            with patch('cpld_toolchain.runtime.execute') as execute, \
                    redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
                self.assertEqual(commands.main(['--workspace', str(invalid), 'scan']), 2)
                with patch.object(workspace.tempfile, 'TemporaryFile', side_effect=PermissionError('read-only')):
                    self.assertEqual(commands.main(['--workspace', tmp, 'scan']), 2)
                execute.assert_not_called()

    def test_repository_only_commands_reject_workspace_before_creating_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            workspace = Path(tmp) / 'absent'
            for action in ('setup', 'image', 'sim', 'docs', 'docs_assets', 'netlist', 'test'):
                with redirect_stderr(io.StringIO()) as error:
                    self.assertEqual(commands.main(['--workspace', str(workspace), action]), 2)
                self.assertIn('omit --workspace', error.getvalue())
            self.assertFalse(workspace.exists())

    def test_standalone_generator_creates_and_checks_outputs(self):
        from cpld_toolchain.__main__ import main
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            config = root / 'generator.toml'
            config.write_text('schema_version = 3\nname = "sample"\nrouting = "routing.csv"\n'
                              'contract = "s3c_power_on_debounce_v1"\nclock = "external"\n'
                              'pilot_policy = "unused"\n')
            (root / 'routing.csv').write_text('output,normal_state,safe_state\nd_00,fpga_00,0\n')
            args = ['generator', str(config), '--output', str(root)]
            with redirect_stdout(io.StringIO()):
                self.assertEqual(main(args), 0)
                self.assertEqual(main(args + ['--check']), 0)
            self.assertTrue((root / 'cvg_sample.vhdl').is_file())
            (root / 'routing.csv').write_text('output,normal_state,safe_state\nd_00,fpga_00,1\n')
            with redirect_stderr(io.StringIO()):
                self.assertEqual(main(args + ['--check']), 1)

    def test_unified_program_preview_never_executes(self):
        from cpld_toolchain.__main__ import main
        with patch('cpld_toolchain.toolchain.commands.subprocess.run') as execute, redirect_stdout(io.StringIO()) as output:
            self.assertEqual(main(['program', '--target', 'dslot', '--dry-run', '1']), 0)
        execute.assert_not_called()
        self.assertIn('cpld_toolchain.programmer_helper.program', output.getvalue())

    def test_installed_package_locates_checkout_from_working_directory(self):
        from cpld_toolchain import repository_root
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / 'programs').mkdir()
            (root / 'programs/releases.toml').write_text('current = "original"\n')
            (root / 'cpld_toolchain').mkdir()
            with patch('cpld_toolchain.__file__', str(root / 'installed/cpld_toolchain/__init__.py')), patch('pathlib.Path.cwd', return_value=root / 'programs'):
                self.assertEqual(repository_root(), root)


    def test_retired_actions_are_rejected(self):
        for action in ('venv', 'programmer', 'lattice_xcf', 'release_current', 'flasher',
                       'docs_local', 'docs_assets_local', 'netlist_local', '_sim', 'build-all'):
            with self.subTest(action=action), self.assertRaisesRegex(BuildError, 'Unknown action'):
                commands.plan(action, {})


if __name__ == '__main__':
    unittest.main()
