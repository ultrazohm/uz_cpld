"""Run one JSON request in an isolated process."""
import argparse
from ..programmer_service import worker


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--stdio', action='store_true')
    parser.add_argument('request', nargs='?', help='JSON request file')
    parser.add_argument('result', nargs='?', help='JSON response file')
    args = parser.parse_args(argv)
    if args.stdio:
        from .worker import serve
        return serve()
    if not args.request or not args.result:
        parser.error('Supply request and result paths, or --stdio')
    return worker(args.request, args.result)


if __name__ == '__main__':
    raise SystemExit(main())
