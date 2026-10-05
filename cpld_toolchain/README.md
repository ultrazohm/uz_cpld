# CPLD toolchain

The `uz_cpld` CLI contains three components:

- `cpld_vhdl_generator/`: CSV/TOML-to-VHDL generation.
- `toolchain/`: firmware builds, simulation, documentation, releases and setup.
- `programmer_helper/`: selection, JTAG identification and Flash programming.

See the [user guide](../docs/user/index.rst) for usage and the
[developer guide](../docs/developer/index.rst) for setup, tests and implementation references.
Both include a quick start reference.
Run `uz_cpld help --command ACTION` for command options.

From the checkout, run `python -m cpld_toolchain setup` with Python 3.8 or newer.
Setup downloads uv and the project Python as needed, installs all locked Python dependencies into `.venv`, and opens an activated shell with `uz_cpld` available.
The `cpld-toolchain` executable and module entry point remain available.
Repository workflows require the complete checkout and their external tools.
The standalone generator also runs outside a checkout:

```sh
uz_cpld generator generator.toml --output .
uz_cpld generator generator.toml --output . --check
```

`cpld-vhdl-generator` exposes the standalone generator directly.
See the [generator reference](../docs/vhdl-generator.rst).
