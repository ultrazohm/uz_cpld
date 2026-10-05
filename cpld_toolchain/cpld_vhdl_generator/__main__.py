"""Command-line interface, independent of synthesis and repository build tools."""
import argparse
from pathlib import Path
import sys
from .generator import GeneratorError, check, generate


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('config', type=Path, help='Generator TOML configuration')
    parser.add_argument('--output', type=Path, required=True, help='Directory for emitted VHDL and provenance')
    parser.add_argument('--check', action='store_true', help='Check freshness without writing files')
    args = parser.parse_args(argv)
    try:
        if args.check:
            check(args.config, args.output)
            print('Generated VHDL and provenance are current')
        else:
            for source in generate(args.config, args.output):
                print(source)
        return 0
    except (GeneratorError, OSError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
