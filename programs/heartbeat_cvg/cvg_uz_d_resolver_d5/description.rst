Generated counterpart of ``heartbeat/uz_d_resolver_d5`` for the MachXO2 D-slot.

Edit ``routing.csv`` and ``generator.toml``, then run::

   make generate program=cvg_uz_d_resolver_d5 release_cycle=heartbeat_cvg

The CSV preserves every assigned normal/safe route. Ungated routes remain active
in both states. The shared ``s3c_heartbeat_v1`` contract pairs with
``heartbeat_cvg/s3c_heartbeat``; pilot is unused, SlotOK follows normal permission,
and ReqOE stays high. Compilation uses Synplify and VHDL-2008.

Cleanup: previously undriven output declarations are now unused inputs:
``d_18``, ``d_19``, ``d_20``, ``d_21``, ``d_22``, ``d_23``, ``d_24``, ``d_25``, ``d_27``, ``d_28``, ``d_29``, ``fpga_00``, ``fpga_01``, ``fpga_02``, ``fpga_03``, ``fpga_04``, ``fpga_05``, ``fpga_24``, ``fpga_25``, ``fpga_26``, ``fpga_27``, ``fpga_28``, ``fpga_29``.
No driven output level is assigned to these pins.

See the release description for validation limits and physical unused-pin behavior.
