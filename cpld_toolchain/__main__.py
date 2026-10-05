"""Unified CPLD command-line interface."""
import sys


def main(argv=None):
    """Dispatch repository actions or a component's standalone interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if args and args[0] == 'generator':
        from .cpld_vhdl_generator.__main__ import main as run
        return run(args[1:])
    from .toolchain.commands import main as run
    return run(args)


if __name__ == '__main__':
    raise SystemExit(main())
