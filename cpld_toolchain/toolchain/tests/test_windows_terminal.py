"""Explorer launch gets a persistent shell; existing terminals keep CLI behavior."""
import base64
from contextlib import nullcontext
import os
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

from cpld_toolchain import windows_terminal as terminal


class WindowsTerminalTests(unittest.TestCase):
    def test_only_an_interactive_frozen_explorer_console_opens_a_shell(self):
        with patch.object(sys, 'platform', 'win32'), patch.object(sys, 'frozen', True, create=True), \
                patch.object(sys.stdin, 'isatty', return_value=True), \
                patch.object(sys.stdout, 'isatty', return_value=True), \
                patch.object(terminal, 'console_processes', return_value=[os.getpid()]) as processes:
            self.assertTrue(terminal.needs_terminal([]))
            processes.return_value = [42, os.getpid()]
            self.assertFalse(terminal.needs_terminal([]))
            processes.return_value = []
            self.assertFalse(terminal.needs_terminal([]))
            processes.return_value = [os.getpid()]
            self.assertFalse(terminal.needs_terminal(['--help']))
            with patch.object(sys.stdout, 'isatty', return_value=False):
                self.assertFalse(terminal.needs_terminal([]))
            with patch.object(sys, 'frozen', False):
                self.assertFalse(terminal.needs_terminal([]))
            with patch.object(sys, 'platform', 'linux'):
                self.assertFalse(terminal.needs_terminal([]))

    def test_power_shell_stays_open_and_paths_do_not_become_script_code(self):
        executable = Path('/tmp/application with spaces and $symbols/uz_cpld.exe')
        with patch.object(sys, 'executable', str(executable)), \
                patch.dict(os.environ, SystemRoot='C:/Windows'), \
                patch.object(terminal.external, 'environment', return_value={'PATH': 'system-path'}), \
                patch.object(terminal.external, 'system_libraries', return_value=nullcontext()), \
                patch.object(terminal.subprocess, 'call', return_value=0) as call:
            self.assertEqual(terminal.open_terminal(), 0)
        argv = call.call_args.args[0]
        self.assertIn('-NoExit', argv)
        script = base64.b64decode(argv[-1]).decode('utf-16le')
        self.assertNotIn(str(executable.parent), script)
        self.assertIn('Set-Location -LiteralPath', script)
        self.assertEqual(call.call_args.kwargs['cwd'], executable.parent.resolve())
        env = call.call_args.kwargs['env']
        self.assertEqual(env['UZ_CPLD_TERMINAL_DIRECTORY'], str(executable.parent.resolve()))
        self.assertEqual(env['PYINSTALLER_RESET_ENVIRONMENT'], '1')

    def test_entry_point_keeps_normal_cli_dispatch_for_terminal_invocations(self):
        with patch.object(terminal, 'needs_terminal', return_value=False), \
                patch('cpld_toolchain.standalone.main', return_value=7) as cli, \
                patch.object(terminal, 'open_terminal') as shell:
            self.assertEqual(terminal.main(['doctor']), 7)
            cli.assert_called_once_with(['doctor'])
            shell.assert_not_called()
        with patch.object(terminal, 'needs_terminal', return_value=True), \
                patch.object(terminal, 'open_terminal', return_value=0) as shell, \
                patch('cpld_toolchain.standalone.main') as cli:
            self.assertEqual(terminal.main([]), 0)
            shell.assert_called_once()
            cli.assert_not_called()

    @unittest.skipUnless(sys.platform == 'win32', 'Windows console API required')
    def test_actual_windows_console_query_does_not_open_a_shell_for_redirected_output(self):
        self.assertIsInstance(terminal.console_processes(), list)
        with patch.object(sys.stdout, 'isatty', return_value=False):
            self.assertFalse(terminal.needs_terminal([]))


if __name__ == '__main__':
    unittest.main()
