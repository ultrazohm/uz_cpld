"""Build all Diamond catalogs and package verified firmware for CI releases."""
from cpld_toolchain import repository_root
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from zipfile import ZIP_DEFLATED, ZipFile

from cpld_toolchain.toolchain.buildsystem.cli import main as build_cli
from cpld_toolchain.toolchain.buildsystem.identity import read_registry
from cpld_toolchain.toolchain.buildsystem.model import BuildError, catalog, load_build, program_targets, release_cycles
from cpld_toolchain.toolchain.buildsystem.report import _row
from cpld_toolchain.toolchain.buildsystem.workflow import workspace_lock

ROOT = repository_root()


def build_all(root):
    """Attempt every release even when an earlier catalog fails."""
    cycles = release_cycles(root)
    if not cycles:
        raise BuildError('No release catalogs found')
    failed = []
    for cycle in cycles:
        if build_cli(['build-all', '--root', str(root), '--release-cycle', cycle,
                      '--backend', 'diamond']):
            failed.append(cycle)
    if failed:
        raise BuildError('Failed release catalogs: ' + ', '.join(failed))


def package(root, output):
    """Publish an archive only when every catalog export has fresh evidence."""
    root, output = Path(root).resolve(), Path(output).resolve()
    if output.exists():
        raise BuildError(f'Archive already exists: {output}; choose a new output path')
    with workspace_lock(root, exclusive=True):
        cycles = release_cycles(root)
        if not cycles:
            raise BuildError('No release catalogs found')
        revision = subprocess.check_output(['git', '-C', str(root), 'rev-parse', 'HEAD'], text=True).strip()
        manifest = {'schema_version': 1, 'git_revision': revision, 'backend': 'diamond',
                    'release_cycles': cycles, 'builds': [], 'identity_registry': read_registry(root)}
        output.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix='.firmware-', dir=output.parent) as temporary:
            archive = Path(temporary) / 'firmware.zip'
            with ZipFile(archive, 'w', compression=ZIP_DEFLATED) as bundle:
                for cycle in cycles:
                    names = catalog(root, cycle)
                    if not names:
                        raise BuildError(f'Empty release catalog: {cycle}')
                    for name in names:
                        for target in program_targets(root, name, cycle):
                            build = load_build(root, name, target, 'diamond', cycle)
                            row = _row(build)
                            if row['status'] != 'success':
                                raise BuildError(f'{build.qualified_name} ({target}): {row["status"]} build evidence')
                            record = json.loads((build.directory / 'metadata/build.json').read_text())
                            if record.get('git_revision') != revision:
                                raise BuildError(f'{build.qualified_name}: build belongs to another Git revision')
                            files = {}
                            for extension in ('bit', 'jed'):
                                source = build.firmware_path(extension)
                                payload = source.read_bytes()
                                checksum = hashlib.sha256(payload).hexdigest()
                                if not payload or record['outputs'].get(source.name) != checksum:
                                    raise BuildError(f'{source}: missing or mismatched firmware checksum')
                                destination = f'{cycle}/{name}/{target}/{source.name}'
                                bundle.writestr(destination, payload)
                                files[destination] = checksum
                            manifest['builds'].append({'release_cycle': cycle, 'program': name,
                                                      'target': target, 'device': build.device,
                                                      'identity': row['identity'], 'files': files,
                                                      'provenance': record})
                bundle.writestr('manifest.json', json.dumps(manifest, indent=2, sort_keys=True) + '\n')
            archive.replace(output)
    return output


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('build-all', 'package'))
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args(argv)
    try:
        if args.action == 'build-all':
            build_all(args.root.resolve())
        else:
            if args.output is None:
                parser.error('package requires --output')
            print(package(args.root, args.output))
        return 0
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'CI firmware failed: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
