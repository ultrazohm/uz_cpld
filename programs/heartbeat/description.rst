.. rubric:: Scope

The ``heartbeat`` release cycle currently contains only ``s3c_heartbeat``,
the Rev06 S3C controller for the LCMXO2-4000HC-4TG144C.
It imports ``feature/add_dig3v35v_configs_heartbeat`` at commit
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` and its pinned library dependency.

.. rubric:: Firmware and compatibility

The digital ``CarrierReady`` line carries a heartbeat; ``ReqSafeState`` is a
separate active-high static request. Pair it with D-slot firmware implementing
that same protocol. No D-slot programs have been included in this cycle yet.
The ``original`` cycle remains a separate collection; it is not a declared
compatible D-slot set for this controller. See the program description for
signal behavior and source provenance.

.. rubric:: Validation

The program includes a top-level simulation covering startup, heartbeat timing,
module-power gating, soft stop, recovery and supply-failure shutdown.
Simulation accelerates the clock and millisecond timebase; it does not qualify
physical timing or hardware. The manifest supports Diamond builds; preserving
the upstream top-level source precludes the current GHDL synthesis path.
