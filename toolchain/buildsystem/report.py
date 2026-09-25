"""Summarize current catalog build evidence without invoking firmware tools."""
from collections import Counter
from datetime import datetime, timezone
import json
from pathlib import Path

from .model import Build
from .workflow import digest, hashes, write_json


def _read_json(path: Path):
    try:
        return json.loads(path.read_text())
    except (OSError, ValueError):
        return None


def _row(build: Build):
    directory = build.directory
    status = _read_json(directory / 'metadata/status.json')
    record = _read_json(directory / 'metadata/build.json')
    row = {'program': build.name, 'target': build.target, 'backend': build.backend,
           'status': 'missing', 'changed_inputs': [], 'changed_outputs': [],
           'warnings': 0, 'timing': 'not evaluated', 'equivalence': None,
           'initial_alignment': None, 'undefined_rtl_outputs': []}
    if not isinstance(status, dict):
        return row
    row['status'] = status.get('status', 'invalid')
    if row['status'] != 'success' or not isinstance(record, dict) or record.get('status') != 'success':
        row['error'] = status.get('error', 'Missing successful build record')
        if row['status'] == 'success':
            row['status'] = 'invalid'
        return row
    current = hashes(build)
    saved = record.get('inputs', {})
    if not isinstance(saved, dict):
        saved = {}
    row['changed_inputs'] = sorted(key for key in current.keys() | saved.keys()
                                   if current.get(key) != saved.get(key))
    outputs = record.get('outputs', {})
    if not isinstance(outputs, dict):
        outputs = {}
    for name, expected in outputs.items():
        path = directory / name
        if (not path.resolve().is_relative_to(directory.resolve()) or
                not path.is_file() or digest(path) != expected):
            row['changed_outputs'].append(name)
    if not outputs:
        row['changed_outputs'].append('No recorded outputs')
    row['warnings'] = len(record.get('warnings', []))
    row['timing'] = record.get('timing_acceptance', 'not evaluated')
    if build.backend == 'foss':
        proof = _read_json(directory / 'metadata/reports/equivalence.json')
        if isinstance(proof, dict):
            row['equivalence'] = proof.get('result')
            row['initial_alignment'] = proof.get('initial_alignment',
                                                 'not checked' if not proof.get('initial_alignment_proven') else 'proven')
            row['undefined_rtl_outputs'] = proof.get('undefined_rtl_outputs', [])
        else:
            row['equivalence'] = 'missing report'
    if row['changed_inputs'] or row['changed_outputs']:
        row['status'] = 'stale'
    return row


def catalog_report(builds: list[Build], target_filter: str | None = None,
                   selection_errors: list[tuple[str, str, str]] | None = None,
                   *, root: Path | None = None, backend: str | None = None,
                   build_errors: list[tuple[str, str, str]] | None = None) -> Path:
    """Write a backend/target-specific Markdown and JSON catalog report."""
    selection_errors = selection_errors or []
    if not builds and not selection_errors:
        raise ValueError('Cannot report an empty build selection')
    if builds:
        root, backend = builds[0].root, builds[0].backend
    if root is None or backend is None:
        raise ValueError('Catalog report requires a checkout and backend')
    if any(build.root != root or build.backend != backend for build in builds):
        raise ValueError('Catalog report requires one checkout and backend')
    targets = {build.target for build in builds} | {target for _, target, _ in selection_errors if target != '—'}
    name = backend + ('-' + target_filter if target_filter else '') + '-catalog'
    directory = root / 'toolchain/build/validation' / name
    directory.mkdir(parents=True, exist_ok=True)
    rows = [_row(build) for build in builds]
    for program, target, error in build_errors or []:
        row = next(row for row in rows if row['program'] == program and row['target'] == target)
        row['status'] = 'failed'
        row['error'] = error
    rows.extend({'program': program, 'target': target, 'backend': backend,
                 'status': 'failed', 'error': error, 'changed_inputs': [],
                 'changed_outputs': [], 'warnings': 0, 'timing': 'not evaluated',
                 'equivalence': None, 'initial_alignment': None,
                 'undefined_rtl_outputs': []}
                for program, target, error in selection_errors)
    summary = dict(Counter(row['status'] for row in rows))
    payload = {'generated_at': datetime.now(timezone.utc).isoformat(), 'backend': backend,
               'targets': sorted(targets), 'summary': summary, 'builds': rows}
    write_json(directory / 'report.json', payload)
    lines = [f'# {backend.upper()} catalog build report', '',
             f"Generated: {payload['generated_at']}", '',
             'This report reads existing build evidence. A successful status is **fresh** only when '
             'recorded inputs and outputs still match the checkout.', '',
             f"Summary: {', '.join(f'{key} {value}' for key, value in sorted(summary.items()))}.", '',
             f"Startup counterexamples: {sum('counterexample' in (row['initial_alignment'] or '') for row in rows)}. "
             'A fresh bitstream can still have an unresolved startup proof.', '',
             '| Program | Target | Status | Changed inputs | Changed outputs | Proof | Startup | Warnings | Timing |',
             '| --- | --- | --- | ---: | ---: | --- | --- | ---: | --- |']
    for row in rows:
        proof = row['equivalence'] or '—'
        startup = row['initial_alignment'] or '—'
        timing = 'not evaluated' if 'not evaluated' in row['timing'] else row['timing']
        lines.append(f"| {row['program']} | {row['target']} | {row['status']} | "
                     f"{len(row['changed_inputs'])} | {len(row['changed_outputs'])} | "
                     f"{proof} | {startup} | {row['warnings']} | {timing} |")
    lines += ['', '## Details', '']
    for row in rows:
        if (row['status'] == 'success' and not row['undefined_rtl_outputs'] and
                'counterexample' not in (row['initial_alignment'] or '')):
            continue
        lines += [f"### {row['program']} ({row['target']})", '']
        if row['status'] in ('missing', 'failed', 'invalid'):
            lines.append(f"Build status: {row['status']}. {row.get('error', '')}")
        if row['changed_inputs']:
            lines.append('Changed inputs: ' + ', '.join(f'`{item}`' for item in row['changed_inputs']) + '.')
        if row['changed_outputs']:
            lines.append('Changed outputs: ' + ', '.join(f'`{item}`' for item in row['changed_outputs']) + '.')
        if 'counterexample' in (row['initial_alignment'] or ''):
            lines.append('The initialized-state miter found an output mismatch; see `project/impl/startup.log`.')
        if row['undefined_rtl_outputs']:
            lines.append('RTL outputs excluded from the initialized-state miter because every bit is undefined or high impedance: '
                         + ', '.join(f'`{item}`' for item in row['undefined_rtl_outputs']) + '.')
        lines.append('')
    report = directory / 'report.md'
    temporary = report.with_suffix('.tmp')
    temporary.write_text('\n'.join(lines) + '\n')
    temporary.replace(report)
    return report
