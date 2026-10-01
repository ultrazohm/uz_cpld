This cycle contains the same ``s3c_heartbeat`` controller as ``heartbeat`` and
recreates its 28 non-diagnostic D-slot programs using ``cpld_vhdl_generator``.
D-slot program names use the generator's ``cvg_`` prefix. The generator supports D-slot routing;
the S3C is a handwritten copy with identical HDL, constraints, manifest,
testbench and upstream provenance. It was cloned with::

   make new name=s3c_heartbeat template=s3c_heartbeat template_release_cycle=heartbeat release_cycle=heartbeat_cvg

Use ``heartbeat_cvg/s3c_heartbeat`` when selecting the controller for this cycle.
The reviewed S3C reset and power-good changes were reverted in both releases;
the original behavior and documented limitations apply.
The ultimate routing source is ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7``; ``migration.json`` records the
current handwritten source hashes, copied S3C hashes and per-program cleanup.

.. rubric:: Behavior and cleanup

Every assigned normal/safe route and card-enable pattern is preserved.
Pilot is unused, SlotOK follows normal permission, and ReqOE remains high.
The shared ``s3c_heartbeat_v1`` contract selects ``s3c.s3c_logic(heartbeat)``:
ReqSafeState asserts safe state without a clock, recovery takes two clock
edges, and heartbeat qualification continues during safe-state requests.
Ungated routes remain active even in safe state, including the legacy inverter,
encoder and resolver mappings. This conversion does not add safety gating to
those routes. See :doc:`/xo2-library` for heartbeat timing and clock limitations.

The diagnostic ``tx30_hearbeattesting`` program is deliberately omitted.
Previously declared but undriven outputs in ``template_dslots``,
``tx26_w_enable`` and ``uz_d_resolver_d5`` are now unused input ports, following
the generator's routing model. Their names are listed in the corresponding
program descriptions and ``migration.json``. No fixed output value is invented.
Unused inputs may be optimized away; physical pad behavior still depends on
Diamond's unused-pin configuration and board pulls and requires hardware review.

All projects select Synplify and VHDL-2008, matching ``heartbeat``.
The generator supplies the standard D-slot board constraints: pin locations,
electrical settings and system configuration match the source release, while
the generator's existing TraceID default is ``00000001`` instead of
``0000000000``. Firmware identity is allocated independently for this release.
Obsolete dummy keep-signals and handwritten controller wiring are replaced by
the generator's shared-controller instantiation.

.. rubric:: Editing and validation

Edit a program's ``routing.csv`` and ``generator.toml``, then use::

   make generate program=cvg_tx30 release_cycle=heartbeat_cvg
   make check program=cvg_tx30 release_cycle=heartbeat_cvg
   make sim release_cycle=heartbeat_cvg
   make build-all release_cycle=heartbeat_cvg backend=diamond

For the D-slots, generated VHDL, manifests, constraints and cocotb tests are owned by the
generator and accompanied by freshness receipts. Regression checks compare
all routes, enable patterns, pin directions and constraints to ``heartbeat``.
The S3C regression checks its source and configuration against that release.
Generated simulations exercise routing in both states, heartbeat qualification,
loss and recovery, and clock-independent safe requests. RTL simulation and
compilation do not establish board-level behavior. Creation-time validation
passed all 28 RTL simulations and 85 generator, migration and build-system
regression tests. Diamond ``build-all`` was attempted but stopped before
synthesis because the installed license host ID did not match the container
(FlexNet ``-9,57``). No successful firmware build or hardware validation is
claimed. After restoring the reference S3C and adding it to this cycle, all
29 program simulations and 18 relevant regression tests passed. Source-equality
checks cover the copied S3C. The root ``log.md`` records the creation commands,
manual steps and validation results.
