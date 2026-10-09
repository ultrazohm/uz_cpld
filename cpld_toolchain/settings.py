"""Persistent user settings for the standalone programmer."""
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile

from .toolchain.buildsystem.model import BuildError


def user_directory(kind):
    override = os.environ.get(f'UZ_CPLD_{kind.upper()}_DIR')
    if override:
        return Path(override).expanduser().resolve()
    if sys.platform == 'win32':
        name, default = 'LOCALAPPDATA', 'AppData/Local'
    else:
        name, default = ('XDG_CONFIG_HOME', '.config') if kind == 'config' else ('XDG_DATA_HOME', '.local/share')
    # Do not evaluate the home-directory fallback when an explicit base exists.
    value = os.environ.get(name)
    try:
        base = Path(value) if value else Path.home() / default
    except RuntimeError as exc:
        raise BuildError(f'Cannot determine the user {kind} directory; set '
                         f'UZ_CPLD_{kind.upper()}_DIR or {name}') from exc
    return base / 'uz_cpld'


def config_path():
    return user_directory('config') / 'config.json'


def read():
    path = config_path()
    if not path.exists():
        return {}
    try:
        data = json.loads(path.read_text(encoding='utf-8'))
        if not isinstance(data, dict) or set(data) - {'programmer_path'}:
            raise ValueError('unexpected settings')
        if 'programmer_path' in data and (not isinstance(data['programmer_path'], str) or not data['programmer_path']):
            raise ValueError('programmer_path must be a nonempty string')
        return data
    except (OSError, ValueError) as exc:
        raise BuildError(f'Cannot read settings {path}: {exc}') from exc


def atomic_json(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    name = None
    try:
        with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', dir=path.parent,
                                         prefix='.' + path.name, delete=False) as stream:
            name = Path(stream.name)
            json.dump(data, stream, indent=2, sort_keys=True)
            stream.write('\n')
        name.replace(path)
    finally:
        if name is not None:
            name.unlink(missing_ok=True)


def set_programmer(value):
    data = read()
    if value == 'auto':
        data.pop('programmer_path', None)
    else:
        path = Path(value).expanduser().resolve()
        if not path.is_file() or not shutil.which(str(path)):
            raise BuildError(f'Programmer is not an executable file: {path}')
        if sys.platform == 'win32' and path.suffix.lower() != '.exe':
            raise BuildError('The Windows programmer must be a .exe file')
        data['programmer_path'] = str(path)
    atomic_json(config_path(), data)
    print(f'programmer_path={data.get("programmer_path", "auto")} ({config_path()})')


def programmer_override():
    if os.environ.get('CPLD_PGRCMD'):
        return os.environ['CPLD_PGRCMD'], 'CPLD_PGRCMD'
    saved = read().get('programmer_path')
    return (saved, str(config_path())) if saved else (None, 'automatic discovery')
