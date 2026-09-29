Purpose
-------

Routes 16 FPGA inputs to permuted adapter outputs and returns adapter inputs 01 and 17 to the FPGA.

Behavior
--------

Many other declared outputs have no assignment in the archived VHDL.
All implemented data routes remain live when reqsafestate is high, and this mapping differs from the separate sdifix program.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.
The archived design leaves 23 declared outputs undriven, so the testbench does not assign them a defined value.

Archive source
--------------

The VHDL and LPF are byte-for-byte copies of ``archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots/uz_d_resolver_d5_4inverter/source/``.
The archive declares an unused ``machxo2`` library, which the simulator supplies as an empty library during analysis.

Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
