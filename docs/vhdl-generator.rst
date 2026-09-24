Generated slot programs
=======================

``cpld_vhdl_generator`` generates VHDL-1993 from CSV and TOML independently of the build toolchain.
The repository checks generated sources for freshness before building.

Workflow
--------

Clone the example, edit its CSV or TOML, and regenerate::

   make new name=my_slot template=tx30_stateful
   python3 -m cpld_vhdl_generator programs/my_slot/generator.toml --output programs/my_slot
   make sim program=my_slot
   make build program=my_slot backend=diamond

Add ``--check`` to the generator command to verify freshness without writing files.
The program directory contains ``s3c_logic.vhdl``, ``my_slot.vhdl``, and ``generator-output.json``.
The S3C file contains the selected contract and state controller; the top level contains the clock and routing.
The manifest lists the S3C file before the top level, in library ``work``.
The JSON record tracks source order and input hashes.
Diamond builds require a valid license.

Routing
-------

::

   output,normal_state,safe_state
   d_00,fpga_00,0
   d_01,fpga_01,fpga_01
   fpga_02,d_02,0
   d_29,0,0

Each row defines one output in normal_state and safe_state.
Only ``d_00``–``d_29`` and ``fpga_00``–``fpga_29`` are valid pin names, with exactly two digits and lowercase letters.
State values accept input names, ``0``, ``1``, or uppercase ``Z``.
Outputs cannot also serve as inputs, including in ``enable``.
Multiple outputs may share an input.
Expressions and bidirectional ports are unsupported.

All 60 data pins remain in the interface.
Pins omitted from the output column are inputs and have no HDL output driver.
Use a constant output row when a pin must be driven to a defined level.
Physical pulls and unused-pad settings belong to board constraints and synthesis configuration.
The fixed S3C signals and unused I2C inputs are provided separately and cannot appear in the CSV.

Configuration and states
------------------------

.. literalinclude:: ../programs/tx30_stateful/generator.toml
   :language: toml

``clock`` selects ``machxo2`` for an internal nominal 2.08 MHz oscillator or ``external`` for clock/reset ports.
The optional ``enable`` table specifies required data input levels, for example ``enable = {fpga_29 = 1}``.
``pilot_policy = "required"`` requires a high synchronized pilot input for normal operation; ``unused`` ignores it.
The controller starts in ``safe_state`` and enters ``normal_state`` when synchronized S3C controls, the pilot policy, and the enable pattern permit operation.
It returns to ``safe_state`` when any condition fails and resumes ``normal_state`` automatically when all conditions are satisfied.
After startup, control changes reach the state on the third clock edge counting their first sampling edge.
Data forwarding remains combinational.

The built-in contract uses active-high ReqSafeState, ignores CarrierReady, asserts SlotOK only in normal_state, and keeps ReqOE high.
Additional contract files support active-high or active-low requests and unused, active-high, or active-low readiness.
The complete contract schema and standalone commands are documented in ``cpld_vhdl_generator/README.md``.

Generated programs use the supported routing and controller functions.
For manual VHDL, stop regenerating and remove the program manifest's optional ``generator`` field.
The generator refuses to overwrite manually edited output files.
``make test`` checks the generator and its integration with the actual S3C program.
