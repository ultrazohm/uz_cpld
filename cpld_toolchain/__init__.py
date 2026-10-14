"""CPLD generation, build tooling, and programming in one modular package."""

__version__ = "0.5.0"


def repository_root():
    """Use the source checkout, or locate a checkout for the installed CLI."""
    from pathlib import Path

    source_root = Path(__file__).resolve().parent.parent
    for candidate in (source_root, Path.cwd(), *Path.cwd().parents):
        if (candidate / 'programs/releases.toml').is_file() and (candidate / 'cpld_toolchain').is_dir():
            return candidate
    return source_root
