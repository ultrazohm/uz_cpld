"""Native wire output for orchestration fixtures; never accesses a probe."""
import json
from pathlib import Path


def loader_output(command, log, *, timeout=60):
    if '--read-identity' not in command:
        return ''
    directory = next(p for p in Path(log).parents if (p / 'result.json').is_file())
    record = json.loads((directory / 'result.json').read_text())
    code = '012BC043' if record['chain'] == 's3c' else '012BB043'
    return ''.join(f'UZ_IDENTITY_V1 {i} {code} {identity["usercode"]} {identity["usercode"]} FF0000000000000{i}\n'
                   for i, identity in enumerate(record['expected_identities'].values())) + \
        f'UZ_IDENTITY_END_V1 {len(record["expected_identities"])}\n'
