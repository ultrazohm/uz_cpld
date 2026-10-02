"""Temporary Linux/CI reproducer: no retries, synthesis, or identity allocation."""
import argparse
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import signal
import subprocess
import sys
import tempfile
import time
import xml.etree.ElementTree as ET

from toolchain.buildsystem.backends import diamond
from toolchain.buildsystem.identity import constraint_text, read_registry
from toolchain.buildsystem.model import BuildError, load_build
from toolchain.buildsystem.workflow import locked

ROOT = Path(__file__).resolve().parents[1]
ENV_KEYS = ('HOME', 'USER', 'LOGNAME', 'TMPDIR', 'PATH', 'LD_LIBRARY_PATH',
            'TCL_LIBRARY', 'FOUNDRY', 'DIAMOND_ROOT', 'QT_PLUGIN_PATH',
            'QT_QPA_PLATFORM', 'DISPLAY', 'WAYLAND_DISPLAY')
GDB_REPORT = ['thread apply all bt', 'info sharedlibrary', 'info proc mappings']
GDB_SCRIPT = '''set pagination off
set confirm off
set disable-randomization off
python
import gdb
def exited(event):
    print("UZ_CPLD_GDB_EXIT=" + str(getattr(event, "exit_code", "unknown")))
def stopped(event):
    if isinstance(event, gdb.SignalEvent):
        print("UZ_CPLD_GDB_SIGNAL=" + event.stop_signal)
gdb.events.exited.connect(exited)
gdb.events.stop.connect(stopped)
end
run
python
if gdb.selected_inferior().pid:
    for command in ("thread apply all bt", "info sharedlibrary", "info proc mappings"):
        gdb.execute(command)
end
'''


def digest(path):
    value = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            value.update(chunk)
    return value.hexdigest()


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + '\n')


def capture(argv, **kwargs):
    try:
        result = subprocess.run(argv, stdin=subprocess.DEVNULL, capture_output=True,
                                text=True, errors='replace', timeout=30, **kwargs)
        return {'returncode': result.returncode, 'output': result.stdout + result.stderr}
    except (OSError, subprocess.TimeoutExpired) as exc:
        return {'error': str(exc)}


def fingerprint(binary):
    """Allowlist environment data; never collect credentials or license contents."""
    import pwd
    try:
        account = pwd.getpwuid(os.getuid()).pw_name
    except KeyError:
        account = None
    bindir = binary.parent
    probe = ('import json,os; print(json.dumps({k:os.environ[k] for k in '
             + repr(ENV_KEYS) + ' if k in os.environ}))')
    vendor = capture(['bash', '-c', 'bindir=$1; source "$bindir/diamond_env"; exec "$2" -c "$3"',
                      'diamond-environment', str(bindir), sys.executable, probe])
    env = diamond.environment(binary)
    vendor_env = json.loads(vendor['output']) if vendor.get('returncode') == 0 else {}
    env.update(vendor_env)
    libraries = capture(['ldd', str(bindir / 'pnmainc')], env=env)
    paths = {binary, bindir / 'pnmainc', bindir / 'diamond_env'}
    paths.update(Path(p) for p in re.findall(r'(/\S+)\s+\(0x', libraries.get('output', '')))
    system_files = ('/proc/self/limits', '/proc/self/cgroup', '/proc/meminfo', '/proc/sys/kernel/core_pattern',
                    '/proc/sys/kernel/randomize_va_space', '/sys/fs/cgroup/memory.max',
                    '/sys/fs/cgroup/memory.events', '/sys/fs/cgroup/cpu.max',
                    '/sys/fs/cgroup/pids.max')
    return {'platform': platform.platform(), 'uid': os.getuid(), 'gid': os.getgid(), 'account': account,
            'groups': os.getgroups(), 'cpu_affinity': sorted(os.sched_getaffinity(0)),
            'environment': {k: os.environ[k] for k in ENV_KEYS if k in os.environ},
            'vendor_environment': vendor_env, 'vendor_probe': vendor if not vendor_env else None,
            'launcher': str(binary), 'diamond_version': diamond.installed_version(binary),
            'startup_libraries': libraries,
            'file_sha256': {str(p): digest(p) for p in sorted(paths) if p.is_file()},
            'system_files': {p: Path(p).read_text() for p in system_files if Path(p).is_file()},
            'cpu': capture(['lscpu']), 'mounts': capture(['findmnt', '-T', str(ROOT)]),
            'packages': capture(['dpkg-query', '-W']),
            'git_revision': capture(['git', '-C', str(ROOT), 'rev-parse', 'HEAD'])}


