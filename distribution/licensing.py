"""Collect licenses and exact corresponding sources from the packaging inputs.

Unknown native files fail closed. Linux builders need deb-src indexes matching
installed packages. Source downloads are retained with the application, not URLs
that downstream distributors must keep alive.
"""
import ctypes
import hashlib
import importlib.metadata
import json
import re
from pathlib import Path
import shutil
import subprocess
import sys
import sysconfig
import tarfile

ROOT = Path(__file__).resolve().parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def command(args):
    return subprocess.check_output(args, text=True).strip()


def validate_windows_python_license(text):
    # CPython appends OpenSSL 3's Apache-2.0 text without an "OpenSSL" label.
    # Check the license terms themselves, retaining the complete original file.
    for required in ('Microsoft Distributable Code', 'libffi'):
        if required not in text:
            raise RuntimeError(f'Windows Python license is missing {required} terms')
    start, end = 'TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION', 'END OF TERMS AND CONDITIONS'
    apache = (ROOT / 'LICENSE').read_text(encoding='utf-8')
    terms = apache[apache.index(start):apache.index(end) + len(end)]
    normalize = lambda value: ' '.join(value.replace('https://', 'http://').split())
    if normalize(terms) not in normalize(text):
        raise RuntimeError('Windows Python license is missing complete Apache-2.0 terms for OpenSSL 3')


def system_dll(name):
    name = Path(name).name.lower()
    return name == 'ucrtbase.dll' or name.startswith(('api-ms-win-', 'ext-ms-win-'))


def debian_package(path):
    candidates = [path, path.resolve()]
    # Ubuntu's usrmerge can leave the package database using either spelling.
    if str(path).startswith('/usr/lib/'):
        candidates.append(Path(str(path)[4:]))
    for candidate in candidates:
        result = subprocess.run(['dpkg-query', '-S', str(candidate)], text=True, capture_output=True)
        if result.returncode == 0:
            return result.stdout.split(': ', 1)[0].splitlines()[0]
    return None


def debian_materials(package, notices, sources):
    metadata = command(['dpkg-query', '-W', '-f=${binary:Package}\t${Version}\t${source:Package}\t${source:Version}', package]).split('\t')
    binary, version, source, source_version = metadata
    folder = notices / package.replace(':', '_')
    folder.mkdir(exist_ok=True)
    copyright_file = Path('/usr/share/doc') / package.split(':')[0] / 'copyright'
    if not copyright_file.is_file():
        raise RuntimeError(f'Missing license for {package}')
    shutil.copy2(copyright_file, folder / 'copyright')
    source_folder = sources / (source + '-' + source_version.replace(':', '_'))
    if not source_folder.exists():
        source_folder.mkdir()
        try:
            subprocess.run(['apt-get', 'source', '--download-only', '--only-source',
                            source + '=' + source_version], cwd=source_folder, check=True)
            if not list(source_folder.glob('*.dsc')):
                raise RuntimeError(f'No source descriptor for {source}={source_version}')
        except BaseException:
            shutil.rmtree(source_folder)
            raise
    return {'provider': binary, 'version': version, 'source_package': source,
            'source_version': source_version, 'notices': [folder], 'sources': [source_folder]}


def project_source(destination):
    """Include actual application/build sources, excluding historical vendor trees."""
    paths = subprocess.check_output(['git', 'ls-files', '-z', '--cached', '--others', '--exclude-standard'], cwd=ROOT).decode().split('\0')
    roots = {'cpld_toolchain', 'xo2_library', 'distribution', '.github'}
    files = {'LICENSE', 'NOTICE', 'LICENSING.md', 'THIRD_PARTY_NOTICES.txt', 'pyproject.toml', 'setup.cfg', 'README.md'}
    with tarfile.open(destination, 'w:gz') as archive:
        for name in sorted(set(paths)):
            path = Path(name)
            if name and (path.parts[0] in roots or name in files) and (ROOT / path).is_file():
                archive.add(ROOT / path, arcname='uz_cpld/' + name, recursive=False)


