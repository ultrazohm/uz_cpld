import json
from pathlib import Path
import subprocess
import sys
import tempfile
import threading
import unittest
from urllib.error import HTTPError
from urllib.request import Request, urlopen

HERE = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(HERE))
from standalone import Session, ThreadingHTTPServer, handler


class TransportTests(unittest.TestCase):
    def bridge(self, request, demo=False):
        run = subprocess.run([sys.executable, str(HERE / 'bridge.py'), *(['--demo'] if demo else [])],
                             input=json.dumps({'version': 1, 'id': 'test', 'request': request}), capture_output=True, text=True, cwd=tempfile.gettempdir())
        messages = [json.loads(line) for line in run.stdout.splitlines()]
        self.assertEqual(messages[-1]['type'], 'result')
        return messages[-1]

    def test_real_api_preserves_explicit_assignments(self):
        with tempfile.TemporaryDirectory() as directory:
            result = self.bridge(dict(action='save', workspace=directory,
                                      selection={'release': 'original', 's3c': 's3c_test'}))
            self.assertTrue(result['ok'], result)
            saved = (Path(directory) / 'selection.toml').read_text()
            self.assertIn('s3c_test', saved)
            self.assertNotIn('[slots]', saved)

    def test_real_api_rejects_unreviewed_execution(self):
        with tempfile.TemporaryDirectory() as directory:
            result = self.bridge(dict(action='execute', workspace=directory, plan_id='../invalid', review_sha256='a' * 64))
            self.assertFalse(result['ok'])
            self.assertIn('Invalid plan ID', result['message'])

    def test_demo_does_not_create_workspace(self):
        with tempfile.TemporaryDirectory() as directory:
            workspace = Path(directory) / 'must-not-exist'
            for action in ('load', 'scan', 'identify', 'save', 'drivers', 'execute'):
                result = self.bridge(dict(action=action, workspace=str(workspace)), demo=True)
                self.assertTrue(result['ok'], result)
            self.assertFalse(workspace.exists())

    def test_session_serializes_jobs_and_preserves_results(self):
        session = Session('/unused-demo-workspace', demo=True)
        token = session.start({'action': 'load'})
        with self.assertRaisesRegex(ValueError, 'still running'):
            session.start({'action': 'scan'})
        session.thread.join(5)
        result = session.snapshot(token, 0)
        self.assertTrue(result['done'])
        self.assertTrue(result['result']['ok'])
        self.assertTrue(result['events'])
        self.assertIsNone(session.context()['active_job'])

    def test_http_requires_session_token_and_loopback_host(self):
        session = Session('/unused-demo-workspace', demo=True)
        server = ThreadingHTTPServer(('127.0.0.1', 0), handler(session))
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        url = f'http://127.0.0.1:{server.server_port}'
        try:
            for headers in ({}, {'X-Programmer-Token': session.token, 'Host': 'untrusted.example'}):
                with self.assertRaises(HTTPError) as raised:
                    urlopen(Request(url + '/api/context', headers=headers))
                self.assertEqual(raised.exception.code, 403)
            with urlopen(Request(url + '/api/context', headers={'X-Programmer-Token': session.token})) as response:
                self.assertTrue(json.load(response)['demo'])
            with urlopen(url) as response:
                page = response.read().decode()
                self.assertNotIn('__CSP__', page)
                self.assertIn(session.token, page)
        finally:
            server.shutdown()
            server.server_close()
            thread.join()


if __name__ == '__main__':
    unittest.main()
