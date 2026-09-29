Purpose
-------

``s3c_power_on_debounce`` ports the ``Power_on_debounce.vhd`` controller selected by the archive's default ``S3C_171224`` Diamond implementation.
This is the December 2024 reference controller; ``s3c_rev6_beta`` provides a separate snapshot of the newer October 2025 controller, with one unused driver commented out for GHDL synthesis.
The archived source is from commit ``6794ce263a7c2b099001e429ce03a2d9b91d9b1d`` (17 December 2024, ``rev05 00``).
See :doc:`/s3c` for the pinned source link, port adaptations, and scope.
The older root-level archive file with the same name belongs to a different implementation and is not the source of this program.

Relationship to Rev06
---------------------

``s3c_rev6_beta`` is imported from commit ``2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae`` (31 October 2025, ``cleanup``).
That revision already contains the modular Rev06 FSM later retained in ``develop`` at ``886271c``, before heartbeat signaling was introduced by ``f399720`` and ``524df52``.
This December 2024 program does not incorporate that FSM: it removes carrier power immediately on hard error, lacks the newer supply-failure handling and error-history acknowledgement states, and leaves front-panel user LEDs undriven.
Rev06 instead allows a five-second shutdown interval, indicates error categories, and requires STOP to be released before ENABLE can resume operation.
Both programs retain static, active-high ``ReqSafeState`` and generate no heartbeat.
The later FlexLIO pin correction is absent from both programs' historical Diamond LPFs.
See :doc:`/s3c` for the side-by-side scope and validation limits.

Behavior
--------

The MachXO2 ``OSCH`` primitive supplies a nominal 2.08 MHz clock to the debounce counters and power-state machine.
The controller synchronizes and debounces the power button, external stop, front-panel stop and enable buttons, ``PG_VIN``, and ``PPn_VIN``.
At startup it requests safe state, masks the five digital slot output enables, and keeps the carrier power request low.
Its later states sequence carrier power, a 1.8 V reset output, ready operation, stop and error handling, and shutdown requests.
The ready-state slot mask uses the raw ``PPn_VIN`` input, while ``warning`` is hardcoded low.

Archive limits
--------------

The archived controller declares both ``CarrierReady`` outputs and the front-panel user LEDs without driving them.
Its source comment reports that ``ReqSafeState`` did not work while the 1.8 V bank was unpowered.
The state named ``Waiting_for_Powerbutton_released`` checks for the button being pressed again, so the name does not describe its actual transition condition.
Diamond uses constraints copied from the selected archive implementation, including its pin and bank settings.
The FOSS constraints omit ``JTAG_PORT=DISABLE`` and explicitly preserve Diamond's two bank-2 open-drain outputs.
``FlexMio61ExternalStop`` and ``SD_SEL`` retain ``LVCMOS33`` with explicit open-drain, no pull, 12 mA drive and slow slew. Their packed electrical fields are checked against Diamond before firmware export; see :doc:`/foss`.
The FOSS build proves mapped sequential equivalence with a shared abstract clock and excludes seven optimized internal signals from proof cutpoint matching.
Both firmware backends build this program; their bitstreams and electrical behavior have not been shown equivalent.

Verification
------------

The cocotb test drives the internal clock and checks only startup power, safe-state, slot-enable, and passthrough outputs.
That test does not verify the ready, stop, error, or shutdown transitions.
A separate GHDL integration test checks startup, ready operation, soft stop, and re-enable with the generated D-slot controller and an accelerated oscillator model.
Neither test establishes hardware safety.
