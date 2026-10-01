"""Shared command contract: defaults, filtering, execution, and environments."""
from contextlib import redirect_stdout, redirect_stderr
import io
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from toolchain import commands
from toolchain.buildsystem.model import BuildError


class CommandTests(unittest.TestCase):
    def calls(self, action, **options):
        return commands.plan(action, options, environ={'CPLD_TOOLCHAIN_CONTAINER': '1'})

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

    def test_invalid_combinations_fail_before_runner_selection(self):
        for action, options in [('program', {'target': 'dslot', 'build_backend': 'foss'}),
                                ('gui', {'program': 'tx30', 'backend': 'foss'}),
                                ('sim', {'backend': 'diamond'}),
                                ('scan', {'usb_serial': 'x', 'probe_index': '1', 'backend': 'foss'})]:
            with self.assertRaises(BuildError):
                self.calls(action, **options)

    def test_auto_runner_does_not_change_the_backend(self):
        args = commands.plan('build', {'program': 'tx30'}, environ={})[0].argv
        self.assertEqual(args[1:3], ('-m', 'toolchain.buildsystem'))
        args = commands.plan('build', {'program': 'tx30', 'backend': 'foss'}, environ={})[0].argv
        self.assertEqual(args[:2], ('docker', 'run'))
        self.assertIn('backend=foss', args)
        self.assertIn('program=tx30', args)
        args = commands.plan('build', {'program': 'tx30', 'backend': 'foss', 'runner': 'local'}, environ={})[0].argv
        self.assertEqual(args[1:3], ('-m', 'toolchain.buildsystem'))

    def test_container_forwards_filters_and_worker_options_exactly(self):
        options = {'program': 'tx30', 'target': 'dslot', 'release_cycle': 'original',
                   'seed': '17', 'jobs': '2', 'wave_format': 'fst', 'runner': 'container',
                   'container_engine': 'podman', 'toolchain_image': 'custom-image'}
        args = commands.plan('sim', options, environ={})[0].argv
        self.assertIn('--userns=keep-id', args)
        self.assertIn('custom-image', args)
        for key in ('program', 'target', 'release_cycle', 'seed', 'jobs', 'wave_format'):
            self.assertIn(f'{key}={options[key]}', args)
        self.assertNotIn('runner=container', args)

    def test_configured_container_does_not_nest_containers(self):
        args = self.calls('test', runner='container')[0].argv
        self.assertIn('unittest', args)
        self.assertNotIn('docker', args)

    def test_plain_container_cannot_access_usb_or_unconfigured_diamond(self):
        for action, options in [('program', {'target': 'dslot'}), ('scan', {}),
                                ('build', {'program': 'tx30'}), ('init', {})]:
            with self.assertRaisesRegex(BuildError, 'requires runner=local'):
                commands.plan(action, {**options, 'runner': 'container'}, environ={})

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
        args = commands.plan('programmer-project', {'selection': 'my file.toml'}, cwd='/tmp', environ={})[0].argv
        self.assertIn('/tmp/my file.toml', args)

    def test_unknown_options_and_conflicting_duplicate_syntax_are_errors(self):
        with redirect_stderr(io.StringIO()), patch.object(commands.subprocess, 'run') as run:
            self.assertEqual(commands.main(['scan', '--option', 'typo=value']), 2)
            self.assertEqual(commands.main(['scan', '--backend', 'diamond', '--option', 'backend=foss']), 2)
            self.assertEqual(commands.main(['help', '--option', 'typo=value']), 2)
        run.assert_not_called()


if __name__ == '__main__':
    unittest.main()
