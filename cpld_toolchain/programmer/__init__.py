"""Public, noninteractive programmer API.

Operations raise ProgrammerError (validation) or the underlying OS/tool error.
Instances are synchronous; GUIs should use the JSON worker or a worker process.
"""
from contextlib import contextmanager
from dataclasses import dataclass
from pathlib import Path
import json

from .. import workspace as workspace_state
from ..diagnostics import capture, emit
from ..toolchain.buildsystem.model import BuildError as ProgrammerError


@dataclass(frozen=True)
class ProgrammingPlan:
    """Prepared operation. Treat as opaque; execute with the originating instance."""
    workspace: Path
    backend: str
    target: str
    cable: str | None
    serial: str | None
    probe_index: int | None
    release: str
    output: Path
    builds: tuple
    steps: tuple

    @property
    def summary(self):
        from ..programmer_helper.program import firmware_identity
        return dict(target=self.target, backend=self.backend, release=self.release,
                    assignments=[dict(firmware_identity(build),
                                      position='S3C' if self.target == 's3c' else f'D{index + 1}',
                                      program=build.name)
                                 for _, index, build in self.builds])


class Programmer:
    """Access a workspace using one programmer backend and probe selection.

    ``on_event`` receives dictionaries with ``operation``, ``phase`` and, for
    diagnostic output, ``text``. It must not raise. No method prompts or exits.
    """
    def __init__(self, workspace, *, backend='foss', cable=None, serial=None,
                 probe_index=None, on_event=None):
        self.workspace = Path(workspace).expanduser().resolve()
        # GUI text fields encode an unspecified probe as an empty string.
        serial = None if serial == '' else serial
        cable = None if cable == '' else cable
        for label, value in (('serial', serial), ('cable', cable)):
            if value is not None and (not isinstance(value, str) or any(ord(c) < 32 for c in value)):
                raise ProgrammerError(f'Invalid USB {label}')
        if backend not in ('foss', 'diamond'):
            raise ProgrammerError('Backend must be foss or diamond')
        if probe_index is not None and (type(probe_index) is not int or probe_index < 0):
            raise ProgrammerError('Probe index must be nonnegative')
        if probe_index is not None and serial:
            raise ProgrammerError('Select a probe by index or serial, not both')
        if backend == 'diamond' and (cable or serial):
            raise ProgrammerError('Diamond uses the USB2 cable; select its port with probe_index')
        self.backend, self.cable, self.serial = backend, cable, serial
        self.probe_index, self.on_event = probe_index, on_event

    def _event(self, operation, phase, **data):
        if self.on_event:
            self.on_event(dict(operation=operation, phase=phase, **data))

    @contextmanager
    def _operation(self, name, *, writable=True):
        self._event(name, 'started')
        try:
            if writable:
                workspace_state.prepare(self.workspace)
            with workspace_state.use(self.workspace), capture(
                    lambda text: self._event(name, 'log', text=text)):
                yield
        except BaseException:
            self._event(name, 'failed')
            raise
        else:
            self._event(name, 'completed')

    @staticmethod
    def _chain(target, *, required=False):
        if target not in ('s3c', 'dslot', None) or required and target is None:
            raise ProgrammerError('Choose target=s3c or target=dslot')
        return {'s3c': 's3c', 'dslot': 'dslots'}.get(target)

    def scan(self, *, target=None):
        """Read chain IDs; target=None detects S3C versus D-slots."""
        from .application import scan
        chain = self._chain(target)
        with self._operation('scan'):
            return scan(self.workspace, chain, self.backend, self.serial, self.cable, self.probe_index)

    def identify(self, *, target=None, firmware=None, expected_sha256=None):
        from ..programmer_helper.identify import identify
        chain = self._chain(target)
        with self._operation('identify'):
            info = catalog(firmware) if firmware else None
            if expected_sha256 and (info is None or info['sha256'] != expected_sha256):
                raise ProgrammerError('Firmware changed after it was displayed; select and review it again')
            return identify(self.workspace, chain, self.backend, self.cable, self.serial,
                            self.probe_index, **({'firmware': Path(firmware)} if firmware else {}))

    def prepare_programming(self, selection, *, target, release=None, firmware=None,
                            build_backend=None, expected_sha256=None):
        """Validate and snapshot inputs without accessing USB or writing Flash.

        selection is a selection TOML path or a dictionary with release, s3c,
        and slots (string keys "1".."5"). Omit firmware to use local builds.
        """
        from ..programmer_helper.program import plan
        chain = self._chain(target, required=True)
        if not isinstance(selection, dict):
            selection = Path(selection)
        if firmware is not None:
            firmware = Path(firmware)
        with self._operation('prepare'):
            info = catalog(firmware) if firmware else None
            if info and isinstance(selection, dict):
                selected_release = release or selection.get('release')
                if selected_release:
                    validate_assignments(info, dict(selection, release=selected_release), target)
            if expected_sha256 and (info is None or info['sha256'] != expected_sha256):
                raise ProgrammerError('Firmware changed after review; select and review it again')
            cycle, output, builds, steps = plan(self.workspace, selection, release, chain,
                self.backend, self.cable, self.serial, self.probe_index,
                build_backend=build_backend, source='zip' if firmware else 'local', firmware=firmware)
            if expected_sha256 and builds[0][2].package.evidence['archive_sha256'] != expected_sha256:
                raise ProgrammerError('Firmware changed during preparation; select and review it again')
            return ProgrammingPlan(self.workspace, self.backend, target, self.cable, self.serial,
                                   self.probe_index, cycle, output, tuple(builds), tuple(steps))

    def execute(self, prepared):
        """Revalidate the prepared inputs, program, verify, and return readback."""
        from ..programmer_helper.program import execute
        if not isinstance(prepared, ProgrammingPlan) or (
                prepared.workspace, prepared.backend, prepared.cable, prepared.serial, prepared.probe_index) != (
                self.workspace, self.backend, self.cable, self.serial, self.probe_index):
            raise ProgrammerError('Plan belongs to a different workspace or probe configuration')
        with self._operation('program'):
            directory = execute(self.workspace, prepared.release, self._chain(prepared.target, required=True),
                                self.backend, prepared.output, list(prepared.builds), list(prepared.steps),
                                self.cable, self.serial, self.probe_index)
            record = json.loads((directory / 'result.json').read_text())
            return dict(message='Flash programmed, verified and identity readback confirmed.',
                        devices=record.get('devices', []), record=str(directory / 'result.json'))

    def prepare_review(self, selection, *, target, release=None, firmware=None,
                       build_backend=None, expected_sha256=None):
        """Persist a reviewed plan for execution in another worker process."""
        from . import plans
        with self._operation('prepare_review'):
            return plans.prepare(self, selection, target=target, release=release, firmware=firmware,
                                 build_backend=build_backend, expected_sha256=expected_sha256)

    def execute_review(self, plan_id, review_sha256):
        """Execute a persisted plan only if its record and inputs still match."""
        from . import plans
        with self._operation('execute_review'):
            return plans.execute(self, plan_id, review_sha256)

    def program(self, selection, *, target, release=None, firmware=None,
                build_backend=None, expected_sha256=None):
        """Prepare and execute immediately; callers own user confirmation."""
        return self.execute(self.prepare_programming(selection, target=target, release=release,
            firmware=firmware, build_backend=build_backend, expected_sha256=expected_sha256))

    def save_assignments(self, selection, *, destination=None, override=False,
                         firmware=None, expected_sha256=None):
        """Persist only explicit assignments; omitted targets remain unassigned."""
        from .selection import validate, text, write_file
        selection = validate(selection)
        path = Path(destination) if destination else self.workspace / 'selection.toml'
        with self._operation('save'):
            if path.exists() and not override:
                raise ProgrammerError(f'{path} already exists; use override=True to replace it')
            if firmware:
                info = catalog(firmware)
                if expected_sha256 and info['sha256'] != expected_sha256:
                    raise ProgrammerError('Firmware changed after review; select and review it again')
                for key, target in (('s3c', 's3c'), ('slots', 'dslot')):
                    if key in selection:
                        validate_assignments(info, selection, target)
                self.select_firmware(firmware)
            if not write_file(path, text(selection), override=override):
                raise ProgrammerError(f'{path} already exists; use override=True to replace it')
            emit(f'Saved assignments to {path}')
            return dict(path=str(path), selection=selection, message='Assignments saved to selection.toml.')

    def initialize_assignments(self, selection=None, *, destination=None, override=False):
        """Explicitly initialize the legacy editable CLI template, with defaults."""
        from ..programmer_helper.program import create_selection
        selection = selection or {}
        path = Path(destination) if destination else self.workspace / 'selection.toml'
        with self._operation('initialize'):
            return create_selection(path, release=selection.get('release'), s3c=selection.get('s3c'),
                slots={int(k): v for k, v in selection.get('slots', {}).items()}, override=override)

    def build_selection(self, selection, *, release=None, target=None, backend='diamond'):
        from ..programmer_helper.program import build_selection
        self._chain(target)
        with self._operation('build_selection'):
            return build_selection(self.workspace, Path(selection), release, target=target, backend=backend)

    def request(self, action, **options):
        """Structured application operations, also used by the JSON worker.

        Actions include prepare, execute, program, build_selection, save, initialize,
        scan, identify, firmware operations and drivers. Never prompts.
        """
        from .application import validate_request, _operate
        validate_request(action, options)
        with self._operation(action, writable=action not in ('drivers', 'releases')):
            return _operate(dict(options, action=action, workspace=str(self.workspace), backend=self.backend,
                                serial=self.serial, cable=self.cable, probe_index=self.probe_index), api=self)

    def select_firmware(self, path):
        return self.request('select', firmware=str(Path(path).resolve()))

    def load(self):
        return self.request('load')

    def releases(self):
        return self.request('releases')

    def download(self, release_id, *, commit):
        return self.request('download', release_id=release_id, release_commit=commit)

    def download_firmware(self, *, remote=None, output=None, git_url=None, branch=None,
                          stable=False):
        """Download without selecting; stable=False follows the checkout/branch."""
        from ..toolchain import firmware_download as downloads
        with self._operation('download'):
            if stable:
                repository = downloads.github_repository(git_url) if git_url else 'ultrazohm/uz_cpld'
                path = downloads.download_stable(self.workspace, repository, output=output)
            else:
                path = downloads.download(self.workspace, remote=remote, output=output,
                                          git_url=git_url, branch=branch)
            return dict(firmware=str(path))

    def setup_drivers(self, *, device_id=None, default=False):
        return self.request('drivers', device_id=device_id, default_driver=default)


from .application import catalog, validate_assignments


def operate(request, *, on_event=None):
    """Execute a JSON-compatible request through the same public Python API."""
    options = dict(request)
    root = options.pop('workspace')
    action = options.pop('action')
    client = Programmer(root, on_event=on_event, **{key: options.pop(key) for key in
        ('backend', 'serial', 'cable', 'probe_index') if key in options})
    return client.request(action, **options)

__all__ = ['Programmer', 'ProgrammingPlan', 'ProgrammerError', 'catalog', 'operate', 'validate_assignments']
