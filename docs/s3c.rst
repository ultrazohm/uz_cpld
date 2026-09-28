S3C controller and source provenance
====================================

Implemented controller
----------------------

``s3c_power_on_debounce`` is the only implemented S3C power and safety controller in the active program catalog.
Its logic is based on ``archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd``, selected by the archived default ``S3C_171224`` Diamond implementation.
The older root-level ``Power_on_debounce.vhd`` and other S3C implementations in the archive or on other branches are not incorporated into this controller.
In particular, this catalog does not include subsequent S3C development from ``develop``.

``s3c_toolchain_test_program`` is a fixed-output build and simulation example with no power sequencing, debounce, or shutdown controller.
The generator's ``s3c_logic.vhdl`` implements the D-slot side of the S3C interface; it is not an additional S3C controller.

Source revision
---------------

The archived source is byte-for-byte identical to the file in **commit 6794ce263a7c2b099001e429ce03a2d9b91d9b1d**, dated **17 December 2024**, with commit subject **rev05 00**.
That is the last source-content revision of the selected archived file before the repository was reorganized.
At that commit the path was ``MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd`` (without the ``archive/`` prefix).

* `Source at the original commit <https://github.com/ultrazohm/uz_cpld/blob/6794ce263a7c2b099001e429ce03a2d9b91d9b1d/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd>`_
* `Original commit <https://github.com/ultrazohm/uz_cpld/commit/6794ce263a7c2b099001e429ce03a2d9b91d9b1d>`_

The source was moved under ``archive/`` in commit ``7428b1ea2c05cb4cf6edba458881d4696f26e1d8`` (``restructure repo``, 24 September 2026).
That move did not change the archived file's contents.
Its SHA-256 is ``c820573f7fae2dcf63e7ddf223f848eda5bba95586985cff1ff59215b51f6294``.

Active port
-----------

The buildable source is ``programs/original/s3c_power_on_debounce/s3c_power_on_debounce.vhdl``.
The port retains the archived state machine, debounce logic, and output assignments, with these toolchain adaptations:

* Remove unused ``machxo2``, ``STD_LOGIC_ARITH``, and ``STD_LOGIC_UNSIGNED`` imports.
* Remove the unused internal ``tristate_signals`` vector and its two drivers; these assignments did not drive the physical ports.
* Remove the ``synthesis translate_off/on`` directives around the ``OSCH`` frequency generic and its mapping, exposing the nominal 2.08 MHz setting to synthesis.
* Normalize text encoding, line endings, and trailing whitespace, and add provenance comments.

Diamond uses the selected archived implementation's constraints.
FOSS uses a separate constraint file that omits ``JTAG_PORT=DISABLE`` and corrects two bank-2 ``IO_TYPE`` settings.
Source provenance does not establish identical Diamond and FOSS bitstreams or electrical behavior.

Validation limits
-----------------

The inherited controller leaves both ``CarrierReady`` outputs and the front-panel user LEDs undriven.
Its source records a ``ReqSafeState`` limitation while the 1.8 V bank is unpowered.
The program-level cocotb test checks startup outputs only.
A separate GHDL integration test couples the controller to ``cvg_tx30_stateful`` and checks startup, ready operation, soft stop, and re-enable with an accelerated oscillator model.
These tests do not cover the complete error and shutdown sequences or establish hardware qualification.
The FOSS initialized-state equivalence check records a startup counterexample.
See :doc:`validation` and :doc:`foss` for the scope of build and simulation evidence, and :doc:`programmer` for hardware programming commands.
