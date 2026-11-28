Purpose
-------

Routes three adapter inputs back to the FPGA and permutes the remaining 27 transmit channels for the D4 four inverter resolver wiring.

Behavior
--------

All data routes remain live when reqsafestate is high.
This mapping differs from the separate sdifix program.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
