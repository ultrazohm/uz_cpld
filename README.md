# UltraZohm CPLD

Build, simulate and program UltraZohm MachXO2 D-slot and S3C firmware.
Run commands from this checkout with Python 3.10+.

- [User guide](docs/user/index.rst): setup, select firmware, build and program.
- [Developer guide](docs/developer/index.rst): setup, authoring, tests and technical references.
- [Program catalog](programs/): source, constraints and testbenches grouped by release.

Both guides include a **Quick start reference** with executable commands.
The selected release is recorded in `programs/releases.toml`; use `--release-cycle NAME` to override it for one command.
Diamond is the default backend. Commands use tools installed in the calling environment.

```sh
python -m cpld_toolchain help
python -m cpld_toolchain release-list
python -m cpld_toolchain list
```

Use `python3` if your Linux installation has no `python` command.
To build the full documentation in a configured development environment, run
`python -m cpld_toolchain docs --release-cycle all` and open `docs/_build/html/index.html`.
