Routes D4 resolver signals with compensation for three physical wire swaps:

* ``d_00`` / ``d_01``: ``fpga_01`` drives ``d_01``; ``d_00`` drives ``fpga_08``.
* ``d_09`` / ``d_10``: ``fpga_10`` drives ``d_10``; ``d_09`` drives ``fpga_17``.
* ``d_18`` / ``d_19``: ``fpga_19`` drives ``d_19``; ``d_18`` drives ``fpga_26``.

LPF pin locations remain unchanged.
All other routes retain their existing mapping.

A high ``reqsafestate`` deasserts ``slotok`` but does not gate data routing.
``reqoe`` stays high.
