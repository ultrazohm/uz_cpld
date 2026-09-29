This cycle collects the archived reference firmware, resolver/inverter variants, and the generated ``cvg_tx30_stateful`` example for UltraZohm MachXO2 D-slot and S3C CPLDs.
``catalog.toml`` lists the programs included in catalog-wide builds.

.. rubric:: S3C source and scope

This cycle provides ``s3c_power_on_debounce`` and ``s3c_rev6_beta`` as separate S3C power and safety controllers.
``s3c_power_on_debounce`` is based on ``archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd`` from **commit 6794ce263a7c2b099001e429ce03a2d9b91d9b1d** (17 December 2024, ``rev05 00``).
``s3c_rev6_beta`` imports the three VHDL sources and LPF from commit ``2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae`` (31 October 2025), with only the unused internal high-impedance driver commented out for GHDL synthesis.
See :doc:`/s3c` for source links, historical context, behavior differences, and inherited limitations.
``s3c_toolchain_test_program`` is a fixed-output build and simulation example, not a power controller.

.. rubric:: S3C and D-slot compatibility

This cycle uses an active-high, static ``ReqSafeState`` signal.
Neither S3C controller generates a heartbeat, and its D-slot programs do not implement heartbeat-loss detection.
The generated ``cvg_tx30_stateful`` program uses the ``s3c_power_on_debounce_v1`` contract, which ignores ``CarrierReady`` because the archived S3C leaves that output undriven.
Heartbeat firmware using either ``ReqSafeState`` or ``CarrierReady`` requires a different contract and coordinated S3C and D-slot programs.

The Rev06 snapshot predates heartbeat signaling; the later heartbeat implementations and 16 grouped voltage-card TX/RX configurations are not part of this cycle.
The two archived voltage-card TX30 variants remain available.
Individual program descriptions define routing, output gating, and card-specific behavior; in particular, the temperature-card communication signals retain their safe-state gating.

.. rubric:: Build and programming support

Firmware builds support the backends declared by each program.
All 22 catalog programs support Diamond and FOSS firmware builds.
Both S3C controllers preserve their Diamond LPFs and use separate FOSS constraints.
Diamond firmware can be programmed using Diamond or FOSS; FOSS firmware uses the FOSS programmer.
The selected firmware build and programmer backend are independent choices; see :doc:`/programmer`.
S3C and D-slots require different UltraZohm physical states and are programmed separately.

.. rubric:: Validation and limits

The cycle includes program-level simulations and a GHDL integration test of the S3C controller with ``cvg_tx30_stateful``.
The tests do not cover every S3C error and shutdown sequence or establish hardware qualification.
Both S3C controllers have strict initialized-state equivalence counterexamples associated with unspecified RTL startup values; successful compilation does not establish identical startup or electrical behavior between firmware backends.
See :doc:`/validation` for evidence scope and use ``make report release_cycle=original backend=diamond|foss`` to inspect current local build evidence.
