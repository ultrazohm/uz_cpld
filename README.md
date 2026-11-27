# UltraZohm CPLD

Firmware and tooling for UltraZohm MachXO2 D-slot and S3C devices.

Follow the [user guide](docs/user/index.rst) to install `ultrazohm-cpld-user` with uv and program existing firmware. It automatically installs our patched FOSS programmer; firmware downloads default to stable releases.

- [Windows standalone application](docs/standalone.rst): an alternative with Python included, built from the same user wheel. Linux uses the Python package.
- Run `ultrazohm-cpld-user programmer_gui` for the GUI, or `ultrazohm-cpld-user --help` for programmer commands.
- [HDL developer guide](docs/developer/hdl.rst): create, simulate and build programs.
- [Toolchain contribution guide](docs/developer/toolchain.rst): tooling, tests and CI.
- [Release comparison](docs/releases.rst): program families and S3C/D-slot compatibility.
- [Program catalog](programs/): firmware sources, constraints and testbenches.

Developers can run `uz_cpld help` after checkout setup for the development command overview.
To build the full documentation in a configured development environment, run `uz_cpld docs --release-cycle all` and open `docs/_build/html/index.html`.
To run Linux CI checks locally with Bash and Docker, run `bash ci.sh`; see the [CI task inventory](docs/builds.rst) for coverage and logs.

Original project code is licensed under [Apache-2.0](LICENSE). See [licensing scope](LICENSING.md) and [third-party notices](THIRD_PARTY_NOTICES.txt) for exceptions and dependency terms.
