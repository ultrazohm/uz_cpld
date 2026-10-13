"""Build one native standalone application. Run separately on each OS."""
import argparse
import importlib.metadata
import json
from pathlib import Path
import platform
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpld_toolchain import __version__


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/standalone')
    parser.add_argument('--loader', type=Path, default=ROOT / 'build/portable-loader',
                        help='Tested portable loader directory from distribution/loader.py')
    parser.add_argument('--drivers', type=Path, default=ROOT / 'build/windows-drivers',
                        help='Verified Windows driver helper from distribution/windows_drivers/build.py')
    args = parser.parse_args()
    if sys.platform not in ('win32', 'linux') or platform.machine().lower() not in ('amd64', 'x86_64'):
        raise RuntimeError('Standalone release builds currently require Windows or Linux x64')
    output = args.output.resolve()
    from cpld_toolchain.toolchain.foss import flasher
    loader = args.loader.resolve()
    filename = 'openFPGALoader.exe' if sys.platform == 'win32' else 'openFPGALoader'
    provenance = flasher.verify(loader / filename)
    if sys.platform == 'win32' and (provenance.get('linkage') != 'static' or provenance.get('runtime_sha256')):
        raise RuntimeError('Windows releases require the static MinGW-w64 loader with no runtime DLLs')
    commit = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    if provenance.get('git_revision') != commit:
        raise RuntimeError('Portable loader must come from this application commit')
    driver_provenance = None
    if sys.platform == 'win32':
        from cpld_toolchain.driver_setup import verify as verify_drivers
        driver_provenance = verify_drivers(args.drivers / 'uz-cpld-driver-helper.exe')
        if driver_provenance.get('git_revision') != commit:
            raise RuntimeError('Driver helper must come from this application commit')
    subprocess.run([sys.executable, '-m', 'PyInstaller', '--noconfirm', '--clean',
                    '--distpath', str(output / 'dist'), '--workpath', str(output / 'work'),
                    str(ROOT / 'distribution/uz_cpld.spec')], cwd=ROOT, check=True)
    application = output / 'dist/uz_cpld'
    # Keep the portable native runtime separate from PyInstaller's Python libraries.
    bundled = application / '_internal/cpld_toolchain/bundled_tools/openFPGALoader'
    shutil.copytree(loader, bundled)
    if driver_provenance:
        shutil.copytree(args.drivers, bundled.parent / 'windows-drivers')
    shutil.copy2(ROOT / 'distribution/README.txt', application / 'README.txt')
    info = dict(schema_version=1, application_version=__version__, git_revision=commit,
                platform='windows-x64' if sys.platform == 'win32' else 'ubuntu-24.04-x64',
                build_system=platform.platform(),
                git_dirty=bool(subprocess.check_output(['git', 'status', '--porcelain'], cwd=ROOT)),
                python=sys.version.split()[0], diamond_version='3.14.0.75.2', firmware_schema=1,
                default_programmer_backend='foss', openfpgaloader=provenance, windows_drivers=driver_provenance)
    (application / 'application.json').write_text(json.dumps(info, indent=2) + '\n')
    notices = application / 'licenses'
    notices.mkdir(exist_ok=True)
    # Retain notices supplied by the actual build environment.
    for name in ('pyinstaller', 'tomli'):
        dist = importlib.metadata.distribution(name)
        for file in dist.files or ():
            if 'license' in Path(file).name.lower() or 'copying' in Path(file).name.lower():
                source = Path(dist.locate_file(file))
                if source.is_file():
                    shutil.copy2(source, notices / (name + '-' + source.name))
    import sysconfig
    candidates = [Path(sys.base_prefix) / 'LICENSE.txt',
                  Path(sysconfig.get_path('stdlib')) / 'LICENSE.txt',
                  Path(f'/usr/share/doc/python{sys.version_info.major}.{sys.version_info.minor}/copyright')]
    license_file = next((path for path in candidates if path.is_file()), None)
    if license_file is None:
        raise RuntimeError('Python LICENSE.txt is required for the standalone distribution')
    shutil.copy2(license_file, notices / 'Python-LICENSE.txt')
    print(application)


if __name__ == '__main__':
    main()
