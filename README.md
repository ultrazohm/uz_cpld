# UltraZohm CPLD

Firmware and tooling for UltraZohm MachXO2 D-slot and S3C devices.

Follow the [user guide and quick start](docs/user/index.rst) to clone the repository, download firmware binaries and program them with Diamond Programmer.
This path requires Git, Python 3.8+ for setup, and Diamond Programmer with its cable drivers; no local firmware build is needed.

- [Standalone CLI](docs/standalone.rst): Windows and Ubuntu application downloads with Python included.
- [HDL developer guide](docs/developer/hdl.rst): create, simulate and build programs.
- [Toolchain contribution guide](docs/developer/toolchain.rst): tooling, tests and CI.
- [Release comparison](docs/releases.rst): program families and S3C/D-slot compatibility.
- [Program catalog](programs/): firmware sources, constraints and testbenches.

Run `uz_cpld help` after setup for the command overview.
To build the full documentation in a configured development environment, run `uz_cpld docs --release-cycle all` and open `docs/_build/html/index.html`.
To run Linux CI checks locally with Bash and Docker, run `bash ci.sh`; see the [CI task inventory](docs/builds.rst) for coverage and logs.
