"""The shared container check must preserve failures while collecting results."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[3]


@unittest.skipUnless(shutil.which('bash') and os.name == 'posix', 'Linux CI shell required')
class ContainerCITests(unittest.TestCase):
    def run_checks(self, failing=()):
        temporary = tempfile.TemporaryDirectory(prefix='ci script ')
        self.addCleanup(temporary.cleanup)
        root = Path(temporary.name)
        shutil.copy2(ROOT / 'ci.sh', root / 'ci.sh')
        commands = root / 'bin'
        commands.mkdir()
        # Stub only external tools; execute the real script, pipes and logging.
        for tool, script in {
            'python': '#!/bin/sh\necho "Python step"\n',
            'make': '#!/bin/sh\necho "$*" >> "$CI_CALLS"\necho "output: $*"\n'
                    'case ",$CI_FAIL," in *,$1,*) exit 7;; esac\n',
        }.items():
            path = commands / tool
            path.write_text(script)
            path.chmod(0o755)
        result = subprocess.run(['bash', str(root / 'ci.sh')], cwd=root,
                                env={**os.environ, 'PATH': str(commands) + os.pathsep + os.environ['PATH'],
                                     'CPLD_TOOLCHAIN_CONTAINER': '1', 'CI_CALLS': str(root / 'calls'),
                                     'CI_FAIL': ','.join(failing)},
                                capture_output=True, text=True, timeout=20)
        calls = [line.split()[0] for line in (root / 'calls').read_text().splitlines()]
        return root, result, calls

    def test_success_runs_every_check_and_retains_logs(self):
        root, result, calls = self.run_checks()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(calls, ['test', 'build_all', 'build', 'compare', 'docs'])
        self.assertIn('output: test', (root / 'build/ci-tests.log').read_text())
        self.assertTrue((root / 'build/ci-summary.md').is_file())

    def test_failures_survive_tee_and_later_successes(self):
        root, result, calls = self.run_checks(('test', 'build_all', 'build'))
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(calls, ['test', 'build_all', 'build', 'docs'])
        for name in ('Tooling tests', 'Original FOSS firmware', 'Heartbeat FOSS build and comparison'):
            self.assertIn(name, result.stderr)
            self.assertIn(name, (root / 'build/ci-summary.md').read_text())
        self.assertNotIn('All Linux CI checks passed', result.stdout)
        self.assertTrue((root / 'build/ci-docs.log').is_file())
        self.assertTrue((root / 'build/ci-summary.md').is_file())


if __name__ == '__main__':
    unittest.main()