def gdb_result(output):
    """GDB's exit status is not necessarily the inferior's exit status."""
    events = re.findall(r'UZ_CPLD_GDB_(EXIT|SIGNAL)=(\S+)', output)
    for kind, value in reversed(events):
        if kind == 'SIGNAL':
            return -int(getattr(signal, value)) if hasattr(signal, value) else None
        if value.isdecimal():
            return int(value)
    return None


def execute(binary, project, log, *, env, debugger, timeout):
    argv = [str(binary), 'prepare.tcl']
    if debugger:
        commands = project / 'diagnose.gdb'
        commands.write_text(GDB_SCRIPT)
        # Follow the vendor shell wrapper's exec into pnmainc, preserving its setup.
        argv = ['gdb', '--batch', '--nx', '-x', str(commands), '--args',
                '/bin/bash', str(binary), 'prepare.tcl']
    started = time.monotonic()
    with log.open('w') as stream:
        proc = subprocess.Popen(argv, cwd=project, env=env, stdin=subprocess.DEVNULL,
                                stdout=stream, stderr=subprocess.STDOUT, start_new_session=True)
        try:
            code = proc.wait(timeout=timeout)
            timed_out = False
        except subprocess.TimeoutExpired:
            os.killpg(proc.pid, signal.SIGKILL)
            proc.wait()
            code, timed_out = None, True
    output = log.read_text(errors='replace')
    if debugger and not timed_out:
        code = gdb_result(output)
    markers = [line for line in output.splitlines() if line.startswith('UZ_CPLD_DIAMOND_')]
    return {'returncode': code, 'timeout': timed_out, 'seconds': time.monotonic() - started,
            'last_marker': markers[-1] if markers else None,
            'resource_counters': {name: Path('/sys/fs/cgroup', name).read_text()
                                  for name in ('memory.events', 'memory.current', 'pids.current')
                                  if Path('/sys/fs/cgroup', name).is_file()},
            'status': 'success' if code == 0 and not timed_out else 'failed'}


def inputs(build, project, seed, trace):
    if seed:
        result = {name: (seed / name).read_bytes()
                  for name in ('baseline.sty', 'constraints.lpf', 'prepare.tcl')}
        if trace:
            script = result['prepare.tcl'].decode()
            start, end = 'if {[catch {\n', '\n} message]} {'
            if script.count(start) != 1 or script.count(end) != 1:
                raise BuildError('Seed must contain a generated Diamond preparation script')
            lines = script.split(start, 1)[1].split(end, 1)[0].splitlines()
            result['prepare.tcl'] = diamond.wrap(lines, trace=True).encode()
        return result
    # Reuse a recorded USERID solely to prepare the project; allocate nothing.
    entry = read_registry(build.root)['programs'][build.qualified_name]
    revisions = [int(r) for r, b in entry['builds'].items()
                 if b['backend'] == 'diamond' and b['target'] == build.target]
    if not revisions:
        raise BuildError('No recorded Diamond identity; supply --seed-project from diagnostics')
    identity = {'usercode': f'{(entry["number"] << 16) | max(revisions):08X}'}
    return {'baseline.sty': build.strategy.read_bytes(),
            'constraints.lpf': constraint_text(build, identity).encode(),
            'prepare.tcl': diamond.wrap(diamond.preparation_commands(build, project), trace=trace).encode()}


