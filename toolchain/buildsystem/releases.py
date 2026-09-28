"""Create release cycles and select the tracked default under the workspace lock."""
import os
from pathlib import Path
import shutil
import tempfile

from .model import (BuildError, catalog, discover_programs, identifier, load_build,
                    release_directory, resolve_release, program_targets, program_backends)
from .workflow import workspace_lock


def _select(root: Path, name: str):
    path = root / 'programs/releases.toml'
    if path.is_symlink():
        raise BuildError('Release settings must not be a symlink')
    fd, temporary = tempfile.mkstemp(prefix='.releases-', dir=path.parent)
    try:
        with os.fdopen(fd, 'w') as stream:
            stream.write(f'current = "{name}"\n')
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


def select(root: Path, name: str) -> str:
    root = root.resolve()
    with workspace_lock(root, exclusive=True):
        name = resolve_release(root, name)
        _select(root, name)
    return name


def _validate(root: Path, cycle: str):
    for program in set(catalog(root, cycle)) | set(discover_programs(root, cycle)):
        for target in program_targets(root, program, cycle):
            for backend in program_backends(root, program, cycle):
                load_build(root, program, target, backend, cycle)


def create(root: Path, name: str, source: str | None = None) -> Path:
    """Create an empty cycle or copy authored files, then make it current."""
    root = root.resolve()
    name = identifier(name)
    with workspace_lock(root, exclusive=True):
        base = root / 'programs'
        if base.is_symlink():
            raise BuildError('Programs directory must not be a symlink')
        destination = base / name
        if destination.exists() or destination.is_symlink():
            raise BuildError(f'Release cycle already exists: {name}')
        origin = release_directory(root, source) if source is not None else None
        ignored = {'build', '__pycache__', '.pytest_cache'}
        if origin is not None:
            # Validate before copying, including uncatalogued complete programs.
            _validate(root, source)
            for parent, dirs, files in os.walk(origin):
                dirs[:] = [d for d in dirs if d not in ignored]
                for child in dirs + files:
                    path = Path(parent) / child
                    if path.is_symlink():
                        raise BuildError(f'Release copying requires regular authored files: {path}')
        try:
            if origin is None:
                destination.mkdir()
                (destination / 'catalog.toml').write_text('programs = []\n')
            else:
                shutil.copytree(origin, destination,
                                ignore=shutil.ignore_patterns(*ignored, '*.pyc'))
                _validate(root, name)
            description = destination / 'description.rst'
            if not description.exists():
                description.write_text(
                    '.. rubric:: Scope\n\n'
                    'TODO: Describe the purpose and intended hardware of this release cycle.\n\n'
                    '.. rubric:: Firmware and compatibility\n\n'
                    'TODO: Record source revisions, the S3C/D-slot protocol, and compatible program combinations.\n\n'
                    '.. rubric:: Validation\n\n'
                    'TODO: Record validation evidence and remaining limitations.\n')
            _select(root, name)
        except Exception:
            if destination.exists():
                shutil.rmtree(destination)
            raise
        return destination
