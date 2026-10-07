"""Create tool archives and assemble a release using the exact tested artifacts."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import sys
import tarfile
import tempfile
from zipfile import ZipFile, ZIP_DEFLATED

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpld_toolchain.programmer_helper.release import read_package
from cpld_toolchain.toolchain.buildsystem.model import BuildError


def digest(path):
    with path.open('rb') as stream:
        result = hashlib.sha256()
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            result.update(block)
        return result.hexdigest()


def pack(application, output, *, combined=False):
    info = json.loads((application / 'application.json').read_text())
    platform = info['platform']
    if platform not in ('windows-x64', 'ubuntu-24.04-x64'):
        raise BuildError(f'Unsupported application platform: {platform}')
    version = info['application_version']
    if not version or any(c not in '0123456789abcdefghijklmnopqrstuvwxyz.-' for c in version):
        raise BuildError('Invalid application version')
    name = f'uz_cpld-{version}-{platform}' + ('-with-firmware' if combined else '')
    output.mkdir(parents=True, exist_ok=True)
    if platform == 'windows-x64':
        destination = output / (name + '.zip')
        with ZipFile(destination, 'w', ZIP_DEFLATED) as archive:
            for path in sorted(application.rglob('*')):
                if path.is_file():
                    archive.write(path, Path('uz_cpld') / path.relative_to(application))
    else:
        destination = output / (name + '.tar.gz')
        # TAR preserves executable modes and PyInstaller's internal symlinks.
        with tarfile.open(destination, 'w:gz', dereference=False) as archive:
            archive.add(application, arcname='uz_cpld')
    return destination


def unpack(path, destination):
    if path.name.endswith('.tar.gz'):
        with tarfile.open(path) as archive:
            archive.extractall(destination, filter='data')
    else:
        with ZipFile(path) as archive:
            for item in archive.infolist():
                target = (destination / item.filename).resolve()
                if not target.is_relative_to(destination.resolve()) or '\\' in item.filename:
                    raise BuildError('Invalid application archive path')
            archive.extractall(destination)
    application = destination / 'uz_cpld'
    if not (application / 'application.json').is_file():
        raise BuildError('Application archive is missing application.json')
    return application


def assemble(tools, firmware, output, commit):
    manifest, evidence = read_package(firmware)
    if manifest['backend'] != 'diamond' or manifest['git_revision'] != commit:
        raise BuildError('Release firmware must be Diamond firmware from this workflow commit')
    archives = sorted([*tools.glob('*.zip'), *tools.glob('*.tar.gz')])
    if len(archives) != 2:
        raise BuildError('Release requires exactly one Windows and one Ubuntu tool archive')
    output.mkdir(parents=True, exist_ok=True)
    platforms = set()
    for source in archives:
        with tempfile.TemporaryDirectory(prefix='uz-release-') as temporary:
            application = unpack(source, Path(temporary))
            info = json.loads((application / 'application.json').read_text())
            if info['git_revision'] != commit or info['platform'] in platforms:
                raise BuildError('Application artifacts must have distinct platforms and match the workflow commit')
            platforms.add(info['platform'])
            included = application / 'firmware/uz-cpld-firmware.zip'
            if included.parent.exists() or (application / 'bundle.json').exists():
                raise BuildError('Expected a tool-only artifact')
            included.parent.mkdir()
            shutil.copy2(firmware, included)
            bundle = dict(schema_version=1, application=info, firmware_git_revision=manifest['git_revision'],
                          firmware_sha256=evidence['archive_sha256'])
            (application / 'bundle.json').write_text(json.dumps(bundle, indent=2) + '\n')
            pack(application, output, combined=True)
        shutil.copy2(source, output / source.name)
    if platforms != {'windows-x64', 'ubuntu-24.04-x64'}:
        raise BuildError('Both Windows and Ubuntu artifacts are required')
    shutil.copy2(firmware, output / 'uz-cpld-firmware.zip')
    assets = sorted(p for p in output.iterdir() if p.name != 'SHA256SUMS.txt')
    (output / 'SHA256SUMS.txt').write_text(''.join(f'{digest(p)}  {p.name}\n' for p in assets))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    actions = parser.add_subparsers(dest='action', required=True)
    package = actions.add_parser('pack')
    package.add_argument('--application', type=Path, required=True)
    package.add_argument('--output', type=Path, required=True)
    release = actions.add_parser('assemble')
    release.add_argument('--tools', type=Path, required=True)
    release.add_argument('--firmware', type=Path, required=True)
    release.add_argument('--output', type=Path, required=True)
    release.add_argument('--commit', required=True)
    args = parser.parse_args()
    if args.action == 'pack':
        print(pack(args.application.resolve(), args.output.resolve()))
    else:
        assemble(args.tools.resolve(), args.firmware.resolve(), args.output.resolve(), args.commit)


if __name__ == '__main__':
    main()