def windows_tk_materials(application, notices):
    """Official Windows Python omits notices from its Tcl/Tk script folders.

    Prefer installed notices; otherwise use exact, checksum-pinned upstream
    notices for the version required by the bundled library scripts.
    """
    directory = ROOT / 'distribution/tcltk'
    pins = json.loads((directory / 'licenses.json').read_text(encoding='utf-8'))
    if pins.get('schema_version') != 1:
        raise RuntimeError('Unsupported Tcl/Tk license pins')
    materials, versions, origins = [], {}, {}
    for library, data, script, package in (
            ('tcl', '_tcl_data', 'init.tcl', 'Tcl'), ('tk', '_tk_data', 'tk.tcl', 'Tk')):
        text = (application / '_internal' / data / script).read_text(encoding='utf-8', errors='replace')
        match = re.search(r'package\s+require\s+-exact\s+' + package + r'\s+(\d+\.\d+\.\d+)\b', text)
        if match is None:
            raise RuntimeError(f'Cannot determine bundled {library} version for license attribution')
        version = match[1]
        paths = list((Path(sys.base_prefix) / 'tcl').glob(library + '*/license.terms'))
        paths += list((Path(sys.base_prefix) / 'tcl').glob(library + '*/license*'))
        source = next((p for p in paths if p.is_file()), None)
        origin = str(source) if source else None
        if source is None:
            pin = pins['libraries'][library]
            if version not in pin['releases']:
                raise RuntimeError(f'Missing pinned upstream notice for {library} {version}; update distribution/tcltk/licenses.json')
            source = directory / pin['file']
            if digest(source) != pin['sha256']:
                raise RuntimeError(f'Pinned {library} notice checksum mismatch')
            origin = pin['releases'][version]
        target = notices / (library + '-LICENSE.txt')
        shutil.copy2(source, target)
        materials.append(target)
        versions[library] = version
        origins[library] = dict(version=version, source=origin, sha256=digest(target))
    provenance = notices / 'Tcl-Tk-SOURCES.json'
    provenance.write_text(json.dumps(origins, indent=2) + '\n', encoding='utf-8')
    materials.append(provenance)
    return dict(provider='Tcl/Tk', versions=versions, notices=materials, sources=[])


def windows_zlib_materials(source, notices):
    """Attribute the Tcl/Tk compression DLL using its runtime version export."""
    library = ctypes.CDLL(str(source))
    library.zlibVersion.argtypes = []
    library.zlibVersion.restype = ctypes.c_char_p
    version = library.zlibVersion().decode('ascii')
    directory = ROOT / 'distribution/zlib'
    pins = json.loads((directory / 'licenses.json').read_text(encoding='utf-8'))
    if pins.get('schema_version') != 1:
        raise RuntimeError('Unsupported zlib license pins')
    pin = pins['releases'].get(version)
    if pin is None:
        raise RuntimeError(f'Missing pinned upstream notice for zlib {version}; update distribution/zlib/licenses.json')
    license_file = directory / pin['file']
    if digest(license_file) != pin['sha256']:
        raise RuntimeError('Pinned zlib notice checksum mismatch')
    target = notices / 'zlib-LICENSE.txt'
    shutil.copy2(license_file, target)
    provenance = notices / 'zlib-SOURCES.json'
    provenance.write_text(json.dumps(dict(version=version, source=pin['url'],
                                          sha256=digest(target)), indent=2) + '\n', encoding='utf-8')
    return dict(provider='zlib', version=version, notices=[target, provenance], sources=[])


