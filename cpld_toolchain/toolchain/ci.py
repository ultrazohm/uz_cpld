"""Build all Diamond catalogs and package verified firmware for CI releases."""
from cpld_toolchain import repository_root
import argparse
from pathlib import Path
import subprocess
import sys

from cpld_toolchain.toolchain.buildsystem.cli import main as build_cli
from cpld_toolchain.toolchain.buildsystem.model import BuildError, catalog, load_build, program_backends, program_targets, release_cycles

ROOT = repository_root()


def build_all(root):
    """Attempt every release even when an earlier catalog fails."""
    cycles = release_cycles(root)
    if not cycles:
        raise BuildError('No release catalogs found')
    failed = []
    for cycle in cycles:
        if build_cli(['build_all', '--root', str(root), '--release-cycle', cycle,
                      '--backend', 'diamond']):
            failed.append(cycle)
    if failed:
        raise BuildError('Failed release catalogs: ' + ', '.join(failed))


def package(root, output):
    """Archive all releases using the same exporter as local builds."""
    from cpld_toolchain.toolchain.buildsystem.publication import archive
    root = Path(root).resolve()
    cycles = release_cycles(root)
    if not cycles:
        raise BuildError('No release catalogs found')
    builds = []
    for cycle in cycles:
        names = catalog(root, cycle)
        if not names:
            raise BuildError(f'Empty release catalog: {cycle}')
        for name in names:
            if 'diamond' not in program_backends(root, name, cycle):
                continue
            for target in program_targets(root, name, cycle):
                builds.append(load_build(root, name, target, 'diamond', cycle))
    return archive(root, builds, output)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('build_all', 'package'))
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args(argv)
    try:
        if args.action == 'build_all':
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
