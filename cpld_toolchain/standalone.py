"""Standalone firmware downloader and Diamond programmer; no checkout required."""
import argparse
from http.client import HTTPException
import json
from pathlib import Path
import shutil
import sys
import tempfile
from zipfile import BadZipFile

from . import __version__, settings, workspace
from .programmer_helper import program, release
from .toolchain import diamond, firmware_download
from .toolchain.buildsystem.model import BuildError

DEFAULT_REPOSITORY = 'https://github.com/ultrazohm/uz_cpld'
DEFAULT_BRANCH = 'master'
DIAMOND_VERSION = '3.14.0.75.2'


def application_directory():
    return Path(sys.executable).resolve().parent if getattr(sys, 'frozen', False) else Path(__file__).resolve().parent


def included_firmware():
    return application_directory() / 'firmware' / firmware_download.ASSET


def selected_firmware(root):
    path = root / 'firmware.json'
    if not path.is_file():
        raise BuildError('No firmware selected. Run firmware_download, then firmware_select --firmware FILE; '
                         'or firmware_select --included for a combined download.')
    try:
        data = json.loads(path.read_text(encoding='utf-8'))
        if data['schema_version'] != 1 or not isinstance(data['path'], str):
            raise ValueError('unsupported selection format')
        firmware = Path(data['path'])
        if not firmware.is_absolute():
            raise ValueError('selection path must be absolute')
        _, evidence = release.read_package(firmware)
        if evidence['archive_sha256'] != data['sha256']:
            raise BuildError('Selected firmware changed. Inspect and select it again before programming.')
        return firmware
    except (KeyError, TypeError, ValueError) as exc:
        raise BuildError(f'Invalid firmware selection {path}: {exc}') from exc


def inspect_firmware(path):
    manifest, evidence = release.read_package(path)
    if manifest['backend'] != 'diamond':
        raise BuildError('This standalone release requires Diamond JEDEC firmware; FOSS support will be added later.')
    print(f'Firmware: {path}')
    print(f'Source commit: {manifest["git_revision"]}')
    print(f'SHA-256: {evidence["archive_sha256"]}')
    for entry in manifest['builds']:
        print(f'{entry["release_cycle"]}/{entry["program"]}  {entry["target"]}  '
              f'USERCODE {entry["identity"]["usercode"]}')
    return manifest, evidence


def doctor(root):
    override, origin = settings.programmer_override()
    print(f'Application: {__version__}')
    print(f'Workspace: {root}')
    print(f'Settings: {settings.config_path()}')
    print(f'Programmer configuration: {origin} ({override or "auto"})')
    try:
        binary = diamond.executable('programmer')
    except BuildError as exc:
        print(f'MISSING: {exc}')
        print('Set the executable with uz_cpld programmer_path=PATH')
        return 1
    version = diamond.installed_version(binary)
    print(f'Diamond Programmer: {binary}')
    print(f'Installation version: {version or "unavailable"}; release test baseline: {DIAMOND_VERSION}')
    print('Discovery only: no license or USB operation was attempted.')
    if included_firmware().is_file():
        print(f'Included firmware: {included_firmware()} (use firmware_select --included)')
    return 0


