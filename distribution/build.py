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
    args = parser.parse_args()
    if sys.platform not in ('win32', 'linux') or platform.machine().lower() not in ('amd64', 'x86_64'):
        raise RuntimeError('Standalone release builds currently require Windows or Linux x64')
    output = args.output.resolve()
    subprocess.run([sys.executable, '-m', 'PyInstaller', '--noconfirm', '--clean',
                    '--distpath', str(output / 'dist'), '--workpath', str(output / 'work'),
                    str(ROOT / 'distribution/uz_cpld.spec')], cwd=ROOT, check=True)
    application = output / 'dist/uz_cpld'
    shutil.copy2(ROOT / 'distribution/README.txt', application / 'README.txt')
    commit = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    info = dict(schema_version=1, application_version=__version__, git_revision=commit,
                platform='windows-x64' if sys.platform == 'win32' else 'ubuntu-24.04-x64',
                build_system=platform.platform(),
                git_dirty=bool(subprocess.check_output(['git', 'status', '--porcelain'], cwd=ROOT)),
                python=sys.version.split()[0], diamond_version='3.14.0.75.2', firmware_schema=1)
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
                  Path(sysconfig.get_path('stdlib')) / 'LICENSE.txt']
    license_file = next((path for path in candidates if path.is_file()), None)
    if license_file is None:
        raise RuntimeError('Python LICENSE.txt is required for the standalone distribution')
    shutil.copy2(license_file, notices / 'Python-LICENSE.txt')
    print(application)


if __name__ == '__main__':
    main()
