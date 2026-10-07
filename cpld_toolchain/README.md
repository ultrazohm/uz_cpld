# CPLD toolchain

The `uz_cpld` CLI contains three components:

- `cpld_vhdl_generator/`: CSV/TOML-to-VHDL generation.
- `toolchain/`: firmware builds, simulation, documentation, releases and setup.
- `programmer_helper/`: selection, JTAG identification and Flash programming.

See the [user guide](../docs/user/index.rst) for usage and the
[toolchain contribution guide](../docs/developer/toolchain.rst) for tooling changes.
The [HDL developer guide](../docs/developer/hdl.rst) covers handwritten and generated programs.
Each guide includes a quick start reference.
Run `uz_cpld ACTION --help` for Typer command options, or `uz_cpld help --command ACTION` for shared defaults.
All commands remain available; `uz_cpld doctor` reports their environment prerequisites.
The Python package includes the full dependency set. External tools are required only by the workflows that use them.

From the checkout, run `python -m cpld_toolchain setup` with Python 3.8 or newer.
Setup downloads uv and the project Python as needed, installs all locked Python dependencies into `.venv`, and opens an activated shell with `uz_cpld` available.
The `cpld-toolchain` executable and module entry point remain available.
Source builds and local-artifact programming require the checkout and their external tools.
Release ZIP programming and identification can use an installed package without matching sources or a local catalog; use `uz_cpld --workspace DIRECTORY program ...` as described in the [programmer reference](../docs/programmer.rst).
The separate [standalone CLI](../docs/standalone.rst) release bundles Python for Windows and Ubuntu and uses the system's Diamond Programmer.
The standalone generator also runs outside a checkout:

```sh
uz_cpld generator generator.toml --output .
uz_cpld generator generator.toml --output . --check
```

`cpld-vhdl-generator` exposes the standalone generator directly.
See the [generator reference](../docs/vhdl-generator.rst).
