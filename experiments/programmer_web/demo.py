"""Explicit simulation fixtures. Never imports the programmer or touches USB."""
import time

CATALOG = {'2026.1-demo': {'s3c': ['s3c_heartbeat', 's3c_passthrough'],
                         'dslot': ['cvg_tx30', 'loopback', 'safe_outputs']}}
SELECTION = {'release': '2026.1-demo', 's3c': 's3c_heartbeat',
             'slots': {str(i): 'cvg_tx30' for i in range(1, 6)}}


def operate(request, *, on_event):
    action = request['action']
    on_event({'operation': action, 'phase': 'log', 'text': f'[DEMO] {action}: simulated operation; no hardware access.\n'})
    time.sleep(0.12)
    if action in ('load', 'select', 'download'):
        return dict(message='Demo firmware ready.', cycles=CATALOG, selection=SELECTION,
                    firmware=request.get('firmware') or '/demo/uz-cpld-firmware.zip', sha256='a' * 64,
                    commit='0123456789abcdef' * 2 + '01234567')
    if action == 'releases':
        return {'releases': [dict(id=1, name='Demo stable firmware', tag='demo-2026.1',
                                 prerelease=False, commit='01234567', published_at='2026-11-28T12:00:00Z')]}
    if action == 'prepare':
        target = request['target']
        selection = request['selection']
        labels = ['S3C'] if target == 's3c' else [f'D{i}' for i in range(1, 6)]
        assignments = [dict(position=p, program=selection['s3c'] if p == 'S3C' else selection['slots'][p[1:]],
                            usercode='10203040') for p in labels]
        return dict(plan_id='d' * 32, review_sha256='e' * 64,
                    summary=dict(target=target, backend=request['backend'], release=selection['release'],
                                 assignments=assignments), firmware=[dict(sha256='a' * 64)])
    if action in ('scan', 'identify', 'execute'):
        target = request.get('target') or 's3c'
        labels = ['S3C'] if target == 's3c' else [f'D{i}' for i in range(1, 6)]
        devices = [dict(label=p, idcode='012BC043' if p == 'S3C' else '012BB043', usercode='10203040',
                        identity=dict(program='s3c_heartbeat' if p == 'S3C' else 'cvg_tx30',
                                      revision=1, known_build=True)) for p in labels]
        return dict(message='Demo operation complete; hardware was not accessed.', devices=devices,
                    chain_matches=True, target=target)
    if action in ('save', 'drivers'):
        return {'message': f'Demo {action} complete; no files or drivers were changed.'}
    raise ValueError(f'Unsupported demo operation: {action}')
