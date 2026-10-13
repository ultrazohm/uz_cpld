"""Portable dependency resolution must fail closed instead of relying on PATH."""
from pathlib import Path
import unittest
from unittest.mock import patch

from distribution import loader


class DistributionTests(unittest.TestCase):
    def test_windows_static_imports_allow_only_system_dlls(self):
        imports = ['KERNEL32.dll', 'msvcrt.dll', 'WS2_32.dll', 'api-ms-win-crt-runtime-l1-1-0.dll']
        def inspect(command):
            if '-f' in command:
                return 'architecture: i386:x86-64'
            return '\n'.join(f'DLL Name: {name}' for name in imports)
        with patch.object(loader, 'output', side_effect=inspect):
            self.assertEqual(loader.windows_imports(Path('loader.exe')), sorted(imports))
            for name in ('libftdi1.dll', 'libusb-1.0.dll', 'zlib1.dll', 'libstdc++-6.dll',
                         'libgcc_s_seh-1.dll', 'libwinpthread-1.dll', 'msys-2.0.dll', 'unknown.dll'):
                imports.append(name)
                with self.subTest(name=name), self.assertRaisesRegex(RuntimeError, 'non-system DLL'):
                    loader.windows_imports(Path('loader.exe'))
                imports.pop()
        with patch.object(loader, 'output', return_value='architecture: i386'):
            with self.assertRaisesRegex(RuntimeError, 'x64 PE'):
                loader.windows_imports(Path('loader.exe'))

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
