"""Check Diamond's final routed TRACE report, never synthesis estimates."""
import re

from .model import BuildError


def check_final_timing(path):
    try:
        text = path.read_text(errors='replace')
    except OSError as exc:
        raise BuildError(f'Missing final routed timing report: {path}') from exc
    scored = re.findall(r'(\d+) items scored,\s*(\d+) timing errors detected\.', text)
    # Require recognizable completed reports, not just the presence of a file.
    if ('Lattice TRACE Report' not in text or 'Report Summary' not in text
            or not scored or sum(int(count) for count, _ in scored) == 0):
        raise BuildError(f'Incomplete or unconstrained final routed timing report: {path}')
    if (any(int(errors) for _, errors in scored)
            or re.search(r'(?im)^\s*Error:|\b[1-9]\d* (?:constraints|preferences) not met\b', text)):
        raise BuildError(f'Final routed timing requirements failed: {path}')
    return {'result': 'passed', 'report': path.name,
            'scored_items': sum(int(count) for count, _ in scored),
            'timing_errors': 0, 'scope': 'Existing routed constraints only; board timing budgets not defined.'}
