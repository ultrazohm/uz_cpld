"""Serialize the scalar, list and inline-table values used by program manifests."""
import json
import math
import re


def dumps(data):
    """Render a flat TOML document, preserving field order."""
    return ''.join(f'{_key(key)} = {_value(value)}\n' for key, value in data.items())


def _string(value):
    value.encode('utf-8')  # Reject surrogate code points, which TOML cannot represent.
    return json.dumps(value, ensure_ascii=False).replace('\x7f', '\\u007f')


def _key(value):
    if not isinstance(value, str):
        raise ValueError('TOML keys must be strings')
    return value if re.fullmatch(r'[A-Za-z0-9_-]+', value) else _string(value)


def _value(value):
    if isinstance(value, dict):
        return '{' + ', '.join(f'{_key(key)} = {_value(item)}' for key, item in value.items()) + '}'
    if isinstance(value, list):
        return '[' + ', '.join(_value(item) for item in value) + ']'
    if isinstance(value, str):
        return _string(value)
    if type(value) in (bool, int):
        return json.dumps(value)
    if type(value) is float and math.isfinite(value):
        return repr(value)
    raise ValueError(f'Unsupported TOML value: {value!r}')
