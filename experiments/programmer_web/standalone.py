"""Local browser/desktop host for the isolated programmer GUI prototype."""
import argparse
from collections import deque
import html
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
from pathlib import Path
import secrets
import subprocess
import sys
import threading
from urllib.parse import parse_qs, urlsplit
import webbrowser

HERE = Path(__file__).resolve().parent


class Session:
    def __init__(self, workspace, demo=False):
        self.workspace = str(Path(workspace).expanduser().resolve())
        self.demo = demo
        self.token = secrets.token_hex(32)
        self.lock = threading.Lock()
        self.jobs = {}
        self.active = None
        self.thread = None

    def context(self):
        with self.lock:
            return dict(workspace=self.workspace, demo=self.demo, platform=sys.platform,
                        host='standalone', busy=self.active is not None, active_job=self.active)

    def start(self, request):
        if not isinstance(request, dict) or not isinstance(request.get('action'), str):
            raise ValueError('Supply an operation request.')
        with self.lock:
            if self.active:
                raise ValueError('Another programmer operation is still running.')
            token = secrets.token_hex(16)
            request = dict(request, workspace=self.workspace)
            while len(self.jobs) >= 20:
                self.jobs.pop(next(iter(self.jobs)))
            self.jobs[token] = dict(action=request['action'], events=deque(maxlen=2000), cursor=0, done=False)
            self.active = token
            self.thread = threading.Thread(target=self._run, args=(token, request))
            self.thread.start()
            return token

    def event(self, token, event):
        with self.lock:
            job = self.jobs[token]
            job['cursor'] += 1
            job['events'].append((job['cursor'], event))

    def snapshot(self, token, cursor):
        with self.lock:
            job = self.jobs[token]
            return dict(action=job['action'], cursor=job['cursor'], done=job['done'],
                        events=[e for n, e in job['events'] if n > cursor], result=job.get('result'))

    def _run(self, token, request):
        result = None
        try:
            command = [sys.executable, '-u', str(HERE / 'bridge.py')]
            if self.demo:
                command.append('--demo')
            sys.path.insert(0, str(HERE.parents[1]))
            from cpld_toolchain.programmer.client import run
            result = run(request, lambda event: self.event(token, event), worker_command=command)
        except Exception as exc:
            result = dict(ok=False, message=str(exc))
        finally:
            with self.lock:
                self.jobs[token].update(done=True, result=result)
                self.active = None


def handler(session):
    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_):
            pass

        def reply(self, status, value, content_type='application/json'):
            data = json.dumps(value).encode() if content_type == 'application/json' else value
            self.send_response(status)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(data)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.send_header('X-Frame-Options', 'DENY')
            self.end_headers()
            self.wfile.write(data)

        def authorized(self):
            # All API calls require a per-launch token; no CORS access is granted.
            return secrets.compare_digest(self.headers.get('X-Programmer-Token', '').encode(), session.token.encode())

        def local_host(self):
            return self.headers.get('Host') == f'127.0.0.1:{self.server.server_port}'

        def do_GET(self):
            if not self.local_host():
                return self.reply(403, {'message': 'Use the local launch URL.'})
            url = urlsplit(self.path)
            try:
                if url.path.startswith('/api/'):
                    if not self.authorized():
                        return self.reply(403, {'message': 'Invalid session token.'})
                    if url.path == '/api/context':
                        return self.reply(200, session.context())
                    if url.path == '/api/job':
                        query = parse_qs(url.query)
                        return self.reply(200, session.snapshot(query['id'][0], int(query.get('cursor', ['0'])[0])))
                    return self.reply(404, {'message': 'Unknown endpoint.'})
                if url.path == '/':
                    nonce = secrets.token_hex(16)
                    page = (HERE / 'web/index.html').read_text()
                    csp = f"default-src 'none'; style-src 'self'; script-src 'nonce-{nonce}'; connect-src 'self';"
                    page = (page.replace('__STYLE__', '/style.css').replace('__SCRIPT__', '/app.js')
                            .replace('__NONCE__', nonce).replace('__CSP__', html.escape(csp, quote=True))
                            .replace('__TOKEN__', session.token))
                    return self.reply(200, page.encode(), 'text/html; charset=utf-8')
                if url.path in ('/app.js', '/style.css'):
                    mime = 'text/javascript' if url.path.endswith('.js') else 'text/css'
                    return self.reply(200, (HERE / 'web' / url.path[1:]).read_bytes(), mime)
                self.reply(404, {'message': 'Not found.'})
            except (KeyError, ValueError) as exc:
                self.reply(400, {'message': str(exc)})

        def do_POST(self):
            if not self.local_host() or not self.authorized():
                return self.reply(403, {'message': 'Invalid session token.'})
            try:
                length = int(self.headers.get('Content-Length', '0'))
                if not 0 < length <= 1024 * 1024:
                    raise ValueError('Invalid request size.')
                data = json.loads(self.rfile.read(length))
                if self.path == '/api/request':
                    return self.reply(202, {'id': session.start(data)})
                if self.path == '/api/workspace':
                    with session.lock:
                        if session.active:
                            raise ValueError('Wait for the active operation to finish.')
                        session.workspace = str(Path(data['path']).expanduser().resolve())
                    return self.reply(200, {'path': session.workspace})
                self.reply(404, {'message': 'Unknown endpoint.'})
            except (KeyError, TypeError, ValueError) as exc:
                self.reply(400, {'message': str(exc)})
    return Handler


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workspace', default=str(Path.cwd()))
    parser.add_argument('--demo', action='store_true', help='Simulate every operation, without accessing hardware.')
    parser.add_argument('--desktop', action='store_true', help='Use an optional pywebview desktop window.')
    parser.add_argument('--no-open', action='store_true', help='Print the URL without opening a browser.')
    parser.add_argument('--port', type=int, default=0)
    args = parser.parse_args()
    session = Session(args.workspace, args.demo)
    server = ThreadingHTTPServer(('127.0.0.1', args.port), handler(session))
    url = f'http://127.0.0.1:{server.server_port}'
    print(f'Programmer preview{" (DEMO)" if args.demo else ""}: {url}', flush=True)
    try:
        if args.desktop:
            import webview

            class Dialogs:
                def pick(self, kind):
                    paths = window.create_file_dialog(webview.FileDialog.FOLDER if kind == 'workspace' else webview.FileDialog.OPEN,
                                                      **({} if kind == 'workspace' else {'file_types': ('Firmware (*.zip)',)}))
                    return paths[0] if paths else None

            window = webview.create_window('UltraZohm CPLD programmer · Preview', url, js_api=Dialogs(),
                                           width=1120, height=820, min_size=(640, 520))
            window.events.closing += lambda: False if session.active else None
            threading.Thread(target=server.serve_forever, daemon=True).start()
            webview.start()
            server.shutdown()
        else:
            if not args.no_open:
                webbrowser.open(url)
            server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        if session.thread and session.thread.is_alive():
            print('Waiting for the active operation to finish before exiting.', flush=True)
            session.thread.join()
        server.server_close()


if __name__ == '__main__':
    main()
