"""Portable dependency resolution must fail closed instead of relying on PATH."""
import os
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from distribution import loader


class DistributionTests(unittest.TestCase):
    def test_windows_collects_transitive_dlls_and_keeps_system_dlls_external(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            prefix = root / 'ucrt64'
            (prefix / 'bin').mkdir(parents=True)
            (root / 'System32').mkdir()
            for name in ('ftdi.dll', 'usb.dll', 'gcc.dll'):
                (prefix / 'bin' / name).touch()
            (root / 'System32/kernel32.dll').touch()
            imports = {'loader.exe': ['ftdi.dll', 'kernel32.dll', 'api-ms-win-crt-runtime-l1-1-0.dll'],
                       'ftdi.dll': ['usb.dll', 'gcc.dll'], 'usb.dll': ['kernel32.dll'],
                       'gcc.dll': ['kernel32.dll']}
            def inspect(command):
                if '-f' in command:
                    return 'architecture: i386:x86-64'
                return '\n'.join(f'DLL Name: {name}' for name in imports[Path(command[-1]).name])
            with patch.dict(os.environ, SystemRoot=str(root)), patch.object(loader, 'output', side_effect=inspect):
                dependencies = loader.windows_dependencies(root / 'loader.exe', prefix)
                self.assertEqual({p.name for p in dependencies}, {'ftdi.dll', 'usb.dll', 'gcc.dll'})
                imports['usb.dll'].append('missing.dll')
                with self.assertRaisesRegex(RuntimeError, 'Unresolved Windows dependency'):
                    loader.windows_dependencies(root / 'loader.exe', prefix)
                imports['usb.dll'][-1] = 'msys-2.0.dll'
                (prefix / 'bin/msys-2.0.dll').touch()
                with self.assertRaisesRegex(RuntimeError, 'MSYS/Cygwin'):
                    loader.windows_dependencies(root / 'loader.exe', prefix)

    def test_linux_keeps_glibc_external_and_rejects_unresolved_dependencies(self):
        sample = '''libusb-1.0.so.0 => /lib/libusb-1.0.so.0 (0x00)
libc.so.6 => /lib/libc.so.6 (0x00)
libudev.so.1 => /lib/libudev.so.1 (0x00)
/lib64/ld-linux-x86-64.so.2 (0x00)'''
        with patch.object(loader, 'output', return_value=sample):
            self.assertEqual(loader.linux_dependencies(Path('/loader')),
                             [Path('/lib/libusb-1.0.so.0'), Path('/lib/libudev.so.1')])
        with patch.object(loader, 'output', return_value='libusb-1.0.so.0 => not found'):
            with self.assertRaisesRegex(RuntimeError, 'Unresolved Linux dependency'):
                loader.linux_dependencies(Path('/loader'))


if __name__ == '__main__':
    unittest.main()
