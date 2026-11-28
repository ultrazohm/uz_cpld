"""Optional external tools must not disable unrelated application functionality."""
from contextlib import redirect_stdout, redirect_stderr
import io
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from rich.text import Text

from cpld_toolchain import capabilities, runtime, tools
from cpld_toolchain.toolchain import commands
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class CapabilityTests(unittest.TestCase):
    def test_help_lists_every_command_even_when_every_dependency_is_missing(self):
        with patch.object(capabilities, 'missing', return_value='missing') as probe, \
                redirect_stdout(io.StringIO()) as output:
            self.assertEqual(commands.main(['help']), 0)
        probe.assert_not_called()
        for name in commands.COMMANDS:
            self.assertIn('uz_cpld ' + name, output.getvalue())

    def test_command_help_and_numeric_validation_are_specific(self):
        with redirect_stdout(io.StringIO()) as output:
            self.assertEqual(commands.main(['scan', '--help']), 0)
        help_text = Text.from_ansi(output.getvalue()).plain
        self.assertIn('--probe-index', help_text)
        self.assertNotIn('--release-cycle', help_text)
        with patch.object(runtime, 'execute') as execute, redirect_stderr(io.StringIO()):
            self.assertEqual(commands.main(['sim', '--jobs', '0']), 2)
        execute.assert_not_called()

    def test_docs_missing_dependencies_do_not_import_or_execute_the_workflow(self):
        with patch.object(capabilities, 'missing', side_effect=lambda r: 'GHDL' if r.value == 'ghdl' else None), \
                patch.object(runtime, 'execute') as execute, redirect_stderr(io.StringIO()) as errors:
            self.assertEqual(commands.main(['docs']), 2)
        execute.assert_not_called()
        self.assertIn('GHDL', errors.getvalue())
        self.assertIn('uz_cpld doctor', errors.getvalue())

    def test_preview_does_not_check_dependencies(self):
        with patch.object(capabilities, 'missing', side_effect=AssertionError('probed')), \
                patch.object(runtime, 'execute') as execute, redirect_stdout(io.StringIO()):
            self.assertEqual(commands.main(['docs', '--dry-run', '1']), 0)
        execute.assert_not_called()

    def test_list_and_init_need_no_external_tools(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(capabilities, 'missing', side_effect=AssertionError('probed')), \
                redirect_stdout(io.StringIO()):
            self.assertEqual(commands.main(['list', '--release-cycle', 'original']), 0)
            selection = Path(tmp) / 'selection.toml'
            self.assertEqual(commands.main(['init_programmer', '--selection', str(selection), '--release', '']), 0)
            self.assertTrue(selection.is_file())

    def test_backend_requirements_are_independent_and_never_switch_backend(self):
        diamond = capabilities.requirements('program', {'backend': 'diamond'})
        self.assertIn('programmer', [r.value for r in diamond])
        self.assertNotIn('cli', [r.value for r in diamond])
        foss = capabilities.requirements('program', {'programmer_backend': 'foss'})
        self.assertEqual({r.value for r in foss}, {'openFPGALoader'})
        self.assertEqual({r.value for r in capabilities.requirements('scan', {'backend': 'foss'})}, {'openFPGALoader'})
        self.assertEqual({r.value for r in capabilities.requirements('identify', {'backend': 'foss'})}, {'openFPGALoader'})
        self.assertEqual(capabilities.requirements('diamond_xcf_programming_chain', {}), ())
        self.assertEqual({r.value for r in capabilities.requirements('project', {})}, {'cli'})
        self.assertEqual({r.value for r in capabilities.requirements('gui', {})}, {'cli', 'gui'})
        with patch.object(capabilities, 'missing', return_value='Diamond unavailable'), patch.object(runtime, 'execute') as execute:
            with self.assertRaisesRegex(BuildError, 'Diamond unavailable'):
                commands.run('program', {'target': 'dslot'})
        execute.assert_not_called()

    def test_internal_dispatch_uses_a_callable_and_restores_cwd(self):
        before = Path.cwd()
        call, = commands.plan('init_programmer', {'selection': 'selection.toml'})
        with patch.object(runtime, 'import_module') as module, patch.object(runtime.subprocess, 'run') as child:
            module.return_value.main.return_value = 0
            runtime.execute(call)
            module.return_value.main.assert_called_once_with(list(call.arguments))
            child.assert_not_called()
            module.return_value.main.side_effect = SystemExit(2)
            with self.assertRaises(BuildError):
                runtime.execute(call)
        self.assertEqual(Path.cwd(), before)

    def test_help_and_list_do_not_import_simulation_or_documentation_dependencies(self):
        script = '''
import sys
class Block:
    def find_spec(self, fullname, path=None, target=None):
        if fullname.split('.')[0] in {'sphinx', 'cocotb', 'pytest', 'plotly', 'vcd'}:
            raise ImportError('unexpected optional import: ' + fullname)
sys.meta_path.insert(0, Block())
from cpld_toolchain.__main__ import main
assert main(['help']) == 0
assert main(['list', '--release-cycle', 'original']) == 0
'''
        result = subprocess.run([sys.executable, '-c', script], cwd=commands.ROOT,
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(result.returncode, 0, result.stderr)


class ToolDiscoveryTests(unittest.TestCase):
    def binary(self, path):
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(b'tool')
        path.chmod(0o755)
        return path

    def test_explicit_override_is_authoritative_even_when_missing(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            bundled = self.binary(base / 'bundle/openFPGALoader')
            custom = self.binary(base / 'custom/openFPGALoader')
            with patch.dict(os.environ, {'CPLD_BUNDLED_TOOLS': str(bundled.parent),
                                        'CPLD_OPENFPGALOADER': str(custom)}, clear=True):
                self.assertEqual(tools.loader_path(), custom)
                custom.unlink()
                self.assertEqual(tools.loader_path(), custom)
                self.assertFalse(tools.installed(tools.loader_path()))

    def test_bundled_tools_win_over_system_tools_and_find_windows_exe(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            filename = 'testtool.exe' if sys.platform == 'win32' else 'testtool'
            system = self.binary(base / 'system' / filename)
            bundled = self.binary(base / 'bundle' / filename)
            with patch.dict(os.environ, {'PATH': str(system.parent), 'PATHEXT': '.EXE',
                                        'CPLD_BUNDLED_TOOLS': str(bundled.parent)}, clear=True):
                self.assertEqual(tools.executable('testtool'), bundled)
                bundled.unlink()
                self.assertEqual(tools.executable('testtool'), system)
                windows = self.binary(base / 'bundle/testtool.exe')
                with patch.object(sys, 'platform', 'win32'):
                    self.assertEqual(tools.executable('testtool'), windows)
