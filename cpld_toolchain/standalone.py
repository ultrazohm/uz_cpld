"""Standalone firmware downloader and programmer; defaults to bundled FOSS tools."""
import argparse
from http.client import HTTPException
from pathlib import Path
import sys
import subprocess
from zipfile import BadZipFile

from . import __version__, settings, workspace
from .firmware_choice import selected_firmware
from .programmer_helper import release
from .toolchain import diamond, firmware_download
from .toolchain.buildsystem.model import BuildError

DEFAULT_REPOSITORY = 'https://github.com/ultrazohm/uz_cpld'
DEFAULT_BRANCH = 'master'
DIAMOND_VERSION = '3.14.0.75.2'


def application_directory():
    return Path(sys.executable).resolve().parent if getattr(sys, 'frozen', False) else Path(__file__).resolve().parent


def included_firmware():
    return application_directory() / 'firmware' / firmware_download.ASSET


def inspect_firmware(path):
    manifest, evidence = release.read_package(path)
    print(f'Firmware: {path}')
    print(f'Source commit: {manifest["git_revision"]}')
    print(f'SHA-256: {evidence["archive_sha256"]}')
    for entry in manifest['builds']:
        print(f'{entry["release_cycle"]}/{entry["program"]}  {entry["target"]}  '
              f'USERCODE {entry["identity"]["usercode"]}')
    return manifest, evidence


def doctor(root, backend='foss'):
    from .driver_status import report as driver_report
    driver_report()
    if backend == 'foss':
        from .tools import loader_path
        from .toolchain.foss import flasher
        print(f'Application: {__version__}')
        print(f'Workspace: {root}')
        try:
            binary = loader_path()
            record = flasher.verify(binary)
            version = flasher.version(binary)
            if record['pin']['capability'] not in version:
                raise ValueError('Loader does not report its pinned capability')
            print(f'FOSS programmer: {binary}')
            print(f'Capability: {record["pin"]["capability"]}; {version.strip()}')
        except (OSError, ValueError, subprocess.SubprocessError) as exc:
            print(f'MISSING or INVALID: {exc}')
            return 1
        print('Loader verified without USB access. See README.txt for USB driver/permission setup.')
        if included_firmware().is_file():
            print(f'Included firmware: {included_firmware()} (use firmware_select --included)')
        return 0
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
    gui = actions.add_parser('programmer_gui', help='Open the optional desktop programmer')
    gui.add_argument('--check', action='store_true', help='Check Tk availability without opening a window')
    health = actions.add_parser('doctor', help='Verify programmer availability without accessing USB')
    health.add_argument('--programmer-backend', choices=('foss', 'diamond'), default='foss',
                        help='Default: foss (bundled patched openFPGALoader)')
    for name in ('setup_foss_drivers', 'setup_diamond_driver'):
        item = actions.add_parser(name, help='Configure the Windows programmer driver; requests administrator approval')
        item.add_argument('--device-id', help='Windows device instance ID; required when multiple programmers are connected')
        item.add_argument('--dry-run', type=int, choices=(0, 1), default=0)
    download = actions.add_parser('firmware_download', help='Download newest published master firmware; does not select it')
    download.add_argument('--git-url', default=DEFAULT_REPOSITORY)
    download.add_argument('--branch', default=DEFAULT_BRANCH)
    download.add_argument('--output', type=Path)
    for name in ('firmware_list', 'firmware_select'):
        item = actions.add_parser(name, help='Inspect firmware' if name.endswith('list') else 'Persist the selected firmware ZIP')
        choice = item.add_mutually_exclusive_group(required=name == 'firmware_select')
        choice.add_argument('--firmware', type=Path)
        choice.add_argument('--included', action='store_true')
    init = actions.add_parser('init_programmer', help='Initialize program/slot assignments; --override replaces an existing selection')
    init.add_argument('--selection', type=Path)
    init.add_argument('--override', action='store_true', help='Replace the existing selection with new assignments')
    init.add_argument('--release')
    init.add_argument('--s3c')
    for i in range(1, 6):
        init.add_argument(f'--dslot-{i}')
    for name in ('scan', 'identify', 'program'):
        item = actions.add_parser(name, help='Program and verify Flash immediately' if name == 'program' else name.capitalize() + ' the connected chain')
        item.add_argument('--target', choices=('dslot', 's3c'), default=None if name == 'program' else 'dslot')
        item.add_argument('--probe-index', type=int)
        item.add_argument('--programmer-backend', choices=('foss', 'diamond'), default='foss',
                          help='Default: foss (bundled patched openFPGALoader)')
        item.add_argument('--cable', help='FOSS cable; managed operations require ft4232_b')
        item.add_argument('--usb-serial', help='Select one FT4232 by serial number (FOSS)')
        item.add_argument('--dry-run', type=int, choices=(0, 1), default=0)
        if name != 'scan':
            item.add_argument('--firmware', type=Path, help='ZIP path or latest-downloaded; overrides the saved selection for this invocation')
        if name == 'program':
            item.add_argument('--selection', type=Path)
            item.add_argument('--release', '--release-cycle', dest='release_cycle')
            item.add_argument('--s3c-program')
            for i in range(1, 6):
                item.add_argument(f'--dslot{i}')
    return result


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    if args and args[0] == '--programmer-gui-worker':
        from .programmer_service import worker
        return worker(*args[1:])
    cli = parser()
    try:
        if len(args) == 1 and args[0].startswith('programmer_path='):
            settings.set_programmer(args[0].split('=', 1)[1])
            return 0
        options = cli.parse_args(args)
        if options.action is None:
            cli.print_help()
            return 0
        if options.action == 'programmer_gui':
            from .programmer_gui import main as gui
            gui_args = ['--workspace', str(options.workspace)] if options.workspace else []
            if options.check:
                gui_args.append('--check')
            return gui(gui_args, standalone=True)
        root = (options.workspace or settings.user_directory('data') / 'workspace').expanduser().resolve()
        if options.action == 'doctor':
            return doctor(root, options.programmer_backend)
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
            inspect_firmware(path)
            if options.action == 'firmware_select':
                from .firmware_choice import select
                select(root, path)
                print(f'Selected firmware in {root / "firmware.json"}; slot assignments are unchanged.')
            return 0
        # Preserve the shared CLI's validation, snapshots, USB locking and readback.
        from .toolchain.commands import run
        values = {key: str(value) for key, value in vars(options).items()
                  if key not in ('workspace', 'action', 'override') and value is not None}
        if getattr(options, 'override', False):
            values['override'] = '1'
        if options.action == 'init_programmer':
            from .firmware_choice import guide_init
            values = guide_init(root, values, standalone=True, included=included_firmware())
        if options.action == 'program' and not options.target:
            return run('program', values, workspace=root, standalone=True, included=included_firmware())
        if options.action in ('identify', 'program'):
            # A dry run can preview an explicit ZIP without opening it.
            from .firmware_choice import resolve
            path = resolve(root, options.firmware, included=included_firmware(), standalone=True,
                           prompt=options.action == 'program' and not options.dry_run)
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
