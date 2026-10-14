"""Component entry point; prefer python -m cpld_toolchain."""
from .commands import main

if __name__ == "__main__":
    raise SystemExit(main())
