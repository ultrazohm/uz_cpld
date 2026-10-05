"""Unified CPLD command-line interface."""
import sys


def main(argv=None):
    """Dispatch repository actions or a component's standalone interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if args and args[0] in ('setup', 'venv'):
        from .bootstrap import main as setup
        return setup(args[1:])
    if sys.version_info < (3, 10):
        print(
            'error: uz_cpld requires Python 3.10 or newer; running {}.{} ({}). '
            'Run python -m cpld_toolchain setup first.'.format(
                sys.version_info[0], sys.version_info[1], sys.executable),
            file=sys.stderr,
        )
        return 2
    if args and args[0] == 'generator':
        from .cpld_vhdl_generator.__main__ import main as run
        return run(args[1:])
    from .toolchain.commands import main as run
    return run(args)


if __name__ == '__main__':
    raise SystemExit(main())
