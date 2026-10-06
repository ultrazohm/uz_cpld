# Codex conversation

## User

workspaces/uz_cpld/programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/build/uz_dslot_xo2_diamond
/workspaces/uz_cpld/programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/build/uz_dslot_xo2_diamond
s3c_heartbeat: Build or GUI already active: /workspaces/uz_cpld/programs/heartbeat_cvg/s3c_heartbeat/build/uz_s3c_xo2_diamond
/workspaces/uz_cpld/cpld_toolchain/toolchain/build/validation/heartbeat_cvg/diamond-catalog/report.md
error: Failed programs: s3c_heartbeat
error: Command '('/opt/uz-cpld-env/bin/python3', '-m', 'cpld_toolchain.toolchain.buildsystem', 'build-all', '--backend', 'diamond')' returned non-zero exit status 1.
make: *** [Makefile:17: build-all] Error 2

## Assistant

I’ll check what holds the `s3c_heartbeat` build lock and whether it’s an active Diamond process or a stale lock, then fix the cause and verify the build.

## Activity

    $ pwd; rg --files -g AGENTS.md -g '*lock*' -g '*diamond*' -g Makefile -g '*buildsystem*'
    bwrap: No permissions to create a new namespace, likely because the kernel does not allow non-privileged user namespaces. On e.g. debian this can be enabled with 'sysctl kernel.unprivileged_userns_clone=1'.
    ✗ (1) • 0ms

## Activity

    $ git status --short; rg -n 'Build or GUI already active|Failed programs' .
    bwrap: No permissions to create a new namespace, likely because the kernel does not allow non-privileged user namespaces. On e.g. debian this can be enabled with 'sysctl kernel.unprivileged_userns_clone=1'.
    ✗ (1) • 0ms

## Activity

    $ pwd; rg --files -g AGENTS.md; git status --short; rg -n 'Build or GUI already active|Failed programs' .
    /workspaces/uz_cpld
     M programs/usercodes.json
    ?? codex-session-01a10c29-f4f7-7cf1-8d30-04be3a1992a2.md
    ./cpld_toolchain/toolchain/buildsystem/cli.py:131:                raise BuildError('Failed programs: ' + ', '.join(failed))
    ./cpld_toolchain/toolchain/buildsystem/workflow.py:88:                raise BuildError(f'Build or GUI already active: {directory}') from exc
    ✓ • 0ms

## Activity

    $ ls -la programs/heartbeat_cvg/s3c_heartbeat/build/uz_s3c_xo2_diamond; sed -n '1,240p' cpld_toolchain/toolchain/buildsystem/workflow.py; sed -n '1,200p' cpld_toolchain/toolchain/buildsystem/cli.py; ps -eo pid,ppid,etime,args | rg 'diamond|pnmain|s3c|buildsystem'
    total 872
    drwxr-xr-x 6 vscode vscode   4096 Oct  5 09:32 .
    drwxr-xr-x 5 vscode vscode   4096 Oct  5 15:39 ..
    drwxr-xr-x 2 vscode vscode   4096 Oct  5 09:32 logs
    drwxr-xr-x 2 vscode vscode   4096 Oct  5 09:32 metadata
    drwxr-xr-x 3 vscode vscode   4096 Oct  5 09:32 project
    drwxr-xr-x 6 vscode vscode   4096 Oct  5 09:32 reports
    -rw-r--r-- 1 vscode vscode  19457 Oct  5 09:32 s3c_heartbeat_uz_s3c_xo2_diamond.bit
    -rw-r--r-- 1 vscode vscode 846206 Oct  5 09:32 s3c_heartbeat_uz_s3c_xo2_diamond.jed
    """Locked build lifecycle, artifact provenance and program cloning."""
    from contextlib import contextmanager, ExitStack
    from datetime import datetime, timezone
    from cpld_toolchain.toolchain.locking import directory_lock, file_lock
    import hashlib
    import json
    import os
    from pathlib import Path
    import re
    import shutil
    import subprocess
    import sys
    import tempfile
    from .model import Build, BuildError, catalog, identifier, input_path, load_build, read_toml, release_directory, resolve_release, resolve_program
    from .backends.diamond import DiamondBackend, launcher, synthesis_options
    from .ghdl import read_vhdl
    from cpld_toolchain.toolchain.diamond import environment as diamond_environment
    
    
    def backend_for(build):
        if build.backend == 'diamond':
            return DiamondBackend()
        from .backends.foss import FossBackend
        return FossBackend()
    
    
    def digest(path: Path) -> str:
        """Return a file's SHA-256 digest."""
        return hashlib.sha256(path.read_bytes()).hexdigest()
    
    
    def hashes(build: Build) -> dict:
        """Hash authored inputs and the Python implementation used for this build."""
        code = build.root / 'cpld_toolchain/toolchain/buildsystem'
        paths = set(build.inputs) | {code / name for name in
                                     ('model.py', 'workflow.py', 'cli.py', 'identity.py', 'backends/' + build.backend + '.py')}
        paths.add(build.root / 'cpld_toolchain/toolchain/locking.py')
        if build.backend == 'diamond':
            paths.add(build.root / 'cpld_toolchain/toolchain/diamond.py')
        if build.backend == 'foss':
            paths |= {code / 'ghdl.py', code / 'foss_config.py'}
            paths |= set((build.root / 'cpld_toolchain/toolchain/hdl').rglob('*.v'))
            paths |= set((build.root / 'cpld_toolchain/toolchain/hdl').rglob('*.vhdl'))
        return {str(p.relative_to(build.root)): digest(p) for p in sorted(paths)}
    
    
    def write_json(path: Path, value):
        """Atomically write a JSON record in its destination directory."""
        temp = path.with_suffix('.tmp')
        temp.write_text(json.dumps(value, indent=2, sort_keys=True) + '\n')
        temp.replace(path)
    
    
    def safe_directory(build: Build, directory: Path | None = None) -> Path:
        """Reject symlinks in generated directory ancestry before any deletion."""
        directory = build.directory if directory is None else directory
        current = build.root
        for part in directory.relative_to(build.root).parts:
            current /= part
            if current.is_symlink():
                raise BuildError(f'Generated path is a symlink: {current}')
        return directory
    
    
    @contextmanager
    def workspace_lock(root: Path, *, exclusive: bool = False):
        """Coordinate cleanup with a persistent workspace lock on either platform."""
        with ExitStack() as stack:
            try:
                stack.enter_context(directory_lock(root, exclusive=exclusive))
            except BlockingIOError as exc:
                raise BuildError(f'Workspace operation already active: {root}') from exc
            yield
    
    
    @contextmanager
    def locked(build: Build):
        """Exclude cleanup and competing project, build, GUI or clean operations."""
        with workspace_lock(build.root):
            directory = safe_directory(build)
            lockdir = safe_directory(build, build.root / 'cpld_toolchain/toolchain/build/locks')
            lockdir.mkdir(parents=True, exist_ok=True)
            lockpath = lockdir / f'{build.release_cycle}.{build.name}.{build.target}.{build.backend}.lock'
            with ExitStack() as stack:
                try:
                    stack.enter_context(file_lock(lockpath))
                except BlockingIOError as exc:
                    raise BuildError(f'Build or GUI already active: {directory}') from exc
                yield directory
    
    
    def configuration(project: Path) -> dict:
        """Fingerprint generated project settings, including GUI-added metadata."""
        result = {str(p.relative_to(project)): digest(p) for p in sorted(project.rglob('*'))
                  if p.is_file() and (p.suffix in ('.ldf', '.sty', '.tcl', '.ys', '.lpf'))}
        plan = project.parent / 'metadata/build-plan.json'
        if plan.is_file():
            result['metadata/build-plan.json'] = digest(plan)
        return result
    
    
    def guard(directory: Path):
        """Refuse regeneration when generated configuration was edited externally."""
        metadata = directory / 'metadata'
        if metadata.is_symlink():
            raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
        project, record = directory / 'project', metadata / 'configuration.json'
        if project.exists():
            if not record.is_file() or json.loads(record.read_text()) != configuration(project):
                raise BuildError(f'Generated configuration changed in {project}. Transfer useful settings into manifests, then use clean --discard-project-changes explicitly.')
    
    
    def prepare(build: Build, directory: Path):
        """Prepare a fresh project, retaining previous logs and guarding GUI changes."""
        guard(directory)
        project = directory / 'project'
        if project.is_symlink():
            raise BuildError('Project directory must not be a symlink')
        if project.exists():
            shutil.rmtree(project)
        logs = directory / 'logs'
        if logs.is_symlink():
            raise BuildError('Logs directory must not be a symlink')
        logs.mkdir(parents=True, exist_ok=True)
        stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
        log = logs / f'{stamp}-prepare.log'
        try:
            from .identity import reserve_build
            metadata = directory / 'metadata'
            if metadata.is_symlink():
                raise BuildError('Metadata directory must not be a symlink')
            metadata.mkdir(exist_ok=True)
            write_json(metadata / 'identity.json', reserve_build(build))
            backend_for(build).prepare(build, project, log)
        finally:
            # Even a failed generation can be safely retried if it remains unchanged.
            if project.exists():
                metadata = directory / 'metadata'
                if metadata.is_symlink():
                    raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
                metadata.mkdir(exist_ok=True)
                write_json(metadata / 'configuration.json', configuration(project))
        return project, logs / f'{stamp}-build.log'
    
    
    def project(build: Build) -> Path:
        """Create a Diamond project or a FOSS build plan without synthesizing it."""
        with locked(build) as directory:
            path, _ = prepare(build, directory)
            return path / 'firmware.ldf' if build.backend == 'diamond' else path.parent / 'metadata/build-plan.json'
    
    
    def clear_publication(build: Build, directory: Path):
        """Remove published firmware, reports and provenance without losing diagnostics."""
        metadata = directory / 'metadata'
        if metadata.is_symlink():
            raise BuildError(f'Metadata directory must not be a symlink: {metadata}')
        json_reports = metadata / 'reports'
        if json_reports.is_symlink():
            raise BuildError(f'JSON report directory must not be a symlink: {json_reports}')
        reports = directory / 'reports'
        if reports.is_symlink():
            raise BuildError(f'Report directory must not be a symlink: {reports}')
        for extension in ('jed', 'bit'):
            build.firmware_path(extension).unlink(missing_ok=True)
        (metadata / 'build.json').unlink(missing_ok=True)
        if json_reports.exists():
            shutil.rmtree(json_reports)
        if reports.exists():
            shutil.rmtree(reports)
    
    
    def build_program(build: Build) -> Path:
        """Build fresh firmware; publish success only after input/output validation.
    
        Failed attempts retain logs and intermediates. Previous artifacts are removed
        before invoking the selected backend so they cannot be mistaken for the current result.
        """
        with locked(build) as directory:
            current = load_build(build.root, build.name, build.target, build.backend, build.release_cycle)
            if current != build:
                raise BuildError('Build configuration changed since it was loaded; reload before building')
            guard(directory)
            clear_publication(build, directory)
            directory.mkdir(parents=True, exist_ok=True)
            metadata = directory / 'metadata'
            metadata.mkdir(exist_ok=True)
            write_json(metadata / 'status.json', {'status': 'running'})
            try:
                before = hashes(build)
                proj, log = prepare(build, directory)
                output = backend_for(build).build(proj, log)
                from .backends.diamond import reported_versions
                versions = reported_versions(output)
                if build.backend == 'diamond' and build.expected_version not in versions:
                    raise BuildError(f'Expected Diamond {build.expected_version}; reported {", ".join(versions) or "no full version"}; see {log}')
                if before != hashes(build):
                    raise BuildError('Inputs changed during build; outputs were not published')
                exports = {}
                for ext in (('jed', 'bit') if build.backend == 'diamond' else ('bit',)):
                    path = proj / 'impl' / f'firmware_impl.{ext}'
                    if not path.is_file() or not path.stat().st_size:
                        raise BuildError(f'Missing fresh export: {path}; see {log}')
                    exports[ext] = path
                from .identity import validate_identity, record_artifacts
                identity = validate_identity(build, json.loads((metadata / 'identity.json').read_text()))
                if build.backend == 'diamond':
                    values = re.findall(rb'(?m)^UH([0-9A-Fa-f]{8})\*\r?$', exports['jed'].read_bytes())
                    if values != [identity['usercode'].encode()]:
                        raise BuildError('Exported JEDEC USERCODE does not match the registered build identity')
                published = []
                for ext, path in exports.items():
                    destination = build.firmware_path(ext)
                    shutil.copy2(path, destination)
                    published.append(destination)
                reports = directory / 'reports'; reports.mkdir()
                for p in (proj / 'impl').rglob('*'):
                    if p.is_file() and p.suffix.lower() in {'.twr', '.mrp', '.par', '.pad', '.srr', '.rpt', '.bgn', '.html', '.log', '.json', '.config', '.v', '.vo', '.sdf'}:
                        destination = (metadata / 'reports' if p.suffix.lower() == '.json' else reports) / p.relative_to(proj / 'impl')
                        destination.parent.mkdir(parents=True, exist_ok=True)
                        shutil.copy2(p, destination)
                def git(*args):
                    result = subprocess.run(['git', '-C', str(build.root), *args], capture_output=True, text=True)
                    return result.stdout.strip() if result.returncode == 0 else None
                record = {'schema_version': 1, 'status': 'success', 'program': build.name, 'release_cycle': build.release_cycle,
                          'target': build.target, 'backend': build.backend, 'device': build.device,
                          'top': build.top, 'standard': build.standard, 'identity': identity,
                          'tool_version': build.expected_version,
                          'options': build.options,
                          'generated_configuration': configuration(proj),
                          'warnings': [line for line in output.splitlines() if 'WARNING' in line.upper()],
                          'timing_acceptance': 'not evaluated: no program timing budget defined',
                          'git_revision': git('rev-parse', 'HEAD'),
                          'git_status': git('status', '--porcelain', '--untracked-files=all'),
                          'inputs': before, 'completed_at': datetime.now(timezone.utc).isoformat(),
                          'log': str(log.relative_to(build.root)),
                          'outputs': {str(p.relative_to(directory)): digest(p) for p in sorted([*published, *reports.rglob('*'), *(metadata / 'reports').rglob('*')]) if p.is_file()}}
                if build.backend == 'diamond':
                    record.update(launcher=str(launcher()), launcher_sha256=digest(launcher()),
                                  synthesis=build.synthesis, options=synthesis_options(build))
    """Command-line interface for manifests, scaffolding, projects and builds."""
    from cpld_toolchain import repository_root
    import argparse
    from pathlib import Path
    import subprocess
    import sys
    from .model import BuildError, catalog, load_build, load_output, program_backends, program_targets, release_cycles, resolve_release
    from . import workflow
    from .backends.diamond import preflight
    
    
    def main(argv: list[str] | None = None) -> int:
        """Execute a command and return a shell-compatible status code."""
        parser = argparse.ArgumentParser(description=__doc__)
        parser.add_argument('command', choices=['list', 'usercodes', 'usercodes-assign', 'doctor', 'new', 'generate', 'check', 'project', 'build', 'compare', 'gui', 'build-all', 'report', 'clean', 'clean-all', 'release-list', 'release-new', 'release-current'])
        parser.add_argument('--root', type=Path, default=repository_root())
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
            if args.command == 'compare':
                from .comparison import require_foss_backend
                require_foss_backend(args.backend)
            if args.command in ('usercodes', 'usercodes-assign'):
                from .identity import read_registry, assign_programs
                if args.command == 'usercodes-assign':
                    assign_programs(root)
                for name, entry in sorted(read_registry(root)['programs'].items(), key=lambda item: item[1]['number']):
                    print(f'{entry["number"]:5d}  0x{entry["number"]:04X}rrrr  {name}  ({len(entry["builds"])} registered builds)')
                return 0
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
            if args.command == 'doctor':
                from cpld_toolchain.toolchain.doctor import report
                return report(root, backend=args.backend or 'diamond', release_cycle=args.release_cycle, target=args.target)
            cycle = resolve_release(root, args.release_cycle)
            if args.command == 'compare':
                if not args.program:
                    raise BuildError('compare requires --program')
                from .comparison import compare
                path, passed = compare(root, args.program, args.target, cycle, args.backend)
                print(path)
                return 0 if passed else 1
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
            elif args.command == 'new':
                if not args.name:
                    raise BuildError('new requires --name (Make: name=...)')
                created = workflow.scaffold(root, args.name, args.template, args.target, args.backend, cycle, args.template_release_cycle)
                print(created)
                if args.template == 'generator':
                    print(f'Edit {created.relative_to(root)}/routing.csv, then run python -m cpld_toolchain generate --program {created.name} --release-cycle {cycle}')
            elif args.command == 'generate':
                if not args.program:
                    raise BuildError('generate requires --program (Make: program=...)')
                print(workflow.generate_program(root, args.program, args.target, args.backend, cycle))
            elif args.command == 'build-all':
                failed = []
                build_errors = []
                builds, selection_errors = selected_builds(collect_errors=True)
                preflight(builds)
                if not builds and not selection_errors:
                    raise BuildError('No programs selected for build-all')
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
                    if args.command == 'build':
                        preflight([build])
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
      15020   15019       00:45 /opt/uz-cpld-env/bin/python3 -m cpld_toolchain.toolchain.buildsystem build-all --backend diamond
      15891   15020       00:10 /opt/diamond/bin/lin64/pnmainc build.tcl
      16156   16155       00:02 /opt/diamond/ispfpga/bin/lin64/par -f firmware_impl.p2t firmware_impl_map.ncd firmware_impl.dir firmware_impl.prf
      16158   13598       00:00 /bin/bash -c ls -la programs/heartbeat_cvg/s3c_heartbeat/build/uz_s3c_xo2_diamond; sed -n '1,240p' cpld_toolchain/toolchain/buildsystem/workflow.py; sed -n '1,200p' cpld_toolchain/toolchain/buildsystem/cli.py; ps -eo pid,ppid,etime,args | rg 'diamond|pnmain|s3c|buildsystem'
      16163   16158       00:00 rg diamond|pnmain|s3c|buildsystem
    ✓ • 0ms

