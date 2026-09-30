.. rubric:: Scope and provenance

The ``heartbeat`` release contains ``s3c_heartbeat`` and all 29 D-slot programs
that instantiate the heartbeat receiver in
``feature/add_dig3v35v_configs_heartbeat`` at commit
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7``. Archive content is excluded.
The S3C targets the LCMXO2-4000HC-4TG144C; the D-slots target the
LCMXO2-2000HC-4TG100C.

All program manifests now select Synplify, matching the feature branch.
The previously built ``s3c_heartbeat`` Diamond LSE image has a reproduced startup
failure: unsupported Gray encoding falls back to one-hot encoding without a
working startup reset, leaving power off and the red LED asserted. See the
S3C program description for the netlist reproduction and the disposable
sequential-encoding experiment. The HDL sources remain unchanged;
successful build/export results do not establish working hardware startup.

The D-slot ports use ``s3c.s3c_logic(heartbeat)`` from ``xo2_library``.
The branch's routing expressions, port directions, card-enable decoding,
oscillator wiring and shared LPF are preserved. Each program records its
original source paths and hashes, reversible controller-only edits, and routing
expectations in ``upstream.json``. ``dslot-ports.json`` inventories the 29 imports.
Names remain unchanged, including the historical ``tx30_hearbeattesting`` spelling.
These are handwritten imports; the receiver integration does not require a
CSV conversion or change the declared directions of unused pins.

.. rubric:: Included D-slot programs

The 16 ``voltage_8rx_8rx_8rx_6rx`` through
``voltage_8tx_8tx_8tx_6tx`` variants cover all RX/TX combinations for channel
groups 00--07, 08--15, 16--23 and 24--29. TX is FPGA to adapter, gated low in
safe state. RX is adapter to FPGA and remains active in both states.

The other 13 imports are ``optical_14tx_4rx``, ``rx30``, ``template_dslots``,
``tx16_14rx``, ``tx20_10rx``, ``tx26_w_enable``, ``tx30``,
``tx30_hearbeattesting``, ``uz_d_3ph_inverter``, ``uz_d_abs_encoder``,
``uz_d_resolver_d1_to_d4``, ``uz_d_resolver_d5`` and
``uz_d_temperature_ltc2983``. Each program description lists its gated,
ungated and undriven outputs. No unrelated programs from ``original`` or
archive have been added.

.. rubric:: Protocol and deliberate differences

Digital CarrierReady carries heartbeat and ReqSafeState is a separate,
active-high static request. The receiver uses the shared defaults at nominal
2.08 MHz: 16 qualifying edges, an inclusive 10--52-clock interval window,
and a 208-clock no-edge timeout. Pair these programs with ``s3c_heartbeat``;
the ``original`` cycle is not a declared compatible firmware set.

The following differences from the branch receiver are intentional:

* A malformed interval revokes qualification and restarts the edge count.
  The branch can remain valid during malformed trains and can qualify a
  malformed final edge using the previous counter value.
* The shared implementation measures actual edge intervals and times out at
  208 clocks. The branch effectively accepts intervals of 11--53 clocks and
  times out at 209 clocks.
* Static ReqSafeState assertion remains clock-independent. Its release requires
  two rising clock edges, whereas the branch releases combinationally.
  Heartbeat monitoring continues during the request and does not require
  fresh qualification on release if it remains valid.
* Card enable is synchronized. In ``tx26_w_enable``, ``template_dslots`` and
  ``uz_d_abs_encoder``, changes to the decoded 0/0/1/1 pattern on FPGA inputs
  26--29 take two sampling edges to affect state/status, rather than acting
  combinationally. Whether this latency and sampling of brief enable changes
  satisfy each card's requirements remains a hardware/application review point.

Pilot is ignored, matching every imported program, and ReqOE remains high in
both states. Low SlotOK indicates denied normal-state permission; it does not
mean every data output has been disabled. See :doc:`/xo2-library` for the
shared receiver's timing and clock-failure limitations.

