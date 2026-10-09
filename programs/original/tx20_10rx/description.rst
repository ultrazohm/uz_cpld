Purpose
-------

Routes FPGA channels 00 through 19 to matching adapter outputs and adapter channels 20 through 29 to matching FPGA outputs.

Behavior
--------

The 20 transmit routes become low when reqsafestate is high, while receive routes remain live.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
