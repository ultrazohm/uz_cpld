# CPLD VHDL generator

Generates VHDL-1993 slot programs from CSV routing and TOML configuration, independently of the build toolchain.
Run from the checkout, or install with `pip install .` to use `cpld-vhdl-generator`.
Python 3.10 requires `tomli`; newer Python versions use the standard library.

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

All 60 data pins remain in the top-level interface.
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
# Optional input levels required for normal_state:
# enable = {fpga_26 = 0, fpga_27 = 0, fpga_28 = 1, fpga_29 = 1}
```

`clock` selects `machxo2` for the internal nominal 2.08 MHz oscillator or `external` for `clk` and active-high `reset` ports.
`pilot_policy` selects `unused` or `required`.
Required pilot monitoring keeps the controller in `safe_state` unless synchronized `pilot_in` is high.
The controller starts in `safe_state`, synchronizes controls, and enters `normal_state` when the S3C, pilot policy, and optional enable pattern permit operation.
It returns to `safe_state` when any condition fails and resumes `normal_state` automatically when all conditions are satisfied.
After startup, a stable control change reaches the state on the third clock edge counting its first sampling edge.
Data forwarding remains combinational.

## S3C contract

The built-in `s3c_power_on_debounce_v1` contract uses active-high ReqSafeState, ignores CarrierReady, asserts SlotOK only in normal_state, and keeps ReqOE high.
To describe another level-based contract, select a relative TOML path with these fields:

```toml
id = "my_s3c_v1"
compatible_s3c = ["my_s3c"]
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

## Output and checks

The program directory receives `s3c_logic.vhdl`, `<name>.vhdl`, and `generator-output.json`.
Compile `s3c_logic.vhdl` first, then the top level, in library `work`.
The controller contains only the selected contract; the top level contains clock setup and routing.
The JSON record tracks source order and input hashes.
Edit the CSV or TOML, regenerate, and use `--check` to verify freshness.
Manually edited or unowned output files are never overwritten.
For manually maintained VHDL, stop regenerating and remove the repository manifest's optional `generator` field.
Run tests with `python3 -m unittest discover -s cpld_vhdl_generator/tests -v`.
HDL tests require GHDL.
