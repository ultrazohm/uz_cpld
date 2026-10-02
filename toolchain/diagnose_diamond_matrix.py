"""Temporary paired CI experiments; never builds/publishes firmware or changes identities."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

from toolchain.diagnose_diamond import write_json


# Each job owns a VM. Two blocks reverse arm order to expose ordering effects.
CASES = {
    'reference': 'Identical control/candidate; measure ordinary variability',
    'account': 'Add a passwd entry for the same UID/GID; keep HOME=/tmp',
    'home': 'Private writable HOME; keep the unnamed UID',
    'tmp': 'Fresh TMPDIR for each attempt',
    'cpu': 'Pin Diamond and its children to one available CPU',
    'stack': 'Unlimited stack instead of the inherited stack limit',
    'shm': 'Increase /dev/shm to 1 GiB',
    'memory': 'Limit RAM to 2 GiB with swap allowance unchanged; resource probe',
    'perturb': 'Fill allocated/freed memory using MALLOC_PERTURB_=165',
    'tcache': 'Disable glibc per-thread allocation cache',
    'aslr': 'Disable address randomization on the disposable host for candidate only',
    'seccomp': 'Disable only the container syscall filter for candidate',
    'close-delay': 'Wait 250 ms after saving, before explicit close',
    'event-loop': 'Process pending Tcl events after saving, before close',
    'no-strategy': 'Omit strategy import/selection/options; lifecycle probe',
    'no-engine': 'Omit explicit synthesis-engine selection; lifecycle probe',
    'minimal': 'Only create, save and close a project; lifecycle probe',
    'memcheck': 'Instrument vendor launcher and children with Valgrind Memcheck',
    'strace': 'Trace failed memory/process syscalls and signals',
    'installation-mount': 'Same image/vendor bytes, read-only bind mount instead of image storage',
    'vendor-environment': 'Source diamond_env before the Python driver, as in the original image entrypoint',
    'qt-environment': 'Unset QT_GRAPHICSSYSTEM=native inherited from the CI base image',
    'full-installation': 'Same CI runtime with mounted pruned versus full Diamond installations',
    'local-image': 'CI base versus default Ubuntu base, both using the same mounted Diamond copy',
    'host24': 'Reference A/A on Ubuntu 24.04 host; compare with Ubuntu 22.04 reference job',
}
LIFECYCLE = {'close-delay', 'event-loop', 'no-strategy', 'no-engine', 'minimal'}
PROBES = {'reference', 'host24', 'memory', 'perturb', 'memcheck', 'strace'} | LIFECYCLE


def command(argv, *, check=True, **kwargs):
    print('+', ' '.join(map(str, argv)), flush=True)
    return subprocess.run(list(map(str, argv)), check=check, **kwargs)


def output(argv):
    return command(argv, capture_output=True, text=True).stdout.strip()


def build(base, tag):
    command(['docker', 'build', '--platform', 'linux/amd64', '--target', 'toolchain',
             '--build-arg', 'TOOLCHAIN_BASE=' + base, '-f', '.devcontainer/Dockerfile', '-t', tag, '.'])


def docker_layer(image, tag, text, directory):
    path = directory / (tag + '.Dockerfile')
    path.write_text('FROM ' + image + '\nUSER root\n' + text + '\nUSER vscode\n')
    command(['docker', 'build', '-f', path, '-t', tag, '.'])


def copy_installation(image, target):
    container = output(['docker', 'create', image])
    try:
        command(['docker', 'cp', '-L', container + ':/opt/diamond', target])
    finally:
        command(['docker', 'rm', '-f', container], check=False)


def setup(case, root, scratch, base, ubuntu, full=None):
    build(base, 'diamond-matrix-control')
    images = dict.fromkeys(('control', 'candidate'), 'diamond-matrix-control')
    installation = None
    if case in ('memcheck', 'strace'):
        docker_layer(images['control'], 'diamond-matrix-instrumented',
                     'RUN apt-get update && apt-get install -y --no-install-recommends valgrind strace '
                     '&& rm -rf /var/lib/apt/lists/*', scratch)
        images = dict.fromkeys(images, 'diamond-matrix-instrumented')
    if case in ('installation-mount', 'local-image', 'full-installation'):
        # The licensed installation never enters the checkout, Docker build context or artifacts.
        installation = scratch / 'diamond'
        copy_installation(images['control'], installation)
        if case == 'full-installation':
            command(['docker', 'pull', full])
            copy_installation(full, scratch / 'diamond-full')
        if case == 'local-image':
            build(ubuntu, 'diamond-matrix-ubuntu')
            # Keep resolved vendor paths identical, so the tested boundary is the base image.
            docker_layer('diamond-matrix-ubuntu', 'diamond-matrix-local',
                         'RUN test ! -e /opt/diamond && ln -s /opt/lattice /opt/diamond', scratch)
            images['candidate'] = 'diamond-matrix-local'
    if case == 'account':
        passwd = output(['docker', 'run', '--rm', '--entrypoint', 'cat', images['control'], '/etc/passwd'])
        if any(line.split(':')[2] == str(os.getuid()) for line in passwd.splitlines()):
            raise ValueError('Control UID already has a passwd entry; account experiment is invalid')
        (scratch / 'passwd').write_text(passwd + f'\ndiamondtest:x:{os.getuid()}:{os.getgid()}::/tmp:/bin/bash\n')
    write_json(root / 'images.json', {arm: {'tag': image, 'id': output(
        ['docker', 'image', 'inspect', '--format', '{{.Id}}', image])} for arm, image in images.items()})
    return images, installation


def options(case, candidate, scratch, installation):
    docker, replay = [], []
    if case in ('memcheck', 'strace'):
        docker += ['--cap-add', 'SYS_PTRACE']  # Identical permissions in both arms.
    if installation and (candidate or case in ('local-image', 'full-installation')):
        source = scratch / 'diamond-full' if case == 'full-installation' and candidate else installation
        docker += ['--mount', f'type=bind,source={source},target=/opt/lattice,readonly']
    if case == 'full-installation':
        docker += ['--mount', f'type=bind,source={installation / "license/license.dat"},target=/run/diamond-license.dat,readonly',
                   '--env', 'LM_LICENSE_FILE=/run/diamond-license.dat']
    if not candidate:
        return docker, replay
    if case == 'account':
        docker += ['--mount', f'type=bind,source={scratch / "passwd"},target=/etc/passwd,readonly']
    elif case in ('home', 'tmp'):
        replay += ['--variant', {'home': 'private-home', 'tmp': 'fresh-tmp'}[case]]
    elif case == 'cpu':
        docker += ['--cpuset-cpus', str(min(os.sched_getaffinity(0)))]
    elif case == 'stack':
        docker += ['--ulimit', 'stack=-1']
    elif case == 'shm':
        docker += ['--shm-size', '1g']
    elif case == 'memory':
        docker += ['--memory', '2g', '--memory-swap', '-1']
    elif case == 'perturb':
        docker += ['--env', 'MALLOC_PERTURB_=165']
    elif case == 'tcache':
        docker += ['--env', 'GLIBC_TUNABLES=glibc.malloc.tcache_count=0']
    elif case == 'seccomp':
        docker += ['--security-opt', 'seccomp=unconfined']
    elif case in LIFECYCLE:
        replay += ['--preparation', case]
    return docker, replay


def host_evidence(path):
    result = command(['sudo', '-n', 'dmesg', '--ctime'], check=False, capture_output=True, text=True)
    lines = [line for line in result.stdout.splitlines()
             if any(word in line.lower() for word in ('oom', 'out of memory', 'killed process', 'segfault', 'pnmainc'))]
    write_json(path, {'returncode': result.returncode, 'events': lines, 'stderr': result.stderr})


def run(args):
    root = args.output.resolve()
    root.mkdir(parents=True, exist_ok=False)
    write_json(root / 'experiment.json', {'case': args.case, 'description': CASES[args.case],
        'base': args.base, 'ubuntu_base': args.ubuntu, 'full_base': args.full, 'attempts_per_block': args.attempts,
        'host': output(['uname', '-a']),
        'local_image_note': 'Default Dockerfile supply path, not a copy of the actual local devcontainer; '
                            'uses CI Diamond bytes, not the host-supplied local installation.'})
    if args.case == 'full-installation' and not args.full:
        (root / 'blocked.txt').write_text('No DIAMOND_FULL_IMAGE repository variable supplied. '
            'A private image containing the full 3.14 installation at /opt/diamond is needed; '
            'this comparison has NOT run. All other matrix jobs are independent.\n')
        return report(root)
    aslr = output(['sysctl', '-n', 'kernel.randomize_va_space'])
    (root / 'original-aslr.txt').write_text(aslr + '\n')
    host_evidence(root / 'host-before.json')
    with tempfile.TemporaryDirectory(prefix='diamond-matrix-') as temporary:
        scratch = Path(temporary)
        images, installation = setup(args.case, root, scratch, args.base, args.ubuntu, args.full)
        for block, order in enumerate((('control', 'candidate'), ('candidate', 'control')), 1):
            for arm in order:
                candidate = arm == 'candidate'
                mode = args.case if candidate and args.case in ('memcheck', 'strace') else 'traced'
                attempts = min(args.attempts, 10) if mode == 'memcheck' else args.attempts
                docker, replay = options(args.case, candidate, scratch, installation)
                destination = root / f'{arm}-{block}'
                name = f'diamond-{args.case}-{arm}-{block}'
                prefix = []
                if args.case == 'vendor-environment' and candidate:
                    prefix = ['bash', '-e', '-c', 'bindir=/opt/lattice/bin/lin64; cd "$bindir"; source ./diamond_env; cd /work; exec "$@"',
                              'diamond-environment']
                elif args.case == 'qt-environment' and candidate:
                    prefix = ['env', '-u', 'QT_GRAPHICSSYSTEM']
                argv = ['docker', 'run', '--name', name, '--init', '--platform', 'linux/amd64',
                        '--ulimit', 'core=0', '--network=name=bridge,mac-address=10:91:d1:3d:14:ae',
                        '--user', f'{os.getuid()}:{os.getgid()}', '--env', 'HOME=/tmp',
                        '--env', 'LM_LICENSE_FILE=/opt/diamond/license/license.dat',
                        '--mount', f'type=bind,source={Path.cwd()},target=/work', '-w', '/work', *docker,
                        images[arm], *prefix, 'python3', '-m', 'toolchain.diagnose_diamond', 'replay',
                        '--output', '/work/' + str(destination.relative_to(Path.cwd())),
                        '--mode', mode, '--attempts', str(attempts), '--timeout', '180' if mode == 'memcheck' else '30',
                        *replay]
                if args.case == 'aslr':
                    command(['sudo', '-n', 'sysctl', '-w', 'kernel.randomize_va_space=' + ('0' if candidate else aslr)])
                try:
                    result = command(argv, check=False)
                    state = command(['docker', 'inspect', '--format', '{{json .State}}', name],
                                    check=False, capture_output=True, text=True)
                    write_json(root / f'{arm}-{block}-execution.json', {
                        'command': argv, 'exit': result.returncode, 'expected_attempts': attempts,
                        'state': state.stdout, 'inspect_error': state.stderr})
                finally:
                    command(['docker', 'rm', '-f', name], check=False)
                    if args.case == 'aslr':
                        command(['sudo', '-n', 'sysctl', '-w', 'kernel.randomize_va_space=' + aslr])
    host_evidence(root / 'host-after.json')
    return report(root)


def read(root, name):
    return json.loads((root / name).read_text())


def isolation(case, before, after, left, right):
    """Reject accidental package/native/input changes outside the stated variable."""
    allowed = {'account': {'account'}, 'cpu': {'cpu_affinity'}, 'shm': {'shared_memory_bytes'}}.get(case, set())
    for key in ('platform', 'uid', 'gid', 'account', 'groups', 'cpu_affinity', 'diamond_version', 'shared_memory_bytes'):
        if before[key] != after[key] and key not in allowed:
            raise ValueError(f'Uncontrolled change: {key}')
    if before['packages']['returncode'] or after['packages']['returncode']:
        raise ValueError('Package inventory failed')
    hashes = [e['file_sha256'] for e in (before, after)]
    changed = {k for k in hashes[0].keys() | hashes[1].keys() if hashes[0].get(k) != hashes[1].get(k)}
    if case == 'local-image':
        if any(k.startswith('/opt/lattice/') for k in changed):
            raise ValueError('Vendor files changed in the base-image comparison')
    elif changed or before['packages']['output'] != after['packages']['output']:
        raise ValueError('Native files or packages changed outside the base-image experiment')
    for key in ('source_sha256', 'program', 'target', 'close_project'):
        if left[key] != right[key]:
            raise ValueError(f'Uncontrolled preparation change: {key}')
    for name in left['inputs_sha256']:
        if name == 'prepare.tcl' and case in LIFECYCLE:
            continue
        if left['inputs_sha256'][name] != right['inputs_sha256'][name]:
            raise ValueError(f'Preparation bytes changed: {name}')
    expected_variant = {'home': 'private-home', 'tmp': 'fresh-tmp'}.get(case, 'baseline')
    expected_mode = case if case in ('memcheck', 'strace') else 'traced'
    if (left['mode'], right['mode'], left['variant'], right['variant']) != ('traced', expected_mode, 'baseline', expected_variant):
        raise ValueError('Unexpected tracing or environment variant')
    if left['preparation'] != 'full' or right['preparation'] != (case if case in LIFECYCLE else 'full'):
        raise ValueError('Unexpected Tcl preparation variant')
    env_keys = {'home': {'HOME'}, 'perturb': {'MALLOC_PERTURB_'}, 'tcache': {'GLIBC_TUNABLES'},
                'qt-environment': {'QT_GRAPHICSSYSTEM'}}.get(case, set())
    for section in ('environment', 'vendor_environment'):
        a, b = before[section], after[section]
        differences = {k for k in a.keys() | b.keys() if a.get(k) != b.get(k)}
        # PATH/loader environment are part of the intentionally different base-image boundary.
        if differences - env_keys and case not in ('local-image', 'vendor-environment'):
            raise ValueError(f'Uncontrolled {section}: {sorted(differences)}')
    a, b = left['effective_environment'], right['effective_environment']
    if {k for k in a.keys() | b.keys() if a.get(k) != b.get(k)} - env_keys and case not in ('local-image', 'vendor-environment'):
        raise ValueError('Uncontrolled effective launch environment')
    for key in env_keys:
        if a.get(key) == b.get(key):
            raise ValueError(f'Candidate environment change did not take effect: {key}')
    variable = {'memory': '/sys/fs/cgroup/memory.max', 'aslr': '/proc/sys/kernel/randomize_va_space'}.get(case)
    for key in ('/sys/fs/cgroup/memory.max', '/sys/fs/cgroup/memory.swap.max', '/sys/fs/cgroup/cpu.max',
                '/proc/sys/kernel/randomize_va_space', '/proc/sys/vm/overcommit_memory', '/proc/sys/vm/max_map_count'):
        if before['system_files'].get(key) != after['system_files'].get(key) and key != variable:
            raise ValueError(f'Uncontrolled resource setting: {key}')
    if variable and before['system_files'].get(variable) == after['system_files'].get(variable):
        raise ValueError(f'Candidate change did not take effect: {variable}')
    for key in allowed:
        if before[key] == after[key]:
            raise ValueError(f'Candidate change did not take effect: {key}')
    if case == 'account' and (before['account'] is not None or after['account'] != 'diamondtest'):
        raise ValueError('Account experiment did not retain the unnamed control UID')
    if case == 'stack':
        limits = [e['system_files']['/proc/self/limits'].splitlines() for e in (before, after)]
        if [s for s in limits[0] if not s.startswith('Max stack size')] != [s for s in limits[1] if not s.startswith('Max stack size')]:
            raise ValueError('A process limit besides stack size changed')
        if limits[0] == limits[1]:
            raise ValueError('Stack limit did not change')
    elif before['system_files']['/proc/self/limits'] != after['system_files']['/proc/self/limits']:
        raise ValueError('Uncontrolled process limits')
    return sorted(changed)


def report(root):
    case = read(root, 'experiment.json')['case']
    result = {'case': case, 'description': CASES[case], 'arms': {}, 'errors': []}
    if (root / 'blocked.txt').exists():
        result['errors'].append((root / 'blocked.txt').read_text())
    for arm in ('control', 'candidate'):
        results = []
        for block in (1, 2):
            try:
                directory = root / f'{arm}-{block}'
                data = read(directory, 'summary.json')
                execution = read(root, f'{arm}-{block}-execution.json')
                expected = execution['expected_attempts']
                if len(data['results']) != expected or data['attempts'] != expected:
                    raise ValueError('Incomplete attempts')
                if execution['exit'] not in (0, 1):
                    raise ValueError('Docker or harness failed outside a measured attempt')
                if execution['exit'] == 0 and any(r['status'] != 'success' for r in data['results']):
                    raise ValueError('Harness exit hid a failed attempt')
                if any(r['status'] == 'success' and (r['returncode'] != 0 or r['timeout']
                       or r['last_marker'] != 'UZ_CPLD_DIAMOND_BEFORE_EXIT') for r in data['results']):
                    raise ValueError('Successful attempt lacks a clean traced exit')
                if case == 'seccomp':
                    expected_seccomp = '0' if arm == 'candidate' else '2'
                    if any(r['memory']['process_settings'].get('Seccomp') != expected_seccomp for r in data['results']):
                        raise ValueError('Seccomp experiment did not apply the expected filter mode')
                if case == 'tmp' and any(bool(r['tmpdir']) != (arm == 'candidate') for r in data['results']):
                    raise ValueError('TMPDIR experiment did not apply to the expected arm')
                results += data['results']
            except (OSError, ValueError, KeyError) as exc:
                result['errors'].append(f'{arm}-{block}: {exc}')
        rss = [r['memory']['peak_rss_kib'] for r in results]
        available = [r['memory']['minimum_sampled_host_available_kib'] for r in results
                     if r['memory']['minimum_sampled_host_available_kib'] is not None]
        def counter(r, key):
            return dict(line.split() for line in r['resource_counters'].get('memory.events', '').splitlines()).get(key, '0')
        result['arms'][arm] = {'attempts': len(results), 'segfaults': sum(r['native_segfault'] for r in results),
            'other_failures': sum(r['status'] != 'success' and not r['native_segfault'] for r in results),
            'memcheck_errors': sum(r['memcheck_errors'] for r in results),
            'peak_rss_kib': max(rss, default=0), 'minimum_host_available_kib': min(available, default=None),
            'oom_kills': max((int(counter(r, 'oom_kill')) for r in results), default=0)}
    try:
        for block in (1, 2):
            control, candidate = (root / f'{arm}-{block}' for arm in ('control', 'candidate'))
            result['changed_native_files'] = isolation(case, read(control, 'environment.json'),
                read(candidate, 'environment.json'), read(control, 'inputs.json'), read(candidate, 'inputs.json'))
            before, after = (read(p, 'installation.json') for p in (control, candidate))
            if case == 'full-installation':
                added = sorted(after.keys() - before.keys())
                if not added or any(before[k] != after.get(k) for k in before if k not in ('container-smoke.tcl', 'machxo2-smoke.tcl')):
                    raise ValueError('Full installation is not a strict superset of the pruned vendor tree')
                result['additional_vendor_files'] = added
            elif before != after:
                raise ValueError('Vendor installation inventory changed outside the full-installation experiment')
    except (OSError, ValueError, KeyError) as exc:
        result['errors'].append(str(exc))
    control, candidate = (result['arms'][arm] for arm in ('control', 'candidate'))
    if result['errors'] or control['other_failures']:
        verdict = 'INVALID / incomplete or uncontrolled comparison'
    elif case in PROBES:
        verdict = 'DIAGNOSTIC PROBE / inspect evidence; not a firmware fix'
    elif candidate['segfaults'] or candidate['other_failures']:
        verdict = 'CRASHES OR FAILURES REMAIN'
    elif not control['segfaults']:
        verdict = 'INCONCLUSIVE / control did not reproduce'
    else:
        verdict = 'PROMISING / needs independent repetition and full catalog validation'
    result['verdict'] = verdict
    write_json(root / 'comparison.json', result)
    print(json.dumps(result, indent=2), flush=True)
    return int(bool(result['errors']) or any(a['segfaults'] or a['other_failures'] for a in result['arms'].values()))


def summary(root):
    root.mkdir(parents=True, exist_ok=True)
    reports = {}
    for path in root.rglob('comparison.json'):
        data = json.loads(path.read_text())
        reports[data['case']] = data
    lines = ['| Experiment | Control crashes / attempts | Candidate crashes / attempts | Candidate peak RSS MiB | Result |',
             '|---|---:|---:|---:|---|']
    for case in CASES:
        if case not in reports:
            lines.append(f'| {case} | Missing | Missing | | Setup failed or artifact unavailable |')
            continue
        data = reports[case]
        a, b = (data['arms'][arm] for arm in ('control', 'candidate'))
        lines.append(f'| {case} | {a["segfaults"]}/{a["attempts"]} | {b["segfaults"]}/{b["attempts"]} '
                     f'({b["other_failures"]} other failures) | {b["peak_rss_kib"] / 1024:.1f} | {data["verdict"]} |')
    lines += ['', 'Crashes intentionally keep the diagnostic red. A passing candidate is not a validated fix.',
              'Compare host24 against reference as a broad host comparison, not a kernel-only experiment.',
              'local-image rebuilds the default Ubuntu supply path with CI vendor bytes; it is not the actual local container.',
              'The earlier close/no-close and glibc comparisons already showed crashes in both arms.']
    text = '\n'.join(lines) + '\n'
    print(text)
    (root / 'summary.md').write_text(text)
    if os.environ.get('GITHUB_STEP_SUMMARY'):
        with open(os.environ['GITHUB_STEP_SUMMARY'], 'a') as stream:
            stream.write(text)
    return int(len(reports) != len(CASES) or any(d['errors'] or any(
        a['segfaults'] or a['other_failures'] for a in d['arms'].values()) for d in reports.values()))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('run', 'report', 'summary'))
    parser.add_argument('--case', choices=CASES)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--base')
    parser.add_argument('--ubuntu')
    parser.add_argument('--full', default='')
    parser.add_argument('--attempts', type=int, default=100)
    args = parser.parse_args()
    if args.action == 'run' and (not args.case or not args.base or not args.ubuntu or not 1 <= args.attempts <= 500):
        parser.error('run requires case, pinned base/Ubuntu images and 1–500 attempts per block')
    try:
        return {'run': lambda: run(args), 'report': lambda: report(args.output),
                'summary': lambda: summary(args.output)}[args.action]()
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as exc:
        print(f'Diamond experiment failed: {exc}', flush=True)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
