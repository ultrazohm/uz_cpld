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


class LicenseInventoryTests(unittest.TestCase):
    def test_windows_zlib_notice_matches_the_dll_version_and_records_origin(self):
        import json
        import tempfile
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            notices = Path(temporary)
            source = notices / 'zlib1.dll'
            with patch.object(licensing.ctypes, 'CDLL') as load:
                load.return_value.zlibVersion.return_value = b'1.2.13'
                component = licensing.windows_zlib_materials(source, notices)
                load.assert_called_once_with(str(source))
                self.assertEqual(load.return_value.zlibVersion.argtypes, [])
                self.assertIs(load.return_value.zlibVersion.restype, licensing.ctypes.c_char_p)
            self.assertEqual(component['version'], '1.2.13')
            origin = json.loads((notices / 'zlib-SOURCES.json').read_text())
            self.assertIn('/v1.2.13/LICENSE', origin['source'])
            self.assertEqual(origin['sha256'], licensing.digest(notices / 'zlib-LICENSE.txt'))
            self.assertEqual((notices / 'zlib-LICENSE.txt').read_bytes(),
                             (licensing.ROOT / 'distribution/zlib/zlib-1.2.13-LICENSE.txt').read_bytes())

    def test_windows_zlib_notice_rejects_unknown_versions_and_modified_material(self):
        import shutil
        import tempfile
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            with patch.object(licensing.ctypes, 'CDLL') as load:
                load.return_value.zlibVersion.return_value = b'9.0.0'
                with self.assertRaisesRegex(RuntimeError, 'Missing pinned upstream notice'):
                    licensing.windows_zlib_materials(root / 'zlib1.dll', root)
                shutil.copytree(licensing.ROOT / 'distribution/zlib', root / 'distribution/zlib')
                (root / 'distribution/zlib/zlib-1.2.13-LICENSE.txt').write_text('modified')
                load.return_value.zlibVersion.return_value = b'1.2.13'
                with patch.object(licensing, 'ROOT', root):
                    with self.assertRaisesRegex(RuntimeError, 'checksum mismatch'):
                        licensing.windows_zlib_materials(root / 'zlib1.dll', root)

    def tk_fixture(self, root, version='8.6.14'):
        application, notices = root / 'application', root / 'licenses'
        notices.mkdir()
        for data, script, package in (('_tcl_data', 'init.tcl', 'Tcl'), ('_tk_data', 'tk.tcl', 'Tk')):
            path = application / '_internal' / data / script
            path.parent.mkdir(parents=True)
            path.write_text(f'package require -exact {package}  {version}\n')
        return application, notices

    def test_windows_tk_notices_use_exact_pinned_upstream_material_when_python_omits_it(self):
        import json
        import tempfile
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            application, notices = self.tk_fixture(root)
            with patch.object(licensing.sys, 'base_prefix', str(root / 'python-without-notices')):
                component = licensing.windows_tk_materials(application, notices)
            self.assertEqual(component['versions'], {'tcl': '8.6.14', 'tk': '8.6.14'})
            origins = json.loads((notices / 'Tcl-Tk-SOURCES.json').read_text())
            for library in ('tcl', 'tk'):
                self.assertIn(f'/core-8-6-14/license.terms', origins[library]['source'])
                self.assertEqual(origins[library]['sha256'], licensing.digest(notices / f'{library}-LICENSE.txt'))
                self.assertEqual((notices / f'{library}-LICENSE.txt').read_bytes(),
                                 (licensing.ROOT / f'distribution/tcltk/{library}-LICENSE.txt').read_bytes())

    def test_windows_tk_notices_prefer_the_installed_license(self):
        import tempfile
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            application, notices = self.tk_fixture(root)
            source = root / 'python/tcl/tcl8.6/license.terms'
            source.parent.mkdir(parents=True)
            source.write_text('Installed runtime notice fixture')
            with patch.object(licensing.sys, 'base_prefix', str(root / 'python')):
                licensing.windows_tk_materials(application, notices)
            self.assertEqual((notices / 'tcl-LICENSE.txt').read_bytes(), source.read_bytes())

    def test_windows_tk_notices_reject_unknown_versions_and_modified_material(self):
        import tempfile
        import shutil
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            application, notices = self.tk_fixture(root, '9.0.0')
            with patch.object(licensing.sys, 'base_prefix', str(root / 'python')):
                with self.assertRaisesRegex(RuntimeError, 'Missing pinned upstream notice'):
                    licensing.windows_tk_materials(application, notices)
            pins = root / 'distribution/tcltk'
            shutil.copytree(licensing.ROOT / 'distribution/tcltk', pins)
            (pins / 'tcl-LICENSE.txt').write_text('modified')
            (application / '_internal/_tcl_data/init.tcl').write_text('package require -exact Tcl 8.6.14\n')
            with patch.object(licensing, 'ROOT', root), patch.object(licensing.sys, 'base_prefix', str(root / 'python')):
                with self.assertRaisesRegex(RuntimeError, 'checksum mismatch'):
                    licensing.windows_tk_materials(application, notices)

    def test_windows_python_license_accepts_unlabelled_apache_but_not_missing_terms(self):
        from distribution import licensing
        apache = (licensing.ROOT / 'LICENSE').read_text()
        text = 'Microsoft Distributable Code\nlibffi\n' + apache
        self.assertNotIn('OpenSSL', text)
        licensing.validate_windows_python_license(text.replace('\n', '\r\n'))
        for incomplete in ('Microsoft Distributable Code libffi OpenSSL',
                           text.replace('END OF TERMS AND CONDITIONS', ''),
                           text.replace('libffi', '')):
            with self.assertRaises(RuntimeError):
                licensing.validate_windows_python_license(incomplete)

    def test_inventory_rejects_missing_sources_and_new_native_files(self):
        import json
        import tempfile
        from distribution import licensing
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / 'licenses').mkdir()
            (root / 'LICENSE').write_text('test notice')
            (root / 'source.tar.gz').write_bytes(b'source fixture')
            (root / 'uz_cpld.exe').write_bytes(b'executable fixture')
            record = dict(schema_version=1,
                          components={'test': dict(notices=['LICENSE'], sources=['source.tar.gz'])},
                          materials={name: licensing.digest(root / name) for name in ('LICENSE', 'source.tar.gz')},
                          files={'uz_cpld.exe': dict(components=['test'], sha256=licensing.digest(root / 'uz_cpld.exe'))})
            (root / 'licenses/inventory.json').write_text(json.dumps(record))
            licensing.verify(root)
            (root / 'extra.dll').write_bytes(b'unknown dependency')
            with self.assertRaisesRegex(RuntimeError, 'Uninventoried'):
                licensing.verify(root)
            (root / 'extra.dll').unlink()
            (root / 'ucrtbase.dll').write_bytes(b'system DLL')
            with self.assertRaisesRegex(RuntimeError, 'system DLL'):
                licensing.verify(root)
            (root / 'ucrtbase.dll').unlink()
            (root / 'source.tar.gz').unlink()
            with self.assertRaisesRegex(RuntimeError, 'Missing or changed'):
                licensing.verify(root)

    def test_failed_source_download_does_not_leave_reusable_partial_source(self):
        import tempfile
        from distribution import licensing
        import subprocess
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            notices, sources = root / 'licenses', root / 'sources'
            notices.mkdir(); sources.mkdir()
            with patch.object(licensing, 'command', return_value='package\t1\tupstream\t1'), \
                    patch.object(Path, 'is_file', return_value=True), \
                    patch.object(licensing.shutil, 'copy2'), \
                    patch.object(licensing.subprocess, 'run', side_effect=subprocess.CalledProcessError(1, 'apt-get')):
                with self.assertRaises(subprocess.CalledProcessError):
                    licensing.debian_materials('package', notices, sources)
            self.assertFalse((sources / 'upstream-1').exists())


if __name__ == '__main__':
    unittest.main()
