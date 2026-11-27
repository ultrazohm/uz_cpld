"""Build the user application wheel, including verified native programmer assets.

The root pyproject remains the checkout's developer environment. Public builds
use isolated setuptools projects so development dependencies never leak into
the user application. Each supported platform gets one complete wheel.
"""
import argparse
from email.parser import BytesParser
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

PLATFORMS = ('win_amd64', 'manylinux_2_28_x86_64')
VERSION = re.compile(r'\d+\.\d+\.\d+(?:\.dev\d+)?')


def release_version():
    """Unique prereleases on this workflow, including reruns; never stable."""
    run = os.environ['GITHUB_RUN_ID']
    attempt = os.environ.get('GITHUB_RUN_ATTEMPT', '1')
    if not run.isdecimal() or not attempt.isdecimal() or len(attempt) > 3:
        raise ValueError('Invalid GitHub run identity')
    return f'0.6.0.dev{run}{int(attempt):03d}'


def publication_version(directory, commit):
    """Validate the tested artifact set and reuse its version on partial reruns."""
    files = sorted(directory.glob('*.whl'))
    if len(files) != len(PLATFORMS):
        raise ValueError('Publication requires exactly one wheel for each supported platform')
    platforms, versions = set(), set()
    for path in files:
        match = re.fullmatch(r'ultrazohm_cpld_user-(\d+\.\d+\.\d+\.dev\d+)-py3-none-(.+)\.whl', path.name)
        if not match:
            raise ValueError(f'Publication requires user prerelease wheels: {path.name}')
        version, platform = match.groups()
        if platform not in PLATFORMS or platform in platforms:
            raise ValueError(f'Unexpected or duplicate wheel platform: {platform}')
        with ZipFile(path) as archive:
            dist_info = f'ultrazohm_cpld_user-{version}.dist-info'
            metadata = BytesParser().parsebytes(archive.read(f'{dist_info}/METADATA'))
            wheel = BytesParser().parsebytes(archive.read(f'{dist_info}/WHEEL'))
            application = json.loads(archive.read('cpld_toolchain/application.json'))
            native = json.loads(archive.read('cpld_toolchain/bundled_tools/release.json'))
        if (metadata['Name'] != 'ultrazohm-cpld-user' or metadata['Version'] != version or
                wheel.get_all('Tag') != [f'py3-none-{platform}'] or native.get('platform') != platform):
            raise ValueError(f'Wheel metadata does not match its filename: {path.name}')
        if any(record.get('version') != version or record.get('git_revision') != commit
               for record in (application, native)):
            raise ValueError(f'Wheel provenance does not match this workflow commit: {path.name}')
        platforms.add(platform)
        versions.add(version)
    if len(versions) != 1:
        raise ValueError('Platform wheels must have the same version; rerun all package builds')
    return versions.pop()


def metadata(stage, version):
    for filename in ('LICENSE', 'NOTICE', 'LICENSING.md', 'THIRD_PARTY_NOTICES.txt'):
        shutil.copy2(ROOT / filename, stage / filename)
    readme = ('# UltraZohm CPLD user application\n\n'
                  'Program existing UltraZohm CPLD firmware with the included FOSS programmer. '
                  'No checkout, compiler or Diamond installation is required.\n\n'
                  '```console\nuv tool install --managed-python --python 3.12 --prerelease allow ultrazohm-cpld-user\n'
                  'uz_cpld doctor\nuz_cpld programmer_gui\n```\n\n'
                  'Downloads default to stable firmware; explicitly enable testing releases in the GUI '
                  'or pass `--branch` to `firmware_download`. Use `uz_cpld setup_drivers` for explicit '
                  'USB setup, which requests host administrator privileges when needed.\n\n'
                  'Windows x64 and Linux x86-64 with glibc 2.28 or newer are supported. '
                  'The optional GUI needs Tcl/Tk; uv-managed Python 3.12 is tested.\n')
    (stage / 'README.md').write_text(readme + '\n[Source and documentation](https://github.com/ultrazohm/uz_cpld)\n')
    data = f'''[build-system]
requires = ["setuptools==84.0.0", "wheel==0.48.0"]
build-backend = "setuptools.build_meta"

[project]
name = "ultrazohm-cpld-user"
version = {json.dumps(version)}
description = "UltraZohm existing-firmware programmer"
readme = "README.md"
requires-python = ">=3.12"
license = "LicenseRef-Bundled-Components"
license-files = ["LICENSE", "NOTICE", "LICENSING.md", "THIRD_PARTY_NOTICES.txt"]
dependencies = ["certifi==2026.7.22"]

[project.urls]
Repository = "https://github.com/ultrazohm/uz_cpld"

[tool.setuptools.packages.find]
where = ["."]
namespaces = true
include = ["cpld_toolchain*"]

[tool.setuptools.package-data]
"*" = ["**/*"]

[project.scripts]
uz_cpld = "cpld_toolchain.user:main"

[project.gui-scripts]
uz_cpld_gui = "cpld_toolchain.user:gui"
'''
    (stage / 'pyproject.toml').write_text(data)


