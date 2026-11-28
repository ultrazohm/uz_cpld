"""One versioned JSON request per process; events and one result on stdout."""
import contextlib
import json
import sys
import traceback


def serve(operation=None):
    output = sys.stdout
    request_id = None
    disconnected = False

    def send(message):
        nonlocal disconnected
        if disconnected:
            return
        try:
            output.write(json.dumps(dict(message, version=1, id=request_id)) + '\n')
            output.flush()
        except (BrokenPipeError, OSError):
            disconnected = True

    try:
        envelope = json.load(sys.stdin)
        if envelope.get('version') != 1 or not isinstance(envelope.get('id'), str):
            raise ValueError('Expected protocol version 1 and a string operation ID')
        request_id = envelope['id']
        request = envelope['request']
        if not isinstance(request, dict):
            raise ValueError('Request must be an object')
        with contextlib.redirect_stdout(sys.stderr):
            if operation is None:
                from . import operate
                operation = operate
            result = operation(request, on_event=lambda event: send({'type': 'event', 'event': event}))
        send({'type': 'result', 'ok': True, 'result': result})
        return 0
    except Exception as exc:
        traceback.print_exc(file=sys.stderr)
        send({'type': 'result', 'ok': False, 'error': {'code': type(exc).__name__, 'message': str(exc)}, 'message': str(exc)})
        return 2
