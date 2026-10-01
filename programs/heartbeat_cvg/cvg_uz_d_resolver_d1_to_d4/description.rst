Generated counterpart of ``heartbeat/uz_d_resolver_d1_to_d4`` for the MachXO2 D-slot.

Edit ``routing.csv`` and ``generator.toml``, then run::

   make generate program=cvg_uz_d_resolver_d1_to_d4 release_cycle=heartbeat_cvg

The CSV preserves every assigned normal/safe route. Ungated routes remain active
in both states. The shared ``s3c_heartbeat_v1`` contract pairs with
``heartbeat_cvg/s3c_heartbeat``; pilot is unused, SlotOK follows normal permission,
and ReqOE stays high in normal and safe states. Compilation uses Synplify and VHDL-2008.

See the release description for validation limits and physical unused-pin behavior.

After the first qualified heartbeat, a heartbeat fault latches ``system_error``.
Every declared data output, SlotOK and ReqOE becomes zero, regardless of CSV
normal/safe values. Restored heartbeat and runtime reset cannot clear this state.
See :doc:`/xo2-library` for power-on initialization and supply-domain limitations.
