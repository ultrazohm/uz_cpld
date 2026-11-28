"""Process locks on Linux and Windows; lock files are never deleted while in use."""
from contextlib import contextmanager
import errno
import os
from pathlib import Path
import sys


@contextmanager
def _windows_lock(fd, exclusive, blocking):
    import ctypes as C
    from ctypes import wintypes as W
    import msvcrt

    class Overlapped(C.Structure):
        _fields_ = [('Internal', C.c_size_t), ('InternalHigh', C.c_size_t),
                    ('Offset', W.DWORD), ('OffsetHigh', W.DWORD), ('hEvent', W.HANDLE)]

    kernel = C.WinDLL('kernel32', use_last_error=True)
    kernel.LockFileEx.argtypes = [W.HANDLE, W.DWORD, W.DWORD, W.DWORD, W.DWORD, C.POINTER(Overlapped)]
    kernel.LockFileEx.restype = W.BOOL
    kernel.UnlockFileEx.argtypes = [W.HANDLE, W.DWORD, W.DWORD, W.DWORD, C.POINTER(Overlapped)]
    kernel.UnlockFileEx.restype = W.BOOL
    handle, overlapped = msvcrt.get_osfhandle(fd), Overlapped()
    flags = (2 if exclusive else 0) | (0 if blocking else 1)
    if not kernel.LockFileEx(handle, flags, 0, 1, 0, C.byref(overlapped)):
        error = C.get_last_error()
        if error == 33:  # ERROR_LOCK_VIOLATION
            raise BlockingIOError(errno.EAGAIN, 'Lock is held by another operation')
        raise C.WinError(error)
    try:
        yield
    finally:
        if not kernel.UnlockFileEx(handle, 0, 1, 0, C.byref(overlapped)):
            raise C.WinError(C.get_last_error())


@contextmanager
def _lock(fd, exclusive, blocking):
    if sys.platform == 'win32':
        with _windows_lock(fd, exclusive, blocking):
            yield
    else:
        import fcntl
        flags = fcntl.LOCK_EX if exclusive else fcntl.LOCK_SH
        fcntl.flock(fd, flags | (0 if blocking else fcntl.LOCK_NB))
        try:
            yield
        finally:
            fcntl.flock(fd, fcntl.LOCK_UN)


@contextmanager
def file_lock(path: Path, *, exclusive=True, blocking=False):
    if path.is_symlink():
        raise OSError(f'Lock file must not be a symlink: {path}')
    fd = os.open(path, os.O_CREAT | os.O_RDWR | getattr(os, 'O_NOFOLLOW', 0), 0o600)
    try:
        with _lock(fd, exclusive, blocking):
            yield
    finally:
        os.close(fd)


@contextmanager
def directory_lock(path: Path, *, exclusive=True, blocking=False):
    """Preserve POSIX directory locks; Windows uses a persistent file inside it."""
    if path.is_symlink():
        raise OSError(f'Lock directory must not be a symlink: {path}')
    if sys.platform == 'win32':
        with file_lock(path / '.cpld.lock', exclusive=exclusive, blocking=blocking):
            yield
    else:
        fd = os.open(path, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
        try:
            with _lock(fd, exclusive, blocking):
                yield
        finally:
            os.close(fd)
