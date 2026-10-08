"""Independently verify S3C identity with both programmer backends."""
from pathlib import Path
import datetime
import json
import shutil
import subprocess
import sys
out = Path(__file__).resolve().parent
root = out.parents[1]
phase = sys.argv[1]
baseline = json.loads((out / 'baseline-s3c-identity.json').read_text())['devices'][0]
identity = json.loads((root / 'build/diamond/heartbeat_cvg/s3c_heartbeat/uz_s3c_xo2/metadata/identity.json').read_text())
expected = {'idcode': '012BC043', 'traceid': baseline['traceid'], 'usercode': identity['usercode'], 'label': 's3c', 'index': 0}
record = {'phase': phase, 'expected': expected, 'status': 'running', 'readers': {}}
path = out / f'crosscheck-s3c-{phase}.json'
def save():
    path.write_text(json.dumps(record, indent=2) + '\n')
save()
try:
    for backend in ['diamond', 'foss']:
        before = set((root / 'build/programmer/identification').glob('*/identity.json'))
        log = out / f'crosscheck-s3c-{phase}-{backend}.log'
        with log.open('w') as handle:
            subprocess.run(['uz_cpld', 'identify', '--target', 's3c', '--programmer-backend', backend], cwd=root, stdout=handle, stderr=subprocess.STDOUT, check=True)
        fresh = set((root / 'build/programmer/identification').glob('*/identity.json')) - before
        assert len(fresh) == 1
        source = fresh.pop()
        data = json.loads(source.read_text())
        assert data['programmer_backend'] == backend and data['chain'] == 's3c'
        assert len(data['devices']) == 1
        actual = data['devices'][0]
        for key, value in expected.items():
            assert actual[key] == value, (backend, key, actual[key], value)
        assert actual['identity']['program'] == identity['program']
        if backend == 'foss':
            assert actual['sram_usercode'] == identity['usercode']
        shutil.copy2(source, out / f'identity-s3c-{phase}-{backend}.json')
        record['readers'][backend] = {'status': 'pass', 'source': str(source), 'read_at': data.get('read_at')}
        save()
        print(backend, phase, 'PASS: S3C silicon and firmware identity match', flush=True)
    record['status'] = 'pass'
except Exception as exc:
    record['status'] = 'failed'
    record['error'] = str(exc)
    raise
finally:
    record['completed_at'] = datetime.datetime.now(datetime.timezone.utc).isoformat()
    save()
