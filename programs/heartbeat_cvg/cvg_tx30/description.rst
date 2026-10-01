Generated counterpart of ``heartbeat/tx30`` for the MachXO2 D-slot.

Edit ``routing.csv`` and ``generator.toml``, then run::

   make generate program=cvg_tx30 release_cycle=heartbeat_cvg

The CSV preserves every assigned normal/safe route. Ungated routes remain active
in both states. The shared ``s3c_heartbeat_v1`` contract pairs with
``heartbeat_cvg/s3c_heartbeat``; pilot is unused, SlotOK follows normal permission,
and ReqOE stays high. Compilation uses Synplify and VHDL-2008.

See the release description for validation limits and physical unused-pin behavior.
