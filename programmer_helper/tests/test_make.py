"""Exercise Make goal routing without issuing hardware writes."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from programmer_helper.helper import read_selection


ROOT = Path(__file__).resolve().parents[2]


class ProgrammerMakeTests(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.cwd = Path(directory.name)

    def make(self, *args, recorder=False):
        command = ['make', '--no-print-directory', '-f', str(ROOT / 'Makefile'), *args]
        if recorder:
            script = self.cwd / 'record.py'
            script.write_text('import json, sys\nprint(json.dumps(sys.argv[1:]))\n')
            command.append(f'python={sys.executable} {script}')
        else:
            command.append(f'python={sys.executable}')
        return subprocess.run(command, cwd=self.cwd, capture_output=True, text=True,
                              env={**os.environ, 'CPLD_TOOLCHAIN_CONTAINER': '1'})

    def recorded(self, *args):
        result = self.make(*args, recorder=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = [json.loads(line) for line in result.stdout.splitlines() if line.startswith('[')]
        self.assertEqual(len(calls), 1, result.stdout)
        return calls[0]

    def test_template_is_created_in_cwd_and_never_overwritten(self):
        result = self.make('programmer')
        self.assertEqual(result.returncode, 0, result.stderr)
        selection = self.cwd / 'selection.toml'
        self.assertEqual(read_selection(selection),
                         ({i: 'tx30' for i in range(1, 6)}, 's3c_power_on_debounce', None))
        self.assertIn('release = ""', selection.read_text())
        selection.write_text('s3c = "my_program"\n')
        result = self.make('programmer')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(selection.read_text(), 's3c = "my_program"\n')

    def test_template_supports_custom_path_with_spaces(self):
        result = self.make('programmer', 'selection=my selection.toml')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.cwd / 'my selection.toml').is_file())

    def test_scan_modifier_runs_only_scan_even_with_parallel_make(self):
        args = self.recorded('-j2', 'programmer', 'scan', 'backend=foss', 'cable=ft4232_b',
                             'usb_serial=probe123')
        self.assertEqual(args[:3], ['-m', 'programmer_helper.program', 'scan'])
        self.assertIn('--execute', args)
        self.assertEqual(args[args.index('--cable') + 1], 'ft4232_b')
        self.assertEqual(args[args.index('--usb-serial') + 1], 'probe123')
        self.assertNotIn('program', args)

    def test_program_executes_one_explicit_target(self):
        for target in ('s3c', 'dslot'):
            with self.subTest(target=target):
                args = self.recorded('programmer', 'program', f'target={target}', 'probe_index=1',
                                     'selection=my selection.toml')
                self.assertEqual(args[:3], ['-m', 'programmer_helper.program', 'program'])
                self.assertEqual(args[args.index('--target') + 1], target)
                self.assertEqual(args[args.index('--selection') + 1], 'my selection.toml')
                self.assertEqual(args[args.index('--probe-index') + 1], '1')
                self.assertIn('--execute', args)

    def test_dry_run_and_execute_zero_do_not_execute(self):
        for option in ('dry_run=1', 'execute=0'):
            args = self.recorded('programmer', 'program', 'target=s3c', option)
            self.assertNotIn('--execute', args)

    def test_untargeted_scan_defaults_to_dslots(self):
        result = self.make('programmer', 'scan', 'dry_run=1')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('scan: dslots', result.stdout)
        self.assertNotIn('scan: s3c', result.stdout)

    def test_program_requires_target_and_scan_alone_is_rejected(self):
        result = self.make('programmer', 'program')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Choose target=s3c or target=dslot', result.stderr)
        result = self.make('scan')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Use make programmer scan', result.stderr)

    def test_build_shorthand_is_still_a_build(self):
        args = self.recorded('program=tx30')
        self.assertEqual(args[:3], ['-m', 'toolchain.buildsystem', 'build'])

    def test_lattice_xcf_generates_xcfs_only(self):
        args = self.recorded('-j2', 'programmer', 'lattice_xcf')
        self.assertEqual(args, ['-m', 'programmer_helper', '--selection', 'selection.toml'])
        args = self.recorded('programmer', 'lattice_xcf', 'selection=my selection.toml',
                             'release_cycle=old', 'rebuild=1')
        self.assertEqual(args, ['-m', 'programmer_helper', '--release-cycle', 'old',
                                '--selection', 'my selection.toml', '--build'])

    def test_standalone_project_remains_firmware_project(self):
        args = self.recorded('project', 'program=tx30')
        self.assertEqual(args[:3], ['-m', 'toolchain.buildsystem', 'project'])

    def test_mixed_actions_are_rejected_before_any_command(self):
        for goals in [('programmer', 'scan', 'program'),
                      ('programmer', 'lattice_xcf', 'program'),
                      ('programmer', 'build'), ('programmer', 'typo')]:
            with self.subTest(goals=goals):
                result = self.make('-j2', *goals, recorder=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse(result.stdout.strip(), result.stdout)

    def test_retired_commands_do_not_access_hardware(self):
        for goals in [('program',), ('program', 'scan'), ('programmer-scan',),
                      ('programmer-project',), ('programmer-program',), ('programmer', 'project')]:
            with self.subTest(goals=goals):
                result = self.make(*goals, recorder=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertNotIn('programmer_helper', result.stdout)

    def test_lattice_xcf_rejects_foss_backend(self):
        result = self.make('programmer', 'lattice_xcf', 'backend=foss', recorder=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('use backend=diamond', result.stderr)
        self.assertFalse(result.stdout.strip(), result.stdout)


if __name__ == '__main__':
    unittest.main()
