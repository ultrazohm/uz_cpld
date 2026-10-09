"""Expose skipped tests and firmware verification limits in GitHub job summaries."""
import argparse
import json
import os
from pathlib import Path
import re
import xml.etree.ElementTree as ET


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
        lines += [f'- {warnings} recorded warning lines; inspect the retained build reports.']
        if backend == 'diamond':
            lines += ['- Final routed timing constraints must pass before firmware is exported.']
        else:
            lines += ['- **Timing acceptance is not evaluated** for FOSS builds.']
        lines += ['- **Board timing budgets are not defined; tool timing checks do not qualify the board.**']
        for path in sorted(base.glob('*/*/*/metadata/reports/equivalence.json')):
            record = json.loads(path.read_text())
            if record.get('initial_alignment_proven') is False:
                name = '/'.join(path.relative_to(base).parts[:3])
                exception = record.get('startup_exception')
                label = 'Accepted startup exception' if exception else 'STARTUP PROOF NOT ACCEPTED'
                lines += [f'- **{label}:** `{name}` — {record.get("initial_alignment")}. '
                          + (exception or 'This must block the build.')]
        lines += ['']
    if backend == 'foss':
        results = sorted((root / 'build/analysis').glob('*/*/simulation/*.result.xml'))
        counts = dict(passed=0, skipped=0, failed=0, errored=0)
        details = []
        for result in results:
            for case in ET.parse(result).iter('testcase'):
                state = ('failed' if case.find('failure') is not None else
                         'errored' if case.find('error') is not None else
                         'skipped' if case.find('skipped') is not None else 'passed')
                counts[state] += 1
                if state != 'passed':
                    details.append(f'- **{state}:** `{result.relative_to(root)}` / `{case.get("name")}`')
        lines += ['### HDL simulations', '',
                  f'- {len(results)} result files: ' + ', '.join(f'{n} {state}' for state, n in counts.items()) + '.',
                  '- Skipped, failed or errored HDL cases block simulation and documentation builds.', *details]
        if not results:
            lines += ['- **No HDL result files available; execution cannot be confirmed.**']
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
