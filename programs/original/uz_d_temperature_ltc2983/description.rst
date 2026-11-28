Purpose
-------

Routes 24 FPGA inputs to matching adapter outputs and six adapter inputs to matching FPGA outputs for LTC2983 temperature boards.

Behavior
--------

Both transmit and receive routes become low when reqsafestate is high.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
