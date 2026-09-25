Purpose
-------

``tx30_stateful`` routes 30 FPGA signals to the D-slot adapter using ``normal_state`` and ``safe_state``.

Behavior
--------

Outputs follow their matching FPGA inputs in ``normal_state`` and are low in ``safe_state``.
ReqSafeState is active high; CarrierReady and pilot are unused.
SlotOK is high only in ``normal_state``, and ReqOE is always high.
An internal nominal 2.08 MHz oscillator clocks startup, control synchronization, and state transitions.
The program starts in ``safe_state`` and resumes ``normal_state`` automatically when the synchronized safe request is released.
After startup, a stable request reaches the state on the third clock edge counting its first sampling edge, excluding metastability delay.
Data forwarding remains combinational.

Editing
-------

Edit ``routing.csv`` and ``generator.toml``, then regenerate.
The CSV header is ``output,normal_state,safe_state``.
Only ``d_00``–``d_29`` and ``fpga_00``–``fpga_29`` are accepted as pin names.
All 60 data pins remain in the interface; pins not declared as outputs remain inputs without HDL drivers.
The shared ``s3c.s3c_logic(level_signals)`` controller is compiled from ``cpld_vhdl_generator/hdl``.
``tx30_stateful.vhdl`` contains clock setup and routing; the program has no local controller copy.

Verification
------------

The testbench checks startup, every route, safe-state gating, and re-enable behavior.
The direct controller testbench checks states, status levels, synchronization, and enable policies.
The interaction testbench connects the program to the actual S3C controller through startup, soft stop, and enable.
Both Diamond and FOSS build this program; the FOSS build proves mapped sequential equivalence with a shared abstract clock.