def stage_user(stage, version, commit):
    metadata(stage, version)
    # Keep shared internal modules until the separate developer-interface change.
    # Only the programmer entry points are exported; no developer dependencies,
    # catalogs, tests or compiled HDL tools are installed.
    shutil.copytree(ROOT / 'cpld_toolchain', stage / 'cpld_toolchain',
                    ignore=shutil.ignore_patterns('tests', 'test_*.py', 'conftest.py', '__pycache__', '*.pyc', 'bundled_tools'))
    (stage / 'cpld_toolchain/__main__.py').write_text(
        'from .user import main\n\nif __name__ == "__main__":\n    raise SystemExit(main())\n')
    init = stage / 'cpld_toolchain/__init__.py'
    init.write_text(re.sub(r'__version__ = "[^"]+"', f'__version__ = "{version}"', init.read_text()))
    (stage / 'cpld_toolchain/application.json').write_text(json.dumps(
        dict(version=version, git_revision=commit, distribution='ultrazohm-cpld-user'), indent=2))


def stage_native(stage, version, commit, platform, loader, drivers=None):
    from cpld_toolchain.toolchain.foss import flasher
    from cpld_toolchain.driver_setup import verify as verify_drivers
    windows = platform == 'win_amd64'
    binary = loader / ('openFPGALoader.exe' if windows else 'openFPGALoader')
    receipt = flasher.verify(binary)
    if receipt.get('git_revision') != commit:
        raise ValueError('Bundled programmer and application must come from the same commit')
    if windows and (receipt.get('linkage') != 'static' or receipt.get('runtime_sha256')):
        raise ValueError('Windows wheel requires the verified static programmer')
    if not windows:
        compatibility = json.loads((loader / 'linux-compatibility.json').read_text())
        if compatibility != dict(platform=platform, executable_sha256=flasher.digest(binary)):
            raise ValueError('Linux programmer must pass checks on glibc 2.28')
    for name in ('LICENSE', 'upstream-source.tar.gz', 'build-recipe.py', '99-openfpgaloader.rules'):
        if not (loader / name).is_file():
            raise ValueError(f'Programmer distribution material missing: {name}')
    package = stage / 'cpld_toolchain/bundled_tools'
    package.mkdir()
    shutil.copytree(loader, package / 'openFPGALoader')
    from distribution.licensing import project_source
    project_source(package / 'build-sources.tar.gz')
    if windows:
        if drivers is None:
            raise ValueError('Windows wheel requires driver helper artifacts')
        record = verify_drivers(drivers / 'uz-cpld-driver-helper.exe')
        if record.get('git_revision') != commit:
            raise ValueError('Driver helper must come from the same commit')
        shutil.copytree(drivers, package / 'windows-drivers')
    (package / 'release.json').write_text(json.dumps(dict(version=version, git_revision=commit, platform=platform)))
    # External executables do not link to CPython, so the ABI tag is "none".
    (stage / 'setup.py').write_text(
        'from setuptools import setup, Distribution\n'
        'from setuptools.command.bdist_wheel import bdist_wheel\n'
        'class Native(Distribution):\n    def has_ext_modules(self): return True\n'
        'class Wheel(bdist_wheel):\n'
        f'    def get_tag(self): return ("py3", "none", {platform!r})\n'
        'setup(distclass=Native, cmdclass={"bdist_wheel": Wheel})\n')


def build(args):
    if not VERSION.fullmatch(args.version):
        raise ValueError('Expected a release or .dev prerelease version')
    if not args.platform or not args.loader:
        raise ValueError('The user wheel requires --platform and --loader to bundle its programmer')
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    commit = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    with tempfile.TemporaryDirectory(prefix='uz-wheel-') as temporary:
        stage = Path(temporary)
        stage_user(stage, args.version, commit)
        stage_native(stage, args.version, commit, args.platform, args.loader.resolve(),
                     args.drivers.resolve() if args.drivers else None)
        subprocess.run([sys.executable, '-m', 'build', '--wheel', '--outdir', str(output), str(stage)], check=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('kind', choices=('user', 'version', 'publication-version'))
    parser.add_argument('--version')
    parser.add_argument('--commit', help='Expected source commit for publication validation')
    parser.add_argument('--platform', choices=PLATFORMS)
    parser.add_argument('--loader', type=Path)
    parser.add_argument('--drivers', type=Path)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/wheels')
    args = parser.parse_args()
    if args.kind == 'version':
        print(release_version())
    elif args.kind == 'publication-version':
        if not args.commit:
            parser.error('--commit is required for publication validation')
        print(publication_version(args.output, args.commit))
    elif not args.version:
        parser.error('--version is required')
    else:
        build(args)
