# MachXO2 shared HDL library

Reusable VHDL components for generated and handwritten programs. The HDL has no dependency on `cpld_vhdl_generator`, Python, or the repository build system.

The component implements the D-slot side of the S3C interface:

| Compile order | Source | VHDL library |
| --- | --- | --- |
| 1 | `s3c/s3c_logic.vhdl` | `s3c` |
| 2 | `s3c/level_signals.vhdl` or `s3c/heartbeat.vhdl` | `s3c` |

Instantiate `entity s3c.s3c_logic(level_signals)` from your top level. Supply a clock, reset and control inputs; use the state outputs to select your normal and safe routing. Select `entity s3c.s3c_logic(heartbeat)` for the `s3c_heartbeat` firmware protocol: qualified heartbeat on CarrierReady plus an independent static ReqSafeState. Both architectures provide the same normal/safe state and status outputs. See the library guide for timing defaults and qualification behavior.

See the [library guide](../docs/xo2-library.rst) for manifest entries, an instantiation example and behavior. You can copy this directory into another HDL project and compile the sources directly. The Python module only provides the default source location to the generator; the generator distribution includes the same HDL files for installation outside the checkout.

Both architectures also expose `state_system_error`. Heartbeat faults after the
first complete qualification latch this state until power-on initialization;
runtime reset cannot clear it. In this state both status outputs are zero and
consumers must override every data output to zero. CVG always adds that override.
The level-based architecture has no heartbeat fault source and holds the error
output low. The library guide explains supply-domain and reconfiguration limits.

Run the independent behavioral test with GHDL installed:

```sh
python3 -m unittest discover -s xo2_library/tests -v
```
