"""Keep an Explorer-launched standalone CLI open in an ordinary PowerShell."""
import base64
import ctypes
import os
from pathlib import Path
import subprocess
import sys

from . import external


def console_processes():
    """Return clients attached to our console; zero means no console is attached."""
    from ctypes import wintypes
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    query = kernel.GetConsoleProcessList
    query.argtypes = [ctypes.POINTER(wintypes.DWORD), wintypes.DWORD]
    query.restype = wintypes.DWORD
    capacity = 8
    while True:
        processes = (wintypes.DWORD * capacity)()
        count = query(processes, capacity)
        if count <= capacity:
            return list(processes[:count])
        capacity = count


def needs_terminal(args):
    if args or sys.platform != 'win32' or not getattr(sys, 'frozen', False):
        return False
    if not sys.stdin.isatty() or not sys.stdout.isatty():
        return False
    # Explorer gives the console executable its own console. An invocation from
    # PowerShell/cmd shares the shell's console and must retain normal CLI behavior.
    return console_processes() == [os.getpid()]


def open_terminal():
    directory = Path(sys.executable).resolve().parent
    shell = Path(os.environ['SystemRoot']) / 'System32/WindowsPowerShell/v1.0/powershell.exe'
    env = external.environment()
    env['UZ_CPLD_TERMINAL_DIRECTORY'] = str(directory)
    env['PYINSTALLER_RESET_ENVIRONMENT'] = '1'
    script = """$env:PATH = $env:UZ_CPLD_TERMINAL_DIRECTORY + [IO.Path]::PathSeparator + $env:PATH
Set-Location -LiteralPath $env:UZ_CPLD_TERMINAL_DIRECTORY
Write-Host 'UltraZohm CPLD programmer terminal. Type exit to close.'
Write-Host 'Try: uz_cpld doctor, uz_cpld init_programmer, uz_cpld init_programmer --override'
& (Join-Path $env:UZ_CPLD_TERMINAL_DIRECTORY 'uz_cpld.exe') --help
"""
    encoded = base64.b64encode(script.encode('utf-16le')).decode('ascii')
    # This system shell must not inherit PyInstaller's native DLL search directory.
    with external.system_libraries():
        return subprocess.call([str(shell), '-NoLogo', '-NoProfile', '-NoExit',
                                '-EncodedCommand', encoded], cwd=directory, env=env)


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    try:
        if needs_terminal(args):
            return open_terminal()
    except (OSError, KeyError) as exc:
        print(f'uz_cpld: could not open PowerShell: {exc}', file=sys.stderr)
        return 2
    from .standalone import main as programmer
    return programmer(args)
