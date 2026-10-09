#!/usr/bin/env bash
# The same Linux checks locally, in a Dev Container, and in GitHub Actions.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
if [[ $# != 0 ]]; then
    echo 'Usage: bash ci.sh (no arguments)' >&2
    exit 2
fi

# Host prerequisites are only Bash and Docker; no host Python setup is needed.
if [[ ${CPLD_TOOLCHAIN_CONTAINER:-0} != 1 ]]; then
    docker build --platform linux/amd64 --target toolchain \
        -f .devcontainer/Dockerfile -t uz-cpld-toolchain .
    exec docker run --rm --init --platform linux/amd64 \
        --user "$(id -u):$(id -g)" \
        --mount "type=bind,source=$PWD,target=/work" -w /work \
        uz-cpld-toolchain bash ci.sh
fi

mkdir -p build
failed=()
check() {
    local name=$1 log=$2
    shift 2
    printf '\nRunning %s\n' "$name"
    # pipefail includes both the command and log writer. Keep collecting
    # independent results, then fail the whole invocation if any check failed.
    if "$@" 2>&1 | tee "$log"; then
        return 0
    else
        failed+=("$name")
    fi
}

check 'Python and uv environment' build/ci-environment.log python - <<'PY'
import json
from pathlib import Path
import subprocess
import sys

if sys.prefix != '/opt/uz-cpld-env':
    raise SystemExit(f'Unexpected Python environment: {sys.prefix}')
if sys.version.split()[0] != Path('.python-version').read_text().strip():
    raise SystemExit('Python version does not match .python-version')
version = json.loads(Path('cpld_toolchain/uv-bootstrap.json').read_text())['version']
if subprocess.check_output(['uv', '--version'], text=True).split()[1] != version:
    raise SystemExit('uv version does not match uv-bootstrap.json')
subprocess.run(['uz_cpld', 'help', '--command', 'setup'], check=True)
subprocess.run(['uv', 'run', 'python', '-c', "import sys; assert sys.prefix == '/opt/uz-cpld-env'"], check=True)
PY
check 'Tooling tests' build/ci-tests.log make test
check 'Original FOSS firmware' build/ci-foss.log make build_all backend=foss release_cycle=original
check 'Heartbeat FOSS build and comparison' build/ci-heartbeat.log bash -e -c '
    make build program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss
    make compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss
'
check 'Documentation and HDL simulations' build/ci-docs.log make docs release_cycle=all
check 'Validation summary' build/ci-summary.md \
    python cpld_toolchain/toolchain/ci_summary.py --backend foss --test-log build/ci-tests.log

if [[ ${#failed[@]} != 0 ]]; then
    {
        printf '\n### Failed CI checks\n\n'
        printf -- '- %s\n' "${failed[@]}"
    } | tee -a build/ci-summary.md >&2
    exit 1
fi
echo 'All Linux CI checks passed. Logs: build/ci-*.log; summary: build/ci-summary.md'
