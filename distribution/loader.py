"""Build a relocatable pinned loader, with its dependency closure and notices.

Windows uses upstream's MinGW-w64 cross toolchain and static libraries.
Only Windows system DLL imports are permitted. Linux keeps glibc from the host
and bundles other shared libraries with $ORIGIN runpaths.
"""
import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tarfile
import urllib.request

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpld_toolchain.toolchain.foss import flasher

WINDOWS_SYSTEM_DLLS = {
    'kernel32.dll', 'ntdll.dll', 'msvcrt.dll', 'ucrtbase.dll', 'ws2_32.dll',
    'advapi32.dll', 'setupapi.dll', 'cfgmgr32.dll', 'ole32.dll', 'oleaut32.dll',
    'user32.dll', 'gdi32.dll', 'shell32.dll', 'shlwapi.dll', 'version.dll',
    'bcrypt.dll', 'winusb.dll', 'combase.dll', 'rpcrt4.dll', 'secur32.dll',
}


def output(command):
    return subprocess.check_output(command, text=True).strip()


def windows_imports(binary, objdump='x86_64-w64-mingw32-objdump'):
    """Reject any non-system PE import; no runtime DLLs may accompany this build."""
    if 'i386:x86-64' not in output([objdump, '-f', str(binary)]):
        raise RuntimeError(f'Expected an x64 PE binary: {binary}')
    imports = sorted(set(re.findall(r'DLL Name:\s*(\S+)', output([objdump, '-p', str(binary)]))))
    if not imports:
        raise RuntimeError('Expected Windows system DLL imports in the PE executable')
    for name in imports:
        key = name.lower()
        if key not in WINDOWS_SYSTEM_DLLS and not key.startswith(('api-ms-win-', 'ext-ms-win-')):
            raise RuntimeError(f'Static Windows loader imports a non-system DLL: {name}')
    return imports


def linux_dependencies(binary):
    dependencies = []
    for line in output(['ldd', str(binary)]).splitlines():
        if 'not found' in line:
            raise RuntimeError(f'Unresolved Linux dependency: {line}')
        match = re.match(r'\s*(\S+) => (/\S+)', line)
        if match:
            name, path = match.groups()
            # The application targets Ubuntu 24.04; its loader and glibc come from the OS.
            if name not in {'libc.so.6', 'libm.so.6', 'libpthread.so.0', 'libdl.so.2',
                            'librt.so.1', 'libresolv.so.2'}:
                dependencies.append(Path(path))
    return dependencies


def notices(dependencies, destination):
    """Keep the copyright/license files shipped with each redistributed library."""
    destination.mkdir()
    packages = {}
    for library in dependencies:
        ownership = output(['dpkg-query', '-S', str(library.resolve())])
        package = ownership.split(': ', 1)[0].splitlines()[0]
        candidates = [Path('/usr/share/doc') / package.split(':')[0] / 'copyright']
        version = output(['dpkg-query', '-W', '-f=${Package} ${Version}', package])
        if package in packages:
            continue
        files = [path for path in candidates if path.is_file()]
        if not files:
            raise RuntimeError(f'Missing dependency license notices: {package}')
        folder = destination / package.replace(':', '_')
        folder.mkdir()
        for index, path in enumerate(files):
            shutil.copy2(path, folder / f'{index}-{path.name}')
        packages[package] = version
    (destination / 'packages.json').write_text(json.dumps(packages, indent=2) + '\n')
    if sys.platform != 'win32':
        shutil.copytree('/usr/share/common-licenses', destination / 'common-licenses')
    return packages


