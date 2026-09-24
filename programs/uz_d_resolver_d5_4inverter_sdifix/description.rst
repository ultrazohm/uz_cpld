Routes D5 resolver signals with compensation for physically swapped
``d_00`` and ``d_01`` wires: ``fpga_07`` drives ``d_01``, and
``d_00`` drives ``fpga_14``. LPF pin locations remain unchanged.
All other routes retain their existing mapping.
Previously unassigned outputs remain unassigned.

A high ``reqsafestate`` deasserts ``slotok`` but does not gate data routing.
``reqoe`` stays high.
