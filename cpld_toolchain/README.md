# CPLD toolchain

The `python -m cpld_toolchain` CLI contains three components:

- `cpld_vhdl_generator/`: CSV/TOML-to-VHDL generation.
- `toolchain/`: firmware builds, simulation, documentation, releases and setup.
- `programmer_helper/`: selection, JTAG identification and Flash programming.

See the [user guide](../docs/user/index.rst) for usage and the
[developer guide](../docs/developer/index.rst) for setup, tests and implementation references.
Both include a quick start reference.
Run `python -m cpld_toolchain help --command ACTION` for command options.

Install with `python -m pip install .` for the `cpld-toolchain` executable.
Repository workflows require the complete checkout and their external tools.
The standalone generator also runs outside a checkout:

```sh
cpld-toolchain generator generator.toml --output .
cpld-toolchain generator generator.toml --output . --check
```

`cpld-vhdl-generator` exposes the standalone generator directly.
See the [generator reference](../docs/vhdl-generator.rst).
