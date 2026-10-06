# UltraZohm CPLD

Build, simulate and program UltraZohm MachXO2 D-slot and S3C firmware.
Start setup from this checkout with Python 3.8 or newer.

- [User guide](docs/user/index.rst): setup, select firmware, build and program.
- [Toolchain contribution](docs/developer/toolchain.rst): tooling setup, implementation, tests and CI.
- [HDL developer](docs/developer/hdl.rst): handwritten and generated programs, simulation and validation.
- [Releases](docs/releases.rst): compare program families, protocols and build support.
- [Program catalog](programs/): source, constraints and testbenches grouped by release.

All three guides include a **Quick start reference** with executable commands.
The selected release is recorded in `programs/releases.toml`; use `--release-cycle NAME` to override it for one command.
Diamond is the default backend. Commands use tools installed in the calling environment.

After cloning, run setup:

```sh
python -m cpld_toolchain setup
uz_cpld help
uz_cpld release_list
uz_cpld list
```

Use `python3` if your Linux installation has no `python` command.
Setup downloads a pinned uv into `.tools/`, obtains Python 3.10.12, and creates `.venv` with all locked Python dependencies, including simulation and documentation packages.
It opens an activated shell with `uz_cpld` available; no prior uv, pip or modern Python installation is needed.
Internet access is required for the initial downloads.
In a new shell, run `source .venv/bin/activate` (PowerShell: `& .\.venv\Scripts\Activate.ps1`).
Use `--activate 0` to install without opening a shell.
Diamond, HDL tools and hardware drivers need separate installation.
The container uses the same pinned Python, uv release and dependency lockfile, with its environment under `/opt/uz-cpld-env`.
The `python -m cpld_toolchain` and `cpld-toolchain` entry points remain available.
To build the full documentation in a configured development environment, run
`uz_cpld docs --release-cycle all` and open `docs/_build/html/index.html`.
