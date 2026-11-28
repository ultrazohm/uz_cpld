#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: diamond_program.sh INPUT.xcf OUTPUT.log" >&2
    exit 2
fi

diamond_root=${DIAMOND_ROOT:-/opt/diamond}
bindir="$diamond_root/bin/lin64"
export FOUNDRY="${FOUNDRY:-$diamond_root/ispfpga}"
export PATH="$bindir:$FOUNDRY/bin/lin64:$PATH"
export LD_LIBRARY_PATH="$bindir:$FOUNDRY/bin/lin64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
if [[ -f "$diamond_root/license/license.dat" ]]; then
    export LM_LICENSE_FILE="$diamond_root/license/license.dat${LM_LICENSE_FILE:+:$LM_LICENSE_FILE}"
fi
if [[ -f "$bindir/diamond_env" ]]; then
    # Diamond's documented Linux setup supplies its shared libraries and FOUNDRY.
    export bindir
    set +u
    source "$bindir/diamond_env"
    set -u
fi

pgrcmd=${CPLD_PGRCMD:-}
if [[ -z "$pgrcmd" ]]; then
    for candidate in "$diamond_root/programmer/bin/lin64/pgrcmd" "$bindir/pgrcmd"; do
        if [[ -x "$candidate" ]]; then
            pgrcmd=$candidate
            break
        fi
    done
fi
if [[ -z "$pgrcmd" ]] && command -v pgrcmd >/dev/null 2>&1; then
    pgrcmd=$(command -v pgrcmd)
fi
if [[ -z "$pgrcmd" || ! -x "$pgrcmd" ]]; then
    echo "Diamond Programmer pgrcmd was not found. Mount Diamond and set DIAMOND_ROOT or CPLD_PGRCMD." >&2
    exit 2
fi

exec "$pgrcmd" -infile "$1" -logfile "$2"
