# UltraZohm CPLD

This repository contains the active CPLD program catalog, the standalone `cpld_vhdl_generator`, and Diamond and FOSS firmware toolchains. Vendor reference projects are under `archive/`.

Programs live under `programs/<release_cycle>/<program>/`; `programs/releases.toml` selects the current cycle. Use `make release-new name=r2026_10 from=original` to copy a cycle and select it, or omit `from` for an empty cycle. See [release cycles](docs/releases.rst) for selection and cloning.

**S3C controllers:** `s3c_power_on_debounce` is based on the December 2024 source (`6794ce2`); `s3c_rev6_beta` uses the October 2025 Rev06 sources and constraints from `2107cd5`, with one unused driver commented out for GHDL synthesis. Both use static safe-state signaling without a heartbeat. See [S3C provenance and scope](docs/s3c.rst) for exact revisions, differences, and validation limits.

Run `make` for available commands. Start with [the quick start](docs/quick-start.rst) for creating, simulating, and building a program; see [verification and limits](docs/validation.rst) before using a firmware export.

Use VS Code's **Dev Containers: Reopen in Container** to build and start the development environment, or run `make image` to build the same image for manual use. Diamond is optional; startup reports whether it is found. See [environment setup](docs/environments.rst) for run commands and the optional Diamond mount.

Build the full documentation with `make docs`, then open `docs/_build/html/index.html`. The [generator guide](docs/vhdl-generator.rst), [FOSS pipeline](docs/foss.rst), and [build reports](docs/builds.rst) describe the main workflows.

Use `make programmer` to create `selection.toml`, `make programmer scan` to read D-slot JTAG IDs, and `make programmer program target=s3c|dslot` to program the selected target. After Diamond builds, `make programmer lattice_xcf` generates both Lattice Programmer XCF files. See [programmer commands](docs/programmer.rst).
