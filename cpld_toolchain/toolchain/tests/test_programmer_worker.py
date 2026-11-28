import sys
import unittest
from cpld_toolchain.programmer.client import run


class WorkerProtocolTests(unittest.TestCase):
    def fake(self, source, callback=lambda event: None):
        prefix = "import json,sys; r=json.load(sys.stdin); base={'version':1,'id':r['id']}; "
        return run({'action': 'scan'}, callback, worker_command=[sys.executable, '-c', prefix + source])

    def test_success_and_stderr_drain(self):
        events = []
        result = self.fake("sys.stderr.write('x'*200000+'\\n'); print(json.dumps(dict(base,type='result',ok=True,result={})))", events.append)
        self.assertTrue(result['ok'])
        self.assertEqual(sum(len(e['text']) for e in events), 200001)

    def test_error_result(self):
        result = self.fake("print(json.dumps(dict(base,type='result',ok=False,message='bad input'))); sys.exit(2)")
        self.assertFalse(result['ok'])

    def test_no_success_after_crash(self):
        with self.assertRaisesRegex(RuntimeError, 'outcome unknown'):
            self.fake("print(json.dumps(dict(base,type='result',ok=True,result={}))); sys.exit(3)")

    def test_invalid_protocol_is_not_a_log(self):
        for source in ["print('not json')", "print(json.dumps(dict(base,type='result',ok=True))); print('extra')", "print(json.dumps({'version':2,'id':r['id'],'type':'result','ok':True}))"]:
            with self.subTest(source=source), self.assertRaisesRegex(RuntimeError, 'outcome unknown'):
                self.fake(source)

    def test_callback_error_does_not_interrupt_worker(self):
        def broken(event):
            raise RuntimeError('closed GUI')
        result = self.fake("print(json.dumps(dict(base,type='event',event={'phase':'started'}))); print(json.dumps(dict(base,type='result',ok=True,result={})))", broken)
        self.assertTrue(result['ok'])