def parser():
    result = argparse.ArgumentParser(prog='uz_cpld', description=__doc__,
        epilog='Persist Diamond configuration: uz_cpld programmer_path=PATH (or programmer_path=auto).')
    result.add_argument('--version', action='version', version=f'uz_cpld {__version__}')
    result.add_argument('--workspace', type=Path, help='Writable data directory; defaults to the user-data workspace')
    actions = result.add_subparsers(dest='action')
    actions.add_parser('doctor', help='Show paths and Diamond discovery; does not access USB')
    download = actions.add_parser('firmware_download', help='Download newest published master firmware; does not select it')
    download.add_argument('--git-url', default=DEFAULT_REPOSITORY)
    download.add_argument('--branch', default=DEFAULT_BRANCH)
    download.add_argument('--output', type=Path)
    for name in ('firmware_list', 'firmware_select'):
        item = actions.add_parser(name, help='Inspect firmware' if name.endswith('list') else 'Persist the selected firmware ZIP')
        choice = item.add_mutually_exclusive_group(required=name == 'firmware_select')
        choice.add_argument('--firmware', type=Path)
        choice.add_argument('--included', action='store_true')
    init = actions.add_parser('init_programmer', help='Create a program/slot selection file without overwriting an existing one')
    init.add_argument('--selection', type=Path)
    init.add_argument('--release')
    init.add_argument('--s3c')
    for i in range(1, 6):
        init.add_argument(f'--dslot-{i}')
    for name in ('scan', 'identify', 'program'):
        item = actions.add_parser(name, help='Program and verify Flash immediately' if name == 'program' else name.capitalize() + ' the connected chain')
        item.add_argument('--target', choices=('dslot', 's3c'), required=name == 'program', default=None if name == 'program' else 'dslot')
        item.add_argument('--probe-index', type=int)
        item.add_argument('--dry-run', type=int, choices=(0, 1), default=0)
        if name != 'scan':
            item.add_argument('--firmware', type=Path, help='Use this ZIP for this invocation instead of the saved selection')
        if name == 'program':
            item.add_argument('--selection', type=Path)
            item.add_argument('--release', '--release-cycle', dest='release_cycle')
            item.add_argument('--s3c-program')
            for i in range(1, 6):
                item.add_argument(f'--dslot{i}')
    return result


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    cli = parser()
    try:
        if len(args) == 1 and args[0].startswith('programmer_path='):
            settings.set_programmer(args[0].split('=', 1)[1])
            return 0
        options = cli.parse_args(args)
        if options.action is None:
            cli.print_help()
            return 0
        root = (options.workspace or settings.user_directory('data') / 'workspace').expanduser().resolve()
        if options.action == 'doctor':
            return doctor(root)
        if options.action == 'firmware_download':
            workspace.prepare(root)
            path = firmware_download.download(root, git_url=options.git_url, branch=options.branch,
                                              output=options.output.expanduser().absolute() if options.output else None)
            print(f'Inspect with firmware_list --firmware "{path}"; select with firmware_select --firmware "{path}".')
            return 0
        if options.action in ('firmware_list', 'firmware_select'):
            if options.firmware:
                path = options.firmware.expanduser().resolve()
            elif options.included or (not (root / 'firmware.json').exists() and included_firmware().is_file()):
                path = included_firmware()
            else:
                path = selected_firmware(root)
            _, evidence = inspect_firmware(path)
            if options.action == 'firmware_select':
                workspace.prepare(root)
                # Keep selections usable after the application/download directory is replaced.
                destination = root / 'firmware' / evidence['archive_sha256'] / firmware_download.ASSET
                destination.parent.mkdir(parents=True, exist_ok=True)
                with tempfile.TemporaryDirectory(prefix='.select-', dir=destination.parent) as temporary:
                    staged = Path(temporary) / firmware_download.ASSET
                    shutil.copyfile(path, staged)
                    _, snapshot = release.read_package(staged)
                    if snapshot['archive_sha256'] != evidence['archive_sha256']:
                        raise BuildError('Firmware changed while selecting; previous selection preserved.')
                    staged.replace(destination)
                settings.atomic_json(root / 'firmware.json', dict(schema_version=1, path=str(destination),
                                     source=str(path), sha256=evidence['archive_sha256']))
                print(f'Selected firmware in {root / "firmware.json"}; slot assignments are unchanged.')
            return 0
        # Preserve the shared CLI's validation, snapshots, USB locking and readback.
        from .toolchain.commands import run
        values = {key: str(value) for key, value in vars(options).items()
                  if key not in ('workspace', 'action') and value is not None}
        if options.action in ('identify', 'program'):
            # A dry run can preview an explicit ZIP without opening it.
            path = options.firmware.expanduser().absolute() if options.firmware else selected_firmware(root)
            values.update(source='zip', firmware=str(path))
        return run(options.action, values, workspace=root)
    except (BuildError, OSError, ValueError, KeyError, TypeError, BadZipFile, HTTPException, RuntimeError) as exc:
        print(f'uz_cpld: {exc}', file=sys.stderr)
        return 2
    except KeyboardInterrupt:
        print('uz_cpld: interrupted', file=sys.stderr)
        return 130


if __name__ == '__main__':
    raise SystemExit(main())
