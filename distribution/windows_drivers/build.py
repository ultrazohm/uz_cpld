"""Cross-build the pinned, static x64 Windows driver helper on Ubuntu 24.04.

Requires mingw-w64, gcc, make, autoconf, automake, libtool and patch.
"""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tarfile
import urllib.request

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from distribution.loader import windows_imports, WINDOWS_SYSTEM_DLLS


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(args, cwd):
    subprocess.run([str(a) for a in args], cwd=cwd, check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/windows-drivers')
    parser.add_argument('--work', type=Path, default=ROOT / 'build/windows-drivers-work')
    parser.add_argument('--libwdi-archive', type=Path)
    args = parser.parse_args()
    pin = json.loads((ROOT / 'cpld_toolchain/windows_driver_pin.json').read_text())
    work, output = args.work.resolve(), args.output.resolve()
    work.mkdir(parents=True, exist_ok=True)
    if output.exists():
        raise RuntimeError(f'Output already exists: {output}; choose a fresh output directory')
    archives = {}
    for name, supplied, filename in [('libwdi', args.libwdi_archive, 'libwdi.tar.gz')]:
        archive = supplied.resolve() if supplied else work / filename
        if not supplied and not archive.exists():
            with urllib.request.urlopen(pin[name]['url'], timeout=120) as response:
                archive.write_bytes(response.read())
        if digest(archive) != pin[name]['sha256']:
            raise RuntimeError(f'{name} archive checksum mismatch')
        archives[name] = archive
    source = work / 'libwdi'
    source.mkdir()  # Refuse stale objects or a reused source tree.
    with tarfile.open(archives['libwdi']) as archive:
        archive.extractall(source, filter='data')
    source, = source.iterdir()
    patch = Path(__file__).with_name('inbox-winusb.patch')
    if digest(patch) != pin['inbox_patch_sha256']:
        raise RuntimeError('Inbox WinUSB patch checksum mismatch')
    run(['patch', '-p1', '--batch', '-i', patch], source)
    run(['autoreconf', '-fi'], source)
    run(['./configure', '--host=x86_64-w64-mingw32', '--disable-32bit', '--disable-shared',
         '--enable-inbox-winusb'], source)
    run(['make', '-C', 'libwdi', '-j4'], source)
    output.mkdir(parents=True)
    relink = output / 'relink'
    relink.mkdir()
    shutil.copy2(source / 'libwdi/.libs/libwdi.a', relink)
    helper = Path(__file__).with_name('helper.cpp')
    run(['x86_64-w64-mingw32-g++', '-std=c++17', '-O2', '-I' + str(source / 'libwdi'),
         '-c', helper, '-o', relink / 'helper.o'], work)
    run(['x86_64-w64-mingw32-windres', 'helper.rc', '-O', 'coff', '-o', relink / 'helper-res.o'], helper.parent)
    binary = output / 'uz-cpld-driver-helper.exe'
    libs = ['-lsetupapi', '-lnewdev', '-lole32', '-lntdll', '-luuid', '-ladvapi32', '-lshell32']
    run(['x86_64-w64-mingw32-g++', '-municode', '-static', relink / 'helper.o', relink / 'helper-res.o', relink / 'libwdi.a',
         *libs, '-o', binary], work)
    tests = work / 'tests'
    tests.mkdir()
    run(['x86_64-w64-mingw32-g++', '-std=c++17', '-O2', '-municode', '-static',
         '-I' + str(source / 'libwdi'), Path(__file__).with_name('tests.cpp'),
         relink / 'helper-res.o', relink / 'libwdi.a', *libs, '-o', tests / 'driver-tests.exe'], work)
    WINDOWS_SYSTEM_DLLS.add('newdev.dll')
    imports = windows_imports(binary)
    notices = output / 'licenses'
    notices.mkdir()
    for name in ('COPYING', 'COPYING-LGPL', 'AUTHORS'):
        shutil.copy2(source / name, notices / ('libwdi-' + name))
    shutil.copy2(ROOT / 'LICENSE', notices / 'helper-Apache-2.0.txt')
    shutil.copy2(ROOT / 'NOTICE', notices / 'helper-NOTICE.txt')
    for name in ('gcc-mingw-w64-x86-64', 'mingw-w64-x86-64-dev'):
        shutil.copy2(Path('/usr/share/doc') / name / 'copyright', notices / (name + '-copyright'))
    for name in ('GPL-3', 'LGPL-3'):
        shutil.copy2(Path('/usr/share/common-licenses') / name, notices / name)
    sources = output / 'sources'
    sources.mkdir()
    shutil.copy2(archives['libwdi'], sources / 'libwdi-1.5.1.tar.gz')
    shutil.copy2(ROOT / 'cpld_toolchain/windows_driver_pin.json', sources / 'pin.json')
    for name in ('helper.cpp', 'tests.cpp', 'build.py', 'inbox-winusb.patch', 'helper.manifest', 'helper.rc'):
        shutil.copy2(Path(__file__).with_name(name), sources)
    (relink / 'RELINK.txt').write_text(
        'This LGPLv3 libwdi build includes its source archive and our build recipe in ../sources.\n'
        'To relink with a modified libwdi.a, use MinGW-w64 from this directory:\n'
        'x86_64-w64-mingw32-g++ -municode -static helper.o helper-res.o libwdi.a ' + ' '.join(libs) +
        ' -o ../uz-cpld-driver-helper.exe\n'
        'To rebuild libwdi, extract ../sources/libwdi-1.5.1.tar.gz, apply inbox-winusb.patch with patch -p1,\n'
        'then autoreconf -fi; ./configure --host=x86_64-w64-mingw32 --disable-32bit --disable-shared --enable-inbox-winusb;\n'
        'make -C libwdi. Copy libwdi/.libs/libwdi.a here. No WDK or Microsoft redistributables are used.\n'
        'After relinking, update the changed files SHA-256 values in ../driver-helper.json.\n'
        'This local receipt is not a signature; it permits users to run their modified library.\n'
        'The helper uses Windows 10/11 inbox WinUSB; no driver binaries are embedded.\n')
    record = dict(schema_version=1, pin=pin, linkage='static', windows_system_imports=imports,
                  git_revision=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
                  files={str(p.relative_to(output)).replace('\\', '/'): digest(p)
                         for p in sorted(output.rglob('*')) if p.is_file()})
    (output / 'driver-helper.json').write_text(json.dumps(record, indent=2) + '\n')
    print(output)


if __name__ == '__main__':
    main()
