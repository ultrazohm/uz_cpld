# CPLD toolchain

The `uz_cpld` repository CLI provides VHDL generation, firmware builds, simulation, documentation and hardware programming.

Follow the [user guide and quick start](../docs/user/index.rst) to set up a checkout, download firmware and program with Diamond.
The [standalone CLI](../docs/standalone.rst) bundles Python for Windows and Ubuntu programming stations.
See the [toolchain contribution guide](../docs/developer/toolchain.rst) for tooling changes and the [HDL developer guide](../docs/developer/hdl.rst) for program authoring.

- `cpld_vhdl_generator/`: CSV/TOML-to-VHDL generation.
- `toolchain/`: setup, builds, simulation, documentation and releases.
- `programmer_helper/`: selections, JTAG identification and Flash programming.

Run `uz_cpld ACTION --help` for command options or `uz_cpld help --command ACTION` for shared defaults.
The `cpld-toolchain` executable and `python -m cpld_toolchain` are equivalent entry points.
Use `uz_cpld doctor` to inspect installed dependencies.

The [standalone generator](../docs/vhdl-generator.rst) also runs outside a checkout:

```sh
uz_cpld generator generator.toml --output .
uz_cpld generator generator.toml --output . --check
```
