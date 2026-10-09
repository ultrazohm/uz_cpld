# Startup file for the interactive shell opened by repository setup.
# Resolve from this file so paths containing spaces work too.
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)/.venv/bin/activate"
