# Startup file for the interactive shell opened by repository setup.
# Resolve from this file so paths containing spaces work too.
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)/.venv/bin/activate"
# Register completion in this shell only, without installing profile hooks.
# Use the explicit completion protocol rather than detecting the parent shell.
source <(_UZ_CPLD_COMPLETE=source_bash uz_cpld)
