"""Native failures must surface on the first attempt and retain evidence."""
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

    def test_startup_segfault_fails_once_and_preserves_log(self):
        with self.assertRaisesRegex(BuildError, r'SIGSEGV.*prepare.log'):
            self.invoke([(-signal.SIGSEGV, 'launcher diagnostic\n'),
                         (0, 'must not retry')])
        self.assertEqual(self.calls, 1)
        self.assertEqual((self.directory / 'prepare.log').read_text(), 'launcher diagnostic\n')
        self.assertFalse((self.directory / 'prepare-retry1.log').exists())

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
    def test_prepare_crash_preserves_partial_project_without_retry(self):
        from types import SimpleNamespace

        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            project = root / 'project'
            (root / 'metadata').mkdir()
            identity = root / 'metadata/identity.json'
            identity.write_text('{}')
            strategy = root / 'strategy.sty'
            strategy.write_text('original strategy')
            build = SimpleNamespace(strategy=strategy, device='LCMXO2-2000HC',
                                    synthesis='lse', sources=[], options={},
                                    standard='2008', top='top')
            log = root / 'prepare.log'

            def execute(*args, **kwargs):
                kwargs['stdout'].write(diamond.STARTUP_MARKER + '\n')
                (project / 'impl').mkdir()
                (project / 'impl/partial.ngd').write_text('partial output')
                (project / 'firmware.ldf').write_text('broken project')
                return subprocess.CompletedProcess(args, -signal.SIGSEGV)

            with patch.object(diamond, 'launcher', return_value=Path('/diamondc')), \
                    patch.object(diamond, 'environment', return_value={}), \
                    patch('toolchain.buildsystem.identity.validate_identity', return_value={}), \
                    patch('toolchain.buildsystem.identity.constraint_text', return_value='constraints'), \
                    patch.object(diamond.subprocess, 'run', side_effect=execute) as run:
                with self.assertRaisesRegex(BuildError, 'SIGSEGV.*prepare.log'):
                    diamond.DiamondBackend().prepare(build, project, log)
            self.assertEqual(run.call_count, 1)
            self.assertEqual((project / 'impl/partial.ngd').read_text(), 'partial output')
            self.assertEqual((project / 'firmware.ldf').read_text(), 'broken project')
            self.assertEqual(identity.read_text(), '{}')
            self.assertIn(diamond.STARTUP_MARKER, log.read_text())
            self.assertFalse((root / 'prepare-retry1.log').exists())