def windows_sources(build_dir, destination):
    """Retain the LGPL libraries' source and static archives for rebuilding/relinking."""
    dependency_root = build_dir / 'cross-deps'
    resources = destination / 'sources'
    resources.mkdir()
    packages = {}
    for archive in sorted((dependency_root / 'src').glob('*.*')):
        if archive.is_file():
            shutil.copy2(archive, resources / archive.name)
            packages[archive.name] = flasher.digest(archive)
    # Upstream's libusb 7z contains binary SDK libraries, so include its source too.
    libusb_source = resources / 'libusb-1.0.27-source.tar.gz'
    urllib.request.urlretrieve('https://codeload.github.com/libusb/libusb/tar.gz/refs/tags/v1.0.27', libusb_source)
    packages[libusb_source.name] = flasher.digest(libusb_source)
    # Include the licenses themselves in addition to their complete source archives.
    for path in (dependency_root / 'src/libftdi1-1.5').glob('COPYING*'):
        shutil.copy2(path, destination / 'licenses' / ('libftdi-' + path.name))
    with tarfile.open(libusb_source) as archive:
        for member in archive.getmembers():
            if member.isfile() and Path(member.name).name == 'COPYING':
                with archive.extractfile(member) as stream:
                    (destination / 'licenses/libusb-COPYING').write_bytes(stream.read())
    libraries = destination / 'relink-libraries'
    libraries.mkdir()
    for name in ('libftdi1.a', 'libusb-1.0.a'):
        shutil.copy2(dependency_root / 'install/lib' / name, libraries / name)
    shutil.copy2('/usr/x86_64-w64-mingw32/lib/libz.a', libraries / 'libz.a')
    objects = destination / 'relink-objects'
    objects.mkdir()
    for path in (build_dir / 'CMakeFiles/openFPGALoader.dir/src').glob('*.obj'):
        shutil.copy2(path, objects / path.name)
    if not any(objects.iterdir()):
        raise RuntimeError('Static distribution requires loader objects for relinking')
    (destination / 'RELINK.txt').write_text(
        'The sources, patch and recipe allow rebuilding the modified loader.\n'
        'To relink with modified LGPL libraries, replace their static .a archives\n'
        'in relink-libraries and run on Linux with MinGW-w64 installed:\n\n'
        'x86_64-w64-mingw32-g++ -static -static-libgcc -static-libstdc++ '
        'relink-objects/*.obj -Wl,--start-group relink-libraries/*.a '
        '-Wl,--end-group -lws2_32 -o openFPGALoader.exe\n\n'
        'A rebuilt/relinked loader needs its own matching provenance receipt.\n')
    # Exact modified application source and build recipe are copied by build().
    (resources / 'SHA256SUMS.json').write_text(json.dumps(packages, indent=2) + '\n')
    return packages


