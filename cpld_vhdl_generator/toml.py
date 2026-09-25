"""Serialize the scalar, list and inline-table values used by program manifests."""
import json


def dumps(data):
    """Render a flat TOML document, preserving field order."""
    return ''.join(f'{key} = {_value(value)}\n' for key, value in data.items())


def _value(value):
    if isinstance(value, dict):
        return '{' + ', '.join(f'{key} = {_value(item)}' for key, item in value.items()) + '}'
    if isinstance(value, list):
        return '[' + ', '.join(_value(item) for item in value) + ']'
    return json.dumps(value)
