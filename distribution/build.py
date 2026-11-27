"""Freeze the installed, tested user wheel as a Windows standalone application."""
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/standalone')
    parser.add_argument('--without-gui', action='store_true', help='Build the CLI without the optional Tk runtime and launcher')
    args = parser.parse_args()
    if sys.platform != 'win32' or platform.machine().lower() not in ('amd64', 'x86_64'):
        raise RuntimeError('Standalone releases are Windows x64 only; use Python wheels on Linux')
    output = args.output.resolve()
    from cpld_toolchain.toolchain.foss import flasher
    installed = json.loads(subprocess.check_output([sys.executable, '-I', '-c',
        'import json; from pathlib import Path; import cpld_toolchain; '
        'print(json.dumps(dict(site=str(Path(cpld_toolchain.__file__).parent.parent), '
        'tools=str(Path(cpld_toolchain.__file__).parent / "bundled_tools"))))'], text=True))
    site = Path(installed['site'])
    package_info = json.loads((site / 'cpld_toolchain/application.json').read_text())
    loader = Path(installed['tools']) / 'openFPGALoader'
    drivers = Path(installed['tools']) / 'windows-drivers'
    filename = 'openFPGALoader.exe' if sys.platform == 'win32' else 'openFPGALoader'
    provenance = flasher.verify(loader / filename)
    if sys.platform == 'win32' and (provenance.get('linkage') != 'static' or provenance.get('runtime_sha256')):
        raise RuntimeError('Windows releases require the static MinGW-w64 loader with no runtime DLLs')
    commit = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    if package_info['git_revision'] != commit:
        raise RuntimeError('Installed user wheel must come from this commit')
    if provenance.get('git_revision') != commit:
        raise RuntimeError('Portable loader must come from this application commit')
    driver_provenance = None
    if sys.platform == 'win32':
        from cpld_toolchain.driver_setup import verify as verify_drivers
        driver_provenance = verify_drivers(drivers / 'uz-cpld-driver-helper.exe')
        if driver_provenance.get('git_revision') != commit:
            raise RuntimeError('Driver helper must come from this application commit')
    output.mkdir(parents=True, exist_ok=True)
    subprocess.run([sys.executable, '-m', 'PyInstaller', '--noconfirm', '--clean',
                    '--distpath', str(output / 'dist'), '--workpath', str(output / 'work'),
                    str(ROOT / 'distribution/uz_cpld.spec')], cwd=output, check=True,
                   env=dict(os.environ, PYTHONPATH='', UZ_CPLD_PACKAGE_ROOT=str(site), UZ_CPLD_BUILD_GUI='0' if args.without_gui else '1'))
    application = output / 'dist/uz_cpld'
    # Keep the portable native runtime separate from PyInstaller's Python libraries.
    bundled = application / '_internal/cpld_toolchain/bundled_tools/openFPGALoader'
    shutil.copytree(loader, bundled)
    if driver_provenance:
        shutil.copytree(drivers, bundled.parent / 'windows-drivers')
    shutil.copy2(ROOT / 'distribution/README.txt', application / 'README.txt')
    info = dict(schema_version=1, application_version=package_info['version'], git_revision=commit,
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
