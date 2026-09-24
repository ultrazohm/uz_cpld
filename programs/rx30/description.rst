Purpose
-------

``rx30`` receives 30 D-slot adapter signals and sends each ``d_00`` through ``d_29`` input to the corresponding ``fpga_00`` through ``fpga_29`` output.

Behavior
--------

All 30 receive routes remain active when ``reqsafestate`` is high.
``slotok`` is high only when ``reqsafestate`` is low, and ``reqoe`` is always high.
``pilot_in`` and ``carrierrdy`` do not control the routes or status outputs in this implementation.

Verification
------------

The cocotb test checks all-low and all-high input patterns, each individual high and low input, and a safe-state transition that leaves receiving active.
