# UltraZohm CPLD

This repository contains the active CPLD program catalog, the standalone `cpld_vhdl_generator`, and Diamond and FOSS firmware toolchains. Vendor reference projects are under `archive/`.

Programs live under `programs/<release_cycle>/<program>/`; `programs/releases.toml` selects the current cycle. Use `make release-new name=r2026_10 from=original` to copy a cycle and select it, or omit `from` for an empty cycle. See [release cycles](docs/releases.rst) for selection and cloning.

**S3C scope:** `s3c_power_on_debounce` is the only implemented S3C controller, based on the archived `S3C_171224/source/Power_on_debounce.vhd` from commit [`6794ce263a7c2b099001e429ce03a2d9b91d9b1d`](https://github.com/ultrazohm/uz_cpld/commit/6794ce263a7c2b099001e429ce03a2d9b91d9b1d) (17 December 2024, “rev05 00”). See [S3C provenance and scope](docs/s3c.rst) for port changes and the distinction from the fixed-output toolchain example.

Run `make` for available commands. Start with [the quick start](docs/quick-start.rst) for creating, simulating, and building a program; see [verification and limits](docs/validation.rst) before using a firmware export.

Use VS Code's **Dev Containers: Reopen in Container** to build and start the development environment, or run `make image` to build the same image for manual use. Diamond is optional; startup reports whether it is found. See [environment setup](docs/environments.rst) for run commands and the optional Diamond mount.

Build the full documentation with `make docs`, then open `docs/_build/html/index.html`. The [generator guide](docs/vhdl-generator.rst), [FOSS pipeline](docs/foss.rst), and [build reports](docs/builds.rst) describe the main workflows.

Use `make programmer` to create `selection.toml`, `make programmer scan` to read D-slot JTAG IDs, and `make programmer program target=s3c|dslot` to program the selected target. After Diamond builds, `make programmer lattice_xcf` generates both Lattice Programmer XCF files. See [programmer commands](docs/programmer.rst).
