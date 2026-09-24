# CPLD VHDL generator

This standalone Python package generates VHDL-1993 slot programs from a routing CSV and a TOML configuration.
It has no dependency on the repository build system, Diamond, GHDL, cocotb, or board constraints.
Python 3.10 needs `tomli`; Python 3.11 and later use the standard library.
Install from the repository root with `pip install .`, or run `python3 -m cpld_vhdl_generator` from the checkout.

```sh
cpld-vhdl-generator path/to/my_slot/generator.toml --output path/to/my_slot
cpld-vhdl-generator path/to/my_slot/generator.toml --output path/to/my_slot --check
```

## Program files

The generator writes two VHDL files directly into the program directory.
`s3c_logic.vhdl` contains the selected S3C contract's signal interpretation, synchronization, NORMAL/SAFE/ERROR state machine, and SlotOK/ReqOE levels.
`my_slot.vhdl` contains the top-level ports, clock/reset setup, optional enable condition, and CSV routing, and instantiates `s3c_logic` once.
Only the selected contract is emitted, with its polarity and readiness policy resolved during generation.
There are no alternative adapter implementations or mode-selection generics in the emitted controller.
Compile `s3c_logic.vhdl` before the top-level file in library `work`.
`generator-output.json` records this source order and the generator, specification, and contract hashes.
Pin placement and electrical constraints belong to the consuming board build.

## Configuration and routing

```toml
schema_version = 1
name = "my_slot"
routing = "routing.csv"
contract = "s3c_power_on_debounce_v1"
clock = "external"
pilot_policy = "unused"
fault_recovery = "safe_cycle"
# Optional input pattern required for NORMAL:
# enable = {fpga_26 = 0, fpga_27 = 0, fpga_28 = 1, fpga_29 = 1}
```

```csv
pin,direction,normal,safe,error
fpga_00,in,,,
d_00,in,,,
d_01,out,fpga_00,0,0
fpga_01,out,d_00,d_00,0
```

Every output must specify an action for NORMAL, SAFE, and ERROR.
Actions are a declared input name, `0`, `1`, or `Z`.
Input rows leave the three action cells empty.
Directions are from the CPLD's perspective and accept only `in` and `out`.
Output references, arbitrary expressions, bidirectional ports, and custom logic hooks are unsupported.
Names must be lowercase VHDL identifiers and must not collide with the fixed interface or the reserved `cvg_` prefix.
The program name `s3c_logic` is reserved for the controller.
The fixed interface provides `pilot_in`, `reqsafestate`, `carrierrdy`, `slotok`, and `reqoe`.
`clock = "external"` also provides `clk` and synchronous active-high `reset` ports.
`clock = "machxo2"` uses an OSCH oscillator at nominal 2.08 MHz and a startup reset sequence.

## States

The controller starts in SAFE and evaluates synchronized controls after three warmup clocks.
NORMAL requires the S3C to permit operation, no safe request, no pilot fault, and a matching enable pattern if configured.
Faults take priority and latch ERROR.
`pilot_policy = "required"` treats a low synchronized pilot as a fault when the S3C permits operation.
`pilot_policy = "unused"` disables pilot monitoring, leaving ERROR unreachable with the currently supported contracts.
The three-state structure is retained in either case.
`fault_recovery = "safe_cycle"` is the only supported recovery policy.
Recovery requires observing the normalized S3C safe request while in ERROR, followed by its release after the fault clears.
A request released while the fault persists does not acknowledge a later fault clearance.
Recovery passes through SAFE for at least one clock, and reset also clears ERROR.
S3C controls, pilot when required, and the card enable condition use two synchronization registers.
A stable request reaches the registered state on the third receiving-clock edge counting its first sampling edge, excluding metastability delay.
Routed data remains combinational.

## S3C contracts

The built-in `s3c_power_on_debounce_v1` contract interprets ReqSafeState as active high and ignores the legacy S3C's undriven CarrierReady output.
It drives SlotOK high only in NORMAL and holds ReqOE high in all states, allowing the CSV to drive defined safe and error levels.
The legacy S3C independently controls the physical SlotOE and ignores SlotOK.
Compatibility is a declared firmware pairing and does not identify firmware loaded on a board.
Additional level-based contracts can be selected through a relative TOML path such as `contract = "contracts/my_contract.toml"`.
Their complete schema is:

```toml
id = "my_contract_v1"
compatible_s3c = ["my_s3c"]
request_mode = "active_low"
carrier_ready = "active_high"
slotok = [1, 0, 0]
reqoe = [1, 1, 1]
```

`request_mode` accepts `active_high` or `active_low`.
`carrier_ready` accepts `unused`, `active_high`, or `active_low`.
An inactive or unknown CarrierReady level requests SAFE when readiness is used.
An unknown ReqSafeState level also requests SAFE.
The output lists contain physical levels for NORMAL, SAFE, and ERROR in that order.
Heartbeat protocols are a possible future generator extension and are not implemented.
Heartbeat contracts and settings are rejected.

## Regeneration and manual programs

Generated programs use only the functions described above.
There is no custom module interface, custom acknowledgment mode, or stub-generation option.
For additional behavior, users can manually edit VHDL or create a fully custom program.
When converting a repository program to manual VHDL, remove its manifest's optional `generator` field to stop freshness checks and maintain its source list explicitly.
Keep the VHDL files and constraints as ordinary program inputs and stop regenerating over the manually edited sources.
The generator refuses to overwrite unowned or manually edited output files.
For programs still managed by the generator, edit the CSV or TOML, regenerate, and use `--check` to verify freshness.

Run standalone tests with `python3 -m unittest discover -s cpld_vhdl_generator/tests -v`.
HDL behavior tests run when GHDL is installed and are reported as skipped otherwise.
The repository example `tx30_stateful` demonstrates the two-file layout and includes a routing testbench.
Repository integration tests connect it to the actual S3C controller through startup, soft stop, and re-enable.
Its firmware manifest selects Diamond; the FOSS backend remains disabled pending sequential equivalence validation.
