Purpose
-------

Routes all 30 FPGA inputs to matching adapter outputs for the voltage 013 variant.

Behavior
--------

The data routes become low when reqsafestate is high.
Its archived VHDL matches the archived tx30 source byte for byte, while its constraints and variant identity are separate.
``slotok`` is high when ``reqsafestate`` is low, and ``reqoe`` is always high.

Archive source
--------------

The VHDL and LPF are byte-for-byte copies of ``archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots/uz_d_voltage_013_tx30/source/``.
The archive declares an unused ``machxo2`` library, which the simulator supplies as an empty library during analysis.

Verification
------------

The cocotb test checks every implemented route with isolated input patterns, all-high inputs, safe-state transitions, and status outputs.
