Purpose
-------

Routes 26 FPGA outputs to adapter pins and four adapter inputs on channels 14 through 17 back to the FPGA.

Behavior
--------

The VHDL implements 26 transmit routes and four receive routes.
The transmit routes become low when reqsafestate is high, while receive routes remain live.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