def collect(application, inputs):
    notices = application / 'licenses'
    sources = application / 'sources'
    notices.mkdir(exist_ok=True)
    sources.mkdir(exist_ok=True)
    for name in ('LICENSE', 'NOTICE', 'LICENSING.md', 'THIRD_PARTY_NOTICES.txt'):
        shutil.copy2(ROOT / name, application / name)
    project_source(sources / 'uz-cpld-source.tar.gz')
    components = {}
    package_files = {}
    for name in ('pyinstaller', 'tomli'):
        dist = importlib.metadata.distribution(name)
        files = []
        for file in dist.files or ():
            package_files[Path(dist.locate_file(file)).resolve()] = name
            if 'license' in Path(file).name.lower() or 'copying' in Path(file).name.lower():
                source = Path(dist.locate_file(file))
                if source.is_file():
                    target = notices / (name + '-' + source.name)
                    shutil.copy2(source, target)
                    files.append(target)
        if not files:
            raise RuntimeError(f'Missing runtime license: {name}')
        components[name] = {'provider': name, 'version': dist.version, 'notices': files, 'sources': []}
    candidates = [Path(sys.base_prefix) / 'LICENSE.txt',
                  Path(sysconfig.get_path('stdlib')) / 'LICENSE.txt',
                  Path(f'/usr/share/doc/python{sys.version_info.major}.{sys.version_info.minor}/copyright')]
    license_file = next((p for p in candidates if p.is_file()), None)
    if license_file is None:
        raise RuntimeError('Python LICENSE.txt is required for the standalone distribution')
    shutil.copy2(license_file, notices / 'Python-LICENSE.txt')
    components['python'] = {'provider': 'CPython', 'version': sys.version.split()[0],
                            'notices': [notices / 'Python-LICENSE.txt'], 'sources': []}
    components['application'] = {'provider': 'UltraZohm CPLD contributors',
                                 'notices': [application / 'LICENSE', application / 'NOTICE'],
                                 'sources': [sources / 'uz-cpld-source.tar.gz']}
    if sys.platform == 'win32':
        text = license_file.read_text(encoding='utf-8')
        validate_windows_python_license(text)
        shutil.copy2(ROOT / 'distribution/WINDOWS-RUNTIME-TERMS.txt', notices)
        components['python']['notices'].append(notices / 'WINDOWS-RUNTIME-TERMS.txt')
        if (application / 'uz_cpld_gui.exe').is_file():
            components['tcl-tk'] = windows_tk_materials(application, notices)
    else:
        shutil.copytree('/usr/share/common-licenses', notices / 'common-licenses', dirs_exist_ok=True)
    native_inputs = {name.replace('\\', '/'): Path(source) for name, source, kind in inputs
                     if kind in ('BINARY', 'EXTENSION')}
    for name, source, kind in inputs:
        if kind == 'PYMODULE' and name.split('.')[0] not in (
                sys.stdlib_module_names | {'cpld_toolchain', 'xo2_library', 'tomli'}):
            raise RuntimeError(f'Unattributed Python runtime dependency: {name} ({source})')
    file_components = {}
    for relative, source in native_inputs.items():
        target = application / '_internal' / relative
        if not target.is_file():
            raise RuntimeError(f'Missing collected runtime file: {relative}')
        package = debian_package(source) if sys.platform == 'linux' else None
        if source.resolve() in package_files:
            key = package_files[source.resolve()]
        elif package:
            key = 'deb:' + package
            if key not in components:
                components[key] = debian_materials(package, notices, sources)
                components[key]['notices'].append(notices / 'common-licenses')
        elif sys.platform == 'win32' and source.is_relative_to(Path(sys.base_prefix)) and source.name.lower() == 'zlib1.dll':
            key = 'zlib'
            if key not in components:
                components[key] = windows_zlib_materials(source, notices)
        elif sys.platform == 'win32' and source.is_relative_to(Path(sys.base_prefix)) and source.name.lower().startswith(('tcl', 'tk')):
            key = 'tcl-tk'
        elif source.is_relative_to(Path(sys.base_prefix)) and (
                source.name.lower().startswith(('python', 'libpython', 'vcruntime', 'libcrypto-', 'libssl-', 'libffi-'))
                or source.suffix.lower() == '.pyd' or source.parent.name == 'lib-dynload'):
            key = 'python'
        else:
            raise RuntimeError(f'Unattributed runtime dependency: {source}')
        file_components[target.relative_to(application).as_posix()] = [key]
    bundle_root = application / '_internal/cpld_toolchain/bundled_tools'
    for bundle in bundle_root.iterdir():
        key = 'bundle:' + bundle.name
        package_versions = {}
        if sys.platform == 'linux':
            receipt = json.loads((bundle / 'usercode-support.json').read_text())
            package_versions = receipt['packages']
        license_paths = [bundle / 'licenses']
        if (bundle / 'LICENSE').exists():
            license_paths.append(bundle / 'LICENSE')
        source_paths = [bundle / name for name in (
            'sources', 'upstream-source.tar.gz', 'openfpgaloader-usercode.patch', 'build-recipe.py',
            'relink', 'relink-libraries', 'relink-objects', 'RELINK.txt') if (bundle / name).exists()]
        if not all(p.exists() for p in license_paths) or not source_paths:
            raise RuntimeError(f'Incomplete native bundle licensing: {bundle.name}')
        components[key] = {'provider': bundle.name, 'notices': license_paths, 'sources': source_paths}
        # Loader's Linux shared dependencies are separately attributable packages.
        for path in bundle.rglob('*'):
            if not path.is_file() or not native_file(path):
                continue
            owner = key
            if sys.platform == 'linux' and '.so' in path.name:
                # Find the installed original rather than the relocated ELF.
                matches = list(Path('/usr/lib/x86_64-linux-gnu').glob(path.name))
                package = debian_package(matches[0]) if matches else None
                if not package:
                    raise RuntimeError(f'Unattributed loader runtime: {path}')
                installed = command(['dpkg-query', '-W', '-f=${Package} ${Version}', package])
                if package_versions.get(package) != installed:
                    raise RuntimeError(f'Loader/source package version mismatch: {package}; rebuild the loader in this environment')
                owner = 'deb:' + package
                if owner not in components:
                    components[owner] = debian_materials(package, notices, sources)
                    components[owner]['notices'].append(notices / 'common-licenses')
            file_components[path.relative_to(application).as_posix()] = [owner]
    executable = 'uz_cpld.exe' if sys.platform == 'win32' else 'uz_cpld'
    file_components[executable] = ['application', 'pyinstaller', 'python', 'tomli']
    gui_executable = 'uz_cpld_gui.exe' if sys.platform == 'win32' else 'uz_cpld_gui'
    if (application / gui_executable).exists():
        file_components[gui_executable] = ['application', 'pyinstaller', 'python', 'tomli']
    # PYZ is inside the executable; base_library.zip contains CPython bytecode.
    for path in application.rglob('base_library.zip'):
        file_components[path.relative_to(application).as_posix()] = ['python']
    for path in application.rglob('*'):
        if path.is_file() and native_file(path) and path.relative_to(application).as_posix() not in file_components:
            raise RuntimeError(f'Uninventoried native runtime: {path}')
    for component in components.values():
        for key in ('notices', 'sources'):
            component[key] = [p.relative_to(application).as_posix() for p in component[key]]
    record = {'schema_version': 1, 'components': components,
              'files': {name: {'components': keys, 'sha256': digest(application / name)}
                        for name, keys in sorted(file_components.items())}}
    materials = {}
    for component in components.values():
        for name in component['notices'] + component['sources']:
            path = application / name
            for file in ([path] if path.is_file() else path.rglob('*')):
                if file.is_file():
                    materials[file.relative_to(application).as_posix()] = digest(file)
    record['materials'] = dict(sorted(materials.items()))
    (notices / 'inventory.json').write_text(json.dumps(record, indent=2) + '\n')
    verify(application)
    return record


