Purpose
-------

``tx30`` sends 30 FPGA signals to the corresponding D-slot adapter pins, from ``fpga_00`` through ``fpga_29`` to ``d_00`` through ``d_29``.

Behavior
--------

When ``reqsafestate`` is low, every adapter output follows its matching FPGA input and ``slotok`` is high.
When ``reqsafestate`` is high, all 30 adapter outputs and ``slotok`` are low.
``reqoe`` is always high, while ``pilot_in`` and ``carrierrdy`` do not control forwarding in this implementation.

Verification
------------

The cocotb test checks all-low and all-high input patterns, each individual high and low input, and the safe-state transition.
