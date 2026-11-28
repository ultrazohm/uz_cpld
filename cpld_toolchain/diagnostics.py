"""Operation-local diagnostic output; never replace process-global stdout."""
from contextlib import contextmanager
from contextvars import ContextVar
import builtins

_sink = ContextVar('cpld_diagnostic_sink', default=None)


@contextmanager
def capture(sink):
    token = _sink.set(sink)
    try:
        yield
    finally:
        _sink.reset(token)


def emit(*values, sep=' ', end='\n', file=None, flush=False):
    sink = _sink.get()
    if sink is None or file is not None:
        builtins.print(*values, sep=sep, end=end, file=file, flush=flush)
    else:
        sink(sep.join(str(value) for value in values) + end)
