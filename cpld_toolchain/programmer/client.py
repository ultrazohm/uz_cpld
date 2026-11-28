"""Synchronous streaming worker client; GUI hosts run it outside their UI thread."""
import json
import os
from pathlib import Path
import subprocess
import sys
import threading
import uuid


def command():
    if getattr(sys, 'frozen', False):
        return [str(Path(sys.executable).with_name('uz_cpld.exe' if sys.platform == 'win32' else 'uz_cpld')), '--programmer-worker']
    return [os.environ.get('UZ_CPLD_GUI_WORKER_PYTHON', sys.executable), '-u', '-m', 'cpld_toolchain.programmer', '--stdio']


def run(request, on_event=lambda event: None, *, worker_command=None, env=None):
    operation_id = uuid.uuid4().hex
    payload = json.dumps({'version': 1, 'id': operation_id, 'request': request})
    result = None
    errors = []
    # Callback failures must not interrupt hardware operations or stop draining pipes.
    def emit(event):
        try:
            on_event(event)
        except Exception:
            pass
    with subprocess.Popen(worker_command or command(), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, text=True, encoding='utf-8', errors='replace', env=env,
                          creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == 'win32' else 0) as process:
        def diagnostics():
            for line in iter(lambda: process.stderr.readline(65536), ''):
                emit({'phase': 'log', 'text': line})
        reader = threading.Thread(target=diagnostics)
        reader.start()
        try:
            process.stdin.write(payload)
            process.stdin.close()
            while True:
                line = process.stdout.readline(1024 * 1024 + 1)
                if not line:
                    break
                try:
                    if len(line) > 1024 * 1024:
                        raise ValueError('Worker message exceeds size limit')
                    message = json.loads(line)
                    if message.get('version') != 1 or message.get('id') != operation_id:
                        raise ValueError('Worker protocol version or operation ID mismatch')
                    if result is not None:
                        raise ValueError('Worker sent data after its terminal result')
                    if message.get('type') == 'event':
                        if not isinstance(message.get('event'), dict):
                            raise ValueError('Invalid worker event')
                        emit(message['event'])
                    elif message.get('type') == 'result' and type(message.get('ok')) is bool:
                        result = message
                    else:
                        raise ValueError('Invalid worker message')
                except (ValueError, TypeError, AttributeError) as exc:
                    if not errors:
                        errors.append(str(exc))
            code = process.wait()
        finally:
            reader.join()
    if errors or result is None or (result.get('ok') and code != 0):
        raise RuntimeError('Worker outcome unknown: ' + (errors[0] if errors else f'exit {code}; missing or inconsistent result'))
    return result
