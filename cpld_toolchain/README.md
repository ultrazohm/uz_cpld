# CPLD toolchain

One command-line program with three separate components:

- `cpld_vhdl_generator/`: deterministic CSV/TOML-to-VHDL generation.
- `toolchain/`: builds, simulation, documentation, releases and environment setup.
- `programmer_helper/`: programmer selection, identification and flashing.

Run from the repository root:

```sh
python -m cpld_toolchain help
python -m cpld_toolchain new --name my_slot --template generator
python -m cpld_toolchain generate --program cvg_my_slot
python -m cpld_toolchain build --program cvg_my_slot
python -m cpld_toolchain init
python -m cpld_toolchain program --target dslot --dry-run 1
```

Existing `make ACTION key=value` commands use the same dispatcher.
Install with `pip install .` for the `cpld-toolchain` command. Repository workflows
require a checkout containing `programs/`, `archive/` and the supporting tools.
The standalone generator can also run outside a checkout:

```sh
cpld-toolchain generator generator.toml --output .
cpld-toolchain generator generator.toml --output . --check
```

The `cpld-vhdl-generator` executable remains available. Python imports now use
`cpld_toolchain.cpld_vhdl_generator`, `cpld_toolchain.toolchain` and
`cpld_toolchain.programmer_helper`. Component module entry points remain available
under those qualified names. Shared HDL remains in `xo2_library/`.
Repository-wide build artifacts now live in `cpld_toolchain/toolchain/build/`;
existing artifacts should be rebuilt after migration.

See the [quickstart](../docs/quick-start.rst) and
[generator reference](cpld_vhdl_generator/README.md).
