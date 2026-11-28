"""JSON review records for prepare/execute across isolated worker processes.

Only data is persisted. Execution reconstructs a validated backend plan and
compares the reviewed inputs before contacting hardware; no pickle or commands
from the record are executed.
"""
import hashlib
import hmac
import json
from pathlib import Path
import re
import secrets

from ..settings import atomic_json
from ..toolchain.buildsystem.model import BuildError, read_toml
from ..toolchain.buildsystem.workflow import workspace_lock


def checksum(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def context(api):
    return dict(workspace=str(api.workspace), backend=api.backend, cable=api.cable,
                serial=api.serial, probe_index=api.probe_index)


def review(plan):
    # Diamond XCF paths change on each preparation, but the reviewed firmware
    # bytes and identity must remain identical. Backend execution checks the XCF.
    return dict(summary=plan.summary, firmware=[
        dict(label=step.label, sha256=step.sha256) if not step.firmware else
        dict(label=step.label, images=[dict(label=f.label, sha256=f.sha256) for f in step.firmware])
        for step in plan.steps])


def directory(root):
    path = root / 'build/programmer/plans'
    for parent in (path, *path.parents):
        if parent == root:
            break
        if parent.is_symlink():
            raise BuildError(f'Plan directory must not be a symlink: {parent}')
    return path


def prepare(api, selection, **options):
    if not isinstance(selection, dict):
        selection = read_toml(Path(selection))
    # Detach the record from caller-owned mutable dictionaries.
    selection = json.loads(json.dumps(selection))
    if options.get('firmware'):
        options['firmware'] = str(Path(options['firmware']).resolve())
    with workspace_lock(api.workspace):
        plan = api.prepare_programming(selection, **options)
        options['release'] = plan.release
        if plan.builds:
            options['build_backend'] = plan.builds[0][2].backend
            package = getattr(plan.builds[0][2], 'package', None)
            if package:
                options['expected_sha256'] = package.evidence['archive_sha256']
        record = dict(schema_version=1, context=context(api),
                      request=dict(options, selection=selection), review=review(plan))
        token = secrets.token_hex(16)
        base = directory(api.workspace)
        base.mkdir(parents=True, exist_ok=True)
        atomic_json(base / f'{token}.json', record)
        return dict(plan_id=token, review_sha256=checksum(record), **record['review'])


def execute(api, plan_id, review_sha256):
    if not isinstance(plan_id, str) or not re.fullmatch('[0-9a-f]{32}', plan_id):
        raise BuildError('Invalid plan ID')
    if not isinstance(review_sha256, str) or not re.fullmatch('[0-9a-f]{64}', review_sha256):
        raise BuildError('Supply the checksum returned when the plan was reviewed')
    with workspace_lock(api.workspace):
        path = directory(api.workspace) / f'{plan_id}.json'
        if path.is_symlink():
            raise BuildError('Plan record must not be a symlink')
        record = json.loads(path.read_text(encoding='utf-8'))
        if not hmac.compare_digest(checksum(record), review_sha256):
            raise BuildError('Plan changed after review; prepare and review again')
        if record.get('schema_version') != 1 or record.get('context') != context(api):
            raise BuildError('Plan belongs to a different workspace, probe configuration, or schema')
        plan = api.prepare_programming(**record['request'])
        if review(plan) != record['review']:
            raise BuildError('Programming inputs changed after review; prepare and review again')
        return api.execute(plan)
