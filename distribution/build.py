"""Build one native standalone application. Run separately on each OS."""
import argparse
import json
import os
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
    parser.add_argument('--without-gui', action='store_true', help='Build the CLI without the optional Tk runtime and launcher')
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
                    str(ROOT / 'distribution/uz_cpld.spec')], cwd=ROOT, check=True,
                   env=dict(os.environ, UZ_CPLD_BUILD_GUI='0' if args.without_gui else '1'))
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
    info['programmer_gui'] = not args.without_gui
    (application / 'application.json').write_text(json.dumps(info, indent=2) + '\n')
    from distribution.licensing import collect
    inputs = json.loads((output / 'work/uz_cpld/runtime-inputs.json').read_text())
    collect(application, inputs)
    print(application)


if __name__ == '__main__':
    try:
        main()
    except Exception as exc:
        if os.environ.get('GITHUB_ACTIONS') == 'true':
            message = f'{type(exc).__name__}: {exc}'.replace('%', '%25').replace('\r', '%0D').replace('\n', '%0A')
            print('::error title=Standalone build failure::' + message, flush=True)
        raise
