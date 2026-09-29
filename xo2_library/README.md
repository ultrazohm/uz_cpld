# MachXO2 shared HDL library

Reusable VHDL components for generated and handwritten programs. The HDL has no dependency on `cpld_vhdl_generator`, Python, or the repository build system.

The current component is the D-slot side of the S3C interface:

| Compile order | Source | VHDL library |
| --- | --- | --- |
| 1 | `s3c/s3c_logic.vhdl` | `s3c` |
| 2 | `s3c/level_signals.vhdl` | `s3c` |

Instantiate `entity s3c.s3c_logic(level_signals)` from your top level. Supply a clock, reset and control inputs; use the state outputs to select your normal and safe routing. This is a level-based D-slot controller, not an S3C power sequencer or heartbeat receiver.

See the [library guide](../docs/xo2-library.rst) for manifest entries, an instantiation example and behavior. You can copy this directory into another HDL project and compile the sources directly. The Python module only provides the default source location to the generator; the generator distribution includes the same HDL files for installation outside the checkout.

Run the independent behavioral test with GHDL installed:

```sh
python3 -m unittest discover -s xo2_library/tests -v
```
