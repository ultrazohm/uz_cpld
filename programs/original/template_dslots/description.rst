Purpose
-------

Routes FPGA channels 00 through 25 to matching adapter channels when the FPGA enable pins 26 through 29 read 0011.

Behavior
--------

The last four adapter outputs are declared but undriven.
The route logic matches the tx26_w_enable variant, but this program retains its own source file.
``slotok`` is high when ``reqsafestate`` is low and ``fpga_26..29`` equals ``0011``, and ``reqoe`` is always high.
The design leaves 4 declared outputs undriven, so the testbench does not assign them a defined value.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
It also checks representative accepted and rejected enable-pin patterns.
