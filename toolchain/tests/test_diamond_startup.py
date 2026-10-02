"""Bound native crash retries and reset partially prepared projects."""
from contextlib import redirect_stderr
import io
from pathlib import Path
import signal
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from toolchain.buildsystem.backends import diamond
from toolchain.buildsystem.model import BuildError


class DiamondStartupTests(unittest.TestCase):
    def invoke(self, outcomes, marked=True):
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        directory = Path(tmp.name)
        script = directory / 'prepare.tcl'
        script.write_text(diamond.wrap(['error "project error"']) if marked else 'exit 0\n')
        log = directory / 'prepare.log'
        pending = iter(outcomes)

        def execute(*args, **kwargs):
            code, output = next(pending)
            kwargs['stdout'].write(output)
            return subprocess.CompletedProcess(args, code)

        self.stderr = io.StringIO()
        with patch.object(diamond, 'launcher', return_value=Path('/diamondc')), \
                patch.object(diamond, 'environment', return_value={}), \
                patch.object(diamond.subprocess, 'run', side_effect=execute) as run, \
                redirect_stderr(self.stderr):
            try:
                output = diamond.run(script, log)
            finally:
                self.calls = run.call_count
                self.directory = directory
        return output

    def test_startup_segfault_retries_once_and_preserves_logs(self):
        output = self.invoke([(-signal.SIGSEGV, 'launcher diagnostic\n'),
                              (0, diamond.STARTUP_MARKER + '\nsuccess\n')])
        self.assertEqual(self.calls, 2)
        self.assertIn('success', output)
        combined = (self.directory / 'prepare.log').read_text()
        self.assertTrue(combined.startswith('launcher diagnostic\n'))
        self.assertIn(output, combined)
        self.assertEqual((self.directory / 'prepare-retry1.log').read_text(), output)
        self.assertIn('retrying once', self.stderr.getvalue())

    def test_repeated_startup_segfault_fails_with_retry_log(self):
        with self.assertRaisesRegex(BuildError, r'SIGSEGV.*prepare-retry1.log'):
            self.invoke([(-signal.SIGSEGV, ''), (-signal.SIGSEGV, '')])
        self.assertEqual(self.calls, 2)
        self.assertTrue((self.directory / 'prepare.log').exists())

    def test_project_crashes_and_other_errors_are_not_retried(self):
        for code, output, marked in [(-signal.SIGSEGV, diamond.STARTUP_MARKER + '\n', True),
                                     (1, 'Tcl error', True),
                                     (-signal.SIGTERM, '', True),
                                     (-signal.SIGSEGV, '', False)]:
            with self.subTest(code=code, output=output, marked=marked):
                with self.assertRaises(BuildError):
                    self.invoke([(code, output)], marked=marked)
                self.assertEqual(self.calls, 1)

    def test_success_does_not_retry(self):
        self.assertEqual(self.invoke([(0, diamond.STARTUP_MARKER)]), diamond.STARTUP_MARKER)
        self.assertEqual(self.calls, 1)

    def test_marker_is_flushed_before_project_commands(self):
        self.assertTrue(diamond.wrap(['prj_project new']).startswith(
            f'puts "{diamond.STARTUP_MARKER}"\nflush stdout\nif {{[catch {{\nprj_project new'))

class DiamondPreparationTests(unittest.TestCase):
    def test_prepare_retry_discards_partial_project_and_preserves_inputs(self):
        from types import SimpleNamespace

        for second_code in (0, -signal.SIGSEGV):
            with self.subTest(second_code=second_code), tempfile.TemporaryDirectory() as tmp:
                root = Path(tmp)
                project = root / 'project'
                metadata = root / 'metadata'
                metadata.mkdir()
                identity = metadata / 'identity.json'
                identity.write_text('{}')
                strategy = root / 'strategy.sty'
                strategy.write_text('original strategy')
                build = SimpleNamespace(strategy=strategy, device='LCMXO2-2000HC',
                                        synthesis='lse', sources=[], options={},
                                        standard='2008', top='top')
                log = root / 'prepare.log'
                original_inputs = {}

                def execute(*args, **kwargs):
                    kwargs['stdout'].write(diamond.STARTUP_MARKER + '\n')
                    if not original_inputs:
                        original_inputs.update({p.name: p.read_bytes() for p in project.iterdir()})
                        (project / 'impl').mkdir()
                        (project / 'impl/partial.ngd').write_text('partial output')
                        (project / 'firmware.ldf').write_text('broken project')
                        (project / 'baseline.sty').write_text('vendor changes')
                        return subprocess.CompletedProcess(args, -signal.SIGSEGV)
                    self.assertEqual({p.name: p.read_bytes() for p in project.iterdir()}, original_inputs)
                    self.assertEqual(identity.read_text(), '{}')
                    self.assertIn(diamond.STARTUP_MARKER, log.read_text())
                    if second_code == 0:
                        (project / 'firmware.ldf').write_text('<Project><Implementation/></Project>')
                    return subprocess.CompletedProcess(args, second_code)

                with patch.object(diamond, 'launcher', return_value=Path('/diamondc')), \
                        patch.object(diamond, 'environment', return_value={}), \
                        patch('toolchain.buildsystem.identity.validate_identity', return_value={}), \
                        patch('toolchain.buildsystem.identity.constraint_text', return_value='constraints'), \
                        patch.object(diamond.subprocess, 'run', side_effect=execute) as run, \
                        redirect_stderr(io.StringIO()):
                    if second_code:
                        with self.assertRaisesRegex(BuildError, 'SIGSEGV.*prepare-retry1.log'):
                            diamond.DiamondBackend().prepare(build, project, log)
                    else:
                        diamond.DiamondBackend().prepare(build, project, log)
                        self.assertIn('def_top="top"', (project / 'firmware.ldf').read_text())
                self.assertEqual(run.call_count, 2)
                self.assertTrue((root / 'prepare-retry1.log').exists())
