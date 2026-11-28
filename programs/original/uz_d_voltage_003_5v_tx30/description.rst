Purpose
-------

Routes all 30 FPGA inputs to matching adapter outputs for the voltage 003 5 V variant.

Behavior
--------

All data routes remain live when reqsafestate is high even though slotok goes low.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
