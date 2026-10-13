"""Build a relocatable pinned loader, with its dependency closure and notices.

Windows uses upstream's native MSYS2 UCRT64 build. DLLs stay beside the executable;
no MSYS runtime or PATH installation is required. Linux keeps glibc from the host
and bundles other shared libraries with $ORIGIN runpaths.
"""
import argparse
import json
import os
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


def windows_dependencies(binary, prefix):
    """Resolve every PE import from UCRT64 or Windows itself, never from PATH."""
    pending = [binary]
    resolved = {}
    system = Path(os.environ['SystemRoot']) / 'System32'
    while pending:
        current = pending.pop()
        if 'i386:x86-64' not in output(['objdump', '-f', str(current)]):
            raise RuntimeError(f'Expected an x64 PE binary: {current}')
        for name in re.findall(r'DLL Name:\s*(\S+)', output(['objdump', '-p', str(current)])):
            key = name.lower()
            if key in ('msys-2.0.dll', 'cygwin1.dll'):
                raise RuntimeError('A portable Windows loader must not depend on MSYS/Cygwin')
            if key.startswith(('api-ms-win-', 'ext-ms-win-')):
                continue  # Windows API sets, provided by the OS.
            source = prefix / 'bin' / name
            if source.is_file():
                if key not in resolved:
                    resolved[key] = source
                    pending.append(source)
            elif key not in WINDOWS_SYSTEM_DLLS or not (system / name).is_file():
                raise RuntimeError(f'Unresolved Windows dependency: {name} ({current})')
    return list(resolved.values())


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
        if sys.platform == 'win32':
            posix = output(['cygpath', '-u', str(library)])
            package = output(['pacman', '-Qqo', posix])
            files = output(['pacman', '-Qlq', package]).splitlines()
            candidates = [Path(output(['cygpath', '-w', name])) for name in files
                          if re.search(r'/(licenses?/|COPYING|COPYRIGHT|LICENSE)', name, re.I)]
            version = output(['pacman', '-Q', package])
        else:
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


def build(destination, work, archive=None, jobs=2):
    if sys.platform not in ('win32', 'linux') or jobs < 1:
        raise RuntimeError('Portable loader builds require Windows/Linux and positive jobs')
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
        test = work / (name + ('.exe' if sys.platform == 'win32' else ''))
        subprocess.run(['c++', '-std=c++11', '-I', str(source / 'src'),
                        str(flasher.BASE / f'tests/{name}.cpp'), '-o', str(test)], check=True)
        subprocess.run([str(test)], check=True)
    options = ['-DCMAKE_BUILD_TYPE=Release', '-DENABLE_CABLE_ALL=OFF',
               '-DENABLE_FTDI_BASED_CABLE=ON', '-DENABLE_VENDORS_ALL=OFF',
               '-DENABLE_LATTICE_SUPPORT=ON', '-DENABLE_UDEV=OFF',
               '-DCMAKE_DISABLE_FIND_PACKAGE_LibFTDI1=TRUE']
    if sys.platform == 'win32':
        options += ['-G', 'Ninja']
    subprocess.run(['cmake', '-S', str(source), '-B', str(work / 'build'), *options], check=True)
    subprocess.run(['cmake', '--build', str(work / 'build'), '--parallel', str(jobs)], check=True)
    filename = 'openFPGALoader.exe' if sys.platform == 'win32' else 'openFPGALoader'
    binary = work / 'build' / filename
    destination.mkdir(parents=True)
    if sys.platform == 'win32':
        prefix = Path(shutil.which('gcc')).resolve().parent.parent
        dependencies = windows_dependencies(binary, prefix)
    else:
        dependencies = linux_dependencies(binary)
    shutil.copy2(binary, destination / filename)
    for dependency in dependencies:
        shutil.copy2(dependency, destination / dependency.name)
    if sys.platform != 'win32':
        for path in destination.iterdir():
            subprocess.run(['patchelf', '--set-rpath', '$ORIGIN', str(path)], check=True)
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
                  packages=packages)
    (destination / flasher.RECEIPT).write_text(json.dumps(record, indent=2) + '\n')
    flasher.verify(destination / filename)
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
    args = parser.parse_args()
    build(args.output.resolve(), args.work.resolve(), args.archive, args.jobs)