def build(destination, work, archive=None, jobs=2, target='linux'):
    if sys.platform != 'linux' or jobs < 1 or target not in ('linux', 'windows-x64'):
        raise RuntimeError('Loader builds require Linux, positive jobs and target linux|windows-x64')
    windows = target == 'windows-x64'
    data = flasher.pin()
    if destination.exists():
        raise RuntimeError(f'Use a fresh loader output directory: {destination}')
    work.mkdir(parents=True, exist_ok=True)
    if archive is None:
        archive = work / 'upstream.tar.gz'
        urllib.request.urlretrieve(data['url'], archive)
    if flasher.digest(archive) != data['sha256']:
        raise RuntimeError('Pinned loader source checksum mismatch')
    source = work / 'source'
    source.mkdir()
    with tarfile.open(archive) as packed:
        # Pinned archive has one top-level folder. Reject paths escaping that folder.
        for member in packed.getmembers():
            if member.issym() or member.islnk() or not member.isfile() and not member.isdir():
                raise RuntimeError('Unsupported source archive member')
            parts = Path(member.name).parts
            if '..' in parts or Path(member.name).is_absolute():
                raise RuntimeError('Invalid source archive path')
        packed.extractall(source, filter='data')
    source = next(source.iterdir())
    subprocess.run(['patch', '-p1', '--batch', '--forward', '-i',
                    str(flasher.BASE / 'openfpgaloader-usercode.patch')], cwd=source, check=True)
    for name in ('usercode', 'identity'):
        test = work / name
        subprocess.run(['c++', '-std=c++11', '-I', str(source / 'src'),
                        str(flasher.BASE / f'tests/{name}.cpp'), '-o', str(test)], check=True)
        subprocess.run([str(test)], check=True)
        if windows:
            windows_tests = work / 'protocol-tests'
            windows_tests.mkdir(exist_ok=True)
            subprocess.run(['x86_64-w64-mingw32-g++', '-static', '-static-libgcc', '-static-libstdc++',
                            '-std=c++11', '-I', str(source / 'src'),
                            str(flasher.BASE / f'tests/{name}.cpp'), '-o', str(windows_tests / f'{name}.exe')], check=True)
            windows_imports(windows_tests / f'{name}.exe')
    options = ['-DCMAKE_BUILD_TYPE=Release', '-DENABLE_CABLE_ALL=OFF',
               '-DENABLE_FTDI_BASED_CABLE=ON', '-DENABLE_VENDORS_ALL=OFF',
               '-DENABLE_LATTICE_SUPPORT=ON', '-DENABLE_UDEV=OFF',
               '-DCMAKE_DISABLE_FIND_PACKAGE_LibFTDI1=TRUE']
    if windows:
        options += ['-DCMAKE_TOOLCHAIN_FILE=' + str(source / 'cmake/Toolchain-x86_64-w64-mingw32.cmake'),
                    '-DWINDOWS_CROSSCOMPILE=ON', '-DCROSS_COMPILE_DEPS=ON',
                    '-DWINDOWS_STATIC_ZLIB=ON', '-DBUILD_STATIC=ON',
                    # v1.1.1's cross module sets LIBFTDI_FOUND, bypassing the pkg-config
                    # branch which normally initializes these version components.
                    '-DLIBFTDI_VERSION=1.5', '-DLIBFTDI_VERSION_MAJOR=1', '-DLIBFTDI_VERSION_MINOR=5']
    subprocess.run(['cmake', '-S', str(source), '-B', str(work / 'build'), *options], check=True)
    subprocess.run(['cmake', '--build', str(work / 'build'), '--parallel', str(jobs)], check=True)
    filename = 'openFPGALoader.exe' if windows else 'openFPGALoader'
    binary = work / 'build' / filename
    destination.mkdir(parents=True)
    imports = windows_imports(binary) if windows else None
    if windows:
        dependencies = []
    else:
        dependencies = linux_dependencies(binary)
    shutil.copy2(binary, destination / filename)
    for dependency in dependencies:
        shutil.copy2(dependency, destination / dependency.name)
    if not windows:
        for path in destination.iterdir():
            subprocess.run(['patchelf', '--set-rpath', '$ORIGIN', str(path)], check=True)
    if windows:
        runtime_archives = [Path(output(['x86_64-w64-mingw32-g++', '-print-file-name=libstdc++.a'])),
                            Path('/usr/x86_64-w64-mingw32/lib/libz.a')]
        packages = notices(runtime_archives, destination / 'licenses')
        packages.update(windows_sources(work / 'build', destination))
    else:
        packages = notices(dependencies, destination / 'licenses')
    shutil.copy2(source / 'LICENSE', destination / 'LICENSE')
    # Redistribute the exact upstream source and our modifications for attribution/rebuilding.
    shutil.copy2(archive, destination / 'upstream-source.tar.gz')
    shutil.copy2(flasher.BASE / 'openfpgaloader-usercode.patch', destination / 'openfpgaloader-usercode.patch')
    shutil.copy2(ROOT / 'distribution/loader.py', destination / 'build-recipe.py')
    for name in ('70-openfpgaloader.rules', '99-openfpgaloader.rules'):
        shutil.copy2(source / name, destination / name)
    record = dict(pin=data, binary_sha256=flasher.digest(destination / filename),
                  git_revision=output(['git', '-C', str(ROOT), 'rev-parse', 'HEAD']),
                  runtime_sha256={path.name: flasher.digest(destination / path.name) for path in dependencies},
                  packages=packages, target=target, linkage='static' if windows else 'shared',
                  windows_system_imports=imports)
    (destination / flasher.RECEIPT).write_text(json.dumps(record, indent=2) + '\n')
    flasher.verify(destination / filename)
    if windows:
        print(destination)
        return  # Execute the PE and native parser tests on Windows in the dependent CI job.
    if data['capability'] not in flasher.version(destination / filename):
        raise RuntimeError('Loader does not report the pinned capability')
    subprocess.run([sys.executable, str(flasher.BASE / 'tests/native.py'),
                    str(destination / filename), '--portable'], check=True)
    print(destination)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/portable-loader')
    parser.add_argument('--work', type=Path, default=ROOT / 'build/portable-loader-work')
    parser.add_argument('--archive', type=Path)
    parser.add_argument('--jobs', type=int, default=2)
    parser.add_argument('--target', choices=('linux', 'windows-x64'), default='linux')
    args = parser.parse_args()
    build(args.output.resolve(), args.work.resolve(), args.archive, args.jobs, args.target)
