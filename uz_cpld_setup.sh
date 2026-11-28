#!/usr/bin/env bash
# Run from any directory; setup opens an activated shell by default.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

for candidate in python3 python; do
    if command -v "$candidate" >/dev/null 2>&1 &&
        "$candidate" -c 'import sys; sys.exit(sys.version_info < (3, 8))' >/dev/null 2>&1; then
        exec "$candidate" -m cpld_toolchain setup "$@"
    fi
done

echo 'Setup requires Python 3.8 or newer on PATH. Install Python, then run this script again.' >&2
exit 1
