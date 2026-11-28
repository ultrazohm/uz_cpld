Purpose
-------

Routes all 30 FPGA inputs to matching adapter outputs for the voltage 013 variant.

Behavior
--------

The data routes become low when reqsafestate is high.
Its VHDL implements the same routing as tx30, while its constraints and variant identity are separate.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.


Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
