"""Read both programmers sequentially and assert slot-to-silicon/firmware mapping."""
from pathlib import Path
import datetime
import json
import shutil
import subprocess
import sys

root = Path(__file__).resolve().parents[2]
out = Path(__file__).resolve().parent
variant, phase = sys.argv[1:]
plan = json.loads((out / 'ordering-plan.json').read_text())
names = plan[variant]
baseline = json.loads((out / 'baseline-dslot-identity.json').read_text())['devices']
expected = []
for name, device in zip(names, baseline):
    folder = root / 'build/diamond/heartbeat_cvg' / name / 'uz_dslot_xo2'
    identity = json.loads((folder / 'metadata/identity.json').read_text())
    expected.append({'label': device['label'], 'traceid': device['traceid'], 'idcode': device['idcode'], 'usercode': identity['usercode'], 'program': 'heartbeat_cvg/' + name})
assert len(expected) == 5 and len({x['usercode'] for x in expected}) == 5
record = {'variant': variant, 'phase': phase, 'expected': expected, 'status': 'running', 'readers': {}}
record_path = out / f'crosscheck-{variant}-{phase}.json'
def save():
    record_path.write_text(json.dumps(record, indent=2) + '\n')
save()
try:
    for backend in ['diamond', 'foss']:
        before = set((root / 'build/programmer/identification').glob('*/identity.json'))
        log = out / f'crosscheck-{variant}-{phase}-{backend}.log'
        with log.open('w') as handle:
            subprocess.run(['uz_cpld', 'identify', '--target', 'dslot', '--programmer-backend', backend], cwd=root, stdout=handle, stderr=subprocess.STDOUT, check=True)
        after = set((root / 'build/programmer/identification').glob('*/identity.json'))
        fresh = after - before
        assert len(fresh) == 1, f'Expected exactly one new identity record: {fresh}'
        source = fresh.pop()
        data = json.loads(source.read_text())
        assert data['programmer_backend'] == backend
        assert len(data['devices']) == 5
        for index, (actual, wanted) in enumerate(zip(data['devices'], expected)):
            assert actual['index'] == index
            for key in ['label', 'traceid', 'idcode', 'usercode']:
                assert actual[key] == wanted[key], (backend, index, key, actual[key], wanted[key])
            assert actual['identity']['program'] == wanted['program']
            if backend == 'foss':
                assert actual['sram_usercode'] == wanted['usercode']
        shutil.copy2(source, out / f'identity-{variant}-{phase}-{backend}.json')
        record['readers'][backend] = {'status': 'pass', 'source': str(source), 'read_at': data.get('read_at'), 'log': str(log)}
        save()
        print(backend, variant, phase, 'PASS: all five slot, silicon and firmware mappings match', flush=True)
    record['status'] = 'pass'
except Exception as exc:
    record['status'] = 'failed'
    record['error'] = str(exc)
    raise
finally:
    record['completed_at'] = datetime.datetime.now(datetime.timezone.utc).isoformat()
    save()
