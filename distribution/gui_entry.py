"""Windowed standalone launcher; the existing CLI remains independent."""
from cpld_toolchain.programmer_gui import main

if __name__ == '__main__':
    raise SystemExit(main(standalone=True))