def replay(args):
    build = load_build(ROOT, args.program, backend='diamond')
    binary = diamond.launcher()
    if args.mode == 'gdb' and not shutil.which('gdb'):
        raise BuildError('GDB is required for --mode gdb; use the temporary diagnostic image')
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    write_json(output / 'environment.json', fingerprint(binary))
    env = diamond.environment(binary)
    env.pop('DISPLAY', None)
    env.pop('WAYLAND_DISPLAY', None)
    if args.variant == 'private-home':
        home = output / 'home'
        home.mkdir()
        env['HOME'] = str(home)
    attempts = []
    cores_kept = 0
    with locked(build):
        build.build_root.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(prefix='diamond-reproducer-', dir=build.build_root) as tmp:
            work = Path(tmp)
            project = work / 'project'
            seed = inputs(build, project, args.seed_project, args.mode != 'plain')
            write_json(output / 'inputs.json', {
                'program': build.qualified_name, 'target': build.target,
                'seed_project': str(args.seed_project) if args.seed_project else None,
                'inputs_sha256': {k: hashlib.sha256(v).hexdigest() for k, v in seed.items()},
                'source_sha256': {str(s.path.relative_to(ROOT)): digest(s.path) for s in build.sources},
                'mode': args.mode, 'variant': args.variant,
                'effective_environment': {k: env[k] for k in ENV_KEYS if k in env}})
            for number in range(1, args.attempts + 1):
                destination = output / f'attempt-{number:04d}'
                destination.mkdir()
                project.mkdir()
                for name, contents in seed.items():
                    (project / name).write_bytes(contents)
                with tempfile.TemporaryDirectory(prefix='diamond-tmp-', dir=work) as temp:
                    if args.variant == 'fresh-tmp':
                        env['TMPDIR'] = temp
                    result = execute(binary, project, destination / 'diamond.log', env=env,
                                     debugger=args.mode == 'gdb', timeout=args.timeout)
                    if result['status'] == 'success':
                        try:
                            implementation = ET.parse(project / 'firmware.ldf').getroot().find('Implementation')
                            if implementation is None or not result['last_marker']:
                                raise ValueError('Missing saved implementation or Tcl startup marker')
                        except (OSError, ValueError, ET.ParseError) as exc:
                            result.update(status='failed', validation_error=str(exc))
                    result['attempt'] = number
                    result['tmpdir'] = env.get('TMPDIR')
                    # Retain fresh temporary state only for failed executions.
                    if result['status'] != 'success' and args.variant == 'fresh-tmp':
                        shutil.copytree(temp, destination / 'temporary-state', symlinks=True)
                write_json(destination / 'result.json', result)
                attempts.append(result)
                for core in sorted(project.glob('core.*')):
                    if cores_kept >= 3:
                        core.unlink()
                    else:
                        cores_kept += 1
                # Retain generated state (and any core) before the next fresh attempt.
                shutil.move(str(project), destination / 'project')
                summary = {'program': build.qualified_name, 'mode': args.mode, 'variant': args.variant,
                           'attempts': len(attempts), 'statuses': dict(Counter(r['status'] for r in attempts)),
                           'segfaults': sum(r['returncode'] == -signal.SIGSEGV for r in attempts),
                           'results': attempts}
                write_json(output / 'summary.json', summary)
                print(f'{args.mode}/{args.variant} {number}/{args.attempts}: '
                      f'{result["status"]}, exit={result["returncode"]}, {result["last_marker"]}', flush=True)
    return int(any(r['status'] != 'success' for r in attempts))


def backtraces(output, core_root=None):
    """Analyze ordinary-run cores without publishing process memory."""
    binary = diamond.launcher().parent / 'pnmainc'
    write_json(output / 'debugger-environment.json', fingerprint(diamond.launcher()))
    results = []
    for core in sorted((core_root or output).rglob('core.*')):
        if not core.is_file():
            continue
        argv = ['gdb', '--batch', '--nx', '-ex', 'set pagination off']
        for command in GDB_REPORT:
            argv += ['-ex', command]
        argv += [str(binary), str(core)]
        result = capture(argv)
        core.with_name('backtrace-' + core.name + '.log').write_text(result.get('output', result.get('error', '')))
        results.append({'core': str(core), 'returncode': result.get('returncode'), 'error': result.get('error')})
    name = 'backtraces-catalog.json' if core_root else 'backtraces.json'
    write_json(output / name, {'cores': len(results), 'results': results})
    return int(any(r['returncode'] != 0 for r in results))


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('replay', 'backtraces'))
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--program', default='original/uz_d_voltage_013_tx30')
    parser.add_argument('--attempts', type=int, default=100)
    parser.add_argument('--mode', choices=('plain', 'traced', 'gdb'), default='plain')
    parser.add_argument('--variant', choices=('baseline', 'private-home', 'fresh-tmp'), default='baseline')
    parser.add_argument('--seed-project', type=Path)
    parser.add_argument('--core-root', type=Path, help='Core search directory for backtraces (default: output)')
    parser.add_argument('--timeout', type=int, default=30)
    args = parser.parse_args(argv)
    if sys.platform != 'linux':
        parser.error('This temporary diagnostic tool requires Linux')
    if not 1 <= args.attempts <= 1000 or not 1 <= args.timeout <= 300:
        parser.error('Use 1–1000 attempts and a 1–300 second timeout')
    try:
        return replay(args) if args.action == 'replay' else backtraces(args.output.resolve(), args.core_root)
    except (OSError, ValueError, BuildError) as exc:
        print(f'Diamond diagnostic failed: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
