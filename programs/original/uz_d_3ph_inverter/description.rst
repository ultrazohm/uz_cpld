Purpose
-------

Routes FPGA channels 00 through 05 and 14 to matching adapter outputs and the other 23 adapter channels to matching FPGA outputs.

Behavior
--------

All data routes remain live when reqsafestate is high.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
