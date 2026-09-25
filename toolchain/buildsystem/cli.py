"""Command-line interface for manifests, scaffolding, projects and builds."""
import argparse
from pathlib import Path
import subprocess
import sys
import tempfile
from .model import BuildError, catalog, load_build, program_backends, program_targets
from . import workflow
from .backends.diamond import launcher, run, wrap


def main(argv: list[str] | None = None) -> int:
    """Execute a command and return a shell-compatible status code."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=['list', 'doctor', 'new', 'check', 'project', 'build', 'gui', 'build-all', 'report', 'clean', 'clean-all'])
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument('--program')
    parser.add_argument('--target', help='Filter catalog commands or select a program target')
    parser.add_argument('--backend', choices=['diamond', 'foss'])
    parser.add_argument('--name')
    parser.add_argument('--template', default='tx30', help='Existing program to clone (default: tx30)')
    parser.add_argument('--discard-project-changes', action='store_true')
    args = parser.parse_args(argv)
    root = args.root.resolve()
    try:
        if args.discard_project_changes and args.command != 'clean':
            raise BuildError('--discard-project-changes is only valid for clean')
        def selected_builds(collect_errors=False):
            builds = []
            errors = []
            for name in catalog(root):
                try:
                    if args.backend and args.backend not in program_backends(root, name):
                        continue
                    targets = program_targets(root, name)
                except (BuildError, OSError, ValueError) as exc:
                    if not collect_errors:
                        raise
                    errors.append((name, args.target or '—', str(exc)))
                    continue
                for target in targets:
                    if args.target is not None and args.target != target:
                        continue
                    try:
                        builds.append(load_build(root, name, target, args.backend))
                    except (BuildError, OSError, ValueError) as exc:
                        if not collect_errors:
                            raise
                        errors.append((name, target, str(exc)))
            if not builds and not errors and args.target:
                raise BuildError(f'No catalog programs support target {args.target} and backend {args.backend or "diamond"}')
            return (builds, errors) if collect_errors else builds

        if args.command == 'list':
            for build in selected_builds():
                print(f'{build.name}\t{build.target}\t{build.backend}')
        elif args.command == 'doctor':
            builds = selected_builds()
            print(f'Python: {sys.version.split()[0]}')
            if builds and builds[0].backend == 'foss':
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
        elif args.command == 'clean-all':
            workflow.clean_all(root)
        elif args.command == 'new':
            if not args.name:
                raise BuildError('new requires --name (Make: name=...)')
            load_build(root, args.template, args.target, args.backend)
            print(workflow.scaffold(root, args.name, args.template, args.target, args.backend))
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
                                 backend=args.backend or 'diamond', build_errors=build_errors))
            if failed:
                raise BuildError('Failed programs: ' + ', '.join(failed))
        elif args.command == 'report':
            from .report import catalog_report
            builds, selection_errors = selected_builds(collect_errors=True)
            print(catalog_report(builds, args.target, selection_errors, root=root,
                                 backend=args.backend or 'diamond'))
            if selection_errors:
                raise BuildError('Invalid programs: ' + ', '.join(name for name, _, _ in selection_errors))
        else:
            if not args.program:
                raise BuildError(f'{args.command} requires --program (Make: program=...)')
            build = load_build(root, args.program, args.target, args.backend)
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
