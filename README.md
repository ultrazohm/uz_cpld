# UltraZohm CPLD

This repository contains the active CPLD program catalog, the standalone `cpld_vhdl_generator`, the shared [`xo2_library`](xo2_library/README.md), and Diamond and FOSS firmware toolchains. Vendor reference projects are under `archive/`.

Programs live under `programs/<release_cycle>/<program>/`; `programs/releases.toml` selects the current cycle. Use `python -m toolchain release-new --name r2026_10 --from original` to copy a cycle and select it, or omit `from` for an empty cycle. See [release cycles](docs/releases.rst) for selection and cloning.

**S3C controllers:** `s3c_power_on_debounce` is based on the December 2024 source (`6794ce2`); `s3c_rev6_beta` uses the October 2025 Rev06 sources and constraints from `2107cd5`, with one unused driver commented out for GHDL synthesis. Both use static safe-state signaling without a heartbeat. See [S3C provenance and scope](docs/s3c.rst) for exact revisions, differences, and validation limits.

See the [tools and environment overview](docs/tool-environments.rst) for native Linux/Windows, venv and Docker support.

Run `python -m toolchain help` for available commands. Start with [the quick start](docs/quick-start.rst) for creating, simulating, and building a program; see [verification and limits](docs/validation.rst) before using a firmware export.

Use VS Code's **Dev Containers: Reopen in Container** to build and start the development environment, or run `python -m toolchain image` to build the same image for manual use. Diamond is optional; startup reports whether it is found. See [environment setup](docs/environments.rst) for run commands and the optional Diamond mount.

The primary CLI is `python -m toolchain` on Linux and Windows. Run `python -m toolchain venv` to install the Python dependencies and open an activated shell. Diamond, its license and programmer drivers are installed separately. See [Windows setup](docs/windows.rst) or [Linux setup](docs/environments.rst#native-python-environment-for-diamond). The Makefile remains an optional Linux wrapper.

Build the full documentation with `python -m toolchain docs`, then open `docs/_build/html/index.html`. The [generator guide](docs/vhdl-generator.rst), [FOSS pipeline](docs/foss.rst), and [build reports](docs/builds.rst) describe the main workflows.

Use `python -m toolchain init` to create `selection.toml`, `python -m toolchain scan` to read D-slot JTAG IDs, and `python -m toolchain program --target s3c|dslot` to program the selected target. After Diamond builds, `python -m toolchain programmer-project` generates both Lattice Programmer XCF files. See [programmer commands](docs/programmer.rst).

`python -m toolchain usercodes` lists permanent program numbers; new programs and clones receive numbers automatically. `python -m toolchain identify --target s3c|dslot` reads the programmed firmware identity and silicon TraceID. Keep `programs/usercodes.json` with your source changes. FOSS programming uses the patched openFPGALoader included in the image; see [firmware identity](docs/firmware-identity.rst) for allocation, readback and native flasher setup.

Use `python -m toolchain help` for a compact list of all commands grouped by tool.
Use `python -m toolchain help --command ACTION` for required and optional arguments.
For a clean clone, the usual workflow is:

```sh
python -m toolchain doctor
python -m toolchain build-all
python -m toolchain init
# Edit selection.toml for your programs and release.
python -m toolchain programmer-project
python -m toolchain scan --target dslot
python -m toolchain identify --target dslot
python -m toolchain program --target dslot --dry-run 1
# After reviewing the selection: python -m toolchain program --target dslot
```

Diamond is the default. `--backend foss` opts into FOSS for both firmware and
programming; `--build-backend` and `--programmer-backend` override each part.
See [the command reference](docs/commands.rst) for scope, previews, and runners.
