"""Command-line interface for manifests, scaffolding, projects and builds."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile
from .model import BuildError, catalog, load_build, load_output, program_backends, program_targets, release_cycles, resolve_release
from . import workflow
from .backends.diamond import launcher, run, wrap


def main(argv: list[str] | None = None) -> int:
    """Execute a command and return a shell-compatible status code."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=['list', 'doctor', 'new', 'generate', 'check', 'project', 'build', 'gui', 'build-all', 'report', 'clean', 'clean-all', 'release-list', 'release-new', 'release-current'])
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument('--program')
    parser.add_argument('--release-cycle', '--release_cycle', dest='release_cycle')
    parser.add_argument('--template-release-cycle')
    parser.add_argument('--from', dest='source_cycle', help='Release to copy when creating a cycle')
    parser.add_argument('--target', help='Filter catalog commands or select a program target')
    parser.add_argument('--backend', choices=['diamond', 'foss'])
    parser.add_argument('--name')
    parser.add_argument('--template', default='tx30', help='Existing program to clone, or generator for editable CSV/TOML inputs (default: tx30)')
    parser.add_argument('--discard-project-changes', action='store_true')
    args = parser.parse_args(argv)
    root = args.root.resolve()
    try:
        if args.discard_project_changes and args.command != 'clean':
            raise BuildError('--discard-project-changes is only valid for clean')
        if args.command.startswith('release-'):
            from . import releases
            if args.command == 'release-list':
                current = resolve_release(root)
                for cycle in release_cycles(root):
                    print(f'{cycle}' + (' (current)' if cycle == current else ''))
            elif args.command == 'release-new':
                if not args.name:
                    raise BuildError('release-new requires --name (Make: name=...)')
                print(releases.create(root, args.name, args.source_cycle))
            else:
                if not args.release_cycle:
                    raise BuildError('release-current requires --release-cycle (Make: release_cycle=...)')
                print(releases.select(root, args.release_cycle))
            return 0
        if args.command == 'clean-all':
            workflow.clean_all(root)
            return 0
        cycle = resolve_release(root, args.release_cycle)
        def selected_builds(collect_errors=False):
            builds = []
            errors = []
            for name in catalog(root, cycle):
                try:
                    if args.backend and args.backend not in program_backends(root, name, cycle):
                        continue
                    targets = program_targets(root, name, cycle)
                except (BuildError, OSError, ValueError) as exc:
                    if not collect_errors:
                        raise
                    errors.append((name, args.target or '—', str(exc)))
                    continue
                for target in targets:
                    if args.target is not None and args.target != target:
                        continue
                    try:
                        builds.append(load_build(root, name, target, args.backend, cycle))
                    except (BuildError, OSError, ValueError) as exc:
                        if not collect_errors:
                            raise
                        errors.append((name, target, str(exc)))
            if not builds and not errors and args.target:
                raise BuildError(f'No catalog programs support target {args.target} and backend {args.backend or "diamond"}')
            return (builds, errors) if collect_errors else builds

        if args.command == 'list':
            for build in selected_builds():
                print(f'{build.qualified_name}\t{build.target}\t{build.backend}')
        elif args.command == 'doctor':
            builds = selected_builds()
            print(f'Python: {sys.version.split()[0]}')
            if args.backend == 'foss' or (builds and builds[0].backend == 'foss'):
                if not builds:
                    raise BuildError('No FOSS programs selected; choose a release cycle with a FOSS program for doctor')
                from .backends.foss import doctor
                for device, build in {build.device: build for build in builds}.items():
                    print(f'{device}: {doctor(build)}')
            else:
                print(f'Diamond: {launcher()}')
                with tempfile.TemporaryDirectory(prefix='cpld-doctor-') as tmp:
                    script = Path(tmp) / 'doctor.tcl'
                    script.write_text(wrap(['if {[llength [info commands prj_project]] == 0} {error "Project Tcl unavailable"}', 'puts "Diamond project Tcl available"']))
                    print(run(script, Path(tmp) / 'doctor.log').strip())
            print('Catalog and tool startup passed; run build to validate synthesis and exports.')
        elif args.command == 'new':
            if not args.name:
                raise BuildError('new requires --name (Make: name=...)')
            created = workflow.scaffold(root, args.name, args.template, args.target, args.backend, cycle, args.template_release_cycle)
            print(created)
            if args.template == 'generator':
                print(f'Edit {created.relative_to(root)}/routing.csv, then run make generate program={created.name} release_cycle={cycle}')
        elif args.command == 'generate':
            if not args.program:
                raise BuildError('generate requires --program (Make: program=...)')
            print(workflow.generate_program(root, args.program, args.target, args.backend, cycle))
        elif args.command == 'build-all':
            failed = []
            build_errors = []
            builds, selection_errors = selected_builds(collect_errors=True)
            for name, target, error in selection_errors:
                failed.append(name)
                print(f'{name} ({target}): {error}', file=sys.stderr)
            for build in builds:
                try:
                    print(workflow.build_program(build))
                except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
                    failed.append(build.name)
                    build_errors.append((build.name, build.target, str(exc)))
                    print(f'{build.name}: {exc}', file=sys.stderr)
            from .report import catalog_report
            print(catalog_report(builds, args.target, selection_errors, root=root,
                                 backend=args.backend or 'diamond', release_cycle=cycle, build_errors=build_errors))
            if failed:
                raise BuildError('Failed programs: ' + ', '.join(failed))
        elif args.command == 'report':
            from .report import catalog_report
            builds, selection_errors = selected_builds(collect_errors=True)
            print(catalog_report(builds, args.target, selection_errors, root=root,
                                 backend=args.backend or 'diamond', release_cycle=cycle))
            if selection_errors:
                raise BuildError('Invalid programs: ' + ', '.join(name for name, _, _ in selection_errors))
        else:
            if not args.program:
                raise BuildError(f'{args.command} requires --program (Make: program=...)')
            loader = load_output if args.command == 'clean' else load_build
            build = loader(root, args.program, args.target, args.backend, cycle)
            if args.command == 'check':
                print(f'{build.name}: manifest and inputs valid')
            elif args.command == 'clean':
                workflow.clean(build, args.discard_project_changes)
            else:
                action = workflow.build_program if args.command == 'build' else getattr(workflow, args.command)
                result = action(build)
                if result:
                    print(result)
        return 0
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
