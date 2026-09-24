Purpose
-------

``tx26_w_enable`` sends FPGA channels 0 through 25 to their matching D-slot adapter outputs when a four-pin enable code is present.

Behavior
--------

Forwarding requires ``fpga_26`` and ``fpga_27`` low, ``fpga_28`` and ``fpga_29`` high, and ``reqsafestate`` low.
If any condition fails, ``d_00`` through ``d_25`` and ``slotok`` are low.
``reqoe`` is always high.
Adapter outputs ``d_26`` through ``d_29`` are declared but have no VHDL drivers and must not be treated as valid data outputs.

Verification
------------

The cocotb test checks all-low, all-high, walking-one, and walking-zero data patterns against all 16 enable codes and safe-state transitions.
