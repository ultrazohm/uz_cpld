Purpose
-------

``uz_d_resolver_d4_4inverter_sdifix`` routes 30 resolver signals between the FPGA and D4 adapter with compensation for three pairs of physically swapped adapter wires.

Routing
-------

For the ``d_00`` and ``d_01`` pair, ``fpga_01`` drives ``d_01`` and ``d_00`` drives ``fpga_08``.
For the ``d_09`` and ``d_10`` pair, ``fpga_10`` drives ``d_10`` and ``d_09`` drives ``fpga_17``.
For the ``d_18`` and ``d_19`` pair, ``fpga_19`` drives ``d_19`` and ``d_18`` drives ``fpga_26``.
The other route assignments are listed in the VHDL and shown in the generated RTL diagram, while the LPF pin locations remain unchanged.

Safety and verification
-----------------------

A high ``reqsafestate`` lowers ``slotok`` but does not interrupt any data route, and ``reqoe`` remains high.
The cocotb test checks every route with all-low, all-high, walking-one, and walking-zero patterns before, during, and after a safe-state request.
