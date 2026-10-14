#!/usr/bin/env bash
# Runs on the Docker host, before Dev Containers creates or starts the container.
set -euo pipefail
config_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
state="$config_dir/.local"
mkdir -p "$state"

# Keep the selected host path across VS Code restarts. Never source local config.
explicit=1
if [[ -n ${DIAMOND_HOST_ROOT:-} ]]; then
    diamond_root=$DIAMOND_HOST_ROOT
elif [[ -n ${DIAMOND_ROOT:-} ]]; then
    diamond_root=$DIAMOND_ROOT
elif [[ -f "$state/diamond-root" ]]; then
    diamond_root=$(cat "$state/diamond-root")
else
    diamond_root="$HOME/lscc/diamond/3.14"
    explicit=0
fi

if [[ $diamond_root == none ]]; then
    printf 'none\n' > "$state/diamond-root"
elif [[ -x "$diamond_root/bin/lin64/diamondc" ]]; then
    diamond_root=$(cd -- "$diamond_root" && pwd -P)
    printf '%s\n' "$diamond_root" > "$state/diamond-root"
elif [[ $explicit == 1 ]]; then
    echo "Full Diamond launcher not found: $diamond_root/bin/lin64/diamondc" >&2
    echo "Set DIAMOND_HOST_ROOT to the Linux installation root, or to 'none' for FOSS only." >&2
    echo "The saved host path is in $state/diamond-root." >&2
    exit 1
else
    diamond_root=none
fi

if [[ $diamond_root == none ]]; then
    mkdir -p "$state/empty-diamond"
    ln -sfn -- "$state/empty-diamond" "$state/diamond"
    echo "Diamond not selected; FOSS tools remain available."
else
    ln -sfn -- "$diamond_root" "$state/diamond"
    echo "Diamond host installation: $diamond_root -> /opt/diamond (read-only)."
    if [[ ! -r "$diamond_root/license/license.dat" && -z ${LM_LICENSE_FILE:-} ]]; then
        echo "No default license found; configure a license before running Diamond builds." >&2
    fi
fi