## Activity

    $ cat cpld_toolchain/toolchain/locking.py; cat /proc/locks; ls -li cpld_toolchain/toolchain/build/locks; cat cpld_toolchain/toolchain/build/validation/heartbeat_cvg/diamond-catalog/report.md; cat programs/heartbeat_cvg/s3c_heartbeat/build/uz_s3c_xo2_diamond/metadata/status.json; sed -n '1,85p' Makefile; rg -n 'def gui|Popen|subprocess' cpld_toolchain/toolchain/buildsystem/workflow.py
    """Process locks on Linux and Windows; lock files are never deleted while in use."""
    from contextlib import contextmanager
    import errno
    import os
    from pathlib import Path
    import sys
    
    
    @contextmanager
    def _windows_lock(fd, exclusive, blocking):
        import ctypes as C
        from ctypes import wintypes as W
        import msvcrt
    
        class Overlapped(C.Structure):
            _fields_ = [('Internal', C.c_size_t), ('InternalHigh', C.c_size_t),
                        ('Offset', W.DWORD), ('OffsetHigh', W.DWORD), ('hEvent', W.HANDLE)]
    
        kernel = C.WinDLL('kernel32', use_last_error=True)
        kernel.LockFileEx.argtypes = [W.HANDLE, W.DWORD, W.DWORD, W.DWORD, W.DWORD, C.POINTER(Overlapped)]
        kernel.LockFileEx.restype = W.BOOL
        kernel.UnlockFileEx.argtypes = [W.HANDLE, W.DWORD, W.DWORD, W.DWORD, C.POINTER(Overlapped)]
        kernel.UnlockFileEx.restype = W.BOOL
        handle, overlapped = msvcrt.get_osfhandle(fd), Overlapped()
        flags = (2 if exclusive else 0) | (0 if blocking else 1)
        if not kernel.LockFileEx(handle, flags, 0, 1, 0, C.byref(overlapped)):
            error = C.get_last_error()
            if error == 33:  # ERROR_LOCK_VIOLATION
                raise BlockingIOError(errno.EAGAIN, 'Lock is held by another operation')
            raise C.WinError(error)
        try:
            yield
        finally:
            if not kernel.UnlockFileEx(handle, 0, 1, 0, C.byref(overlapped)):
                raise C.WinError(C.get_last_error())
    
    
    @contextmanager
    def _lock(fd, exclusive, blocking):
        if sys.platform == 'win32':
            with _windows_lock(fd, exclusive, blocking):
                yield
        else:
            import fcntl
            flags = fcntl.LOCK_EX if exclusive else fcntl.LOCK_SH
            fcntl.flock(fd, flags | (0 if blocking else fcntl.LOCK_NB))
            try:
                yield
            finally:
                fcntl.flock(fd, fcntl.LOCK_UN)
    
    
    @contextmanager
    def file_lock(path: Path, *, exclusive=True, blocking=False):
        if path.is_symlink():
            raise OSError(f'Lock file must not be a symlink: {path}')
        fd = os.open(path, os.O_CREAT | os.O_RDWR | getattr(os, 'O_NOFOLLOW', 0), 0o600)
        try:
            with _lock(fd, exclusive, blocking):
                yield
        finally:
            os.close(fd)
    
    
    @contextmanager
    def directory_lock(path: Path, *, exclusive=True, blocking=False):
        """Preserve POSIX directory locks; Windows uses a persistent file inside it."""
        if path.is_symlink():
            raise OSError(f'Lock directory must not be a symlink: {path}')
        if sys.platform == 'win32':
            with file_lock(path / '.cpld.lock', exclusive=exclusive, blocking=blocking):
                yield
        else:
            fd = os.open(path, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
            try:
                with _lock(fd, exclusive, blocking):
                    yield
            finally:
                os.close(fd)
    5: POSIX  ADVISORY  READ 13598 00:71:97531372 128 128
    6: POSIX  ADVISORY  READ 13598 00:71:97531370 1073741826 1073742335
    15: FLOCK  ADVISORY  WRITE 13598 00:71:97656587 0 EOF
    24: FLOCK  ADVISORY  WRITE 934 00:71:97648643 0 EOF
    36: POSIX  ADVISORY  READ 13598 00:71:97566601 128 128
    37: POSIX  ADVISORY  READ 13598 00:71:97566599 1073741826 1073742335
    62: POSIX  ADVISORY  READ 13484 00:71:97566586 128 128
    63: POSIX  ADVISORY  READ 13484 00:71:97566584 1073741826 1073742335
    64: POSIX  ADVISORY  READ 13484 00:71:97566593 128 128
    65: POSIX  ADVISORY  READ 13484 00:71:97566581 1073741826 1073742335
    66: POSIX  ADVISORY  READ 13484 00:71:97566591 128 128
    67: POSIX  ADVISORY  READ 13484 00:71:97531380 1073741826 1073742335
    69: POSIX  ADVISORY  READ 13484 00:71:97531372 128 128
    70: POSIX  ADVISORY  READ 13484 00:71:97531370 1073741826 1073742335
    71: FLOCK  ADVISORY  WRITE 13692 00:71:97656608 0 EOF
    79: FLOCK  ADVISORY  WRITE 13598 00:71:97656657 0 EOF
    80: FLOCK  ADVISORY  WRITE 934 00:71:97566588 0 EOF
    88: FLOCK  ADVISORY  WRITE 13484 00:71:97656520 0 EOF
    89: POSIX  ADVISORY  READ 934 00:71:97566586 128 128
    90: POSIX  ADVISORY  READ 934 00:71:97566584 1073741826 1073742335
    121: POSIX  ADVISORY  READ 934 00:71:97566582 128 128
    122: POSIX  ADVISORY  READ 934 00:71:97531301 1073741826 1073742335
    134: FLOCK  ADVISORY  WRITE 13598 00:71:97656605 0 EOF
    135: POSIX  ADVISORY  READ 13598 00:71:97566582 128 128
    136: POSIX  ADVISORY  READ 13598 00:71:97531301 1073741826 1073742335
    144: POSIX  ADVISORY  READ 13598 00:71:97566593 128 128
    145: POSIX  ADVISORY  READ 13598 00:71:97566581 1073741826 1073742335
    150: FLOCK  ADVISORY  WRITE 15020 103:02:52049606 0 EOF
    151: FLOCK  ADVISORY  READ 15020 103:02:51118150 0 EOF
    152: POSIX  ADVISORY  READ 13598 00:71:97566586 128 128
    153: POSIX  ADVISORY  READ 13598 00:71:97566584 1073741826 1073742335
    155: POSIX  ADVISORY  READ 13484 00:71:97566582 128 128
    156: POSIX  ADVISORY  READ 13484 00:71:97531301 1073741826 1073742335
    157: POSIX  ADVISORY  READ 13598 00:71:97566591 128 128
    158: POSIX  ADVISORY  READ 13598 00:71:97531380 1073741826 1073742335
    159: POSIX  ADVISORY  READ 934 00:71:97531372 128 128
    160: POSIX  ADVISORY  READ 934 00:71:97531370 1073741826 1073742335
    total 0
    52049502 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.optical_14tx_4rx.uz_dslot_xo2.diamond.lock
    52049514 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.rx30.uz_dslot_xo2.diamond.lock
    52049506 -rw------- 1 vscode vscode 0 Oct  1 16:46 heartbeat.s3c_heartbeat.uz_s3c_xo2.diamond.lock
    52049526 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.template_dslots.uz_dslot_xo2.diamond.lock
    52049548 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.tx16_14rx.uz_dslot_xo2.diamond.lock
    52049571 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.tx20_10rx.uz_dslot_xo2.diamond.lock
    52049594 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.tx26_w_enable.uz_dslot_xo2.diamond.lock
    52049617 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.tx30.uz_dslot_xo2.diamond.lock
    52049640 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.tx30_hearbeattesting.uz_dslot_xo2.diamond.lock
    52049663 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.uz_d_3ph_inverter.uz_dslot_xo2.diamond.lock
    52049686 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.uz_d_abs_encoder.uz_dslot_xo2.diamond.lock
    52049709 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.uz_d_resolver_d1_to_d4.uz_dslot_xo2.diamond.lock
    52049733 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.uz_d_resolver_d5.uz_dslot_xo2.diamond.lock
    52049756 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.uz_d_temperature_ltc2983.uz_dslot_xo2.diamond.lock
    52049784 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049808 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049825 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049852 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049879 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049902 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049926 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049950 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8rx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049974 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049997 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050020 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050069 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52050092 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52050548 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050571 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050594 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat.voltage_8tx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049537 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_optical_14tx_4rx.uz_dslot_xo2.diamond.lock
    52049560 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_rx30.uz_dslot_xo2.diamond.lock
    52049583 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_template_dslots.uz_dslot_xo2.diamond.lock
    52049606 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_tx16_14rx.uz_dslot_xo2.diamond.lock
    52049628 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_tx20_10rx.uz_dslot_xo2.diamond.lock
    52049648 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_tx26_w_enable.uz_dslot_xo2.diamond.lock
    52049669 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_tx30.uz_dslot_xo2.diamond.lock
    52048716 -rw------- 1 vscode vscode 0 Oct  1 15:49 heartbeat_cvg.cvg_tx30.uz_dslot_xo2.foss.lock
    52049693 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_uz_d_3ph_inverter.uz_dslot_xo2.diamond.lock
    52049717 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_uz_d_abs_encoder.uz_dslot_xo2.diamond.lock
    52049740 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_uz_d_resolver_d1_to_d4.uz_dslot_xo2.diamond.lock
    52049762 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_uz_d_resolver_d5.uz_dslot_xo2.diamond.lock
    52049778 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_uz_d_temperature_ltc2983.uz_dslot_xo2.diamond.lock
    52049802 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049830 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049847 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049870 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049893 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049916 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049940 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049963 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8rx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049986 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52050009 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050032 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050081 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52050537 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52050560 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050583 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050606 -rw------- 1 vscode vscode 0 Oct  1 14:46 heartbeat_cvg.cvg_voltage_8tx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52055586 -rw------- 1 vscode vscode 0 Oct  1 16:36 heartbeat_cvg.s3c_heartbeat.uz_s3c_xo2.diamond.lock
    52049714 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.cvg_tx30_stateful.uz_dslot_xo2.diamond.lock
    52050647 -rw------- 1 vscode vscode 0 Oct  1 16:10 original.cvg_tx30_stateful.uz_dslot_xo2.foss.lock
    52055762 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.optical_14tx_4rx.uz_dslot_xo2.diamond.lock
    52049695 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.rx30.uz_dslot_xo2.diamond.lock
    52055763 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.s3c_power_on_debounce.uz_s3c_xo2.diamond.lock
    52049708 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.s3c_rev6_beta.uz_s3c_xo2.diamond.lock
    52049752 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.s3c_toolchain_test_program.uz_s3c_xo2.diamond.lock
    52049689 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.template_dslots.uz_dslot_xo2.diamond.lock
    52055761 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.tx16_14rx.uz_dslot_xo2.diamond.lock
    52049801 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.tx20_10rx.uz_dslot_xo2.diamond.lock
    52049810 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.tx26_w_enable.uz_dslot_xo2.diamond.lock
    52049807 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.tx30.uz_dslot_xo2.diamond.lock
    52049812 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_3ph_inverter.uz_dslot_xo2.diamond.lock
    52049565 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_abs_encoder.uz_dslot_xo2.diamond.lock
    52049657 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d1_to_d4.uz_dslot_xo2.diamond.lock
    52049883 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d4_4inverter.uz_dslot_xo2.diamond.lock
    52049868 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d4_4inverter_sdifix.uz_dslot_xo2.diamond.lock
    52049882 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d5.uz_dslot_xo2.diamond.lock
    52049881 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d5_4inverter.uz_dslot_xo2.diamond.lock
    52049725 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_resolver_d5_4inverter_sdifix.uz_dslot_xo2.diamond.lock
    52049911 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_temperature_ltc2983.uz_dslot_xo2.diamond.lock
    52049936 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_voltage_003_5v_tx30.uz_dslot_xo2.diamond.lock
    52049978 -rw------- 1 vscode vscode 0 Oct  1 16:46 original.uz_d_voltage_013_tx30.uz_dslot_xo2.diamond.lock
    # heartbeat_cvg: DIAMOND catalog build report
    
    Generated: 2026-10-05T15:39:05.672708+00:00
    
    This report reads existing build evidence. A successful status is **fresh** only when recorded inputs and outputs still match the checkout.
    
    Summary: failed 1, success 28.
    
    Startup counterexamples: 0. A fresh bitstream can still have an unresolved startup proof.
    
    | Program | Target | Status | Changed inputs | Changed outputs | Proof | Startup | Warnings | Timing |
    | --- | --- | --- | ---: | ---: | --- | --- | ---: | --- |
    | cvg_optical_14tx_4rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 22 | not evaluated |
    | cvg_rx30 | uz_dslot_xo2 | success | 0 | 0 | — | — | 48 | not evaluated |
    | cvg_template_dslots | uz_dslot_xo2 | success | 0 | 0 | — | — | 30 | not evaluated |
    | cvg_tx16_14rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 32 | not evaluated |
    | cvg_tx20_10rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 28 | not evaluated |
    | cvg_tx26_w_enable | uz_dslot_xo2 | success | 0 | 0 | — | — | 30 | not evaluated |
    | cvg_tx30 | uz_dslot_xo2 | success | 0 | 0 | — | — | 18 | not evaluated |
    | cvg_uz_d_3ph_inverter | uz_dslot_xo2 | success | 0 | 0 | — | — | 41 | not evaluated |
    | cvg_uz_d_abs_encoder | uz_dslot_xo2 | success | 0 | 0 | — | — | 99 | not evaluated |
    | cvg_uz_d_resolver_d1_to_d4 | uz_dslot_xo2 | success | 0 | 0 | — | — | 21 | not evaluated |
    | cvg_uz_d_resolver_d5 | uz_dslot_xo2 | success | 0 | 0 | — | — | 92 | not evaluated |
    | cvg_uz_d_temperature_ltc2983 | uz_dslot_xo2 | success | 0 | 0 | — | — | 24 | not evaluated |
    | cvg_voltage_8rx_8rx_8rx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 48 | not evaluated |
    | cvg_voltage_8rx_8rx_8rx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 42 | not evaluated |
    | cvg_voltage_8rx_8rx_8tx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 40 | not evaluated |
    | cvg_voltage_8rx_8rx_8tx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 34 | not evaluated |
    | cvg_voltage_8rx_8tx_8rx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 40 | not evaluated |
    | cvg_voltage_8rx_8tx_8rx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 34 | not evaluated |
    | cvg_voltage_8rx_8tx_8tx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 32 | not evaluated |
    | cvg_voltage_8rx_8tx_8tx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 26 | not evaluated |
    | cvg_voltage_8tx_8rx_8rx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 40 | not evaluated |
    | cvg_voltage_8tx_8rx_8rx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 34 | not evaluated |
    | cvg_voltage_8tx_8rx_8tx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 32 | not evaluated |
    | cvg_voltage_8tx_8rx_8tx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 26 | not evaluated |
    | cvg_voltage_8tx_8tx_8rx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 32 | not evaluated |
    | cvg_voltage_8tx_8tx_8rx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 26 | not evaluated |
    | cvg_voltage_8tx_8tx_8tx_6rx | uz_dslot_xo2 | success | 0 | 0 | — | — | 24 | not evaluated |
    | cvg_voltage_8tx_8tx_8tx_6tx | uz_dslot_xo2 | success | 0 | 0 | — | — | 18 | not evaluated |
    | s3c_heartbeat | uz_s3c_xo2 | failed | 18 | 0 | — | — | 13 | not evaluated |
    
    ## Details
    
    ### s3c_heartbeat (uz_s3c_xo2)
    
    Build status: failed. Build or GUI already active: /workspaces/uz_cpld/programs/heartbeat_cvg/s3c_heartbeat/build/uz_s3c_xo2_diamond
    Changed inputs: `cpld_toolchain/toolchain/buildsystem/backends/diamond.py`, `cpld_toolchain/toolchain/buildsystem/cli.py`, `cpld_toolchain/toolchain/buildsystem/identity.py`, `cpld_toolchain/toolchain/buildsystem/model.py`, `cpld_toolchain/toolchain/buildsystem/workflow.py`, `cpld_toolchain/toolchain/diamond.py`, `cpld_toolchain/toolchain/locking.py`, `cpld_toolchain/toolchain/targets/uz_s3c_xo2/baseline.sty`, `cpld_toolchain/toolchain/targets/uz_s3c_xo2/target.toml`, `toolchain/buildsystem/backends/diamond.py`, `toolchain/buildsystem/cli.py`, `toolchain/buildsystem/identity.py`, `toolchain/buildsystem/model.py`, `toolchain/buildsystem/workflow.py`, `toolchain/diamond.py`, `toolchain/locking.py`, `toolchain/targets/uz_s3c_xo2/baseline.sty`, `toolchain/targets/uz_s3c_xo2/target.toml`.
    
    {
      "status": "success"
    }
    # Public command definitions and help live in cpld_toolchain/toolchain/commands.py.
    .DEFAULT_GOAL := $(if $(program),build,help)
    python ?= python3
    command_root := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
    quote = '$(subst ','"'"',$(1))'
    # Forward explicit options, including unknown names, so typos cannot be ignored.
    command_options = $(filter-out python,$(foreach key,$(.VARIABLES),$(if $(filter command line,$(origin $(key))),$(key))))
    command_cli = PYTHONPATH=$(call quote,$(command_root))"$${PYTHONPATH:+:$$PYTHONPATH}" $(python) -m cpld_toolchain --make-help
    ifneq ($(word 2,$(MAKECMDGOALS)),)
    $(error Use one action per invocation: make ACTION key=value. Use make scan, make identify, make program, or make programmer-project instead of grouped programmer commands)
    endif
    commands := help image setup venv doctor list build-all report init programmer-project scan identify program new generate check build compare project gui sim netlist docs docs-assets test release-list release-new release-select usercodes usercodes-assign flasher-build clean clean-all
    # Single-action aliases preserve existing automation while help shows canonical names.
    aliases := programmer lattice_xcf release-current flasher docs-local docs-assets-local netlist-local _sim
    .PHONY: $(commands) $(aliases)
    $(commands) $(aliases):
        @$(command_cli) $@ $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
    .DEFAULT:
        @$(command_cli) $(call quote,$@) $(foreach key,$(command_options),--option $(call quote,$(key)=$($(key))))
    11:import subprocess
    223:                result = subprocess.run(['git', '-C', str(build.root), *args], capture_output=True, text=True)
    317:def gui(build: Build):
    331:        result = subprocess.run([str(executable), str(proj / 'firmware.ldf')], cwd=proj, env=diamond_environment(executable))
    ✓ • 0ms

## Assistant

The error comes from an operating-system lock held by another build or GUI session; an old lock file alone cannot cause it. That lock is now released, and another `build-all` run is already underway. I’m checking its progress before starting any competing work.

## Activity

    $ ps -eo pid,ppid,etime,args | rg 'buildsystem|pnmainc'; ls -li cpld_toolchain/toolchain/build/locks/heartbeat_cvg*; readlink /proc/15020/cwd; /opt/uz-cpld-env/bin/python3 - <<'PY'
        from pathlib import Path
        import json
        for p in sorted(Path('programs/heartbeat_cvg').glob('*/build/*/metadata/status.json')):
            if json.loads(p.read_text()).get('status') == 'running':
                print('Running:', p)
        PY
      15020   15019       01:16 /opt/uz-cpld-env/bin/python3 -m cpld_toolchain.toolchain.buildsystem build-all --backend diamond
      16695   15020       00:08 /opt/diamond/bin/lin64/pnmainc build.tcl
      16953   13598       00:00 /bin/bash -c ps -eo pid,ppid,etime,args | rg 'buildsystem|pnmainc'; ls -li cpld_toolchain/toolchain/build/locks/heartbeat_cvg*; readlink /proc/15020/cwd; /opt/uz-cpld-env/bin/python3 - <<'PY' from pathlib import Path import json for p in sorted(Path('programs/heartbeat_cvg').glob('*/build/*/metadata/status.json')):     if json.loads(p.read_text()).get('status') == 'running':         print('Running:', p) PY
      16955   16953       00:00 rg buildsystem|pnmainc
    52049537 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_optical_14tx_4rx.uz_dslot_xo2.diamond.lock
    52049560 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_rx30.uz_dslot_xo2.diamond.lock
    52049583 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_template_dslots.uz_dslot_xo2.diamond.lock
    52049606 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_tx16_14rx.uz_dslot_xo2.diamond.lock
    52049628 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_tx20_10rx.uz_dslot_xo2.diamond.lock
    52049648 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_tx26_w_enable.uz_dslot_xo2.diamond.lock
    52049669 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_tx30.uz_dslot_xo2.diamond.lock
    52048716 -rw------- 1 vscode vscode 0 Oct  1 15:49 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_tx30.uz_dslot_xo2.foss.lock
    52049693 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_uz_d_3ph_inverter.uz_dslot_xo2.diamond.lock
    52049717 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_uz_d_abs_encoder.uz_dslot_xo2.diamond.lock
    52049740 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_uz_d_resolver_d1_to_d4.uz_dslot_xo2.diamond.lock
    52049762 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_uz_d_resolver_d5.uz_dslot_xo2.diamond.lock
    52049778 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_uz_d_temperature_ltc2983.uz_dslot_xo2.diamond.lock
    52049802 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049830 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049847 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049870 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049893 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52049916 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52049940 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52049963 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8rx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52049986 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8rx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52050009 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8rx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050032 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8rx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050081 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8rx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52050537 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8tx_8rx_6rx.uz_dslot_xo2.diamond.lock
    52050560 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8tx_8rx_6tx.uz_dslot_xo2.diamond.lock
    52050583 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8tx_8tx_6rx.uz_dslot_xo2.diamond.lock
    52050606 -rw------- 1 vscode vscode 0 Oct  1 14:46 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.cvg_voltage_8tx_8tx_8tx_6tx.uz_dslot_xo2.diamond.lock
    52055586 -rw------- 1 vscode vscode 0 Oct  1 16:36 cpld_toolchain/toolchain/build/locks/heartbeat_cvg.s3c_heartbeat.uz_s3c_xo2.diamond.lock
    /workspaces/uz_cpld
    Running: programs/heartbeat_cvg/cvg_tx20_10rx/build/uz_dslot_xo2_diamond/metadata/status.json
    ✓ • 0ms

## Activity

    $ /opt/uz-cpld-env/bin/python3 - <<'PY'
        from pathlib import Path
        from cpld_toolchain.toolchain.locking import file_lock
        p = Path('cpld_toolchain/toolchain/build/locks/heartbeat_cvg.s3c_heartbeat.uz_s3c_xo2.diamond.lock')
        try:
            with file_lock(p):
                print('Verified: s3c_heartbeat lock is available.')
        except BlockingIOError:
            print('s3c_heartbeat lock is currently held.')
        PY
    Verified: s3c_heartbeat lock is available.
    ✓ • 0ms

## Assistant

`s3c_heartbeat` was blocked by another build or Diamond GUI holding its lock.

I verified that the lock is now available. A new `build-all --backend diamond` run is already running (PID `15020`); let it finish. Its final result is still pending.

No files need deleting or code changes. The existing lock file is normal and does not block builds by itself.

## User

(cpld-toolchain) ts@TS-WS:~/Documents/uz_cpld$ set DIAMOND_ROOT="~/lscc/programmer/diamond/3.14/"
(cpld-toolchain) ts@TS-WS:~/Documents/uz_cpld$ echo $DIAMOND_ROOT

(cpld-toolchain) ts@TS-WS:~/Documents/uz_cpld$ 

Why is this the case? Also, add the path information to user-guide for windows and ubuntu

## Assistant

In Bash, `set DIAMOND_ROOT=...` sets a positional argument, so `$DIAMOND_ROOT` stays empty. Use `export DIAMOND_ROOT="$HOME/lscc/programmer/diamond/3.14"`; `~` also won’t expand inside quotes. I’ll check how the toolchain uses this path and add Windows and Ubuntu instructions to the user guide.

## Activity

    $ rg --files -g '*user*guide*' -g AGENTS.md; rg -n 'DIAMOND_ROOT|Diamond.*install' docs cpld_toolchain | head -100; git status --short
    docs/tool-environments.rst:145:``programmer-project --rebuild 1`` also runs Diamond builds, so it needs the Diamond installation and license.
    docs/tool-environments.rst:165:On Windows, Docker runs the Linux image; native Windows Diamond cannot serve as the Linux Diamond installation inside that image.
    cpld_toolchain/bootstrap.py:95:        print('Python environment ready. Native HDL tools, Diamond and drivers are installed separately.', flush=True)
    docs/quick-start.rst:70:Diamond requires a licensed installation; see :doc:`environments` for setup and :doc:`vhdl-generator` for routing and configuration details.
    docs/windows.rst:14:See the `Diamond downloads and installation guides <https://www.latticesemi.com/Diamond>`_.
    docs/windows.rst:42:   $env:DIAMOND_ROOT = 'C:\lscc\diamond\3.14'
    docs/windows.rst:55:The launcher supplies Diamond and foundry DLL paths, ``FOUNDRY``, and the installation's ``license/license.dat`` when present, preserving any additional ``LM_LICENSE_FILE`` entries.
    docs/windows.rst:144:``DIAMOND_ROOT`` must name an existing installation.
    docs/windows.rst:155:``Generation inputs changed`` is a repository provenance issue, independent of whether Diamond or Programmer is installed.
    docs/commands.rst:30:``doctor`` reports the current operating environment, Python executable, active venv, Python packages, Diamond executables, simulation/FOSS tools, Docker/Podman clients, FOSS installation receipts and selected catalog.
    docs/commands.rst:62:Configure the Diamond installation and license as described in :doc:`environments`, or reopen in the configured Dev Container.
    docs/builds.rst:104:Diamond and FOSS commands use installed tools in the calling environment.
    docs/builds.rst:149:With a native Diamond installation and display::
    docs/architecture.rst:57:The external Diamond installation, mutable base image and OS packages are environmental inputs.
    cpld_toolchain/programmer_helper/diamond_program.sh:9:diamond_root=${DIAMOND_ROOT:-/opt/diamond}
    cpld_toolchain/programmer_helper/diamond_program.sh:38:    echo "Diamond Programmer pgrcmd was not found. Mount Diamond and set DIAMOND_ROOT or CPLD_PGRCMD." >&2
    docs/environments.rst:29:Requesting Diamond without an installation fails with a setup error.
    docs/environments.rst:52:To use Diamond, mount a Linux installation read-only at the image's default ``DIAMOND_ROOT``, ``/opt/diamond``::
    docs/environments.rst:63:For a different container mount location, also pass ``--env DIAMOND_ROOT=/that/location``.
    docs/environments.rst:105:They detect a full Linux Diamond installation at ``$HOME/lscc/diamond/3.14`` automatically.
    docs/environments.rst:107:The selected directory is mounted read-only at ``/opt/diamond``; inside the container, ``DIAMOND_ROOT`` is always ``/opt/diamond``.
    docs/environments.rst:113:The host setup accepts ``DIAMOND_HOST_ROOT``, then ``DIAMOND_ROOT``, then the saved selection, then the standard location.
    docs/environments.rst:126:To enable Diamond again, run the same command with its installation path.
    docs/environments.rst:150:``echo "$DIAMOND_ROOT"`` reports the configured path even when no installation is mounted.
    docs/environments.rst:154:   ls -l "$DIAMOND_ROOT/bin/lin64/diamond" "$DIAMOND_ROOT/bin/lin64/diamondc"
    docs/environments.rst:175:They inherit its Ubuntu 22.04 runtime, Diamond installation at ``/opt/diamond``, and embedded license, then add the repository's FOSS tools and development environment.
    docs/environments.rst:209:Inside either Dev Container profile, Diamond builds run through the same commands using the installed tools.
    docs/environments.rst:226:   * - ``DIAMOND_ROOT``
    docs/environments.rst:240:These shell helpers use ``DIAMOND_ROOT`` rather than ``DIAMOND_CLI``.
    docs/environments.rst:286:Diamond, licenses, USB drivers, GHDL, Yosys, Graphviz and other native tools must be installed separately.
    docs/developer/toolchain.rst:37:Diamond workflows additionally need an installation and license.
    cpld_toolchain/toolchain/buildsystem/backends/diamond.py:43:        raise BuildError(f'Expected Diamond {wanted}; installed {version} at {binary}. '
    cpld_toolchain/toolchain/buildsystem/backends/diamond.py:44:                         'Set DIAMOND_ROOT or DIAMOND_CLI to the matching full Diamond installation. '
    cpld_toolchain/toolchain/buildsystem/backends/diamond.py:57:            raise BuildError(f'Diamond startup timed out after 30 seconds: {binary}; check the installation and license') from exc
    cpld_toolchain/toolchain/buildsystem/backends/diamond.py:62:        print('Diamond installation version unavailable; the full version will be checked in each build log.')
    cpld_toolchain/toolchain/doctor.py:137:                vendor.append(Finding('Diamond installed version', 'FOUND' if version else 'NOT CHECKED',
    cpld_toolchain/toolchain/doctor.py:141:    diamond_root = Path(os.environ.get('DIAMOND_ROOT', 'C:/lscc/diamond/3.14' if sys.platform == 'win32' else '/opt/diamond'))
    cpld_toolchain/toolchain/diamond.py:30:    root = Path(os.environ.get('DIAMOND_ROOT', 'C:/lscc/diamond/3.14' if windows else '/opt/diamond'))
    cpld_toolchain/toolchain/diamond.py:35:    if 'DIAMOND_ROOT' not in os.environ:
    cpld_toolchain/toolchain/diamond.py:52:    raise BuildError(f'Diamond {kind} unavailable; set DIAMOND_ROOT or {variable} (tried {", ".join(candidates)}).{hint}')
    cpld_toolchain/toolchain/diamond.py:64:    root = Path(env.get('DIAMOND_ROOT', root))
    cpld_toolchain/toolchain/tests/test_container.py:80:        env = dict(os.environ, DIAMOND_ROOT=str(root))
    cpld_toolchain/toolchain/tests/test_container.py:124:                    if key not in ('DIAMOND_ROOT', 'DIAMOND_HOST_ROOT', 'LM_LICENSE_FILE')}
    cpld_toolchain/toolchain/tests/test_container.py:148:        result = self.prepare(DIAMOND_ROOT=str(path), DIAMOND_HOST_ROOT='')
    cpld_toolchain/toolchain/tests/test_container.py:156:        result = self.prepare(DIAMOND_HOST_ROOT=str(path), DIAMOND_ROOT='/not-present')
    cpld_toolchain/toolchain/tests/test_container.py:176:        self.assertEqual(self.prepare(DIAMOND_ROOT=str(path)).returncode, 0)
    cpld_toolchain/toolchain/tests/test_platform.py:76:                    {'DIAMOND_ROOT': str(root), 'PATH': 'original', 'LM_LICENSE_FILE': '27000@server'}, clear=True):
    cpld_toolchain/toolchain/tests/test_doctor.py:102:                patch.dict(os.environ, {'FOSS_ROOT': tmp, 'DIAMOND_ROOT': tmp}, clear=True), \
    cpld_toolchain/toolchain/tests/test_doctor.py:125:                                    cwd=commands.ROOT, env={**os.environ, 'PATH': '', 'DIAMOND_ROOT': tmp,
    cpld_toolchain/toolchain/tests/test_buildsystem.py:291:        self.preflight.side_effect = BuildError('Expected Diamond 3.14; installed 3.13')
     M programs/usercodes.json
    ?? codex-session-01a10c29-f4f7-7cf1-8d30-04be3a1992a2.md
    ✓ • 0ms

## Activity

    $ cat docs/index.rst; cat docs/windows.rst; sed -n '210,310p' docs/environments.rst; cat cpld_toolchain/toolchain/diamond.py | head -85; rg -n 'sphinx|docs-local' pyproject.toml cpld_toolchain/toolchain/commands.py
    UltraZohm CPLD
    ==============
    
    Firmware and tooling for UltraZohm D-slot ``LCMXO2-2000HC-4TG100C`` and S3C ``LCMXO2-4000HC-4TG144C`` devices.
    Use the user guide for existing firmware, the HDL developer guide to create programs, and toolchain contribution to change the tooling.
    Each guide includes a quick start reference.
    
    .. toctree::
       :maxdepth: 2
    
       user/index
       developer/toolchain
       developer/hdl
       _generated/programs/index
       Release comparison <releases>
    Native Windows setup
    ====================
    
    The primary repository interface is ``python -m cpld_toolchain`` on Windows and Linux.
    Run setup from the checkout root with Python 3.8 or later; setup downloads the selected modern Python as needed.
    GNU Make, Bash and Docker are not needed for native VHDL generation, Diamond builds, or Diamond programming.
    The Makefile remains an optional Linux wrapper.
    
    See :doc:`tool-environments` for the workflow and environment matrix.
    
    Install Python and Git, and install the Windows edition of Diamond matching the version in ``cpld_toolchain/toolchain/targets/*/target.toml`` (currently 3.14.0.75.2).
    Install Diamond's programming cable drivers and configure its license.
    The Python environment does not install Diamond or its drivers.
    See the `Diamond downloads and installation guides <https://www.latticesemi.com/Diamond>`_.
    
    Python environment
    ------------------
    
    From PowerShell in the checkout::
    
       python -m cpld_toolchain setup
    
    This creates or updates ``.venv``, installs the editable project and all locked Python dependencies, and opens PowerShell with the environment activated.
    Type ``exit`` to return to the original terminal.
    Without an interactive terminal, setup prints an activation command instead.
    
    To stay in the current PowerShell session::
    
       python -m cpld_toolchain setup --activate 0
       & .\.venv\Scripts\Activate.ps1
    
    Activation is subject to your PowerShell execution policy.
    If scripts are restricted, use ``.\.venv\Scripts\python.exe`` in place of ``python`` below; activation is optional when using that interpreter directly.
    Setup does not change the execution policy.
    Recreate the virtual environment when moving between Windows and Linux; their environments are not interchangeable.
    
    Configure Diamond
    -----------------
    
    Set the installation root in the same terminal::
    
       $env:DIAMOND_ROOT = 'C:\lscc\diamond\3.14'
       # Optional extra license file or floating server:
       $env:LM_LICENSE_FILE = 'C:\licenses\diamond.lic'
       python -m cpld_toolchain doctor
    
    Adjust these example paths to your installation.
    The default root is ``C:/lscc/diamond/3.14``.
    The launcher looks for ``bin/nt64/pnmainc.exe`` for builds and ``bin/nt64/pnmain.exe`` for the GUI.
    Programmer discovery checks ``programmer/bin/nt64/pgrcmd.exe`` and ``bin/nt64/pgrcmd.exe``.
    If no root is specified it also checks PATH.
    ``DIAMOND_CLI``, ``DIAMOND_GUI`` and ``CPLD_PGRCMD`` override the individual executables; supply an executable path, not a command with arguments.
    Windows launchers must be ``.exe`` files.
    
    The launcher supplies Diamond and foundry DLL paths, ``FOUNDRY``, and the installation's ``license/license.dat`` when present, preserving any additional ``LM_LICENSE_FILE`` entries.
    The launcher and environment conventions follow Lattice's `Scripting Lattice FPGA Build Flow <https://www.latticesemi.com/view_document?document_id=54075>`_.
    ``doctor`` lists installed and missing tools plus catalog state.
    It does not start Diamond or validate a license; a successful build is still required to validate synthesis, licensing and firmware exports.
    See :doc:`commands` for the report states and exit behavior.
    
    Generate and build
    ------------------
    
    For an existing program::
    
       python -m cpld_toolchain list
       python -m cpld_toolchain build --program cvg_tx30 --release-cycle heartbeat_cvg
       python -m cpld_toolchain build-all
    
    To create a CSV-based program::
    
       python -m cpld_toolchain new --name my_slot --template generator
       # Edit the new program's routing.csv and generator.toml.
       python -m cpld_toolchain generate --program cvg_my_slot
       python -m cpld_toolchain build --program cvg_my_slot
    
    Use ``--release-cycle NAME`` when selecting a cycle other than the repository current cycle.
    Generated manifests use forward slashes, and generated files use UTF-8 with LF line endings.
    Git attributes preserve tracked bytes across platforms because generation receipts hash the exact source contents.
    Rebuild firmware on the programming station: existing build receipts and XCFs may contain machine-specific paths and tool identities.
    
    Program hardware
    ----------------
    
    Create and edit the selection, then inspect the connected D-slot chain::
    
       python -m cpld_toolchain init
       # Edit selection.toml.
       python -m cpld_toolchain scan --target dslot
       python -m cpld_toolchain identify --target dslot
       python -m cpld_toolchain program --target dslot --dry-run 1
    
    After checking the selection and preparing the hardware::
    
       python -m cpld_toolchain program --target dslot
    
    The last command erases, programs and verifies Flash.
    Use ``--target s3c`` only when the hardware is prepared for S3C access.
    The selection's programs must have successful, current Diamond builds.
    Source hashes, firmware snapshots, JTAG checks and post-programming USERCODE readback remain mandatory.
    ``--dry-run 1`` only previews the command; it does not validate firmware or contact hardware.
    ``programmer-project`` exports XCFs without accessing USB.
    
    Windows uses the installed vendor driver and invokes ``pgrcmd.exe`` directly.
    Linux-only USB bus checks and FTDI driver detachment are not used on Windows.
    Concurrent managed Diamond USB operations are serialized.
    Confirm the actual programmer port with a read-only scan: the existing managed identity/programming mapping is ``FTUSB-1`` and must be validated on the Windows station.
    
    Scope and validation
    --------------------
    
    Native Windows support covers the Python CLI, generator and Diamond workflow.
    The FOSS compiler/source-build installers remain Linux tools.
    All commands use the current environment; enter the Linux toolchain container explicitly for workflows whose tools are unavailable natively.
    Native FOSS hardware drivers and programming are outside the Windows validation scope.
    
    ``python -m cpld_toolchain test`` on Windows runs the native Python suite without Make, Bash or Linux HDL tools.
    Windows CI uses this same command.
    It checks generation, shared/exclusive process locks, concurrent identity allocation and mocked programmer behavior.
    It does not install licensed Diamond or connect physical hardware.
    Before using a Windows station, validate one Diamond build, scan, identity read and program/verify cycle there.
    The implementation was developed and regression tested on Linux; Windows CI and vendor/hardware results must be reviewed on Windows before claiming end-to-end validation.
    
    ``clean-all`` preserves the virtual environment when its Python interpreter is currently running the command.
    Exit that environment before deleting it.
    
    Use ``python -m cpld_toolchain help`` or ``python -m cpld_toolchain help --command ACTION`` for the available arguments.
    
    Troubleshooting Windows installations
    -------------------------------------
    
    A standalone Lattice Programmer installation does not contain the synthesis and build tools.
    Point the programmer override at its actual executable::
    
       $env:CPLD_PGRCMD = 'C:\path\to\programmer\bin\nt64\pgrcmd.exe'
       python -m cpld_toolchain doctor
    
    The report can show Programmer as FOUND and the Diamond build CLI as MISSING.
    Generation needs Python only; ``build`` and ``build-all`` require full Diamond.
    Managed programming still requires the current build artifacts and provenance described above.
    Copying a JEDEC file alone does not satisfy those checks.
    For a Programmer-only station, an XCF and its referenced firmware can instead be prepared on the build station for use with the vendor Programmer; this is outside the repository's managed programming validation.
    
    ``DIAMOND_ROOT`` must name an existing installation.
    Setting it to a 3.14 path does not install or upgrade Diamond 3.13.
    The repository currently requires 3.14.0.75.2; an older installation is not accepted merely because it starts.
    Build commands check vendor installation metadata and CLI startup before starting builds.
    ``build-all`` performs this shared check once.
    If version metadata is unavailable, the full version is still checked in every build log.
    Startup failures include the vendor's license error.
    ``doctor`` reads version metadata without starting Diamond or testing its license.
    
    Use ``python -m cpld_toolchain build-all`` (one hyphenated action), not ``python -m cpld_toolchain build -all``.
    
    ``Generation inputs changed`` is a repository provenance issue, independent of whether Diamond or Programmer is installed.
    The message alone does not identify whether the cause is edited inputs, a generator update or changed checkout bytes.
    Review ``git status`` and your intended generator inputs, then regenerate the affected program, for example::
    
       python -m cpld_toolchain generate --program cvg_optical_14tx_4rx --release-cycle heartbeat_cvg
       python -m cpld_toolchain check --program cvg_optical_14tx_4rx --release-cycle heartbeat_cvg
    
    Review the generated diff.
    Regeneration refreshes generated outputs and their receipt; it does not install missing tools.
    Avoid deleting receipts or weakening version checks to suppress these diagnostics.
    The image variant contains proprietary tools and your license; restrict access when publishing it, just as for the Diamond base image.
    
    Diamond and licensing
    ---------------------
    
    .. list-table:: Runtime configuration
       :header-rows: 1
    
       * - Variable
         - Meaning
       * - ``DIAMOND_HOST_ROOT``
         - Host setup override for the Linux installation path; ``none`` disables the mount's installation.
       * - ``DIAMOND_IMAGE``
         - Optional Diamond image repository name without a tag for the image profiles.
       * - ``DIAMOND_TAG``
         - Diamond image tag for the image profiles, defaulting to ``3.14.0.75.2``.
       * - ``DIAMOND_ROOT``
         - Runtime installation root, defaulting to ``/opt/diamond``.
           Also accepted as a host setup fallback.
       * - ``DIAMOND_CLI`` / ``DIAMOND_GUI``
         - Python frontend executable overrides; values are paths, not shell commands.
       * - ``LM_LICENSE_FILE``
         - Additional license file path or ``port@server``.
    
    The vendor ``diamondc`` wrapper configures libraries and includes its installation's ``license/license.dat`` in the license search path.
    Additional license files need their own mount and a container-visible path.
    The Dev Container and manual Diamond example expose the fixed container MAC for node-locked license detection.
    Floating-license configurations can use a server address reachable from the container; ``localhost`` refers to the container itself with bridge networking.
    
    ``check-diamond`` tests Tcl startup; ``check-diamond --synthesis`` also synthesizes a one-gate design.
    These shell helpers use ``DIAMOND_ROOT`` rather than ``DIAMOND_CLI``.
    Neither check performs full routing or firmware export; use ``make build-all`` for that validation.
    A host-ID mismatch requires checking the authorized license/environment, not editing the signed license or host MAC.
    
    Native tools
    ------------
    
    The full native Linux simulation and documentation workflow requires Python 3.10+, GHDL, Yosys, Graphviz and the packages locked in ``uv.lock``.
    Generation and native Diamond work need only their workflow-specific dependencies; see :doc:`tool-environments`.
    The managed Python includes Tcl support for tooling tests.
    The image and native setup share ``.python-version``, ``cpld_toolchain/uv-bootstrap.json``, ``pyproject.toml`` and ``uv.lock``; OS packages and the Ubuntu image tag remain mutable inputs.
    Firmware and documentation commands use dependencies already installed in the image.
    The C++ compiler and development headers used to build nextpnr and the patched flasher remain in the intermediate builder stage.
    The runtime includes the compiled tools; ``make flasher-build`` is a separate native source build and requires those development dependencies if run there.
    See :doc:`foss` for the pinned tool bundle and native source-build prerequisites.
    
    Native Python setup
    -------------------
    
    From a fresh checkout, run this with Python 3.8 or newer::
    
       python -m cpld_toolchain setup
    
    Use ``python3`` if ``python`` is unavailable.
    Setup downloads the pinned uv executable into the ignored ``.tools/`` directory and verifies the archive checksum.
    It uses ``.python-version`` to select uv-managed Python 3.10.12, downloading it if needed, then installs the editable project and all dependency groups from ``uv.lock`` into ``.venv``.
    An active older Conda environment can run setup; its Python and packages are not changed.
    Initial downloads require internet access to GitHub and Python package sources.
    No prior uv, pip or system venv package is needed.
    An existing virtual environment is synchronized to the lockfile; uv may replace its interpreter when the selected Python changes and removes packages absent from the lockfile.
    Setup refuses an existing ``.venv`` directory that is not a virtual environment.
    
    Interactive setup opens an activated Bash or PowerShell shell with ``uz_cpld`` available.
    Use ``exit`` to return to the original shell.
    To install without opening a shell, then activate in the current Bash or Zsh session::
    
       python -m cpld_toolchain setup --activate 0
       source .venv/bin/activate
    
    In later shells, only the activation command is needed.
    For PowerShell activation, see :doc:`windows`.
    Without an interactive terminal, setup prints the activation command.
    ``python -m cpld_toolchain setup --dry-run 1`` previews setup without downloads or changes.
    ``make setup`` and ``uz_cpld setup`` invoke the same setup; ``venv`` is also accepted.
    
    All Python packages for simulation, analysis and documentation are included.
    Diamond, licenses, USB drivers, GHDL, Yosys, Graphviz and other native tools must be installed separately.
    FOSS hardware programming requires the patched openFPGALoader and OpenOCD described in :doc:`firmware-identity`.
    
    The container builds its Python environment with the same uv release and ``uv sync --locked --all-groups --managed-python``.
    Its environment lives at ``/opt/uz-cpld-env`` and is already on PATH, independently of any host ``.venv`` mounted with the checkout.
    The container's ``uz_cpld`` command runs source from the current checkout.
    ``uv run`` uses the same prebuilt environment with automatic synchronization disabled.
    Rebuild the image after changing the interpreter pin, uv manifest or dependency lockfile.
    CMake 3.31.6 is installed with ``uv tool install`` in the native-tools builder stage only.
    """Native Diamond executable discovery and Windows runtime environment."""
    import os
    from pathlib import Path
    import shutil
    import sys
    import configparser
    import re
    
    from cpld_toolchain.toolchain.buildsystem.model import BuildError
    
    
    def installed_version(binary):
        """Read vendor installation metadata without starting a licensed process."""
        path = Path(binary).resolve().parent.parent.parent / 'data/ispsys.ini'
        config = configparser.ConfigParser(interpolation=None, strict=False)
        try:
            config.read_string(path.read_text(encoding='utf-8-sig'))
            section = config['version']
            value = '.'.join(section[key].strip() for key in ('MajorVersion', 'MinorVersion', 'BuildNumber'))
            return value if re.fullmatch(r'\d+\.\d+\.\d+\.\d+\.\d+', value) else None
        except (OSError, UnicodeError, configparser.Error, KeyError):
            return None
    
    
    def executable(kind='cli', *, required=True):
        windows = sys.platform == 'win32'
        variable = {'cli': 'DIAMOND_CLI', 'gui': 'DIAMOND_GUI', 'programmer': 'CPLD_PGRCMD'}[kind]
        names = ({'cli': 'pnmainc.exe', 'gui': 'pnmain.exe', 'programmer': 'pgrcmd.exe'} if windows else
                 {'cli': 'diamondc', 'gui': 'diamond', 'programmer': 'pgrcmd'})
        root = Path(os.environ.get('DIAMOND_ROOT', 'C:/lscc/diamond/3.14' if windows else '/opt/diamond'))
        platform_dir = 'nt64' if windows else 'lin64'
        candidates = [str(root / 'bin' / platform_dir / names[kind])]
        if kind == 'programmer':
            candidates.insert(0, str(root / 'programmer/bin' / platform_dir / names[kind]))
        if 'DIAMOND_ROOT' not in os.environ:
            candidates.append(names[kind])
        if os.environ.get(variable):
            candidates = [os.environ[variable]]
        for candidate in candidates:
            found = shutil.which(candidate)
            if found:
                result = Path(found).resolve()
                if windows and result.suffix.lower() != '.exe':
                    raise BuildError(f'{variable} must name a Windows .exe, not a batch/shell command')
                return result
        if not required:
            candidate = Path(candidates[0])
            if windows and candidate.suffix.lower() != '.exe':
                raise BuildError(f'{variable} must name a Windows .exe')
            return candidate
        hint = ' Standalone Programmer does not include the build CLI; building requires full Diamond.' if kind == 'cli' else ''
        raise BuildError(f'Diamond {kind} unavailable; set DIAMOND_ROOT or {variable} (tried {", ".join(candidates)}).{hint}')
    
    
    def environment(executable_path):
        """Windows tools need DLL/search paths; Linux launchers set their own environment."""
        env = dict(os.environ)
        if sys.platform != 'win32':
            return env
        binary = Path(executable_path).resolve()
        root = binary.parent.parent.parent
        if root.name.lower() == 'programmer':
            root = root.parent
        root = Path(env.get('DIAMOND_ROOT', root))
        foundry = Path(env.get('FOUNDRY', root / 'ispfpga'))
        env['FOUNDRY'] = str(foundry)
        env['PATH'] = ';'.join(map(str, (binary.parent, root / 'bin/nt64', foundry / 'bin/nt64'))) + ';' + env.get('PATH', '')
        license_path = root / 'license/license.dat'
        if license_path.is_file():
            env['LM_LICENSE_FILE'] = str(license_path) + (';' + env['LM_LICENSE_FILE'] if env.get('LM_LICENSE_FILE') else '')
        return env
    cpld_toolchain/toolchain/commands.py:82:    'docs-local': ('docs', {}), 'docs-assets-local': ('docs-assets', {}),
    pyproject.toml:22:docs = ["Sphinx==7.4.7", "furo==2025.12.19", "sphinxcontrib-mermaid==2.1.1"]
    ✓ • 0ms

## Activity

    $ cat docs/user/index.rst; cat docs/user/quick-start.rst; rg -n 'sphinx|def docs' cpld_toolchain -g '*.py'; cat docs/conf.py | head -70
    User guide
    ==========
    
    Run commands from the repository root with Python 3.8+ for setup (``python3`` on Linux if ``python`` is unavailable).
    Use firmware for your adapter wiring and a matching S3C/D-slot protocol; compare the available :doc:`releases </releases>` before selecting programs.
    The example below uses ``heartbeat_cvg``.
    
    Quick start reference
    ---------------------
    
    Install Diamond 3.14.0.75.2, its license and programming cable drivers, then create the Python environment::
    
       python -m cpld_toolchain setup
       uz_cpld doctor
       uz_cpld list --release-cycle heartbeat_cvg
    
    Setup downloads uv and Python 3.10.12 as needed, installs all locked Python dependencies into ``.venv``, and opens an activated shell with ``uz_cpld`` available.
    Internet access is required for initial downloads.
    In a new Bash shell, run ``source .venv/bin/activate``; in PowerShell, run ``& .\.venv\Scripts\Activate.ps1``.
    Use ``--activate 0`` to install without opening a shell.
    For installation paths, licensing and USB access, see :doc:`../windows` or :doc:`../environments`.
    ``doctor`` reports available tools; it does not test the license or hardware and missing tools do not make it fail.
    
    Build the programs you need and create your selection::
    
       uz_cpld build --program cvg_tx30 --release-cycle heartbeat_cvg
       uz_cpld build --program s3c_heartbeat --release-cycle heartbeat_cvg
       uz_cpld init
    
    Edit ``selection.toml`` to match your adapters (this example uses TX30 in all five slots)::
    
       release = "heartbeat_cvg"
       s3c = "s3c_heartbeat"
    
       [slots]
       "1" = "cvg_tx30"
       "2" = "cvg_tx30"
       "3" = "cvg_tx30"
       "4" = "cvg_tx30"
       "5" = "cvg_tx30"
    
    ``init`` preserves an existing file; its template defaults must be edited for this release.
    Build every distinct selected program in the same release before programming.
    Build commands do not read ``selection.toml``.
    
    Prepare the UltraZohm for D-slot JTAG access, then run::
    
       uz_cpld scan --target dslot
       uz_cpld identify --target dslot
       uz_cpld program --target dslot --dry-run 1
       uz_cpld program --target dslot
    
    ``program`` immediately erases, writes and verifies Flash, including firmware identity readback.
    ``--dry-run 1`` only previews the command; firmware freshness and hardware checks happen during execution.
    To program S3C, change the UltraZohm to its S3C access state and use ``--target s3c``.
    Both targets use FT4232 channel B; Diamond defaults to ``FTUSB-1``.
    
    Useful commands
    ---------------
    
    ::
    
       uz_cpld release-list
       uz_cpld build-all --release-cycle heartbeat_cvg
       uz_cpld report --release-cycle heartbeat_cvg
       uz_cpld programmer-project
       uz_cpld help --command program
    
    ``programmer-project`` optionally exports both Diamond XCF files and requires all six assignments and current builds.
    CLI programming creates its own project, so this export is optional.
    
    Diamond firmware uses ``.jed`` files; FOSS firmware uses ``.bit`` files.
    ``--backend foss`` selects FOSS for builds and programming where the program supports it.
    To program Diamond firmware using FOSS tools, use ``--programmer-backend foss``.
    FOSS programming requires the repository's patched openFPGALoader and OpenOCD; see :doc:`../firmware-identity`.
    
    Simulation and successful exports do not establish board timing or hardware qualification.
    See :doc:`../s3c` for controller compatibility and :doc:`../validation` for verification limits.
    Detailed options are in :doc:`../commands` and :doc:`../programmer`.
    cat: docs/user/quick-start.rst: No such file or directory
    cpld_toolchain/toolchain/doctor.py:127:                                           'pyvcd', 'Sphinx', 'furo', 'sphinxcontrib-mermaid')]
    cpld_toolchain/toolchain/analysis/sitecheck.py:32:        raise ValueError('Missing .nojekyll; enable sphinx.ext.githubpages')
    cpld_toolchain/toolchain/analysis/documentation.py:53:        subprocess.run([sys.executable, '-m', 'sphinx', '-W', '--keep-going',
    cpld_toolchain/toolchain/tests/test_documentation_parallel.py:172:                      side_effect=subprocess.CalledProcessError(1, 'sphinx')), \
    """Sphinx configuration; API imports do not invoke Diamond."""
    from pathlib import Path
    import sys
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    project = 'UltraZohm CPLD build and simulation'
    author = 'UltraZohm contributors'
    release = '0.1'
    extensions = ['sphinx.ext.autodoc', 'sphinx.ext.viewcode', 'sphinx.ext.githubpages',
                  'sphinxcontrib.mermaid']
    master_doc = 'index'
    exclude_patterns = ['_build', '_generated/static']
    html_extra_path = ['_generated/static']
    html_theme = 'furo'
    autodoc_member_order = 'bysource'
    
    # Document the pytest runner without requiring a simulator installation.
    autodoc_mock_imports = ["cocotb_tools"]
    ✓ • 0ms

## Activity

    $ python3 - <<'PY'
        from pathlib import Path
        p = Path('docs/user/index.rst')
        s = p.read_text().replace('   uz_cpld doctor\n   uz_cpld list --release-cycle heartbeat_cvg\n', '', 1)
        s = s.replace('For installation paths, licensing and USB access, see :doc:`../windows` or :doc:`../environments`.\n', '''Set ``DIAMOND_ROOT`` in the activated terminal to your actual Diamond installation directory, not its ``bin`` directory or an executable.
        The following are example paths; adjust them to match your installation.
        
        On Ubuntu (Bash)::
        
           export DIAMOND_ROOT="$HOME/lscc/diamond/3.14"
           echo "$DIAMOND_ROOT"
           ls "$DIAMOND_ROOT/bin/lin64/diamondc"
        
        Bash uses ``export NAME=value`` to make a variable available to commands started from that shell.
        ``set DIAMOND_ROOT=...`` sets a positional argument instead of the environment variable.
        Use ``$HOME`` inside double quotes: ``"~/lscc/diamond/3.14"`` contains a literal ``~`` and will not resolve to your home directory.
        To keep this setting for new interactive Bash terminals, add the same ``export`` line to ``~/.bashrc`` and run ``source ~/.bashrc``.
        The native Linux default, when no root is set, is ``/opt/diamond``.
        
        On Windows (PowerShell)::
        
           $env:DIAMOND_ROOT = 'C:\\lscc\\diamond\\3.14'
           echo $env:DIAMOND_ROOT
           Test-Path "$env:DIAMOND_ROOT\\bin\\nt64\\pnmainc.exe"
        
        For Windows Command Prompt (``cmd.exe``), use its own syntax::
        
           set "DIAMOND_ROOT=C:\\lscc\\diamond\\3.14"
           echo %DIAMOND_ROOT%
        
        These Windows assignments apply to the current terminal and commands started from it.
        For a persistent user setting, see :doc:`../windows`.
        The native Windows default is ``C:/lscc/diamond/3.14``.
        
        A path such as ``$HOME/lscc/programmer/diamond/3.14`` may be a standalone Programmer installation.
        Check that the build executable shown above exists: ``build`` and ``build-all`` require full Diamond; standalone Programmer only provides programming tools.
        For licensing, container paths and USB access, see :doc:`../windows` or :doc:`../environments`.
        
        Check discovery after setting the path::
        
           uz_cpld doctor
           uz_cpld list --release-cycle heartbeat_cvg
        
        ''')
        p.write_text(s)
        p = Path('docs/windows.rst')
        s = p.read_text().replace('Adjust these example paths to your installation.\n', '''Adjust these example paths to your installation.
        ``DIAMOND_ROOT`` names the installation directory, not ``bin\\nt64`` or an executable.
        Check the current PowerShell setting and build executable::
        
           echo $env:DIAMOND_ROOT
           Test-Path "$env:DIAMOND_ROOT\\bin\\nt64\\pnmainc.exe"
        
        ``$env:DIAMOND_ROOT`` applies to this terminal and its child processes.
        To save the current value for future Windows sessions, run this in PowerShell::
        
           [Environment]::SetEnvironmentVariable('DIAMOND_ROOT', $env:DIAMOND_ROOT, 'User')
        
        Restart the terminal application (and VS Code if using its integrated terminal) to inherit the saved value.
        In Command Prompt (``cmd.exe``), the equivalent current-session commands are::
        
           set "DIAMOND_ROOT=C:\\lscc\\diamond\\3.14"
           echo %DIAMOND_ROOT%
        
        ''')
        p.write_text(s)
        PY
        /opt/uz-cpld-env/bin/python3 -m sphinx -W --keep-going -b html docs /tmp/uz-cpld-docs-paths
    Running Sphinx v7.4.7
    loading translations [en]... done
    making output directory... done
    building [mo]: targets for 0 po files that are out of date
    writing output...
    building [html]: targets for 111 source files that are out of date
    updating environment: [new config] 111 added, 0 changed, 0 removed
    reading sources... [  1%] _generated/programs/index
    reading sources... [  2%] _generated/programs/program-heartbeat-optical_14tx_4rx
    reading sources... [  3%] _generated/programs/program-heartbeat-rx30
    reading sources... [  4%] _generated/programs/program-heartbeat-s3c_heartbeat
    reading sources... [  5%] _generated/programs/program-heartbeat-template_dslots
    reading sources... [  5%] _generated/programs/program-heartbeat-tx16_14rx
    reading sources... [  6%] _generated/programs/program-heartbeat-tx20_10rx
    reading sources... [  7%] _generated/programs/program-heartbeat-tx26_w_enable
    reading sources... [  8%] _generated/programs/program-heartbeat-tx30
    reading sources... [  9%] _generated/programs/program-heartbeat-tx30_hearbeattesting
    reading sources... [ 10%] _generated/programs/program-heartbeat-uz_d_3ph_inverter
    reading sources... [ 11%] _generated/programs/program-heartbeat-uz_d_abs_encoder
    reading sources... [ 12%] _generated/programs/program-heartbeat-uz_d_resolver_d1_to_d4
    reading sources... [ 13%] _generated/programs/program-heartbeat-uz_d_resolver_d5
    reading sources... [ 14%] _generated/programs/program-heartbeat-uz_d_temperature_ltc2983
    reading sources... [ 14%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8rx_6rx
    reading sources... [ 15%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8rx_6tx
    reading sources... [ 16%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8tx_6rx
    reading sources... [ 17%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8tx_6tx
    reading sources... [ 18%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8rx_6rx
    reading sources... [ 19%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8rx_6tx
    reading sources... [ 20%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8tx_6rx
    reading sources... [ 21%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8tx_6tx
    reading sources... [ 22%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8rx_6rx
    reading sources... [ 23%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8rx_6tx
    reading sources... [ 23%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8tx_6rx
    reading sources... [ 24%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8tx_6tx
    reading sources... [ 25%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8rx_6rx
    reading sources... [ 26%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8rx_6tx
    reading sources... [ 27%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8tx_6rx
    reading sources... [ 28%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8tx_6tx
    reading sources... [ 29%] _generated/programs/program-heartbeat_cvg-cvg_optical_14tx_4rx
    reading sources... [ 30%] _generated/programs/program-heartbeat_cvg-cvg_rx30
    reading sources... [ 31%] _generated/programs/program-heartbeat_cvg-cvg_template_dslots
    reading sources... [ 32%] _generated/programs/program-heartbeat_cvg-cvg_tx16_14rx
    reading sources... [ 32%] _generated/programs/program-heartbeat_cvg-cvg_tx20_10rx
    reading sources... [ 33%] _generated/programs/program-heartbeat_cvg-cvg_tx26_w_enable
    reading sources... [ 34%] _generated/programs/program-heartbeat_cvg-cvg_tx30
    reading sources... [ 35%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_3ph_inverter
    reading sources... [ 36%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_abs_encoder
    reading sources... [ 37%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_resolver_d1_to_d4
    reading sources... [ 38%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_resolver_d5
    reading sources... [ 39%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_temperature_ltc2983
    reading sources... [ 40%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8rx_6rx
    reading sources... [ 41%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8rx_6tx
    reading sources... [ 41%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8tx_6rx
    reading sources... [ 42%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8tx_6tx
    reading sources... [ 43%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8rx_6rx
    reading sources... [ 44%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8rx_6tx
    reading sources... [ 45%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8tx_6rx
    reading sources... [ 46%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8tx_6tx
    reading sources... [ 47%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8rx_6rx
    reading sources... [ 48%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8rx_6tx
    reading sources... [ 49%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8tx_6rx
    reading sources... [ 50%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8tx_6tx
    reading sources... [ 50%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8rx_6rx
    reading sources... [ 51%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8rx_6tx
    reading sources... [ 52%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8tx_6rx
    reading sources... [ 53%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8tx_6tx
    reading sources... [ 54%] _generated/programs/program-heartbeat_cvg-s3c_heartbeat
    reading sources... [ 55%] _generated/programs/program-original-cvg_tx30_stateful
    reading sources... [ 56%] _generated/programs/program-original-optical_14tx_4rx
    reading sources... [ 57%] _generated/programs/program-original-rx30
    reading sources... [ 58%] _generated/programs/program-original-s3c_power_on_debounce
    reading sources... [ 59%] _generated/programs/program-original-s3c_rev6_beta
    reading sources... [ 59%] _generated/programs/program-original-s3c_toolchain_test_program
    reading sources... [ 60%] _generated/programs/program-original-template_dslots
    reading sources... [ 61%] _generated/programs/program-original-tx16_14rx
    reading sources... [ 62%] _generated/programs/program-original-tx20_10rx
    reading sources... [ 63%] _generated/programs/program-original-tx26_w_enable
    reading sources... [ 64%] _generated/programs/program-original-tx30
    reading sources... [ 65%] _generated/programs/program-original-uz_d_3ph_inverter
    reading sources... [ 66%] _generated/programs/program-original-uz_d_abs_encoder
    reading sources... [ 67%] _generated/programs/program-original-uz_d_resolver_d1_to_d4
    reading sources... [ 68%] _generated/programs/program-original-uz_d_resolver_d4_4inverter
    reading sources... [ 68%] _generated/programs/program-original-uz_d_resolver_d4_4inverter_sdifix
    reading sources... [ 69%] _generated/programs/program-original-uz_d_resolver_d5
    reading sources... [ 70%] _generated/programs/program-original-uz_d_resolver_d5_4inverter
    reading sources... [ 71%] _generated/programs/program-original-uz_d_resolver_d5_4inverter_sdifix
    reading sources... [ 72%] _generated/programs/program-original-uz_d_temperature_ltc2983
    reading sources... [ 73%] _generated/programs/program-original-uz_d_voltage_003_5v_tx30
    reading sources... [ 74%] _generated/programs/program-original-uz_d_voltage_013_tx30
    reading sources... [ 75%] _generated/programs/release-heartbeat
    reading sources... [ 76%] _generated/programs/release-heartbeat_cvg
    reading sources... [ 77%] _generated/programs/release-original
    reading sources... [ 77%] api
    reading sources... [ 78%] architecture
    reading sources... [ 79%] builds
    reading sources... [ 80%] commands
    reading sources... [ 81%] configuration
    reading sources... [ 82%] developer/hdl
    reading sources... [ 83%] developer/index
    reading sources... [ 84%] developer/release-management
    reading sources... [ 85%] developer/toolchain
    reading sources... [ 86%] environments
    reading sources... [ 86%] firmware-identity
    reading sources... [ 87%] foss
    reading sources... [ 88%] index
    reading sources... [ 89%] program-documentation
    reading sources... [ 90%] programmer
    reading sources... [ 91%] publishing
    reading sources... [ 92%] quick-start
    reading sources... [ 93%] releases
    reading sources... [ 94%] s3c
    reading sources... [ 95%] simulation
    reading sources... [ 95%] tool-environments
    reading sources... [ 96%] user/index
    reading sources... [ 97%] validation
    reading sources... [ 98%] vhdl-generator
    reading sources... [ 99%] windows
    reading sources... [100%] xo2-library
    
    looking for now-outdated files... none found
    pickling environment... done
    checking consistency... done
    preparing documents... done
    copying assets...
    copying downloadable files... [  0%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/netlist-viewer.html
    copying downloadable files... [  0%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/netlist.svg
    copying downloadable files... [  0%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/netlist.pdf
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/metadata/netlist.json
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/waveform.html
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/waves.vcd
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/metadata/run.json
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/optical_14tx_4rx/metadata/waveform.json
    copying downloadable files... [  1%] ../programs/heartbeat/optical_14tx_4rx/optical_14tx_4rx_tb.py
    copying downloadable files... [  1%] _generated/static/program-assets/heartbeat/rx30/netlist-viewer.html
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/netlist.svg
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/netlist.pdf
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/metadata/netlist.json
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/waveform.html
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/waves.vcd
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/metadata/run.json
    copying downloadable files... [  2%] _generated/static/program-assets/heartbeat/rx30/metadata/waveform.json
    copying downloadable files... [  2%] ../programs/heartbeat/rx30/rx30_tb.py
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/s3c_heartbeat/waveform.html
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/s3c_heartbeat/waves.vcd
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/s3c_heartbeat/metadata/run.json
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/s3c_heartbeat/metadata/waveform.json
    copying downloadable files... [  3%] ../programs/heartbeat/s3c_heartbeat/s3c_heartbeat_tb.py
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/template_dslots/netlist-viewer.html
    copying downloadable files... [  3%] _generated/static/program-assets/heartbeat/template_dslots/netlist.svg
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/netlist.pdf
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/metadata/netlist.json
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/waveform.html
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/waves.vcd
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/metadata/run.json
    copying downloadable files... [  4%] _generated/static/program-assets/heartbeat/template_dslots/metadata/waveform.json
    copying downloadable files... [  4%] ../programs/heartbeat/template_dslots/template_dslots_tb.py
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/netlist-viewer.html
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/netlist.svg
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/netlist.pdf
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/metadata/netlist.json
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/waveform.html
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/waves.vcd
    copying downloadable files... [  5%] _generated/static/program-assets/heartbeat/tx16_14rx/metadata/run.json
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx16_14rx/metadata/waveform.json
    copying downloadable files... [  6%] ../programs/heartbeat/tx16_14rx/tx16_14rx_tb.py
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/netlist-viewer.html
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/netlist.svg
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/netlist.pdf
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/metadata/netlist.json
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/waveform.html
    copying downloadable files... [  6%] _generated/static/program-assets/heartbeat/tx20_10rx/waves.vcd
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx20_10rx/metadata/run.json
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx20_10rx/metadata/waveform.json
    copying downloadable files... [  7%] ../programs/heartbeat/tx20_10rx/tx20_10rx_tb.py
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx26_w_enable/netlist-viewer.html
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx26_w_enable/netlist.svg
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx26_w_enable/netlist.pdf
    copying downloadable files... [  7%] _generated/static/program-assets/heartbeat/tx26_w_enable/metadata/netlist.json
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx26_w_enable/waveform.html
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx26_w_enable/waves.vcd
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx26_w_enable/metadata/run.json
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx26_w_enable/metadata/waveform.json
    copying downloadable files... [  8%] ../programs/heartbeat/tx26_w_enable/tx26_w_enable_tb.py
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx30/netlist-viewer.html
    copying downloadable files... [  8%] _generated/static/program-assets/heartbeat/tx30/netlist.svg
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/netlist.pdf
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/metadata/netlist.json
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/waveform.html
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/waves.vcd
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/metadata/run.json
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30/metadata/waveform.json
    copying downloadable files... [  9%] ../programs/heartbeat/tx30/tx30_tb.py
    copying downloadable files... [  9%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/netlist-viewer.html
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/netlist.svg
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/netlist.pdf
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/metadata/netlist.json
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/waveform.html
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/waves.vcd
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/metadata/run.json
    copying downloadable files... [ 10%] _generated/static/program-assets/heartbeat/tx30_hearbeattesting/metadata/waveform.json
    copying downloadable files... [ 11%] ../programs/heartbeat/tx30_hearbeattesting/tx30_hearbeattesting_tb.py
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/netlist-viewer.html
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/netlist.svg
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/netlist.pdf
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/metadata/netlist.json
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/waveform.html
    copying downloadable files... [ 11%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/waves.vcd
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/metadata/run.json
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_3ph_inverter/metadata/waveform.json
    copying downloadable files... [ 12%] ../programs/heartbeat/uz_d_3ph_inverter/uz_d_3ph_inverter_tb.py
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/netlist-viewer.html
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/netlist.svg
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/netlist.pdf
    copying downloadable files... [ 12%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/metadata/netlist.json
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/waveform.html
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/waves.vcd
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/metadata/run.json
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_abs_encoder/metadata/waveform.json
    copying downloadable files... [ 13%] ../programs/heartbeat/uz_d_abs_encoder/uz_d_abs_encoder_tb.py
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/netlist-viewer.html
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/netlist.svg
    copying downloadable files... [ 13%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/netlist.pdf
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/metadata/netlist.json
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/waveform.html
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/waves.vcd
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/metadata/run.json
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d1_to_d4/metadata/waveform.json
    copying downloadable files... [ 14%] ../programs/heartbeat/uz_d_resolver_d1_to_d4/uz_d_resolver_d1_to_d4_tb.py
    copying downloadable files... [ 14%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/netlist-viewer.html
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/netlist.svg
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/netlist.pdf
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/metadata/netlist.json
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/waveform.html
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/waves.vcd
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/metadata/run.json
    copying downloadable files... [ 15%] _generated/static/program-assets/heartbeat/uz_d_resolver_d5/metadata/waveform.json
    copying downloadable files... [ 16%] ../programs/heartbeat/uz_d_resolver_d5/uz_d_resolver_d5_tb.py
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/netlist-viewer.html
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/netlist.svg
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/netlist.pdf
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/metadata/netlist.json
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/waveform.html
    copying downloadable files... [ 16%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/waves.vcd
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/metadata/run.json
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/uz_d_temperature_ltc2983/metadata/waveform.json
    copying downloadable files... [ 17%] ../programs/heartbeat/uz_d_temperature_ltc2983/uz_d_temperature_ltc2983_tb.py
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/netlist.svg
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 17%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/waveform.html
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/waves.vcd
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 18%] ../programs/heartbeat/voltage_8rx_8rx_8rx_6rx/voltage_8rx_8rx_8rx_6rx_tb.py
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/netlist.svg
    copying downloadable files... [ 18%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/waveform.html
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/waves.vcd
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 19%] ../programs/heartbeat/voltage_8rx_8rx_8rx_6tx/voltage_8rx_8rx_8rx_6tx_tb.py
    copying downloadable files... [ 19%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/netlist.svg
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/waveform.html
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/waves.vcd
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 20%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 20%] ../programs/heartbeat/voltage_8rx_8rx_8tx_6rx/voltage_8rx_8rx_8tx_6rx_tb.py
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/netlist.svg
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/waveform.html
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/waves.vcd
    copying downloadable files... [ 21%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8rx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 22%] ../programs/heartbeat/voltage_8rx_8rx_8tx_6tx/voltage_8rx_8rx_8tx_6tx_tb.py
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/netlist.svg
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 22%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/waveform.html
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/waves.vcd
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 23%] ../programs/heartbeat/voltage_8rx_8tx_8rx_6rx/voltage_8rx_8tx_8rx_6rx_tb.py
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/netlist.svg
    copying downloadable files... [ 23%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/waveform.html
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/waves.vcd
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 24%] ../programs/heartbeat/voltage_8rx_8tx_8rx_6tx/voltage_8rx_8tx_8rx_6tx_tb.py
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 24%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/netlist.svg
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/waveform.html
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/waves.vcd
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 25%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 25%] ../programs/heartbeat/voltage_8rx_8tx_8tx_6rx/voltage_8rx_8tx_8tx_6rx_tb.py
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/netlist.svg
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/waveform.html
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/waves.vcd
    copying downloadable files... [ 26%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8rx_8tx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 27%] ../programs/heartbeat/voltage_8rx_8tx_8tx_6tx/voltage_8rx_8tx_8tx_6tx_tb.py
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/netlist.svg
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 27%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/waveform.html
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/waves.vcd
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 28%] ../programs/heartbeat/voltage_8tx_8rx_8rx_6rx/voltage_8tx_8rx_8rx_6rx_tb.py
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/netlist.svg
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 28%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/waveform.html
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/waves.vcd
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 29%] ../programs/heartbeat/voltage_8tx_8rx_8rx_6tx/voltage_8tx_8rx_8rx_6tx_tb.py
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 29%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/netlist.svg
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/waveform.html
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/waves.vcd
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 30%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 30%] ../programs/heartbeat/voltage_8tx_8rx_8tx_6rx/voltage_8tx_8rx_8tx_6rx_tb.py
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/netlist.svg
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/waveform.html
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/waves.vcd
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 31%] _generated/static/program-assets/heartbeat/voltage_8tx_8rx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 32%] ../programs/heartbeat/voltage_8tx_8rx_8tx_6tx/voltage_8tx_8rx_8tx_6tx_tb.py
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/netlist.svg
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/waveform.html
    copying downloadable files... [ 32%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/waves.vcd
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 33%] ../programs/heartbeat/voltage_8tx_8tx_8rx_6rx/voltage_8tx_8tx_8rx_6rx_tb.py
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/netlist.svg
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 33%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/waveform.html
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/waves.vcd
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 34%] ../programs/heartbeat/voltage_8tx_8tx_8rx_6tx/voltage_8tx_8tx_8rx_6tx_tb.py
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 34%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/netlist.svg
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/waveform.html
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/waves.vcd
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 35%] ../programs/heartbeat/voltage_8tx_8tx_8tx_6rx/voltage_8tx_8tx_8tx_6rx_tb.py
    copying downloadable files... [ 35%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/netlist.svg
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/waveform.html
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/waves.vcd
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 36%] _generated/static/program-assets/heartbeat/voltage_8tx_8tx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 37%] ../programs/heartbeat/voltage_8tx_8tx_8tx_6tx/voltage_8tx_8tx_8tx_6tx_tb.py
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/netlist-viewer.html
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/netlist.svg
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/netlist.pdf
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/metadata/netlist.json
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/waveform.html
    copying downloadable files... [ 37%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/waves.vcd
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/metadata/run.json
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_optical_14tx_4rx/metadata/waveform.json
    copying downloadable files... [ 38%] ../programs/heartbeat_cvg/cvg_optical_14tx_4rx/cvg_optical_14tx_4rx_tb.py
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/netlist-viewer.html
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/netlist.svg
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/netlist.pdf
    copying downloadable files... [ 38%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/metadata/netlist.json
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/waveform.html
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/waves.vcd
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/metadata/run.json
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_rx30/metadata/waveform.json
    copying downloadable files... [ 39%] ../programs/heartbeat_cvg/cvg_rx30/cvg_rx30_tb.py
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/netlist-viewer.html
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/netlist.svg
    copying downloadable files... [ 39%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/netlist.pdf
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/metadata/netlist.json
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/waveform.html
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/waves.vcd
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/metadata/run.json
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_template_dslots/metadata/waveform.json
    copying downloadable files... [ 40%] ../programs/heartbeat_cvg/cvg_template_dslots/cvg_template_dslots_tb.py
    copying downloadable files... [ 40%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/netlist-viewer.html
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/netlist.svg
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/netlist.pdf
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/metadata/netlist.json
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/waveform.html
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/waves.vcd
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/metadata/run.json
    copying downloadable files... [ 41%] _generated/static/program-assets/heartbeat_cvg/cvg_tx16_14rx/metadata/waveform.json
    copying downloadable files... [ 42%] ../programs/heartbeat_cvg/cvg_tx16_14rx/cvg_tx16_14rx_tb.py
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/netlist-viewer.html
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/netlist.svg
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/netlist.pdf
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/metadata/netlist.json
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/waveform.html
    copying downloadable files... [ 42%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/waves.vcd
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/metadata/run.json
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx20_10rx/metadata/waveform.json
    copying downloadable files... [ 43%] ../programs/heartbeat_cvg/cvg_tx20_10rx/cvg_tx20_10rx_tb.py
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/netlist-viewer.html
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/netlist.svg
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/netlist.pdf
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/metadata/netlist.json
    copying downloadable files... [ 43%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/waveform.html
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/waves.vcd
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/metadata/run.json
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx26_w_enable/metadata/waveform.json
    copying downloadable files... [ 44%] ../programs/heartbeat_cvg/cvg_tx26_w_enable/cvg_tx26_w_enable_tb.py
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/netlist-viewer.html
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/netlist.svg
    copying downloadable files... [ 44%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/netlist.pdf
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/metadata/netlist.json
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/waveform.html
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/waves.vcd
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/metadata/run.json
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_tx30/metadata/waveform.json
    copying downloadable files... [ 45%] ../programs/heartbeat_cvg/cvg_tx30/cvg_tx30_tb.py
    copying downloadable files... [ 45%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/netlist-viewer.html
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/netlist.svg
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/netlist.pdf
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/metadata/netlist.json
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/waveform.html
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/waves.vcd
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/metadata/run.json
    copying downloadable files... [ 46%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_3ph_inverter/metadata/waveform.json
    copying downloadable files... [ 46%] ../programs/heartbeat_cvg/cvg_uz_d_3ph_inverter/cvg_uz_d_3ph_inverter_tb.py
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/netlist-viewer.html
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/netlist.svg
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/netlist.pdf
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/metadata/netlist.json
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/waveform.html
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/waves.vcd
    copying downloadable files... [ 47%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/metadata/run.json
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_abs_encoder/metadata/waveform.json
    copying downloadable files... [ 48%] ../programs/heartbeat_cvg/cvg_uz_d_abs_encoder/cvg_uz_d_abs_encoder_tb.py
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/netlist-viewer.html
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/netlist.svg
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/netlist.pdf
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/metadata/netlist.json
    copying downloadable files... [ 48%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/waveform.html
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/waves.vcd
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/metadata/run.json
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/metadata/waveform.json
    copying downloadable files... [ 49%] ../programs/heartbeat_cvg/cvg_uz_d_resolver_d1_to_d4/cvg_uz_d_resolver_d1_to_d4_tb.py
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/netlist-viewer.html
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/netlist.svg
    copying downloadable files... [ 49%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/netlist.pdf
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/metadata/netlist.json
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/waveform.html
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/waves.vcd
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/metadata/run.json
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_resolver_d5/metadata/waveform.json
    copying downloadable files... [ 50%] ../programs/heartbeat_cvg/cvg_uz_d_resolver_d5/cvg_uz_d_resolver_d5_tb.py
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/netlist-viewer.html
    copying downloadable files... [ 50%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/netlist.svg
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/netlist.pdf
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/metadata/netlist.json
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/waveform.html
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/waves.vcd
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/metadata/run.json
    copying downloadable files... [ 51%] _generated/static/program-assets/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/metadata/waveform.json
    copying downloadable files... [ 51%] ../programs/heartbeat_cvg/cvg_uz_d_temperature_ltc2983/cvg_uz_d_temperature_ltc2983_tb.py
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/netlist.svg
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/waveform.html
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/waves.vcd
    copying downloadable files... [ 52%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 53%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6rx/cvg_voltage_8rx_8rx_8rx_6rx_tb.py
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/netlist.svg
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 53%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/waveform.html
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/waves.vcd
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 54%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8rx_8rx_6tx/cvg_voltage_8rx_8rx_8rx_6tx_tb.py
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/netlist.svg
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 54%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/waveform.html
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/waves.vcd
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 55%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6rx/cvg_voltage_8rx_8rx_8tx_6rx_tb.py
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 55%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/netlist.svg
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/waveform.html
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/waves.vcd
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 56%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 56%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8rx_8tx_6tx/cvg_voltage_8rx_8rx_8tx_6tx_tb.py
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/netlist.svg
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/waveform.html
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/waves.vcd
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 57%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 58%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6rx/cvg_voltage_8rx_8tx_8rx_6rx_tb.py
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/netlist.svg
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/waveform.html
    copying downloadable files... [ 58%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/waves.vcd
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 59%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8tx_8rx_6tx/cvg_voltage_8rx_8tx_8rx_6tx_tb.py
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/netlist.svg
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 59%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/waveform.html
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/waves.vcd
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 60%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6rx/cvg_voltage_8rx_8tx_8tx_6rx_tb.py
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 60%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/netlist.svg
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/waveform.html
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/waves.vcd
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 61%] ../programs/heartbeat_cvg/cvg_voltage_8rx_8tx_8tx_6tx/cvg_voltage_8rx_8tx_8tx_6tx_tb.py
    copying downloadable files... [ 61%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/netlist.svg
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/waveform.html
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/waves.vcd
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 62%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 63%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6rx/cvg_voltage_8tx_8rx_8rx_6rx_tb.py
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/netlist.svg
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/waveform.html
    copying downloadable files... [ 63%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/waves.vcd
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 64%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8rx_8rx_6tx/cvg_voltage_8tx_8rx_8rx_6tx_tb.py
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/netlist.svg
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 64%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/waveform.html
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/waves.vcd
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 65%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6rx/cvg_voltage_8tx_8rx_8tx_6rx_tb.py
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/netlist.svg
    copying downloadable files... [ 65%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/waveform.html
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/waves.vcd
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 66%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8rx_8tx_6tx/cvg_voltage_8tx_8rx_8tx_6tx_tb.py
    copying downloadable files... [ 66%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/netlist-viewer.html
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/netlist.svg
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/netlist.pdf
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/metadata/netlist.json
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/waveform.html
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/waves.vcd
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/metadata/run.json
    copying downloadable files... [ 67%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/metadata/waveform.json
    copying downloadable files... [ 68%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6rx/cvg_voltage_8tx_8tx_8rx_6rx_tb.py
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/netlist-viewer.html
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/netlist.svg
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/netlist.pdf
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/metadata/netlist.json
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/waveform.html
    copying downloadable files... [ 68%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/waves.vcd
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/metadata/run.json
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/metadata/waveform.json
    copying downloadable files... [ 69%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8rx_6tx/cvg_voltage_8tx_8tx_8rx_6tx_tb.py
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/netlist-viewer.html
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/netlist.svg
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/netlist.pdf
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/metadata/netlist.json
    copying downloadable files... [ 69%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/waveform.html
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/waves.vcd
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/metadata/run.json
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/metadata/waveform.json
    copying downloadable files... [ 70%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6rx/cvg_voltage_8tx_8tx_8tx_6rx_tb.py
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/netlist-viewer.html
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/netlist.svg
    copying downloadable files... [ 70%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/netlist.pdf
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/metadata/netlist.json
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/waveform.html
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/waves.vcd
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/metadata/run.json
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/metadata/waveform.json
    copying downloadable files... [ 71%] ../programs/heartbeat_cvg/cvg_voltage_8tx_8tx_8tx_6tx/cvg_voltage_8tx_8tx_8tx_6tx_tb.py
    copying downloadable files... [ 71%] _generated/static/program-assets/heartbeat_cvg/s3c_heartbeat/waveform.html
    copying downloadable files... [ 72%] _generated/static/program-assets/heartbeat_cvg/s3c_heartbeat/waves.vcd
    copying downloadable files... [ 72%] _generated/static/program-assets/heartbeat_cvg/s3c_heartbeat/metadata/run.json
    copying downloadable files... [ 72%] _generated/static/program-assets/heartbeat_cvg/s3c_heartbeat/metadata/waveform.json
    copying downloadable files... [ 72%] ../programs/heartbeat_cvg/s3c_heartbeat/s3c_heartbeat_tb.py
    copying downloadable files... [ 72%] _generated/static/program-assets/original/cvg_tx30_stateful/netlist-viewer.html
    copying downloadable files... [ 72%] _generated/static/program-assets/original/cvg_tx30_stateful/netlist.svg
    copying downloadable files... [ 72%] _generated/static/program-assets/original/cvg_tx30_stateful/netlist.pdf
    copying downloadable files... [ 72%] _generated/static/program-assets/original/cvg_tx30_stateful/metadata/netlist.json
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/state-diagram-1.svg
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/state-diagram-1.pdf
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/metadata/state-diagrams.json
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/waveform.html
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/waves.vcd
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/metadata/run.json
    copying downloadable files... [ 73%] _generated/static/program-assets/original/cvg_tx30_stateful/metadata/waveform.json
    copying downloadable files... [ 74%] ../programs/original/cvg_tx30_stateful/cvg_tx30_stateful_tb.py
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/netlist-viewer.html
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/netlist.svg
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/netlist.pdf
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/metadata/netlist.json
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/waveform.html
    copying downloadable files... [ 74%] _generated/static/program-assets/original/optical_14tx_4rx/waves.vcd
    copying downloadable files... [ 75%] _generated/static/program-assets/original/optical_14tx_4rx/metadata/run.json
    copying downloadable files... [ 75%] _generated/static/program-assets/original/optical_14tx_4rx/metadata/waveform.json
    copying downloadable files... [ 75%] ../programs/original/optical_14tx_4rx/optical_14tx_4rx_tb.py
    copying downloadable files... [ 75%] _generated/static/program-assets/original/rx30/netlist-viewer.html
    copying downloadable files... [ 75%] _generated/static/program-assets/original/rx30/netlist.svg
    copying downloadable files... [ 75%] _generated/static/program-assets/original/rx30/netlist.pdf
    copying downloadable files... [ 75%] _generated/static/program-assets/original/rx30/metadata/netlist.json
    copying downloadable files... [ 76%] _generated/static/program-assets/original/rx30/waveform.html
    copying downloadable files... [ 76%] _generated/static/program-assets/original/rx30/waves.vcd
    copying downloadable files... [ 76%] _generated/static/program-assets/original/rx30/metadata/run.json
    copying downloadable files... [ 76%] _generated/static/program-assets/original/rx30/metadata/waveform.json
    copying downloadable files... [ 76%] ../programs/original/rx30/rx30_tb.py
    copying downloadable files... [ 76%] _generated/static/program-assets/original/s3c_power_on_debounce/netlist-viewer.html
    copying downloadable files... [ 76%] _generated/static/program-assets/original/s3c_power_on_debounce/netlist.svg
    copying downloadable files... [ 76%] _generated/static/program-assets/original/s3c_power_on_debounce/netlist.pdf
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/metadata/netlist.json
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/state-diagram-1.svg
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/state-diagram-1.pdf
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/metadata/state-diagrams.json
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/waveform.html
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/waves.vcd
    copying downloadable files... [ 77%] _generated/static/program-assets/original/s3c_power_on_debounce/metadata/run.json
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_power_on_debounce/metadata/waveform.json
    copying downloadable files... [ 78%] ../programs/original/s3c_power_on_debounce/s3c_power_on_debounce_tb.py
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_rev6_beta/netlist-viewer.html
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_rev6_beta/netlist.svg
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_rev6_beta/netlist.pdf
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_rev6_beta/metadata/netlist.json
    copying downloadable files... [ 78%] _generated/static/program-assets/original/s3c_rev6_beta/waveform.html
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_rev6_beta/waves.vcd
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_rev6_beta/metadata/run.json
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_rev6_beta/metadata/waveform.json
    copying downloadable files... [ 79%] ../programs/original/s3c_rev6_beta/s3c_rev6_beta_tb.py
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_toolchain_test_program/netlist-viewer.html
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_toolchain_test_program/netlist.svg
    copying downloadable files... [ 79%] _generated/static/program-assets/original/s3c_toolchain_test_program/netlist.pdf
    copying downloadable files... [ 80%] _generated/static/program-assets/original/s3c_toolchain_test_program/metadata/netlist.json
    copying downloadable files... [ 80%] _generated/static/program-assets/original/s3c_toolchain_test_program/waveform.html
    copying downloadable files... [ 80%] _generated/static/program-assets/original/s3c_toolchain_test_program/waves.vcd
    copying downloadable files... [ 80%] _generated/static/program-assets/original/s3c_toolchain_test_program/metadata/run.json
    copying downloadable files... [ 80%] _generated/static/program-assets/original/s3c_toolchain_test_program/metadata/waveform.json
    copying downloadable files... [ 80%] ../programs/original/s3c_toolchain_test_program/s3c_toolchain_test_program_tb.py
    copying downloadable files... [ 80%] _generated/static/program-assets/original/template_dslots/netlist-viewer.html
    copying downloadable files... [ 80%] _generated/static/program-assets/original/template_dslots/netlist.svg
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/netlist.pdf
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/metadata/netlist.json
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/waveform.html
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/waves.vcd
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/metadata/run.json
    copying downloadable files... [ 81%] _generated/static/program-assets/original/template_dslots/metadata/waveform.json
    copying downloadable files... [ 81%] ../programs/original/template_dslots/template_dslots_tb.py
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/netlist-viewer.html
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/netlist.svg
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/netlist.pdf
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/metadata/netlist.json
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/waveform.html
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/waves.vcd
    copying downloadable files... [ 82%] _generated/static/program-assets/original/tx16_14rx/metadata/run.json
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx16_14rx/metadata/waveform.json
    copying downloadable files... [ 83%] ../programs/original/tx16_14rx/tx16_14rx_tb.py
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/netlist-viewer.html
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/netlist.svg
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/netlist.pdf
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/metadata/netlist.json
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/waveform.html
    copying downloadable files... [ 83%] _generated/static/program-assets/original/tx20_10rx/waves.vcd
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx20_10rx/metadata/run.json
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx20_10rx/metadata/waveform.json
    copying downloadable files... [ 84%] ../programs/original/tx20_10rx/tx20_10rx_tb.py
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx26_w_enable/netlist-viewer.html
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx26_w_enable/netlist.svg
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx26_w_enable/netlist.pdf
    copying downloadable files... [ 84%] _generated/static/program-assets/original/tx26_w_enable/metadata/netlist.json
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx26_w_enable/waveform.html
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx26_w_enable/waves.vcd
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx26_w_enable/metadata/run.json
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx26_w_enable/metadata/waveform.json
    copying downloadable files... [ 85%] ../programs/original/tx26_w_enable/tx26_w_enable_tb.py
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx30/netlist-viewer.html
    copying downloadable files... [ 85%] _generated/static/program-assets/original/tx30/netlist.svg
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/netlist.pdf
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/metadata/netlist.json
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/waveform.html
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/waves.vcd
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/metadata/run.json
    copying downloadable files... [ 86%] _generated/static/program-assets/original/tx30/metadata/waveform.json
    copying downloadable files... [ 86%] ../programs/original/tx30/tx30_tb.py
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/netlist-viewer.html
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/netlist.svg
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/netlist.pdf
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/metadata/netlist.json
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/waveform.html
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/waves.vcd
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/metadata/run.json
    copying downloadable files... [ 87%] _generated/static/program-assets/original/uz_d_3ph_inverter/metadata/waveform.json
    copying downloadable files... [ 88%] ../programs/original/uz_d_3ph_inverter/uz_d_3ph_inverter_tb.py
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/netlist-viewer.html
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/netlist.svg
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/netlist.pdf
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/metadata/netlist.json
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/waveform.html
    copying downloadable files... [ 88%] _generated/static/program-assets/original/uz_d_abs_encoder/waves.vcd
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_abs_encoder/metadata/run.json
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_abs_encoder/metadata/waveform.json
    copying downloadable files... [ 89%] ../programs/original/uz_d_abs_encoder/uz_d_abs_encoder_tb.py
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/netlist-viewer.html
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/netlist.svg
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/netlist.pdf
    copying downloadable files... [ 89%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/metadata/netlist.json
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/waveform.html
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/waves.vcd
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/metadata/run.json
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d1_to_d4/metadata/waveform.json
    copying downloadable files... [ 90%] ../programs/original/uz_d_resolver_d1_to_d4/uz_d_resolver_d1_to_d4_tb.py
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/netlist-viewer.html
    copying downloadable files... [ 90%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/netlist.svg
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/netlist.pdf
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/metadata/netlist.json
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/waveform.html
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/waves.vcd
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/metadata/run.json
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter/metadata/waveform.json
    copying downloadable files... [ 91%] ../programs/original/uz_d_resolver_d4_4inverter/uz_d_resolver_d4_4inverter_tb.py
    copying downloadable files... [ 91%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/netlist-viewer.html
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/netlist.svg
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/netlist.pdf
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/metadata/netlist.json
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/waveform.html
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/waves.vcd
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/metadata/run.json
    copying downloadable files... [ 92%] _generated/static/program-assets/original/uz_d_resolver_d4_4inverter_sdifix/metadata/waveform.json
    copying downloadable files... [ 93%] ../programs/original/uz_d_resolver_d4_4inverter_sdifix/uz_d_resolver_d4_4inverter_sdifix_tb.py
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/netlist-viewer.html
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/netlist.svg
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/netlist.pdf
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/metadata/netlist.json
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/waveform.html
    copying downloadable files... [ 93%] _generated/static/program-assets/original/uz_d_resolver_d5/waves.vcd
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5/metadata/run.json
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5/metadata/waveform.json
    copying downloadable files... [ 94%] ../programs/original/uz_d_resolver_d5/uz_d_resolver_d5_tb.py
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/netlist-viewer.html
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/netlist.svg
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/netlist.pdf
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/metadata/netlist.json
    copying downloadable files... [ 94%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/waveform.html
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/waves.vcd
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/metadata/run.json
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter/metadata/waveform.json
    copying downloadable files... [ 95%] ../programs/original/uz_d_resolver_d5_4inverter/uz_d_resolver_d5_4inverter_tb.py
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/netlist-viewer.html
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/netlist.svg
    copying downloadable files... [ 95%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/netlist.pdf
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/metadata/netlist.json
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/waveform.html
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/waves.vcd
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/metadata/run.json
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_resolver_d5_4inverter_sdifix/metadata/waveform.json
    copying downloadable files... [ 96%] ../programs/original/uz_d_resolver_d5_4inverter_sdifix/uz_d_resolver_d5_4inverter_sdifix_tb.py
    copying downloadable files... [ 96%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/netlist-viewer.html
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/netlist.svg
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/netlist.pdf
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/metadata/netlist.json
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/waveform.html
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/waves.vcd
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/metadata/run.json
    copying downloadable files... [ 97%] _generated/static/program-assets/original/uz_d_temperature_ltc2983/metadata/waveform.json
    copying downloadable files... [ 98%] ../programs/original/uz_d_temperature_ltc2983/uz_d_temperature_ltc2983_tb.py
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/netlist-viewer.html
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/netlist.svg
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/netlist.pdf
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/metadata/netlist.json
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/waveform.html
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/waves.vcd
    copying downloadable files... [ 98%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/metadata/run.json
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_003_5v_tx30/metadata/waveform.json
    copying downloadable files... [ 99%] ../programs/original/uz_d_voltage_003_5v_tx30/uz_d_voltage_003_5v_tx30_tb.py
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/netlist-viewer.html
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/netlist.svg
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/netlist.pdf
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/metadata/netlist.json
    copying downloadable files... [ 99%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/waveform.html
    copying downloadable files... [100%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/waves.vcd
    copying downloadable files... [100%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/metadata/run.json
    copying downloadable files... [100%] _generated/static/program-assets/original/uz_d_voltage_013_tx30/metadata/waveform.json
    copying downloadable files... [100%] ../programs/original/uz_d_voltage_013_tx30/uz_d_voltage_013_tx30_tb.py
    
    copying static files... done
    copying extra files... done
    copying assets: done
    writing output... [  1%] _generated/programs/index
    writing output... [  2%] _generated/programs/program-heartbeat-optical_14tx_4rx
    writing output... [  3%] _generated/programs/program-heartbeat-rx30
    writing output... [  4%] _generated/programs/program-heartbeat-s3c_heartbeat
    writing output... [  5%] _generated/programs/program-heartbeat-template_dslots
    writing output... [  5%] _generated/programs/program-heartbeat-tx16_14rx
    writing output... [  6%] _generated/programs/program-heartbeat-tx20_10rx
    writing output... [  7%] _generated/programs/program-heartbeat-tx26_w_enable
    writing output... [  8%] _generated/programs/program-heartbeat-tx30
    writing output... [  9%] _generated/programs/program-heartbeat-tx30_hearbeattesting
    writing output... [ 10%] _generated/programs/program-heartbeat-uz_d_3ph_inverter
    writing output... [ 11%] _generated/programs/program-heartbeat-uz_d_abs_encoder
    writing output... [ 12%] _generated/programs/program-heartbeat-uz_d_resolver_d1_to_d4
    writing output... [ 13%] _generated/programs/program-heartbeat-uz_d_resolver_d5
    writing output... [ 14%] _generated/programs/program-heartbeat-uz_d_temperature_ltc2983
    writing output... [ 14%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8rx_6rx
    writing output... [ 15%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8rx_6tx
    writing output... [ 16%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8tx_6rx
    writing output... [ 17%] _generated/programs/program-heartbeat-voltage_8rx_8rx_8tx_6tx
    writing output... [ 18%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8rx_6rx
    writing output... [ 19%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8rx_6tx
    writing output... [ 20%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8tx_6rx
    writing output... [ 21%] _generated/programs/program-heartbeat-voltage_8rx_8tx_8tx_6tx
    writing output... [ 22%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8rx_6rx
    writing output... [ 23%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8rx_6tx
    writing output... [ 23%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8tx_6rx
    writing output... [ 24%] _generated/programs/program-heartbeat-voltage_8tx_8rx_8tx_6tx
    writing output... [ 25%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8rx_6rx
    writing output... [ 26%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8rx_6tx
    writing output... [ 27%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8tx_6rx
    writing output... [ 28%] _generated/programs/program-heartbeat-voltage_8tx_8tx_8tx_6tx
    writing output... [ 29%] _generated/programs/program-heartbeat_cvg-cvg_optical_14tx_4rx
    writing output... [ 30%] _generated/programs/program-heartbeat_cvg-cvg_rx30
    writing output... [ 31%] _generated/programs/program-heartbeat_cvg-cvg_template_dslots
    writing output... [ 32%] _generated/programs/program-heartbeat_cvg-cvg_tx16_14rx
    writing output... [ 32%] _generated/programs/program-heartbeat_cvg-cvg_tx20_10rx
    writing output... [ 33%] _generated/programs/program-heartbeat_cvg-cvg_tx26_w_enable
    writing output... [ 34%] _generated/programs/program-heartbeat_cvg-cvg_tx30
    writing output... [ 35%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_3ph_inverter
    writing output... [ 36%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_abs_encoder
    writing output... [ 37%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_resolver_d1_to_d4
    writing output... [ 38%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_resolver_d5
    writing output... [ 39%] _generated/programs/program-heartbeat_cvg-cvg_uz_d_temperature_ltc2983
    writing output... [ 40%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8rx_6rx
    writing output... [ 41%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8rx_6tx
    writing output... [ 41%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8tx_6rx
    writing output... [ 42%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8rx_8tx_6tx
    writing output... [ 43%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8rx_6rx
    writing output... [ 44%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8rx_6tx
    writing output... [ 45%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8tx_6rx
    writing output... [ 46%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8rx_8tx_8tx_6tx
    writing output... [ 47%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8rx_6rx
    writing output... [ 48%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8rx_6tx
    writing output... [ 49%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8tx_6rx
    writing output... [ 50%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8rx_8tx_6tx
    writing output... [ 50%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8rx_6rx
    writing output... [ 51%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8rx_6tx
    writing output... [ 52%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8tx_6rx
    writing output... [ 53%] _generated/programs/program-heartbeat_cvg-cvg_voltage_8tx_8tx_8tx_6tx
    writing output... [ 54%] _generated/programs/program-heartbeat_cvg-s3c_heartbeat
    writing output... [ 55%] _generated/programs/program-original-cvg_tx30_stateful
    writing output... [ 56%] _generated/programs/program-original-optical_14tx_4rx
    writing output... [ 57%] _generated/programs/program-original-rx30
    writing output... [ 58%] _generated/programs/program-original-s3c_power_on_debounce
    writing output... [ 59%] _generated/programs/program-original-s3c_rev6_beta
    writing output... [ 59%] _generated/programs/program-original-s3c_toolchain_test_program
    writing output... [ 60%] _generated/programs/program-original-template_dslots
    writing output... [ 61%] _generated/programs/program-original-tx16_14rx
    writing output... [ 62%] _generated/programs/program-original-tx20_10rx
    writing output... [ 63%] _generated/programs/program-original-tx26_w_enable
    writing output... [ 64%] _generated/programs/program-original-tx30
    writing output... [ 65%] _generated/programs/program-original-uz_d_3ph_inverter
    writing output... [ 66%] _generated/programs/program-original-uz_d_abs_encoder
    writing output... [ 67%] _generated/programs/program-original-uz_d_resolver_d1_to_d4
    writing output... [ 68%] _generated/programs/program-original-uz_d_resolver_d4_4inverter
    writing output... [ 68%] _generated/programs/program-original-uz_d_resolver_d4_4inverter_sdifix
    writing output... [ 69%] _generated/programs/program-original-uz_d_resolver_d5
    writing output... [ 70%] _generated/programs/program-original-uz_d_resolver_d5_4inverter
    writing output... [ 71%] _generated/programs/program-original-uz_d_resolver_d5_4inverter_sdifix
    writing output... [ 72%] _generated/programs/program-original-uz_d_temperature_ltc2983
    writing output... [ 73%] _generated/programs/program-original-uz_d_voltage_003_5v_tx30
    writing output... [ 74%] _generated/programs/program-original-uz_d_voltage_013_tx30
    writing output... [ 75%] _generated/programs/release-heartbeat
    writing output... [ 76%] _generated/programs/release-heartbeat_cvg
    writing output... [ 77%] _generated/programs/release-original
    writing output... [ 77%] api
    writing output... [ 78%] architecture
    writing output... [ 79%] builds
    writing output... [ 80%] commands
    writing output... [ 81%] configuration
    writing output... [ 82%] developer/hdl
    writing output... [ 83%] developer/index
    writing output... [ 84%] developer/release-management
    writing output... [ 85%] developer/toolchain
    writing output... [ 86%] environments
    writing output... [ 86%] firmware-identity
    writing output... [ 87%] foss
    writing output... [ 88%] index
    writing output... [ 89%] program-documentation
    writing output... [ 90%] programmer
    writing output... [ 91%] publishing
    writing output... [ 92%] quick-start
    writing output... [ 93%] releases
    writing output... [ 94%] s3c
    writing output... [ 95%] simulation
    writing output... [ 95%] tool-environments
    writing output... [ 96%] user/index
    writing output... [ 97%] validation
    writing output... [ 98%] vhdl-generator
    writing output... [ 99%] windows
    writing output... [100%] xo2-library
    
    generating indices... genindex py-modindex done
    highlighting module code... [ 12%] cpld_toolchain.toolchain.analysis.netlist
    highlighting module code... [ 25%] cpld_toolchain.toolchain.analysis.waveform
    highlighting module code... [ 38%] cpld_toolchain.toolchain.buildsystem.backends.diamond
    highlighting module code... [ 50%] cpld_toolchain.toolchain.buildsystem.backends.foss
    highlighting module code... [ 62%] cpld_toolchain.toolchain.buildsystem.cli
    highlighting module code... [ 75%] cpld_toolchain.toolchain.buildsystem.model
    highlighting module code... [ 88%] cpld_toolchain.toolchain.buildsystem.workflow
    highlighting module code... [100%] cpld_toolchain.toolchain.simulation.test_simulation
    
    writing additional pages... search done
    copying images... [ 50%] _generated/static/program-assets/original/cvg_tx30_stateful/state-diagram-1.svg
    copying images... [100%] _generated/static/program-assets/original/s3c_power_on_debounce/state-diagram-1.svg
    
    dumping search index in English (code: en)... done
    dumping object inventory... done
    build succeeded.
    
    The HTML pages are in ../../tmp/uz-cpld-docs-paths.
    ✓ • 12.25s

## Activity

    $ git diff --check; git diff --stat
     docs/user/index.rst     |  42 ++-
     docs/windows.rst        |  17 ++
     programs/usercodes.json | 749 ++++++++++++++++++++++++++++++++++++++++++++++--
     3 files changed, 776 insertions(+), 32 deletions(-)
    ✓ • 0ms

## Activity

    $ /opt/uz-cpld-env/bin/python3 -m sphinx -E -q -W --keep-going -b html docs /tmp/uz-cpld-docs-paths > /tmp/uz-cpld-docs-paths.log 2>&1
    ✓ • 10.66s

## Assistant

In Bash, `set DIAMOND_ROOT=...` sets a positional argument, so the environment variable remains unset. Also, `~` does not expand inside quotes.

Use:

```bash
export DIAMOND_ROOT="$HOME/lscc/programmer/diamond/3.14"
echo "$DIAMOND_ROOT"
python -m cpld_toolchain doctor
```

That path must contain full Diamond to build firmware; a standalone Programmer installation won’t include the build tools.

Updated the [user guide](/workspaces/uz_cpld/docs/user/index.rst) and [Windows setup](/workspaces/uz_cpld/docs/windows.rst) with Ubuntu, PowerShell, and Command Prompt syntax, persistent settings, and executable checks.

Validation: Sphinx documentation build and whitespace checks passed.

## User

would it be possible to install openfpga loader somehow with uv for windows and ubuntu or is this not possible at all?

## Assistant

I’ll check how the repository installs openFPGALoader and what native Windows and Ubuntu options are available, including whether `uv` can help automate them.

## Activity

    $ rg -n 'openFPGALoader|openfpgaloader|flasher-build' docs/foss.rst docs/firmware-identity.rst cpld_toolchain -g '*.py' -g '*.sh' -g '*.toml' | head -80
    docs/firmware-identity.rst:83:Diamond identification does not require or invoke OpenOCD or openFPGALoader.
    docs/firmware-identity.rst:91:Managed FOSS programming requires the pinned USERCODE-capable openFPGALoader build included in the toolchain image.
    docs/firmware-identity.rst:92:On a native host, ``make flasher-build`` builds it under ``cpld_toolchain/toolchain/build/openfpgaloader/`` (requires a C++ compiler, CMake, pkg-config, patch, libftdi1/libusb development headers and zlib).
    docs/firmware-identity.rst:94:The managed loader selection prefers that local build, then the image's ``FOSS_ROOT/native/openfpgaloader/`` installation; ``CPLD_OPENFPGALOADER`` can select another verified installation.
    docs/firmware-identity.rst:106:``cpld_toolchain/toolchain/foss/openfpgaloader.json`` pins upstream v1.1.1 and the SHA-256 hashes of its source archive and ``openfpgaloader-usercode.patch``.
    docs/firmware-identity.rst:113:No manual ``make flasher-build`` step is needed in a fresh container.
    docs/firmware-identity.rst:119:Rebuild that installation with native prerequisites, or remove only ``cpld_toolchain/toolchain/build/openfpgaloader/`` to select the bundled loader.
    docs/foss.rst:20:The container installs checksum-pinned OSS CAD Suite 2026-09-16 for Yosys, Project Trellis, OpenOCD and the stock openFPGALoader, alongside GHDL 4.1.0.
    docs/foss.rst:23:It also compiles a separately pinned openFPGALoader v1.1.1 with the repository's MachXO2 USERCODE patch for managed programming.
    docs/foss.rst:37:   make flasher-build
    docs/foss.rst:42:``make flasher-build`` verifies its source and patch checksums and replaces its local installation after compilation and tests pass.
    docs/foss.rst:43:Release and source pins are in ``cpld_toolchain/toolchain/foss/toolchain.json``, ``cpld_toolchain/toolchain/foss/sources.json`` and ``cpld_toolchain/toolchain/foss/openfpgaloader.json``.
    docs/foss.rst:48:The image's patched loader resides in ``$FOSS_ROOT/native/openfpgaloader/``; ``make flasher-build`` installs a workspace override in ``cpld_toolchain/toolchain/build/openfpgaloader/``.
    docs/foss.rst:73:      artifacts -. separate manual step .-> loader[openFPGALoader: optional device programming]
    docs/foss.rst:172:* `openFPGALoader <https://github.com/trabucayre/openFPGALoader>`_
    cpld_toolchain/programmer_helper/program.py:69:    for candidate in (repository_root() / 'cpld_toolchain/toolchain/build/openfpgaloader/openFPGALoader',
    cpld_toolchain/programmer_helper/program.py:70:                      suite / 'native/openfpgaloader/openFPGALoader'):
    cpld_toolchain/programmer_helper/program.py:73:    found = shutil.which('openFPGALoader')
    cpld_toolchain/programmer_helper/program.py:74:    return Path(found) if found else Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite')) / 'bin/openFPGALoader'
    cpld_toolchain/programmer_helper/program.py:79:    # These are openFPGALoader probe indices; Diamond FTUSB ports can enumerate
    cpld_toolchain/programmer_helper/program.py:96:    """Read the zero-based chain index and IDCODE reported by openFPGALoader."""
    cpld_toolchain/programmer_helper/program.py:106:        raise BuildError('No JTAG devices were reported; inspect openFPGALoader output and USB access')
    cpld_toolchain/programmer_helper/program.py:330:        raise BuildError(f'openFPGALoader is missing: {loader_path()}')
    cpld_toolchain/programmer_helper/program.py:418:    parser.add_argument('--cable', help=f'openFPGALoader cable name; default: {DEFAULT_FOSS_CABLE}')
    cpld_toolchain/toolchain/foss/flasher.py:1:"""Build and verify the pinned MachXO2 USERCODE-capable openFPGALoader."""
    cpld_toolchain/toolchain/foss/flasher.py:23:    data = json.loads((BASE / 'openfpgaloader.json').read_text())
    cpld_toolchain/toolchain/foss/flasher.py:24:    if digest(BASE / 'openfpgaloader-usercode.patch') != data['patch_sha256']:
    cpld_toolchain/toolchain/foss/flasher.py:25:        raise ValueError('openFPGALoader patch checksum differs from its tracked pin')
    cpld_toolchain/toolchain/foss/flasher.py:37:        raise ValueError(f'{binary}: a verified USERCODE-capable flasher is required; run make flasher-build or rebuild the container ({exc})') from exc
    cpld_toolchain/toolchain/foss/flasher.py:58:        for name, source, mode in (('openFPGALoader', binary, 0o755), ('LICENSE', license_file, 0o644)):
    cpld_toolchain/toolchain/foss/flasher.py:77:        verify(output / 'openFPGALoader')
    cpld_toolchain/toolchain/foss/flasher.py:100:            raise ValueError('openFPGALoader source checksum mismatch')
    cpld_toolchain/toolchain/foss/flasher.py:102:        subprocess.run(['patch', '-p1', '--batch', '--forward', '-i', str(BASE / 'openfpgaloader-usercode.patch')], cwd=source, check=True)
    cpld_toolchain/toolchain/foss/flasher.py:111:        binary = build_dir / 'openFPGALoader'
    cpld_toolchain/toolchain/foss/flasher.py:117:    print(output / 'openFPGALoader')
    cpld_toolchain/toolchain/foss/flasher.py:122:    parser.add_argument('--output', type=Path, default=ROOT / 'cpld_toolchain/toolchain/build/openfpgaloader')
    cpld_toolchain/toolchain/foss/install.py:32:        for tool in ('yosys', 'nextpnr-machxo2', 'ecppack', 'ecpunpack', 'openFPGALoader'):
    cpld_toolchain/toolchain/tests/test_container.py:21:        for name in ('flasher.py', 'openfpgaloader.json', 'openfpgaloader-usercode.patch',
    cpld_toolchain/toolchain/buildsystem/backends/foss.py:46:                'openFPGALoader': [tool('openFPGALoader'), '--Version']}
    cpld_toolchain/toolchain/tests/test_flasher.py:32:            self.assertEqual((output / 'openFPGALoader').stat().st_mode & 0o777, 0o755)
    cpld_toolchain/toolchain/tests/test_flasher.py:35:            self.assertEqual(flasher.verify(output / 'openFPGALoader')['binary_sha256'], flasher.digest(binary))
    cpld_toolchain/toolchain/tests/test_flasher.py:49:            binary = Path(directory) / 'openFPGALoader'
    cpld_toolchain/toolchain/commands.py:77:    'flasher-build': spec('Programmer', 'flasher-build', 'Compile the optional FOSS programmer utility locally', {'jobs'}),
    cpld_toolchain/toolchain/commands.py:81:    'release-current': ('release-select', {}), 'flasher': ('flasher-build', {}),
    cpld_toolchain/toolchain/commands.py:246:    if sys.platform == 'win32' and action == 'flasher-build':
    cpld_toolchain/toolchain/commands.py:292:    if action == 'flasher-build':
    cpld_toolchain/toolchain/doctor.py:165:        ('openFPGALoader', loader_path(), ['--Version']),
    cpld_toolchain/toolchain/doctor.py:185:        pins.append(Finding('Patched flasher receipt', 'NOT CHECKED', 'openFPGALoader is missing'))
    ✓ • 0ms

## Activity

    Searched the web for site.trabucayre.github.io/openFPGALoader guide install windows ubuntu, site.docs.astral.sh uv tools Python packages executables

## Activity

    Opened https://trabucayre.github.io/openFPGALoader/guide/install.html

## Activity

    $ sed -n '238,253p' cpld_toolchain/toolchain/commands.py; sed -n '85,115p' docs/firmware-identity.rst
    def plan(action, options, *, root=ROOT, cwd=None):
        """Resolve a command without writes, tool startup, or hardware access."""
        action, options = normalize(action, options)
        root = Path(root).resolve()
        cwd = Path(cwd or Path.cwd()).resolve()
        backend = options.get('backend', 'diamond')
        build_backend = options.get('build_backend', backend)
        programmer_backend = options.get('programmer_backend', backend)
        if sys.platform == 'win32' and action == 'flasher-build':
            raise BuildError('The pinned FOSS source build requires Linux; use the toolchain container or WSL')
        if action == 'image':
            return [Invocation((options.get('container_engine', 'docker'), 'build',
                                '--platform', options.get('container_platform', 'linux/amd64'),
                                '--target', 'toolchain', '-f', '.devcontainer/Dockerfile',
                                '-t', options.get('toolchain_image', 'uz-cpld-toolchain'), '.'), root)]
        python = sys.executable
    
    Only explicit ``programmer_backend=foss`` (or ``backend=foss`` on a programmer command) selects OpenOCD from the pinned OSS CAD Suite for identification.
    For that backend, native hosts need OpenOCD on ``PATH``, under ``FOSS_ROOT/bin``, or at ``CPLD_OPENOCD``.
    The supported reader wiring is the UltraZohm FT4232 channel B at 1 MHz: Diamond ``probe_index=1`` or FOSS ``probe_index=0``.
    For multiple probes, the FOSS interface accepts ``usb_serial=SERIAL``; an ambiguous unselected probe is rejected.
    Other cable types or probe-index mappings require extending the reader and are rejected before managed programming starts.
    Managed FOSS programming requires the pinned USERCODE-capable openFPGALoader build included in the toolchain image.
    On a native host, ``make flasher-build`` builds it under ``cpld_toolchain/toolchain/build/openfpgaloader/`` (requires a C++ compiler, CMake, pkg-config, patch, libftdi1/libusb development headers and zlib).
    This command builds the programming executable only; it does not build CPLD firmware, access USB or program a device.
    The managed loader selection prefers that local build, then the image's ``FOSS_ROOT/native/openfpgaloader/`` installation; ``CPLD_OPENFPGALOADER`` can select another verified installation.
    The wrapper checks the binary and patch provenance and parses every selected input before accessing USB.
    Stock or modified loaders are rejected before flash writes.
    The patch accepts ``--usercode``, writes the MachXO2 register, waits for completion and verifies it before finishing flash programming.
    JEDEC input must contain the same code; bitstream input uses the code from verified build provenance.
    FOSS builds emit compressed bitstreams, as required by the MachXO2 internal-flash parser.
    Plain ``scan`` retains its existing cable options.
    The Linux FTDI interface lock and driver restoration also cover identity reads.
    
    Flasher builds and container rebuilds
    -------------------------------------
    
    ``cpld_toolchain/toolchain/foss/openfpgaloader.json`` pins upstream v1.1.1 and the SHA-256 hashes of its source archive and ``openfpgaloader-usercode.patch``.
    ``flasher.py`` verifies both, applies the patch to a fresh source tree, runs the mocked USERCODE write/readback tests and compiles Lattice/FTDI support.
    It installs a binary reporting ``v1.1.1-uz-usercode1``, its license and a readable ``usercode-support.json`` receipt containing the pin and binary checksum.
    Concurrent installers serialize publication of the binary and receipt.
    
    The Docker builder stage runs this automatically and copies the installation into the runtime image.
    Rebuilding the image reapplies the patch and recompiles when the source pin or patch changes; unchanged inputs can reuse Docker's cached layer.
    No manual ``make flasher-build`` step is needed in a fresh container.
    The runtime lacks the compiler/development headers from the builder stage; use a container rebuild to update its bundled loader.
    
    ✓ • 0ms

## Assistant

**Yes, we could automate installation through our Python setup, with `uv` running it.** However, openFPGALoader is a native C++ executable. `uv tool install` installs tools distributed as Python packages; it doesn’t directly replace `apt` or MSYS2. [uv documentation](https://docs.astral.sh/uv/concepts/tools/)

Upstream currently supports these installation routes:

| Platform | Installation |
|---|---|
| Ubuntu | `sudo apt install openfpgaloader` |
| Windows, through MSYS2 | `pacman -S mingw-w64-ucrt-x86_64-openFPGALoader` |

These install the standard upstream version. [Upstream instructions](https://trabucayre.github.io/openFPGALoader/guide/install.html)

**For this repository, we need our patched version** for MachXO2 USERCODE writing and verification. Managed FOSS programming rejects stock binaries. Currently, Ubuntu can build that version using:

```bash
uv run python -m cpld_toolchain flasher-build
```

Native compiler and library dependencies must already be installed. Our installer currently rejects native Windows builds.

For an easy installation on both platforms, I recommend extending our setup to download **prebuilt, checksum-verified patched binaries** for Windows and Linux, including their required runtime libraries and provenance receipt. `uv` could run that installer. Alternatively, we could package those binaries in platform-specific Python wheels for direct installation through `uv`.

Both approaches are feasible. USB drivers on Windows and device permissions on Ubuntu would still need OS-level setup, and our Windows FOSS programming workflow would need adaptation and hardware validation.

## User

openfpgaloader publishes binaries here: https://github.com/trabucayre/openFPGALoader/releases/tag/v1.1.1 and the install instructions state that they generate a standalone .exe file

## Assistant

I’ll check the v1.1.1 release assets and distinguish what the standalone executable solves from what our USERCODE patch still requires.

## Activity

    Opened https://github.com/trabucayre/openFPGALoader/releases/tag/v1.1.1

## Assistant

You’re right—my previous answer understated the available binary options.

The [v1.1.1 release assets](https://github.com/trabucayre/openFPGALoader/releases/expanded_assets/v1.1.1) include Ubuntu 22.04/24.04 archives and Windows MSYS2 packages. The [current build instructions](https://trabucayre.github.io/openFPGALoader/guide/install.html#windows) also describe producing a standalone Windows `.exe` that depends only on standard Windows system DLLs. That standalone build capability doesn’t necessarily mean the older release’s MSYS2 packages are equally self-contained.

**We can automate downloading and installing binaries from our Python setup, invoked through `uv`.** Users wouldn’t need a compiler, and a standalone Windows build wouldn’t require MSYS2 at runtime.

The remaining constraint is specific to our repository: upstream v1.1.1 lacks our MachXO2 USERCODE patch. To preserve the current programming checks, we would build patched binaries once in CI and distribute them with checksums and provenance. Setup could then download the appropriate binary for Windows or Ubuntu.

So yes: an automatic binary installation is feasible. `uv` can run the installer; packaging openFPGALoader as a Python wheel is optional.
