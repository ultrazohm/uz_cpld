# CPLD VHDL generator

Generates VHDL-1993 slot programs from CSV routing and TOML configuration, independently of the build toolchain.
Run from the checkout, or install with `pip install .` to use `cpld-vhdl-generator`.
Python 3.10 requires `tomli`; newer Python versions use the standard library.

## Quick start

Run these commands from the repository root:

```sh
make new name=my_slot template=generator
# Edit programs/my_slot/routing.csv
make generate program=my_slot
make sim program=my_slot
make build program=my_slot backend=diamond
```

The starter contains `routing.csv`, `generator.toml` and `description.rst` in `programs/my_slot/`.
Generation creates:

* `my_slot.vhdl`: VHDL matching the routing.
* `my_slot_tb.py`: a matching cocotb testbench.
* `my_slot_constraints.lpf`: D-slot board constraints.
* `my_slot.toml`: the build manifest.
* `generator-output.json`: the generation receipt.

`make generate` validates the finished project and registers it in the catalog.
Edit the CSV or configuration and run the same generation command to update the generated files together.
The testbench follows the CSV input/output directions and checks both routing states, constants, high impedance, and configured control conditions.

You can also run the standalone generator directly; this does not update the repository catalog:

```sh
python3 -m cpld_vhdl_generator programs/my_slot/generator.toml --output programs/my_slot
python3 -m cpld_vhdl_generator programs/my_slot/generator.toml --output programs/my_slot --check
```

## Routing

```csv
output,normal_state,safe_state
d_00,fpga_00,0
d_01,fpga_01,fpga_01
fpga_02,d_02,0
d_29,0,0
```

Each row declares an output and its value in normal_state and safe_state.
The examples show gated forwarding, forwarding in every state, routing toward the FPGA, and a constant-low output.
Only `d_00`–`d_29` and `fpga_00`–`fpga_29` are valid pin names, with exactly two digits and lowercase letters.
State values accept those input names, `0`, `1`, or uppercase `Z`.
Every output requires both state values.
Outputs must be unique and cannot also be used as inputs, including in `enable`.
Multiple outputs may share an input.
Expressions and bidirectional ports are unsupported.

The top-level interface includes all 60 data pins.
Pins omitted from the output column are inputs, including unused pins; they have no HDL output driver.
Use an explicit constant row when a pin must be driven to a defined level.
A header-only CSV leaves all data pins as inputs.
Electrical pull and unused-pad settings belong to the board constraints and synthesis configuration.
The fixed S3C signals and unused `i2c_scl`/`i2c_sda` inputs are provided separately and cannot appear in the CSV.

## Configuration

```toml
schema_version = 3
name = "my_slot"
routing = "routing.csv"
contract = "s3c_power_on_debounce_v1"
clock = "machxo2"
pilot_policy = "unused"
# Optional shared HDL directory; defaults to this package's hdl directory:
# s3c_library = "../../cpld_vhdl_generator/hdl"
# Optional input levels required for normal_state:
# enable = {fpga_26 = 0, fpga_27 = 0, fpga_28 = 1, fpga_29 = 1}
# Optional complete D-slot project (the repository starter sets this):
# target = "uz_dslot_xo2"
```

`clock` selects `machxo2` for the internal nominal 2.08 MHz oscillator or `external` for `clk` and active-high `reset` ports.
`name` must be a lowercase VHDL identifier. VHDL keywords, the `cvg_` prefix, and names used by generated declarations (`ieee`, `std`, `work`, `s3c`, `s3c_logic`, `std_logic`, `natural`, `string`, `rising_edge`, `true`, `false`, and `osch`) are reserved.
`pilot_policy` selects `unused` or `required`.
Required pilot monitoring keeps the controller in `safe_state` unless synchronized `pilot_in` is high.
The controller starts in `safe_state`, synchronizes controls, and enters `normal_state` when the S3C, pilot policy, and optional enable pattern permit operation.
It returns to `safe_state` when any condition fails and resumes `normal_state` automatically when all conditions are satisfied.
After startup, a stable control change reaches the state on the third clock edge counting its first sampling edge.
Data forwarding is combinational.

`target = "uz_dslot_xo2"` also generates `<name>.toml`, `<name>_tb.py` and `<name>_constraints.lpf`.
This project mode uses `clock = "machxo2"`, the packaged D-slot board pin map and electrical settings, and the Diamond backend.
Without `target`, the generator emits VHDL and provenance only.

## S3C contract

The built-in `s3c_power_on_debounce_v1` contract uses active-high ReqSafeState, ignores CarrierReady, asserts SlotOK only in normal_state, and keeps ReqOE high.
To describe another level-based contract, select a relative TOML path with these fields:

```toml
id = "my_s3c_v1"
compatible_s3c = ["my_s3c"]
implementation = "level_signals"
request_mode = "active_low"
carrier_ready = "active_high"
slotok = [1, 0]
reqoe = [1, 1]
```

`request_mode` accepts `active_high` or `active_low`.
`carrier_ready` accepts `unused`, `active_high`, or `active_low`.
Status levels are listed in `normal_state`, `safe_state` order.
Unknown request levels or inactive/unknown readiness request safe_state.
Compatibility names declare the intended firmware pairing; they do not detect installed firmware.

## Shared library and output

The shared VHDL lives in `cpld_vhdl_generator/hdl` and is compiled independently for each program into library `s3c`.
`s3c_logic.vhdl` declares the common entity interface and generics.
`level_signals.vhdl` implements the two-state controller for level-based S3C contracts.
The contract's `implementation` selects an architecture and its same-named VHDL file from the shared directory.
Additional implementations must provide that architecture for the same entity interface.
Only the entity declaration and selected architecture are compiled.

The generator writes `<name>.vhdl` and `generator-output.json` into the program directory.
In project mode, the manifest, testbench and constraints are also owned generated files; edit the routing/configuration and regenerate to update them together.
The top level supplies clock/reset, routing, and generics derived from the selected contract and pilot policy.
It explicitly instantiates `entity s3c.s3c_logic(level_signals)` for the built-in contract.
Compile the shared entity and architecture in library `s3c`, followed by the generated top level in library `work`.
`source_entries(load_config(config_path), output_directory)` returns the ordered paths and libraries for standalone build tools.
The JSON record uses `s3c_library` and `output` as path bases and hashes all shared dependencies.
Changing shared HDL requires regenerating dependent programs to refresh their provenance.
Edit the CSV or TOML, regenerate, and use `--check` to verify freshness.
Manually edited or unowned output files are never overwritten.
For manually maintained VHDL, stop regenerating and remove the repository manifest's optional `generator` field.

## Tests

HDL tests require GHDL.
Run the direct controller testbench with `python3 -m unittest cpld_vhdl_generator.tests.test_s3c_logic -v`.
It checks state and status outputs, startup/reset, synchronization latency, both polarities, pilot, readiness, and enable conditions.
Run the actual S3C interaction testbench with `python3 -m unittest toolchain.tests.test_s3c_interaction -v` from the repository.
It connects the generated slot and shared controller to the real `s3c_power_on_debounce` sources through startup, soft stop, and re-enable.
Its simulation oscillator runs faster to exercise the original debounce and startup counters quickly.
`make test` runs both testbenches and generator/build regressions.
