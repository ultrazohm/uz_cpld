"""Run one JSON request in an isolated process."""
import argparse
from ..programmer_service import worker


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('request', help='JSON request file')
    parser.add_argument('result', help='JSON response file')
    args = parser.parse_args(argv)
    return worker(args.request, args.result)


if __name__ == '__main__':
    raise SystemExit(main())
