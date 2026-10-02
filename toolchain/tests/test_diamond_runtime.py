"""Reject confounded runtime comparisons and crashes hidden by aggregate counts."""
from contextlib import redirect_stdout
import io
import json
from pathlib import Path
import tempfile
import unittest

from toolchain.diagnose_diamond_runtime import validate


class RuntimeComparisonTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        for arm, revision in [('control', '14'), ('candidate', '15')]:
            (self.root / arm).mkdir()
            env = {k: None for k in ('platform', 'uid', 'gid', 'account', 'groups', 'cpu_affinity',
                                     'environment', 'vendor_environment', 'diamond_version')}
            env['packages'] = {'returncode': 0, 'output':
                f'libc6:amd64\t2.35-0ubuntu3.{revision}\nlibc-bin\t2.35-0ubuntu3.{revision}\nother\t1\n'}
            env['file_sha256'] = {'/lib/x86_64-linux-gnu/libc.so.6': revision,
                                  '/lib64/ld-linux-x86-64.so.2': revision,
                                  '/opt/lattice/bin/lin64/libprojmngr.so.1': 'same'}
            inputs = {k: 'same' for k in ('program', 'target', 'inputs_sha256', 'source_sha256', 'mode', 'variant')}
            inputs['close_project'] = True
            report = {'attempts': 100, 'close_project': True, 'statuses': {'success': 100}, 'segfaults': 0,
                      'results': [{'status': 'success', 'returncode': 0, 'timeout': False,
                                   'last_marker': 'UZ_CPLD_DIAMOND_BEFORE_EXIT'} for _ in range(100)]}
            for name, data in [('environment.json', env), ('inputs.json', inputs), ('summary.json', report)]:
                self.write(arm, name, data)

    def write(self, arm, name, data):
        (self.root / arm / name).write_text(json.dumps(data))

    def change(self, arm, name, mutate):
        data = json.loads((self.root / arm / name).read_text())
        mutate(data)
        self.write(arm, name, data)

    def check(self):
        with redirect_stdout(io.StringIO()):
            validate(self.root)

    def test_control_segfault_does_not_reject_clean_candidate(self):
        def crash(d):
            d.update(statuses={'success': 99, 'failed': 1}, segfaults=1)
            d['results'][0].update(status='failed', returncode=-11)
        self.change('control', 'summary.json', crash)
        self.check()

    def test_vendor_library_change_invalidates_comparison(self):
        self.change('candidate', 'environment.json', lambda d:
                    d['file_sha256'].update({'/opt/lattice/bin/lin64/libprojmngr.so.1': 'changed'}))
        with self.assertRaisesRegex(ValueError, 'native-library'):
            self.check()

    def test_unrelated_package_upgrade_invalidates_comparison(self):
        self.change('candidate', 'environment.json', lambda d:
                    d['packages'].update(output=d['packages']['output'].replace('other\t1', 'other\t2')))
        with self.assertRaisesRegex(ValueError, 'package changes'):
            self.check()

    def test_candidate_crash_cannot_be_hidden_by_summary(self):
        self.change('candidate', 'summary.json', lambda d:
                    d['results'][0].update(status='failed', returncode=-11))
        with self.assertRaisesRegex(ValueError, 'candidate crash'):
            self.check()

    def test_missing_attempt_invalidates_comparison(self):
        self.change('candidate', 'summary.json', lambda d: d['results'].pop())
        with self.assertRaisesRegex(ValueError, 'incomplete'):
            self.check()
