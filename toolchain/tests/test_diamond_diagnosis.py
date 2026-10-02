"""Ensure diagnostics expose native failures and cannot report debugger success."""
from contextlib import redirect_stdout
import importlib.util
import io
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from toolchain import diagnose_diamond as diagnosis
from toolchain.buildsystem.backends import diamond

ROOT = Path(__file__).resolve().parents[2]


class DebuggerStatusTests(unittest.TestCase):
    def test_inferior_status_is_required_and_segfault_survives_debugger_cleanup(self):
        self.assertIsNone(diagnosis.gdb_result('gdb could not start'))
        self.assertEqual(diagnosis.gdb_result('UZ_CPLD_GDB_EXIT=0\n'), 0)
        self.assertEqual(diagnosis.gdb_result('UZ_CPLD_GDB_EXIT=7\n'), 7)
        self.assertEqual(diagnosis.gdb_result('UZ_CPLD_GDB_SIGNAL=SIGSEGV\n'), -signal.SIGSEGV)
        self.assertEqual(diagnosis.gdb_result(
            'UZ_CPLD_GDB_SIGNAL=SIGSEGV\nUZ_CPLD_GDB_EXIT=unknown\n'), -signal.SIGSEGV)

    @unittest.skipUnless(sys.platform == 'linux' and shutil.which('gdb'), 'GDB required')
    def test_real_gdb_preserves_arguments_and_reports_native_signal(self):
        for body, code in [('exit 7', 7), ('ulimit -c 0\nkill -s SEGV $$', -signal.SIGSEGV)]:
            with self.subTest(code=code), tempfile.TemporaryDirectory() as tmp:
                project = Path(tmp)
                binary = project / 'diamondc'
                binary.write_text('#!/bin/bash\n' + body + '\n')
                binary.chmod(0o755)
                result = diagnosis.execute(binary, project, project / 'debugger.log',
                                           env=dict(os.environ), debugger=True, timeout=15)
                self.assertEqual(result['returncode'], code, (project / 'debugger.log').read_text())
                self.assertEqual(result['status'], 'failed')


@unittest.skipUnless(importlib.util.find_spec('tkinter'), 'Tcl interpreter required')
class TclTracingTests(unittest.TestCase):
    def execute(self, lines):
        runner = ('import tkinter,sys,os; t=tkinter.Tcl(); '
                  't.createcommand("exit",lambda code=0: os._exit(int(code))); t.eval(sys.stdin.read())')
        return subprocess.run([sys.executable, '-c', runner],
                              input=diamond.wrap(lines, trace=True), capture_output=True, text=True)

    def test_trace_does_not_evaluate_quoted_command_text_or_repeat_commands(self):
        result = self.execute(['set n 0', 'incr n', 'puts "VALUE=$n"',
                               'set literal {$missing [error forbidden] "quoted"}'])
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('\nVALUE=1\n', result.stdout)
        self.assertIn('UZ_CPLD_DIAMOND_AFTER 4:', result.stdout)
        self.assertTrue(result.stdout.endswith('UZ_CPLD_DIAMOND_BEFORE_EXIT\n'))

    def test_tcl_error_retains_last_before_marker_and_nonzero_exit(self):
        result = self.execute(['set n 0', 'error "expected error"', 'incr n'])
        self.assertEqual(result.returncode, 1)
        self.assertIn('UZ_CPLD_DIAMOND_BEFORE 2:', result.stdout)
        self.assertNotIn('UZ_CPLD_DIAMOND_AFTER 2:', result.stdout)
        self.assertNotIn('UZ_CPLD_DIAMOND_BEFORE_EXIT', result.stdout)
        self.assertIn('expected error', result.stderr)


