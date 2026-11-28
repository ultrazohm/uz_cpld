"""Explicit assignment persistence, separate from CLI template initialization."""
import json
import os
from pathlib import Path
import tempfile

from ..programmer_helper.helper import read_selection
from ..toolchain.buildsystem.model import BuildError


def validate(selection):
    if not isinstance(selection, dict) or not {'s3c', 'slots'}.intersection(selection):
        raise BuildError('Supply an S3C assignment or all five D-slot assignments')
    # Validate each supplied target, including targets not used by the next write.
    for key, chain in (('s3c', 's3c'), ('slots', 'dslots')):
        if key in selection:
            read_selection(selection, chain)
    return json.loads(json.dumps(selection))


def text(selection):
    lines = [f'{key} = {json.dumps(selection[key])}'
             for key in ('release', 's3c', 'build_backend') if key in selection]
    if 'slots' in selection:
        lines += ['', '[slots]']
        lines += [f'"{i}" = {json.dumps(selection["slots"][str(i)])}' for i in range(1, 6)]
    return '\n'.join(lines) + '\n'


def write_file(destination, content, *, override=False):
    """Return whether a file was written; never overwrite implicitly."""
    destination = Path(destination)
    if destination.is_symlink() or destination.exists() and not destination.is_file():
        raise BuildError(f'Cannot write a symlink or non-file selection: {destination}')
    if not override:
        try:
            with destination.open('x', encoding='utf-8') as stream:
                stream.write(content)
        except FileExistsError:
            return False
    else:
        temporary = None
        try:
            with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', dir=destination.parent,
                                             prefix=f'.{destination.name}-', delete=False) as stream:
                temporary = Path(stream.name)
                stream.write(content)
            os.replace(temporary, destination)
        finally:
            if temporary is not None:
                temporary.unlink(missing_ok=True)
    return True
