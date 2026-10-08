"""CI must expose missing coverage and reject unexpected startup failures."""
import json
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest

from cpld_toolchain.toolchain.ci_summary import render
from cpld_toolchain.toolchain.buildsystem.backends.foss import enforce_startup_proof
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class CoverageTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)

    def proof(self, name, outcome='output counterexample', proven=False, target='uz_s3c_xo2'):
        build = SimpleNamespace(qualified_name=name, target=target)
        record = dict(result='proven', initial_alignment=outcome, initial_alignment_proven=proven)
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


if __name__ == '__main__':
    unittest.main()
