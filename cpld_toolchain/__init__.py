"""CPLD generation, build tooling, and programming in one modular package."""

__version__ = "0.5.0"


def programmer_command():
    """Name the installed user command without changing developer or EXE hints."""
    from pathlib import Path
    import sys

    if not getattr(sys, 'frozen', False) and Path(__file__).with_name('application.json').is_file():
        return 'ultrazohm-cpld-user'
    return 'uz_cpld'


def repository_root():
    """Use the source checkout, or locate a checkout for the installed CLI."""
    from pathlib import Path

    source_root = Path(__file__).resolve().parent.parent
    for candidate in (source_root, Path.cwd(), *Path.cwd().parents):
        if (candidate / 'programs/releases.toml').is_file() and (candidate / 'cpld_toolchain').is_dir():
            return candidate
    return source_root
