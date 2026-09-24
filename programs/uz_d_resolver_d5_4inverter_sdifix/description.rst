Purpose
-------

``uz_d_resolver_d5_4inverter_sdifix`` routes 18 resolver signals between the FPGA and D5 adapter with compensation for a physical swap of ``d_00`` and ``d_01``.

Routing
-------

``fpga_07`` drives ``d_01``, and ``d_00`` drives ``fpga_14``.
The other route assignments are listed in the VHDL and shown in the generated RTL diagram, while the LPF pin locations remain unchanged.
Declared outputs without route assignments remain undriven, including ``d_18`` through ``d_25``, ``d_27`` through ``d_29``, ``fpga_00`` through ``fpga_05``, and ``fpga_24`` through ``fpga_29``.

Safety and verification
-----------------------

A high ``reqsafestate`` lowers ``slotok`` but does not interrupt any data route, and ``reqoe`` remains high.
The cocotb test checks every defined route with all-low, all-high, walking-one, and walking-zero patterns before, during, and after a safe-state request.
