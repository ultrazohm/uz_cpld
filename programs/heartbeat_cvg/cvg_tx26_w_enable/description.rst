Generated counterpart of ``heartbeat/tx26_w_enable`` for the MachXO2 D-slot.

Edit ``routing.csv`` and ``generator.toml``, then run::

   make generate program=cvg_tx26_w_enable release_cycle=heartbeat_cvg

The CSV preserves every assigned normal/safe route. Ungated routes remain active
in both states. The shared ``s3c_heartbeat_v1`` contract pairs with
``heartbeat_cvg/s3c_heartbeat``; pilot is unused, SlotOK follows normal permission,
and ReqOE stays high. Compilation uses Synplify and VHDL-2008.

Card-enable requires ``fpga_26=0``, ``fpga_27=0``, ``fpga_28=1``, ``fpga_29=1``.

Cleanup: previously undriven output declarations are now unused inputs:
``d_26``, ``d_27``, ``d_28``, ``d_29``.
No driven output level is assigned to these pins.

See the release description for validation limits and physical unused-pin behavior.
