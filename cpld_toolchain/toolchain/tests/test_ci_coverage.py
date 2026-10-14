"""CI must expose missing coverage and reject unexpected startup failures."""
import json
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

from cpld_toolchain.toolchain.ci_summary import render
from cpld_toolchain.toolchain.ci_summary import failure_annotations, run_tests
from cpld_toolchain.toolchain.buildsystem.backends.foss import enforce_startup_proof, STARTUP_POLICY, startup_fingerprint
from cpld_toolchain.toolchain import ci_freshness
from cpld_toolchain.toolchain.buildsystem.timing import check_final_timing
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class CoverageTests(unittest.TestCase):
    def test_ci_failure_annotations_preserve_tracebacks_and_escape_control_characters(self):
        from contextlib import redirect_stdout
        import io
        import os
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'tests.log'
            path.write_text('FAIL: test_example (ExampleTests)\n' + '-' * 70 + '\n'
                            'Traceback (most recent call last):\nAssertionError: 100% mismatch\n'
                            + '-' * 70 + '\nRan 1 test in 0.1s\nFAILED (failures=1)\n')
            output = io.StringIO()
            with patch.dict(os.environ, GITHUB_ACTIONS='true'), redirect_stdout(output):
                failures = failure_annotations(path)
            self.assertEqual(len(failures), 1)
            self.assertIn('AssertionError: 100% mismatch', failures[0])
            self.assertIn('::error title=Python test failure::', output.getvalue())
            self.assertIn('%0A', output.getvalue())
            self.assertIn('100%25 mismatch', output.getvalue())
            self.assertNotIn('Ran 1 test', failures[0])

    def test_test_runner_preserves_failure_exit_code_and_complete_log(self):
        from contextlib import redirect_stdout
        import io
        import subprocess
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'build/tests.log'
            result = subprocess.CompletedProcess([], 1, 'failed test output\n')
            with patch('cpld_toolchain.toolchain.ci_summary.subprocess.run', return_value=result), redirect_stdout(io.StringIO()):
                self.assertEqual(run_tests(['example.tests', '-v'], path), 1)
            self.assertEqual(path.read_text(), result.stdout)

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        policy = self.root / STARTUP_POLICY
        policy.parent.mkdir(parents=True)
        policy.write_text(json.dumps({name: {
            'target': 'uz_s3c_xo2', 'input_fingerprint': 'a' * 64,
            'tool_fingerprint': 'c' * 64,
            'outcome': 'output counterexample', 'reason': 'Reviewed unspecified startup outputs.'}
            for name in ('original/s3c_power_on_debounce', 'original/s3c_rev6_beta')}))

    def proof(self, name, outcome='output counterexample', proven=False, target='uz_s3c_xo2', fingerprint='a' * 64, tool_fingerprint='c' * 64):
        build = SimpleNamespace(qualified_name=name, target=target, root=self.root)
        record = dict(result='proven', initial_alignment=outcome, initial_alignment_proven=proven,
                      proof_tool_fingerprint=tool_fingerprint)
        with patch('cpld_toolchain.toolchain.buildsystem.backends.foss.startup_fingerprint', return_value=fingerprint):
            enforce_startup_proof(build, record, self.root / 'equivalence.json')
        return record

    def test_new_program_and_other_release_cannot_inherit_exception(self):
        for name in ('original/new_controller', 'heartbeat/s3c_power_on_debounce'):
            with self.subTest(name=name), self.assertRaises(BuildError):
                self.proof(name)
            record = json.loads((self.root / 'equivalence.json').read_text())
            self.assertEqual(record['result'], 'failed startup acceptance')

    def test_only_documented_output_failures_are_allowed(self):
        for name in ('original/s3c_power_on_debounce', 'original/s3c_rev6_beta'):
            self.assertIn('startup_exception', self.proof(name))
            with self.assertRaises(BuildError):
                self.proof(name, 'internal match-point counterexample')
            with self.assertRaises(BuildError):
                self.proof(name, target='uz_dslot_xo2')
            with self.assertRaises(BuildError):
                self.proof(name, fingerprint='b' * 64)
            with self.assertRaises(BuildError):
                self.proof(name, tool_fingerprint='d' * 64)
            self.assertNotIn('startup_exception', self.proof(name, proven=True))

    def test_successful_new_proof_is_accepted(self):
        self.assertNotIn('startup_exception', self.proof('heartbeat/new', proven=True))

    def test_summary_exposes_skips_exceptions_and_failed_builds(self):
        log = self.root / 'tests.log'
        log.write_text("test_viewer (ViewerTests) ... skipped 'requires browser'\nRan 3 tests in 1.0s\nOK (skipped=1)\n")
        metadata = self.root / 'build/foss/original/s3c_rev6_beta/uz_s3c_xo2/metadata'
        (metadata / 'reports').mkdir(parents=True)
        (metadata / 'build.json').write_text(json.dumps({'warnings': ['warning']}))
        (metadata / 'status.json').write_text(json.dumps({'status': 'failed'}))
        (metadata / 'reports/equivalence.json').write_text(json.dumps(self.proof('original/s3c_rev6_beta')))
        summary = render(self.root, 'foss', Path('tests.log'))
        for expected in ('1 skipped tests', 'requires browser', 'Accepted startup exception',
                         'Unsuccessful build', 'Timing acceptance is not evaluated', '1 recorded warning'):
            self.assertIn(expected, summary)

    def test_missing_evidence_is_not_reported_as_success(self):
        summary = render(self.root, 'foss', Path('missing.log'))
        self.assertIn('Test log unavailable', summary)
        self.assertIn('No completed build records', summary)

    def test_waiver_fingerprint_changes_with_proof_inputs(self):
        build = SimpleNamespace(root=self.root, qualified_name='original/s3c_rev6_beta', target='uz_s3c_xo2')
        with patch('cpld_toolchain.toolchain.buildsystem.workflow.hashes', return_value={'hdl': 'old', STARTUP_POLICY: 'policy1'}):
            first = startup_fingerprint(build)
        with patch('cpld_toolchain.toolchain.buildsystem.workflow.hashes', return_value={'hdl': 'new', STARTUP_POLICY: 'policy1'}):
            self.assertNotEqual(first, startup_fingerprint(build))
        with patch('cpld_toolchain.toolchain.buildsystem.workflow.hashes', return_value={'hdl': 'old', STARTUP_POLICY: 'policy2'}):
            self.assertEqual(first, startup_fingerprint(build))

    def test_final_timing_rejects_violations_missing_and_incomplete_reports(self):
        report = self.root / 'firmware_impl.twr'
        with self.assertRaises(BuildError):
            check_final_timing(report)
        good = 'Lattice TRACE Report - Setup\n10 items scored, 0 timing errors detected.\nReport Summary\n'
        report.write_text(good)
        self.assertEqual(check_final_timing(report)['result'], 'passed')
        for bad in (good.replace('0 timing errors', '1 timing errors'),
                    good.replace('10 items', '0 items'), good.replace('Report Summary', ''),
                    good + '1 constraints not met.\n', 'Lattice Synthesis Timing Report\n' + good.split('\n', 1)[1]):
            report.write_text(bad)
            with self.subTest(report=bad), self.assertRaises(BuildError):
                check_final_timing(report)

    def test_publication_rejects_old_commits_and_api_failure(self):
        with patch.object(ci_freshness.subprocess, 'check_output', return_value=json.dumps({'object': {'sha': 'a' * 40}})):
            self.assertTrue(ci_freshness.is_current('owner/repo', 'refs/heads/master', 'a' * 40))
            self.assertFalse(ci_freshness.is_current('owner/repo', 'refs/heads/master', 'b' * 40))
            self.assertFalse(ci_freshness.is_current('owner/repo', 'refs/tags/v1', 'a' * 40))
        with patch.object(ci_freshness.subprocess, 'check_output', side_effect=RuntimeError('API unavailable')):
            with self.assertRaises(RuntimeError):
                ci_freshness.is_current('owner/repo', 'refs/heads/master', 'a' * 40)

    def test_summary_exposes_skipped_hdl_cases(self):
        result = self.root / 'build/analysis/original/tx30/simulation/results.result.xml'
        result.parent.mkdir(parents=True)
        result.write_text('<testsuite><testcase name="route"/><testcase name="fault"><skipped/></testcase></testsuite>')
        summary = render(self.root, 'foss')
        self.assertIn('1 passed, 1 skipped', summary)
        self.assertIn('`fault`', summary)


if __name__ == '__main__':
    unittest.main()
