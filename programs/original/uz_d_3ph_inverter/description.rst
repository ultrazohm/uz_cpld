Purpose
-------

Routes FPGA channels 00 through 05 and 14 to matching adapter outputs and the other 23 adapter channels to matching FPGA outputs.

Behavior
--------

All data routes remain live when reqsafestate is high.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.

Archive source
--------------

The VHDL and LPF are byte-for-byte copies of ``archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots/uz_d_3ph_inverter/source/``.
The archive declares an unused ``machxo2`` library, which the simulator supplies as an empty library during analysis.

Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