def native_file(path):
    return path.suffix.lower() in ('.dll', '.pyd', '.exe') or '.so' in path.name or path.name in ('uz_cpld', 'uz_cpld_gui', 'openFPGALoader')


def verify(application):
    """Check extracted/assembled archives as well as the build directory."""
    record = json.loads((application / 'licenses/inventory.json').read_text())
    if record.get('schema_version') != 1 or not record.get('materials') or not record.get('files'):
        raise RuntimeError('Missing distribution license inventory')
    hashes = dict(record['materials'])
    for name, entry in record['files'].items():
        hashes[name] = entry['sha256']
        for component in entry['components']:
            if component not in record['components']:
                raise RuntimeError(f'Unknown inventory component: {component}')
    for name, expected in hashes.items():
        path = application / name
        if not path.resolve().is_relative_to(application.resolve()) or not path.is_file() or digest(path) != expected:
            raise RuntimeError(f'Missing or changed distribution material: {name}')
    for component in record['components'].values():
        if not component['notices']:
            raise RuntimeError('Component has no license notice')
        for name in component['notices'] + component['sources']:
            if name not in record['materials'] and not any(key.startswith(name + '/') for key in record['materials']):
                raise RuntimeError(f'Unrecorded distribution material: {name}')
    windows = (application / 'uz_cpld.exe').is_file()
    for path in application.rglob('*'):
        if path.is_file() and native_file(path):
            if windows and system_dll(path.name):
                raise RuntimeError(f'Windows system DLL must not be redistributed: {path.name}')
            if path.relative_to(application).as_posix() not in record['files']:
                raise RuntimeError(f'Uninventoried native runtime: {path}')
    return record
