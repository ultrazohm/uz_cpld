Purpose
-------

Routes FPGA channels 00 through 15 to matching adapter outputs and adapter channels 16 through 29 to matching FPGA outputs.

Behavior
--------

The 16 transmit routes become low when reqsafestate is high, while receive routes remain live.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.

Archive source
--------------

The VHDL and LPF are byte-for-byte copies of ``archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots/tx16_14rx/source/``.
The archive declares an unused ``machxo2`` library, which the simulator supplies as an empty library during analysis.

Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
