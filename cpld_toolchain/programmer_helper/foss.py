"""Managed MachXO2 operations using the pinned openFPGALoader protocol.

Indices are openFPGALoader indices (nearest TDI first), including programming.
A session owns channel B across discovery, all writes, and readback.
"""
from contextlib import contextmanager
from pathlib import Path
import re
import shutil
import subprocess
import time

from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.buildsystem.workflow import digest, write_json
from cpld_toolchain.toolchain.foss import flasher
from .helper import DEFAULT_DIAMOND_PORT
from .usb import diamond_usb


def expected_chain(chain):
    if chain == 's3c':
        return ['012BC043']
    if chain == 'dslots':
        return ['012BB043'] * 5
    raise BuildError('Choose the dslots or s3c chain')


def identity_command(binary, chain, cable=None, serial=None, probe_index=None):
    from .program import cable_args
    return (str(binary), *cable_args(chain, cable, serial, probe_index),
            '--read-identity', '--expected-chain', ','.join(expected_chain(chain)))


def run(command, log, *, timeout=60):
    """Bound the process, retain diagnostics, and reap it before releasing USB."""
    log = Path(log)
    log.parent.mkdir(parents=True, exist_ok=True)
    with log.open('w') as stream:
        process = subprocess.Popen(command, stdout=stream, stderr=subprocess.STDOUT)
        try:
            returncode = process.wait(timeout=timeout)
        except subprocess.TimeoutExpired as exc:
            process.kill()
            process.wait()
            raise BuildError(f'FOSS programmer timed out after {timeout}s; see {log}') from exc
        except BaseException:
            process.kill()
            process.wait()
            raise
    output = log.read_text(errors='replace')
    if returncode:
        raise BuildError(f'FOSS programmer failed with exit code {returncode}; see {log}')
    return output


def parse(root, chain, output, *, registry=None):
    from .identify import parse as parse_identity
    rows = []
    ended = False
    for line in output.splitlines():
        if not line.startswith('UZ_IDENTITY'):
            continue
        match = re.fullmatch(r'UZ_IDENTITY_V1 (\d+) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{8}) ([0-9a-fA-F]{16})', line)
        if match and not ended:
            rows.append(match.groups())
        elif line == f'UZ_IDENTITY_END_V1 {len(expected_chain(chain))}' and not ended:
            ended = True
        else:
            raise BuildError('Malformed or duplicate FOSS identity record')
    if not ended:
        raise BuildError('Incomplete FOSS identity readback: completion record missing')
    raw = ''.join(f'UZ_IDENTITY {i} {idcode} {flash} {trace}\n' for i, idcode, flash, sram, trace in rows)
    devices = parse_identity(root, chain, raw, registry=registry)
    for device, row in zip(devices, rows):
        device['sram_usercode'] = row[3].upper()
    return devices


class Session:
    def __init__(self, binary, chain, cable=None, serial=None, probe_index=None):
        self.binary = Path(binary).resolve()
        self.chain = chain
        self.command = identity_command(self.binary, chain, cable, serial, probe_index)
        self.provenance = flasher.verify(self.binary)

    def checked_run(self, command, log, timeout=60):
        if flasher.verify(self.binary) != self.provenance:
            raise BuildError('FOSS programmer changed during the session')
        return run(command, log, timeout=timeout)

    def read(self, root, directory, registry=None):
        directory.mkdir(parents=True, exist_ok=True)
        return parse(root, self.chain, self.checked_run(self.command, directory / 'identify.log'), registry=registry)


@contextmanager
def session(chain, cable=None, serial=None, probe_index=None, *, binary=None):
    from .program import loader_path
    active = Session(binary if binary is not None else loader_path(), chain, cable, serial, probe_index)
    with diamond_usb(DEFAULT_DIAMOND_PORT, serial=serial):
        yield active


def execute(root, chain, builds, steps, identities, run_dir, record, cable, serial, probe_index, package):
    """Snapshot and validate every input before taking the probe, then verify both stores."""
    from .program import loader_path
    binary = loader_path().resolve()
    active = Session(binary, chain, cable, serial, probe_index)
    record['programmer_provenance'] = active.provenance
    snapshots = []
    private = run_dir / 'firmware'
    private.mkdir(mode=0o700)
    for step in steps:
        snapshot = private / (step.label + step.artifact.suffix)
        shutil.copyfile(step.artifact, snapshot)
        if digest(snapshot) != step.sha256:
            raise BuildError(f'Firmware changed while snapshotting: {step.artifact}')
        flasher.check_file(binary, snapshot, identities[step.label]['usercode'])
        snapshot.chmod(0o400)
        snapshots.append(snapshot)
    registry = package.registry if package else None
    with diamond_usb(DEFAULT_DIAMOND_PORT, serial=serial):
        before = active.read(root, run_dir / 'before', registry)
        record['before_devices'] = before
        record['detected_chain'] = [d['idcode'] for d in before]
        write_json(run_dir / 'result.json', record)
        for step, snapshot, (_, index, _) in zip(steps, snapshots, builds):
            if digest(snapshot) != step.sha256:
                raise BuildError('Private firmware snapshot changed')
            command = (str(binary), *step.command[1:-1], '--expected-chain', ','.join(expected_chain(chain)),
                       '--expected-silicon', before[index]['silicon_id'], str(snapshot))
            log = run_dir / f'{step.label}.log'
            print(f'FOSS: programming {step.label}; log: {log}', flush=True)
            active.checked_run(command, log, timeout=180)
            record['steps'].append({'label': step.label, 'artifact': str(step.artifact), 'sha256': step.sha256,
                                    'command': list(command), 'log': str(log),
                                    'firmware': [{'label': step.label, 'snapshot': str(snapshot), 'sha256': step.sha256}]})
            write_json(run_dir / 'result.json', record)
        deadline = time.monotonic() + 10
        attempt = 0
        while True:
            directory = run_dir / 'readback' / str(attempt)
            after = active.read(root, directory, registry)
            record['devices'] = after
            write_json(directory / 'identity.json', {'chain': chain, 'devices': after})
            if [d['silicon_id'] for d in after] != [d['silicon_id'] for d in before]:
                raise BuildError('Silicon identity changed during FOSS programming')
            if any(d['usercode'] != identities[d['label']]['usercode'] for d in after):
                raise BuildError('Flash USERCODE does not match the programmed firmware')
            if all(d['sram_usercode'] == identities[d['label']]['usercode'] for d in after):
                return
            if time.monotonic() >= deadline:
                raise BuildError('SRAM USERCODE did not become active after programming')
            time.sleep(0.25)
            attempt += 1
