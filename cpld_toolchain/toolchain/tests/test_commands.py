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
    def calls(self, action, **options):
        return commands.plan(action, options)

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
        for action in ('build', 'build-all', 'doctor', 'check', 'clean', 'report'):
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
                                ('build-all', {'backend': 'diamond'}), ('sim', {}),
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
                for action, opts in [('init', ['--selection', selection]),
                                     ('program', ['--target', 'dslot', '--selection', selection]),
                                     ('clean-all', []), ('image', []), ('venv', []),
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

    def test_docs_scope_is_current_unless_all_is_explicit(self):
        with patch.object(commands, 'resolve_release', return_value='selected'):
            args = self.calls('docs')[0].argv
            self.assertIn('selected', args)
            args = self.calls('docs', release_cycle='all')[0].argv
            self.assertIn('all', args)
        with self.assertRaises(BuildError):
            self.calls('build-all', release_cycle='all')

    def test_relative_selection_uses_caller_not_repository(self):
        args = commands.plan('programmer-project', {'selection': 'my file.toml'}, cwd='/tmp')[0].argv
        self.assertIn(str(Path('/tmp').resolve() / 'my file.toml'), args)

    def test_unknown_options_and_conflicting_duplicate_syntax_are_errors(self):
        with redirect_stderr(io.StringIO()), patch.object(commands.subprocess, 'run') as run:
            self.assertEqual(commands.main(['scan', '--option', 'typo=value']), 2)
            self.assertEqual(commands.main(['scan', '--backend', 'diamond', '--option', 'backend=foss']), 2)
            self.assertEqual(commands.main(['help', '--option', 'typo=value']), 2)
        run.assert_not_called()


class UnifiedEntryPointTests(unittest.TestCase):
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


if __name__ == '__main__':
    unittest.main()
