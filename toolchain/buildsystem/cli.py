"""Command-line interface for manifests, scaffolding, projects and builds."""
import argparse
from pathlib import Path
import sys
import tempfile
from .model import BuildError, catalog, load_build, program_targets
from . import workflow
from .backends.diamond import launcher, run, wrap


def main(argv: list[str] | None = None) -> int:
    """Execute a command and return a shell-compatible status code."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=['list', 'doctor', 'new', 'check', 'project', 'build', 'gui', 'build-all', 'clean', 'clean-all'])
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
        def selected_builds():
            builds = []
            for name in catalog(root):
                for target in program_targets(root, name):
                    if args.target is None or args.target == target:
                        builds.append(load_build(root, name, target, args.backend))
            if not builds and args.target:
                raise BuildError(f'No catalog programs target {args.target}')
            return builds

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
            for build in selected_builds():
                try:
                    print(workflow.build_program(build))
                except (BuildError, OSError, ValueError) as exc:
                    failed.append(build.name); print(f'{build.name}: {exc}', file=sys.stderr)
            if failed:
                raise BuildError('Failed programs: ' + ', '.join(failed))
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
    except (BuildError, OSError, ValueError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