@unittest.skipUnless(sys.platform == 'linux', 'Linux diagnostic runner')
class ReproducerTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        for relative in ('programs/original/uz_d_voltage_013_tx30', 'toolchain/targets'):
            shutil.copytree(ROOT / relative, self.root / relative,
                            ignore=shutil.ignore_patterns('build', '__pycache__'))
        for relative in ('programs/usercodes.json', 'programs/original/catalog.toml'):
            shutil.copy2(ROOT / relative, self.root / relative)
        self.binary = self.root / 'fake-diamond'

    def replay(self, body, *extra):
        self.binary.write_text(f'#!{sys.executable}\n' + body)
        self.binary.chmod(0o755)
        output = self.root / 'evidence'
        registry = (self.root / 'programs/usercodes.json').read_bytes()
        with patch.object(diagnosis, 'ROOT', self.root), \
                patch.object(diamond, 'launcher', return_value=self.binary), \
                patch.object(diagnosis, 'fingerprint', return_value={}), \
                redirect_stdout(io.StringIO()):
            code = diagnosis.main(['replay', '--output', str(output), '--attempts', '2', *extra])
        self.assertEqual((self.root / 'programs/usercodes.json').read_bytes(), registry)
        return code, output, json.loads((output / 'summary.json').read_text())

    def test_each_native_crash_is_counted_and_partial_project_is_preserved(self):
        code, output, report = self.replay('''import os,signal,resource
from pathlib import Path
resource.setrlimit(resource.RLIMIT_CORE,(0,0))
assert not Path('firmware.ldf').exists()
Path('firmware.ldf').write_text('partially saved')
print('UZ_CPLD_DIAMOND_BEFORE 8: prj_project close',flush=True)
os.kill(os.getpid(),signal.SIGSEGV)
''')
        self.assertEqual(code, 1)
        self.assertEqual(report['attempts'], 2)
        self.assertEqual(report['segfaults'], 2)
        self.assertEqual(report['statuses'], {'failed': 2})
        for attempt in (1, 2):
            directory = output / f'attempt-{attempt:04d}'
            self.assertEqual((directory / 'project/firmware.ldf').read_text(), 'partially saved')
            self.assertIn('prj_project close', (directory / 'diamond.log').read_text())

    def test_successful_exit_and_fresh_temporary_directories(self):
        code, output, report = self.replay('''import os
from pathlib import Path
assert Path(os.environ['TMPDIR']).is_dir()
assert not list(Path(os.environ['TMPDIR']).iterdir())
Path(os.environ['TMPDIR'],'vendor-state').touch()
Path('firmware.ldf').write_text('<BaliProject><Implementation/></BaliProject>')
print('UZ_CPLD_DIAMOND_TCL_STARTED',flush=True)
''', '--variant', 'fresh-tmp')
        self.assertEqual(code, 0)
        self.assertEqual(report['statuses'], {'success': 2})
        self.assertNotEqual(report['results'][0]['tmpdir'], report['results'][1]['tmpdir'])

    def test_no_close_saves_and_preserves_all_other_preparation_commands(self):
        build = diagnosis.load_build(self.root, 'original/uz_d_voltage_013_tx30', backend='diamond')
        project = self.root / 'project'
        control = diagnosis.inputs(build, project, None, True)
        candidate = diagnosis.inputs(build, project, None, True, close_project=False)
        for name in ('baseline.sty', 'constraints.lpf'):
            self.assertEqual(control[name], candidate[name])
        original = diamond.preparation_commands(build, project)
        changed = diamond.preparation_commands(build, project, close_project=False)
        self.assertEqual(original, changed + ['prj_project close'])
        self.assertEqual(changed[-1], 'prj_project save')
        code, output, report = self.replay('''from pathlib import Path
script = Path('prepare.tcl').read_text()
assert 'prj_project close' not in script
assert 'prj_project save' in script
Path('firmware.ldf').write_text('<BaliProject><Implementation/></BaliProject>')
print('UZ_CPLD_DIAMOND_TCL_STARTED', flush=True)
''', '--no-close')
        self.assertEqual(code, 0)
        self.assertFalse(report['close_project'])

    def test_zero_exit_without_a_saved_project_is_not_success(self):
        code, output, report = self.replay('print("UZ_CPLD_DIAMOND_TCL_STARTED")\n')
        self.assertEqual(code, 1)
        self.assertEqual(report['statuses'], {'failed': 2})
        self.assertTrue(all('validation_error' in r for r in report['results']))

    def test_timeout_fails_instead_of_hanging_or_retrying(self):
        code, output, report = self.replay('import time; time.sleep(30)\n', '--timeout', '1')
        self.assertEqual(code, 1)
        self.assertTrue(all(r['timeout'] for r in report['results']))
        self.assertEqual(report['segfaults'], 0)

    def test_debugger_that_fails_to_launch_inferior_is_not_success(self):
        with tempfile.TemporaryDirectory() as tmp:
            project = Path(tmp)
            (project / 'gdb').write_text('#!/bin/sh\necho "could not launch inferior"\nexit 0\n')
            (project / 'gdb').chmod(0o755)
            env = dict(os.environ, PATH=str(project) + os.pathsep + os.environ.get('PATH', ''))
            result = diagnosis.execute(Path('/missing/diamondc'), project, project / 'gdb.log',
                                       env=env, debugger=True, timeout=5)
            self.assertEqual(result['status'], 'failed')
            self.assertIsNone(result['returncode'])
