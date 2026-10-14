# CPLD VHDL generator

Generate VHDL slot programs from CSV routing and TOML configuration.
For a repository project, follow the [program authoring walkthrough](../../docs/quick-start.rst#generate-a-program-from-csv) to create a starter, generate, simulate and build it.
The [generator reference](../../docs/vhdl-generator.rst) documents configuration, contracts, shared HDL and generated file ownership.

For standalone use, install the package with Python 3.10+ and run:

```sh
cpld-vhdl-generator generator.toml --output .
cpld-vhdl-generator generator.toml --output . --check
```

`python -m cpld_toolchain.cpld_vhdl_generator` is equivalent.
Standalone generation uses explicit config and output paths and does not update the repository catalog.
Edit the CSV/TOML and regenerate to update outputs; `--check` verifies freshness without writing files.
