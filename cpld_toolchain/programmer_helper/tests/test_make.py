"""Public Make routing and first-use behavior without hardware access."""
import os
from pathlib import Path
import shlex
import subprocess
import sys
import tempfile
import unittest

from cpld_toolchain.programmer_helper.helper import read_selection

ROOT = Path(__file__).resolve().parents[3]


class ProgrammerMakeTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.cwd = Path(temporary.name)

    def make(self, *args):
        return subprocess.run(['make', '--no-print-directory', '-f', str(ROOT / 'Makefile'),
                               *args, f'python={sys.executable}'], cwd=self.cwd,
                              env={**os.environ, 'CPLD_TOOLCHAIN_CONTAINER': '1'},
                              text=True, capture_output=True, timeout=15)

    def preview(self, *args):
        result = self.make(*args, 'dry_run=1')
        self.assertEqual(result.returncode, 0, result.stderr)
        commands = [shlex.split(line.split('] ', 1)[1]) for line in result.stdout.splitlines()
                    if line.startswith('[')]
        self.assertEqual(len(commands), 1, result.stdout)
        return commands[0]

    def test_initialization_creates_selection_in_callers_directory_without_overwriting(self):
        result = self.make('init')
        self.assertEqual(result.returncode, 0, result.stderr)
        selection = self.cwd / 'selection.toml'
        self.assertEqual(read_selection(selection),
                         ({i: 'tx30' for i in range(1, 6)}, 's3c_power_on_debounce', None, 'diamond'))
        self.assertNotIn('build_backend =', selection.read_text())
        selection.write_text('s3c = "custom"\n')
        self.assertEqual(self.make('init').returncode, 0)
        self.assertEqual(selection.read_text(), 's3c = "custom"\n')

    def test_initialization_with_spaces_and_shell_characters(self):
        name = "my ' selection `touch UNEXPECTED`.toml"
        result = self.make('init', f'selection={name}')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.cwd / name).exists())
        self.assertFalse((self.cwd / 'UNEXPECTED').exists())

    def test_preview_does_not_create_selection(self):
        self.preview('init')
        self.assertFalse((self.cwd / 'selection.toml').exists())
        self.preview('program', 'target=s3c')
        self.assertFalse((self.cwd / 'selection.toml').exists())

    def test_hardware_actions_default_to_diamond(self):
        for action in ('scan', 'identify', 'program'):
            args = self.preview(action, 'target=dslot')
            self.assertIn('cpld_toolchain.programmer_helper.program', args)
            self.assertEqual(args[args.index('--programmer-backend') + 1], 'diamond')
            self.assertEqual(args[args.index('--target') + 1], 'dslot')

    def test_backend_defaults_and_independent_overrides(self):
        args = self.preview('program', 'target=s3c', 'backend=foss')
        for flag in ('--build-backend', '--programmer-backend'):
            self.assertEqual(args[args.index(flag) + 1], 'foss')
        args = self.preview('program', 'target=s3c', 'programmer_backend=foss')
        self.assertEqual(args[args.index('--build-backend') + 1], 'diamond')
        args = self.preview('program', 'target=s3c', 'backend=foss', 'build_backend=diamond')
        self.assertEqual(args[args.index('--build-backend') + 1], 'diamond')

    def test_build_and_programmer_project_are_distinct(self):
        args = self.preview('project', 'program=tx30', 'target=dslot')
        self.assertIn('cpld_toolchain.toolchain.buildsystem', args)
        self.assertIn('uz_dslot_xo2', args)
        args = self.preview('programmer-project', 'selection=custom.toml', 'probe_index=3')
        self.assertIn('cpld_toolchain.programmer_helper', args)
        self.assertNotIn('--execute', args)
        self.assertIn(str(self.cwd / 'custom.toml'), args)
        self.assertEqual(args[args.index('--probe-index') + 1], '3')

    def test_invalid_or_inapplicable_options_fail_before_any_command(self):
        for args in [('build-all', 'program=tx30'), ('build', 'program=tx30', 'bakend=foss'),
                     ('scan', 'selection=missing.toml'), ('identify', 'build_backend=foss'),
                     ('scan', 'programmer_backend=typo'), ('programmer-project', 'backend=foss'),
                     ('program',), ('build', 'program=tx30', 'execute=0'),
                     ('sim', 'jobs=0'), ('scan', 'dry_run=yes')]:
            with self.subTest(args=args):
                result = self.make(*args)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse(result.stdout.strip(), result.stdout)

    def test_parallel_make_cannot_mix_workflow_actions(self):
        for actions in [('init', 'program'), ('build-all', 'program'), ('programmer', 'scan')]:
            result = self.make('-j2', *actions)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('one action', result.stderr)
            self.assertFalse(result.stdout.strip())

    def test_help_lists_all_commands_compactly_and_keeps_focused_arguments(self):
        from cpld_toolchain.toolchain.commands import COMMANDS, ARGUMENT_VALUES, command_help
        result = self.make('help')
        self.assertEqual(result.returncode, 0, result.stderr)
        help_text = result.stdout
        groups = ('Environment', 'Documentation', 'Simulation', 'Toolchain',
                  'cpld_vhdl_generator', 'Programmer')
        positions = [help_text.index('\n' + group + '\n') for group in groups]
        self.assertEqual(positions, sorted(positions))
        for action, command in COMMANDS.items():
            self.assertEqual(sum(line.startswith('  make ' + command.example + ' ')
                                 for line in help_text.splitlines()), 1)
            block = command_help(action)
            self.assertIn('Required:', block)
            self.assertIn('Optional:', block)
            self.assertTrue(command.options <= ARGUMENT_VALUES.keys())
            for key in command.options:
                self.assertIn(key + '=', block)
        self.assertLessEqual(len(help_text.splitlines()), len(COMMANDS) + 20)
        self.assertNotIn('Required:', help_text)
        result = self.make('help', 'command=program')
        self.assertIn('Required: target=dslot|s3c', result.stdout)
        self.assertIn('programmer_backend=diamond|foss', result.stdout)
        self.assertNotIn('make sim', result.stdout)

    def test_build_shorthand_and_single_action_aliases(self):
        self.assertIn('build', self.preview('program=tx30'))
        self.assertEqual(self.make('programmer').returncode, 0)
        self.assertTrue((self.cwd / 'selection.toml').exists())
        self.assertIn('cpld_toolchain.programmer_helper', self.preview('lattice_xcf'))


if __name__ == '__main__':
    unittest.main()
