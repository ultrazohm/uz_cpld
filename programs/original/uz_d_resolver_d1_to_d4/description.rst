Purpose
-------

Routes adapter channels 08, 17, and 26 to matching FPGA outputs and sends the other 27 FPGA channels to matching adapter outputs.

Behavior
--------

All data routes remain live when reqsafestate is high.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
