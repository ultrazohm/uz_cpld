"""Experimental host entry point; protocol implementation belongs to the package."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from cpld_toolchain.programmer.worker import serve
if __name__ == '__main__':
    if '--demo' in sys.argv:
        from demo import operate
        raise SystemExit(serve(operate))
    raise SystemExit(serve())
