Purpose
-------

Routes 12 FPGA inputs to selected adapter outputs and three adapter inputs to selected FPGA outputs for the absolute encoder wiring.

Behavior
--------

The 0011 pattern on FPGA pins 26 through 29 controls slotok, but all data routes remain live regardless of that pattern and reqsafestate.
The remaining adapter pins are inputs or unused in this design.
``slotok`` is high when ``reqsafestate`` is low and ``fpga_26..29`` equals ``0011``, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
It also checks representative accepted and rejected enable-pin patterns.
