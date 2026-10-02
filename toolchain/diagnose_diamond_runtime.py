"""Validate the temporary Diamond glibc experiment before allowing catalog builds."""
import json
from pathlib import Path
import sys

# Files from libc6 recorded by the Diamond reproducer. No vendor library may change.
GLIBC_FILES = {'/lib/x86_64-linux-gnu/' + name for name in (
    'libc.so.6', 'libdl.so.2', 'libm.so.6', 'libpthread.so.0', 'librt.so.1')}
GLIBC_FILES.add('/lib64/ld-linux-x86-64.so.2')


def validate(root):
    def read(arm, name):
        return json.loads((root / arm / name).read_text())

    environments = [read(arm, 'environment.json') for arm in ('control', 'candidate')]
    packages = []
    for environment, version in zip(environments, ('2.35-0ubuntu3.14', '2.35-0ubuntu3.15')):
        result = environment['packages']
        if result.get('returncode') != 0:
            raise ValueError('Package fingerprint failed')
        installed = dict(line.split('\t') for line in result['output'].splitlines())
        if any(installed.get(name) != version for name in ('libc6:amd64', 'libc-bin')):
            raise ValueError(f'Expected glibc {version}')
        packages.append(installed)
    changed_packages = {k for k in packages[0].keys() | packages[1].keys()
                        if packages[0].get(k) != packages[1].get(k)}
    if changed_packages != {'libc6:amd64', 'libc-bin'}:
        raise ValueError(f'Unexpected package changes: {sorted(changed_packages)}')
    for key in ('platform', 'uid', 'gid', 'account', 'groups', 'cpu_affinity',
                'environment', 'vendor_environment', 'diamond_version'):
        if environments[0][key] != environments[1][key]:
            raise ValueError(f'Uncontrolled environment difference: {key}')
    before, after = [e['file_sha256'] for e in environments]
    changed = {k for k in before.keys() | after.keys() if before.get(k) != after.get(k)}
    required = {'/lib/x86_64-linux-gnu/libc.so.6', '/lib64/ld-linux-x86-64.so.2'}
    if before.keys() != after.keys() or not required <= changed or not changed <= GLIBC_FILES:
        raise ValueError(f'Unexpected native-library changes: {sorted(changed)}')
    print('Changed native libraries:', ', '.join(sorted(changed)))
    inputs = [read(arm, 'inputs.json') for arm in ('control', 'candidate')]
    for key in ('program', 'target', 'inputs_sha256', 'source_sha256', 'mode', 'variant', 'close_project'):
        if inputs[0][key] != inputs[1][key]:
            raise ValueError(f'Preparation inputs differ: {key}')
    for arm in ('control', 'candidate'):
        report = read(arm, 'summary.json')
        if report['attempts'] != 100 or len(report['results']) != 100 or not report['close_project']:
            raise ValueError(f'{arm}: incomplete experiment or explicit close disabled')
        if arm == 'candidate':
            valid = report['statuses'] == {'success': 100} and all(
                r['status'] == 'success' and r['returncode'] == 0 and not r['timeout']
                and r['last_marker'] == 'UZ_CPLD_DIAMOND_BEFORE_EXIT' for r in report['results'])
        else:
            valid = all(not r['timeout'] and (
                (r['status'] == 'success' and r['returncode'] == 0)
                or (r['status'] == 'failed' and r['returncode'] == -11)) for r in report['results'])
        print(f'{arm}: {report["attempts"]} attempts, {report["segfaults"]} segfaults')
        if not valid:
            raise ValueError(f'{arm}: unexpected failure or candidate crash')
    print('Runtime isolation verified; candidate is ready for full-catalog validation.')


if __name__ == '__main__':
    try:
        validate(Path(sys.argv[1]))
    except (OSError, ValueError, KeyError, IndexError) as exc:
        print(f'Runtime comparison failed: {exc}', file=sys.stderr)
        raise SystemExit(1)