.. rubric:: Preserved behaviors requiring review

* ``uz_d_3ph_inverter``, ``uz_d_abs_encoder``, both resolver programs, ``rx30``
  and the all-RX voltage variant retain all their assigned data routes in safe
  state. Heartbeat and ReqSafeState affect SlotOK but do not gate those routes.
  In particular, the inverter's forwarded outputs continue when normal-state
  permission is denied. The S3C does not currently turn SlotOK into an FSM
  fault, so that status signal is not a substitute for route gating.
  These inherited policies require application review; this port does not
  change them.
* ``uz_d_temperature_ltc2983`` intentionally keeps channels 00--18 active,
  including the LTC2983 interfaces and reset. Only outputs 19--29 are gated.
* ``tx30_hearbeattesting`` exposes raw CarrierReady on adapter outputs 00 and
  01 in both states. It is a lab diagnostic, not a normal tx30 replacement.
* ``tx26_w_enable`` and ``template_dslots`` leave adapter outputs 26--29
  undriven in RTL. ``uz_d_resolver_d5`` also declares 23 undriven outputs,
  listed in its program description. The port preserves these declarations;
  a simulation unknown does not establish a safe physical pin level. Review
  fitted unused-pin behavior and the connected hardware before deployment.
* The branch's names do not always describe all routes: ``optical_14tx_4rx``
  also forwards FPGA channels 18--29, for a total of 26 gated TX and four RX
  routes. All of those assignments are preserved.
* LPFs are byte-identical to the shared branch LPF, including electrical pulls,
  configuration options and TRACEID. Managed builds inject their own USERCODE
  into a generated copy. Pin/electrical compatibility with the actual card
  revision still requires review; no 3.3 V/5 V hardware configuration change
  is inferred from a program name.
* Diamond reports the preserved ``TRACEID "0000000000"`` as invalid because
  it exceeds eight bits. Firmware export succeeds, but that TRACEID setting
  must not be treated as successfully applied. Selecting a valid value is an
  open constraint issue; the managed USERCODE is separately verified.
* ``SLAVE_SPI_PORT=ENABLE`` reserves the SN pin. Diamond warns that an external
  pull-up is needed when the slave SPI configuration port is not used.
  The board configuration must be checked before changing this option.
* LSE reports ignored initialization values on some heartbeat age-counter
  bits, along with unused-port/net warnings. Qualification also depends on
  its initialized valid flag and edge counter; RTL simulation alone does not
  establish the fitted startup behavior. Review mapped startup and board
  behavior before claiming hardware qualification.

The previously identified S3C behaviors remain unchanged: power-good loss is
filtered by an approximately 10 ms debounce before heartbeat gating, enabling
the heartbeat can create a one-clock startup pulse, and a healthy heartbeat
does not detect a static ReqSafeState line stuck low. The D-slot cannot measure
elapsed time while its own clock is stopped; qualification can be stale after
that clock resumes. These are documented limits, not fixes in this migration.

.. rubric:: Build and validation

Each D-slot manifest supports Diamond and includes a cocotb test that checks
all assigned routes against pinned upstream expectations, both routing states,
heartbeat qualification/loss/malformed pulses/recovery, asynchronous safe
assertion, two-edge recovery, and all 16 card-enable combinations where used.
Source-fidelity tests reconstruct the original source bytes from the recorded
patches and check unchanged routing, port directions and constraints.
The original S3C snapshot and its existing validation remain in the release.

::

   make sim release_cycle=heartbeat target=dslot
   make build-all release_cycle=heartbeat backend=diamond
   make report release_cycle=heartbeat backend=diamond
   make docs release_cycle=heartbeat

Simulation drives the unbound oscillator and uses accelerated clock timing.
Diamond builds verify compilation and firmware export, not board safety or
physical fault-response times. All manifests select Synplify, matching the
branch's project settings. FOSS firmware support and hardware programming are
outside this port. Refer to each retained build report for warnings and timing
acceptance; a successful export is not a hardware qualification claim.
