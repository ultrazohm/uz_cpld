"""Ensure paired experiments reject confounding changes and missing evidence."""
from contextlib import redirect_stdout
import copy
import io
import json
from pathlib import Path
import tempfile
import unittest

from toolchain import diagnose_diamond_matrix as matrix


class IsolationTests(unittest.TestCase):
    def setUp(self):
        self.env = dict(platform='linux', uid=1001, gid=1001, account=None, groups=[1001],
                        cpu_affinity=[0, 1, 2, 3], diamond_version='3.14', shared_memory_bytes=64 * 1024**2,
                        packages={'returncode': 0, 'output': 'libc6\t2.35\n'},
                        file_sha256={'/opt/lattice/bin/lin64/libprojmngr.so.1': 'vendor', '/lib/libc.so': 'system'},
                        environment={'HOME': '/tmp'}, vendor_environment={'HOME': '/tmp'},
                        system_files={'/proc/self/limits': 'Max stack size   16777216 unlimited bytes\n',
                                      '/sys/fs/cgroup/memory.max': 'max\n',
                                      '/sys/fs/cgroup/memory.swap.max': 'max\n'})
        self.inputs = dict(program='original/test', target='xo2', source_sha256={'input.vhd': 'source'},
                           close_project=True, mode='traced', variant='baseline', preparation='full',
                           inputs_sha256={'prepare.tcl': 'script', 'baseline.sty': 'strategy'},
                           effective_environment={'HOME': '/tmp'})

    def compare(self, case, after=None, candidate=None):
        return matrix.isolation(case, self.env, after or copy.deepcopy(self.env),
                                self.inputs, candidate or copy.deepcopy(self.inputs))

    def test_identical_reference_is_valid_but_vendor_changes_are_rejected(self):
        self.assertEqual(self.compare('reference'), [])
        after = copy.deepcopy(self.env)
        after['file_sha256']['/opt/lattice/bin/lin64/libprojmngr.so.1'] = 'changed'
        for case in ('reference', 'local-image', 'full-installation'):
            with self.subTest(case=case), self.assertRaisesRegex(ValueError, 'Vendor|Native'):
                self.compare(case, after)

    def test_local_image_allows_system_packages_but_not_a_different_uid(self):
        after = copy.deepcopy(self.env)
        after['packages']['output'] = 'libc6\tother\n'
        after['file_sha256']['/lib/libc.so'] = 'other'
        self.assertEqual(self.compare('local-image', after), ['/lib/libc.so'])
        after['uid'] = 1000
        with self.assertRaisesRegex(ValueError, 'uid'):
            self.compare('local-image', after)

    def test_account_changes_only_name_and_requires_effective_change(self):
        with self.assertRaisesRegex(ValueError, 'did not take effect'):
            self.compare('account')
        after = copy.deepcopy(self.env)
        after['account'] = 'diamondtest'
        self.assertEqual(self.compare('account', after), [])
        after['environment']['HOME'] = '/home/new'
        with self.assertRaisesRegex(ValueError, 'environment'):
            self.compare('account', after)

    def test_memory_probe_rejects_accidentally_changing_swap_too(self):
        after = copy.deepcopy(self.env)
        after['system_files']['/sys/fs/cgroup/memory.max'] = str(2 * 1024**3)
        self.assertEqual(self.compare('memory', after), [])
        after['system_files']['/sys/fs/cgroup/memory.swap.max'] = '0'
        with self.assertRaisesRegex(ValueError, 'memory.swap.max'):
            self.compare('memory', after)

    def test_lifecycle_probe_cannot_change_hdl_or_strategy(self):
        candidate = copy.deepcopy(self.inputs)
        candidate['preparation'] = 'no-engine'
        candidate['inputs_sha256']['prepare.tcl'] = 'different-script'
        self.assertEqual(self.compare('no-engine', candidate=candidate), [])
        candidate['source_sha256']['input.vhd'] = 'different-hdl'
        with self.assertRaisesRegex(ValueError, 'source_sha256'):
            self.compare('no-engine', candidate=candidate)

    def test_instrumentation_must_be_applied_only_to_candidate(self):
        with self.assertRaisesRegex(ValueError, 'tracing'):
            self.compare('memcheck')
        candidate = copy.deepcopy(self.inputs)
        candidate['mode'] = 'memcheck'
        self.assertEqual(self.compare('memcheck', candidate=candidate), [])

    def test_missing_results_cannot_be_reported_as_a_fix(self):
        with tempfile.TemporaryDirectory() as tmp, redirect_stdout(io.StringIO()):
            root = Path(tmp)
            (root / 'experiment.json').write_text(json.dumps({'case': 'full-installation'}))
            (root / 'blocked.txt').write_text('Full installation unavailable')
            self.assertEqual(matrix.report(root), 1)
            report = json.loads((root / 'comparison.json').read_text())
            self.assertTrue(report['verdict'].startswith('INVALID'))
            self.assertIn('Full installation unavailable', report['errors'])
            self.assertEqual(matrix.summary(root), 1)
            self.assertIn('Setup failed or artifact unavailable', (root / 'summary.md').read_text())
