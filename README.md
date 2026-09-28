# UltraZohm CPLD

This repository contains the active CPLD program catalog, the standalone `cpld_vhdl_generator`, and Diamond and FOSS firmware toolchains. Vendor reference projects are under `archive/`.

Programs live under `programs/<release_cycle>/<program>/`; `programs/releases.toml` selects the current cycle. Use `make release-new name=r2026_10 from=original` to copy a cycle and select it, or omit `from` for an empty cycle. See [release cycles](docs/releases.rst) for selection and cloning.

Run `make` for available commands. Start with [the quick start](docs/quick-start.rst) for creating, simulating, and building a program; see [verification and limits](docs/validation.rst) before using a firmware export.

Build the full documentation with `make docs`, then open `docs/_build/html/index.html`. The [generator guide](docs/vhdl-generator.rst), [FOSS pipeline](docs/foss.rst), and [build reports](docs/builds.rst) describe the main workflows.
