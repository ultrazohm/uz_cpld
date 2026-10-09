``cvg_uz_d_resolver_d5`` is a CSV-generated MachXO2 D-slot program.

Edit ``routing.csv`` and ``generator.toml``, then run::

   make generate program=cvg_uz_d_resolver_d5 release_cycle=heartbeat_cvg

``routing.csv`` defines each normal/safe route.
Ungated routes remain active in both states.
The shared ``s3c_heartbeat_v1`` contract pairs with ``heartbeat_cvg/s3c_heartbeat``; pilot is unused, SlotOK follows normal permission, and ReqOE stays high in normal and safe states.
Compilation uses Synplify and VHDL-2008.

Unused input ports: ``d_18``, ``d_19``, ``d_20``, ``d_21``, ``d_22``, ``d_23``, ``d_24``, ``d_25``, ``d_27``, ``d_28``, ``d_29``, ``fpga_00``, ``fpga_01``, ``fpga_02``, ``fpga_03``, ``fpga_04``, ``fpga_05``, ``fpga_24``, ``fpga_25``, ``fpga_26``, ``fpga_27``, ``fpga_28``, ``fpga_29``.
No driven output level is assigned to these pins.

See the release description for validation limits and physical unused-pin behavior.

Before first qualification, system_error inhibits every declared data output, SlotOK and ReqOE; qualification clears this startup inhibition automatically.
After the first qualified heartbeat, a heartbeat fault latches ``system_error``.
Every declared data output, SlotOK and ReqOE becomes zero, regardless of CSV normal/safe values.
Restored heartbeat and runtime reset cannot clear this state.
See :doc:`/xo2-library` for power-on initialization and supply-domain limitations.
