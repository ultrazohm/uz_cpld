"""Per-invocation writable workspace, independent of installed resources."""
from contextlib import contextmanager
from contextvars import ContextVar
from pathlib import Path
import tempfile

from . import repository_root

_current = ContextVar('cpld_workspace', default=None)


def current():
    return _current.get() or repository_root()


@contextmanager
def use(path):
    token = _current.set(Path(path).resolve())
    try:
        yield
    finally:
        _current.reset(token)


def prepare(path):
    """Check write access before any workflow can contact hardware."""
    path.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryFile(dir=path):
        pass
