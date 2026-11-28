This cycle contains ``s3c_heartbeat`` and 28 CSV-generated D-slot programs with ``cvg_`` names.
The S3C is handwritten; D-slot projects use ``routing.csv``, ``generator.toml`` and the shared ``s3c_heartbeat_v1`` contract.
All programs select Synplify and VHDL-2008 for Diamond builds.
``cvg_tx30`` also supports FOSS; the other manifests enable Diamond only.

.. rubric:: Behavior

Pair the D-slots with this cycle's ``s3c_heartbeat`` controller.
CarrierReady supplies heartbeat and ReqSafeState requests safe state independently.
Before qualification system_error inhibits all declared data outputs, SlotOK and ReqOE; first qualification clears this inhibition.
After qualification malformed heartbeat or timeout latches system_error; restored heartbeat and runtime reset do not clear it.
Static safe-state assertion is clock-independent and release takes two edges.
See :doc:`/xo2-library` for timing and power-domain limits.

CSV routing defines normal and safe values; routes with matching values remain active in safe state.
Pilot is unused, SlotOK follows normal permission, and ReqOE stays high in normal/safe states.
System_error overrides every declared output to zero regardless of CSV values.
Unused pins are inputs and may be optimized away; physical behavior depends on device configuration and board pulls.

.. rubric:: Editing and validation

Edit CSV/TOML inputs and regenerate; the generator owns the VHDL, manifest, LPF, testbench and freshness receipt.

::

   uz_cpld generate --program cvg_tx30 --release-cycle heartbeat_cvg
   uz_cpld check --program cvg_tx30 --release-cycle heartbeat_cvg
   uz_cpld sim --release-cycle heartbeat_cvg
   uz_cpld build_all --release-cycle heartbeat_cvg

Simulations exercise normal/safe routing, startup inhibition, system-error overrides and fault persistence.
Regression tests compare routing, enable patterns, pin directions and constraints with the handwritten programs.
The FOSS ``cvg_tx30`` pilot has a separate mapped-logic comparison command described in :doc:`/foss`.
Simulation and compilation do not establish board-level behavior; see :doc:`/s3c` and :doc:`/validation`.
