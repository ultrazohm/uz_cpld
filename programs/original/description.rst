This cycle contains static-protocol D-slot programs, two S3C power controllers, the fixed-output ``s3c_toolchain_test_program`` and the generated ``cvg_tx30_stateful`` example.
``catalog.toml`` selects 22 programs for catalog-wide builds, all supporting Diamond and FOSS.

.. rubric:: Protocol and behavior

``s3c_power_on_debounce`` and ``s3c_rev6_beta`` generate active-high static ReqSafeState and no heartbeat.
``cvg_tx30_stateful`` uses ``s3c_power_on_debounce_v1``, which ignores CarrierReady.
Do not pair these controllers with receivers requiring heartbeat.
Program descriptions define routing and safe-state gating; see :doc:`/s3c` for controller behavior.

.. rubric:: Validation

Program testbenches check declared behavior; a GHDL integration test couples ``s3c_power_on_debounce`` to ``cvg_tx30_stateful``.
Both S3C controllers have strict FOSS initialized-state counterexamples associated with unspecified RTL startup values.
Successful compilation does not establish matching initial state, electrical behavior or hardware qualification.
See :doc:`/validation`; inspect local evidence with ``uz_cpld report --release-cycle original``.
