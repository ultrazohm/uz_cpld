"""Compatibility entry point for the programmer JSON worker."""
import json
from pathlib import Path
import sys
from . import settings
from .programmer import operate as application_operate, catalog, validate_assignments


def operate(request):
    output = sys.stdout
    return application_operate(request, on_event=lambda event:
        output.write(event['text']) if event['phase'] == 'log' else None)


def worker(request_path, result_path):
    """Logs go to the worker's redirected output; only JSON crosses into the UI."""
    try:
        result = dict(ok=True, **operate(json.loads(Path(request_path).read_text())))
    except Exception as exc:
        import traceback
        traceback.print_exc()
        result = dict(ok=False, message=str(exc))
    settings.atomic_json(Path(result_path), result)
    return 0 if result['ok'] else 2


if __name__ == '__main__':
    raise SystemExit(worker(*sys.argv[1:]))
