"""Fail-closed native identity protocol and whole-session programming tests."""
from contextlib import contextmanager
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch, Mock

from cpld_toolchain.programmer_helper import foss, program
from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.buildsystem.workflow import digest


class FossTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.registry = {'schema_version': 1, 'next_program': 1, 'programs': {}}

    def raw(self, count=5, code='80000001', sram=None, high='FF', silicon='0000000000000'):
        return ''.join(f'UZ_IDENTITY_V1 {i} {"012BC043" if count == 1 else "012BB043"} '
                       f'{code} {sram or code} {high}{silicon}{i}\n' for i in range(count)) + \
            f'UZ_IDENTITY_END_V1 {count}\n'

    def test_chain_positions_and_distinct_stores_are_not_reversed(self):
        devices = foss.parse(self.root, 'dslots', self.raw(sram='90000001'), registry=self.registry)
        self.assertEqual([d['label'] for d in devices], [f'slot{i}' for i in range(1, 6)])
        self.assertEqual([d['silicon_id'] for d in devices], [f'{i:014X}' for i in range(5)])
        self.assertTrue(all(d['usercode'] == '80000001' and d['sram_usercode'] == '90000001' for d in devices))

    def test_protocol_rejects_partial_duplicate_out_of_order_or_wrong_chain(self):
        valid = self.raw()
        for text in ('', valid.replace('UZ_IDENTITY_END_V1 5', ''), valid+valid,
                     valid.replace('V1 1 012', 'V1 0 012'), valid.replace('012BB043', '012BC043'),
                     valid.replace('V1 3 012', 'V1 4 012'), valid+'UZ_IDENTITY_BOGUS\n',
                     valid.replace('FF00000000000000', 'short'), valid.replace('V1 5\n', 'V1 4\n')):
            with self.subTest(text=text), self.assertRaises(BuildError):
                foss.parse(self.root, 'dslots', text, registry=self.registry)

    def test_runner_records_failure_and_kills_a_timed_out_process(self):
        log = self.root / 'run.log'
        with self.assertRaisesRegex(BuildError, 'exit code 3'):
            foss.run([sys.executable, '-c', 'print("failed"); exit(3)'], log)
        self.assertIn('failed', log.read_text())
        with self.assertRaisesRegex(BuildError, 'timed out'):
            foss.run([sys.executable, '-c', 'import time; time.sleep(60)'], log, timeout=0.05)

    def test_interrupt_reaps_the_process_before_returning_to_the_usb_guard(self):
        process = Mock()
        process.wait.side_effect = [KeyboardInterrupt(), 0]
        with patch.object(foss.subprocess, 'Popen', return_value=process), self.assertRaises(KeyboardInterrupt):
            foss.run(['/loader'], self.root / 'interrupted.log')
        process.kill.assert_called_once()
        self.assertEqual(process.wait.call_count, 2)

    def exercise(self, *, count=5, after=None, failure=None, invalid_file=False):
        chain = 's3c' if count == 1 else 'dslots'
        steps, builds, identities = [], [], {}
        for i in range(count):
            path = self.root / f'input{i}.jed'
            path.write_bytes(b'fixture')
            label = 's3c' if count == 1 else f'slot{i+1}'
            step = program.Step(label, object(), path, digest(path),
                                ('/loader', '--index-chain', str(i), '--write-flash', '--verify', str(path)))
            steps.append(step)
            builds.append((label, i, step.build))
            identities[label] = {'usercode': '80000001'}
        record = {'steps': []}
        run_dir = self.root / 'run'
        run_dir.mkdir()
        calls = []
        held = False
        @contextmanager
        def guard(*a, **k):
            nonlocal held
            self.assertFalse(held)
            held = True
            calls.append('acquire')
            try:
                yield
            finally:
                held = False
                calls.append('release')
        reads = 0
        def run(command, log, *, timeout=60):
            nonlocal reads
            self.assertTrue(held)
            if '--read-identity' in command:
                reads += 1
                calls.append('read')
                if failure == 'read':
                    raise BuildError('read failed')
                return self.raw(count) if reads == 1 or after is None else after(reads)
            calls.append('write')
            if failure == 'write':
                raise BuildError('write failed')
            snapshot = Path(command[-1])
            self.assertEqual(snapshot.parent, run_dir / 'firmware')
            self.assertEqual(snapshot.read_bytes(), b'fixture')
            i = int(command[command.index('--index-chain')+1])
            self.assertEqual(command[command.index('--expected-silicon')+1], f'{i:014X}')
        def check(*a):
            self.assertFalse(held)
            calls.append('validate')
            if invalid_file:
                raise ValueError('invalid file')
        with patch.object(program, 'loader_path', return_value=Path('/loader')), \
                patch.object(foss.flasher, 'verify', return_value={}), \
                patch.object(foss.flasher, 'check_file', side_effect=check), \
                patch.object(foss, 'diamond_usb', side_effect=guard), \
                patch.object(foss, 'run', side_effect=run):
            try:
                foss.execute(self.root, chain, builds, steps, identities, run_dir, record,
                             None, 'probe serial', None, SimpleNamespace(registry=self.registry))
            finally:
                self.calls = calls
                self.assertFalse(held)
        return record

    def test_one_lock_snapshots_all_files_and_immutable_trace_id(self):
        record = self.exercise(after=lambda _: self.raw(high='01'))
        self.assertEqual(self.calls, ['validate']*5+['acquire', 'read']+['write']*5+['read', 'release'])
        self.assertEqual(len(record['steps']), 5)

    def test_sram_activation_can_settle_without_reprogramming(self):
        with patch.object(foss.time, 'sleep'):
            self.exercise(count=1, after=lambda n: self.raw(1, sram='00000000' if n == 2 else '80000001'))
        self.assertEqual(self.calls.count('write'), 1)
        self.assertEqual(self.calls.count('read'), 3)

    def test_bad_files_are_rejected_before_usb(self):
        with self.assertRaises(ValueError):
            self.exercise(invalid_file=True)
        self.assertEqual(self.calls, ['validate'])

    def test_failed_write_releases_lock_and_does_not_retry(self):
        with self.assertRaisesRegex(BuildError, 'write failed'):
            self.exercise(failure='write')
        self.assertEqual(self.calls.count('write'), 1)
        self.assertEqual(self.calls[-1], 'release')

    def test_failed_pre_read_prevents_writes(self):
        with self.assertRaisesRegex(BuildError, 'read failed'):
            self.exercise(failure='read')
        self.assertNotIn('write', self.calls)

    def test_changed_silicon_is_rejected_even_when_usercode_matches(self):
        with self.assertRaisesRegex(BuildError, 'Silicon identity'):
            self.exercise(after=lambda _: self.raw(silicon='1000000000000'))

    def test_flash_mismatch_is_not_retried(self):
        with self.assertRaisesRegex(BuildError, 'Flash USERCODE'):
            self.exercise(after=lambda _: self.raw(code='00000000'))
        self.assertEqual(self.calls.count('read'), 2)

    def test_sram_mismatch_expires(self):
        with patch.object(foss.time, 'monotonic', side_effect=[0, 11]), \
                self.assertRaisesRegex(BuildError, 'SRAM USERCODE'):
            self.exercise(after=lambda _: self.raw(sram='00000000'))

    def test_loader_changed_during_session_is_rejected_before_execution(self):
        with patch.object(foss.flasher, 'verify', side_effect=[{'binary': 'a'}, {'binary': 'b'}]), \
                patch.object(foss, 'run') as run:
            active = foss.Session('/loader', 's3c')
            with self.assertRaisesRegex(BuildError, 'changed during'):
                active.checked_run(active.command, self.root / 'log')
        run.assert_not_called()
