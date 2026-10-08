"""Expose skipped tests and firmware verification limits in GitHub job summaries."""
import argparse
import json
import os
from pathlib import Path
import re


def render(root, backend=None, test_log=None):
    lines = ['## Validation coverage', '']
    if test_log is not None:
        path = root / test_log
        lines += ['### Tooling tests', '']
        if path.is_file():
            text = re.sub(r'\x1b\[[0-9;]*m', '', path.read_text(encoding='utf-8', errors='replace'))
            totals = re.findall(r'^Ran \d+ tests? in .*$', text, re.MULTILINE)
            lines += [f'- {item}' for item in totals]
            skipped = [line.strip() for line in text.splitlines() if ' ... skipped ' in line]
            lines += [f'- **{len(skipped)} skipped tests** reported.']
            lines += [f'- {line}' for line in skipped]
            if not totals:
                lines += ['- **No completed unittest suite reported; inspect the job log.**']
            lines += ['- Counts describe execution coverage; the test step exit status determines success.']
        else:
            lines += ['- **Test log unavailable; test execution cannot be confirmed.**']
        lines += ['']
    if backend:
        base = root / 'build' / backend
        records = [json.loads(p.read_text()) for p in sorted(base.glob('*/*/*/metadata/build.json'))]
        lines += [f'### {backend.capitalize()} firmware', '',
                  f'- {len(records)} build records available.']
        failed = []
        for path in sorted(base.glob('*/*/*/metadata/status.json')):
            if json.loads(path.read_text()).get('status') != 'success':
                failed.append(str(path.relative_to(root)))
        lines += [f'- **Unsuccessful build:** `{path}`' for path in failed]
        if not records:
            lines += ['- **No completed build records; this does not establish firmware validation.**']
        warnings = sum(len(record.get('warnings', [])) for record in records)
        lines += [f'- {warnings} recorded warning lines; inspect the retained build reports.',
                  '- **Timing acceptance is not evaluated:** no program timing budgets are defined.']
        for path in sorted(base.glob('*/*/*/metadata/reports/equivalence.json')):
            record = json.loads(path.read_text())
            if record.get('initial_alignment_proven') is False:
                name = '/'.join(path.relative_to(base).parts[:3])
                exception = record.get('startup_exception')
                label = 'Accepted startup exception' if exception else 'STARTUP PROOF NOT ACCEPTED'
                lines += [f'- **{label}:** `{name}` — {record.get("initial_alignment")}. '
                          + (exception or 'This must block the build.')]
        lines += ['']
    lines += ['### Scope limits', '',
              '- CI does not test USB drivers or program real CPLD hardware.',
              '- Standalone smoke checks exercise packaging, fixtures and dry runs, not vendor programming.',
              '- Windows native programmer checks run inside MSYS2; they do not qualify a standalone programmer distribution.',
              '- Build success does not establish board routing, startup, fault recovery or electrical timing acceptance.', '']
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('foss', 'diamond'))
    parser.add_argument('--test-log', type=Path)
    args = parser.parse_args()
    summary = render(Path.cwd(), args.backend, args.test_log)
    print(summary)
    if os.environ.get('GITHUB_STEP_SUMMARY'):
        with Path(os.environ['GITHUB_STEP_SUMMARY']).open('a', encoding='utf-8') as stream:
            stream.write(summary + '\n')


if __name__ == '__main__':
    main()
