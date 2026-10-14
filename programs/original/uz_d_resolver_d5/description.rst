Purpose
-------

Routes 16 FPGA inputs to adapter outputs 00 through 07 and 09 through 16, and returns adapter inputs 08 and 17 to the FPGA.

Behavior
--------

Many other declared outputs have no assignment in the VHDL.
All implemented data routes remain live when reqsafestate is high.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.
The design leaves 23 declared outputs undriven, so the testbench does not assign them a defined value.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
