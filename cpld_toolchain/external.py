"""Launch system tools without inheriting a frozen application's libraries."""
from contextlib import contextmanager
import ctypes
import os
from pathlib import Path
import sys


def environment():
    env = dict(os.environ)
    if not getattr(sys, 'frozen', False):
        return env
    if sys.platform != 'win32':
        original = env.pop('LD_LIBRARY_PATH_ORIG', None)
        if original is None:
            env.pop('LD_LIBRARY_PATH', None)
        else:
            env['LD_LIBRARY_PATH'] = original
    bundle = Path(sys._MEIPASS).resolve()
    env['PATH'] = os.pathsep.join(p for p in env.get('PATH', '').split(os.pathsep)
                                if p and not Path(p).resolve().is_relative_to(bundle))
    return env


@contextmanager
def system_libraries():
    if sys.platform != 'win32' or not getattr(sys, 'frozen', False):
        yield
        return
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    get_directory = kernel.GetDllDirectoryW
    get_directory.argtypes = [ctypes.c_uint32, ctypes.c_wchar_p]
    get_directory.restype = ctypes.c_uint32
    set_directory = kernel.SetDllDirectoryW
    set_directory.argtypes = [ctypes.c_wchar_p]
    set_directory.restype = ctypes.c_int
    buffer = ctypes.create_unicode_buffer(get_directory(0, None) + 1)
    get_directory(len(buffer), buffer)
    if not set_directory(None):
        raise ctypes.WinError(ctypes.get_last_error())
    try:
        yield
    finally:
        if not set_directory(buffer.value or None):
            raise ctypes.WinError(ctypes.get_last_error())
