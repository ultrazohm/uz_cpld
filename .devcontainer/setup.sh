#!/usr/bin/env bash
set -euo pipefail
if ! command -v codex >/dev/null 2>&1; then
    installer=$(mktemp)
    trap 'rm -f "$installer"' EXIT
    curl -fsSL https://chatgpt.com/codex/install.sh -o "$installer"
    CODEX_NON_INTERACTIVE=1 sh "$installer" --release "${CODEX_VERSION:-latest}"
fi
codex --version
