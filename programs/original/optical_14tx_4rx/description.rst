Purpose
-------

Routes 26 FPGA outputs to adapter pins and four adapter inputs on channels 14 through 17 back to the FPGA.

Behavior
--------

The folder name describes an earlier split, while the archived VHDL implements 26 transmit routes.
The transmit routes become low when reqsafestate is high, while receive routes remain live.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.

Archive source
--------------

The VHDL and LPF are byte-for-byte copies of ``archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots/optical_14tx_4rx/source/``.
The archive declares an unused ``machxo2`` library, which the simulator supplies as an empty library during analysis.

Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
