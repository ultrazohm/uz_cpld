S3C controller and source provenance
====================================

Implemented controllers
-----------------------

The ``original`` cycle contains two S3C power and safety controllers: ``s3c_power_on_debounce`` (December 2024) and ``s3c_rev6_beta`` (October 2025).
Both use static, active-high ``ReqSafeState`` without a heartbeat.
The logic of ``s3c_power_on_debounce`` is based on ``archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd``, selected by the archived default ``S3C_171224`` Diamond implementation.
The older root-level ``Power_on_debounce.vhd`` and other S3C implementations in the archive or on other branches are not incorporated into this controller.
The separate ``s3c_rev6_beta`` program includes the newer pre-heartbeat FSM; later heartbeat signaling from ``develop`` and the CarrierReady heartbeat branch is not included.

``s3c_toolchain_test_program`` is a fixed-output build and simulation example with no power sequencing, debounce, or shutdown controller.
The generator's ``s3c_logic.vhdl`` implements the D-slot side of the S3C interface; it is not an additional S3C controller.

December 2024 source revision
-----------------------------

The archived source is byte-for-byte identical to the file in **commit 6794ce263a7c2b099001e429ce03a2d9b91d9b1d**, dated **17 December 2024**, with commit subject **rev05 00**.
That is the last source-content revision of the selected archived file before the repository was reorganized.
At that commit the path was ``MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd`` (without the ``archive/`` prefix).

* `Source at the original commit <https://github.com/ultrazohm/uz_cpld/blob/6794ce263a7c2b099001e429ce03a2d9b91d9b1d/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd>`_
* `Original commit <https://github.com/ultrazohm/uz_cpld/commit/6794ce263a7c2b099001e429ce03a2d9b91d9b1d>`_

The source was moved under ``archive/`` in commit ``7428b1ea2c05cb4cf6edba458881d4696f26e1d8`` (``restructure repo``, 24 September 2026).
That move did not change the archived file's contents.
Its SHA-256 is ``c820573f7fae2dcf63e7ddf223f848eda5bba95586985cff1ff59215b51f6294``.

December 2024 port
------------------

The buildable source is ``programs/original/s3c_power_on_debounce/s3c_power_on_debounce.vhdl``.
The port retains the archived state machine, debounce logic, and output assignments, with these toolchain adaptations:

* Remove unused ``machxo2``, ``STD_LOGIC_ARITH``, and ``STD_LOGIC_UNSIGNED`` imports.
* Remove the unused internal ``tristate_signals`` vector and its two drivers; these assignments did not drive the physical ports.
* Remove the ``synthesis translate_off/on`` directives around the ``OSCH`` frequency generic and its mapping, exposing the nominal 2.08 MHz setting to synthesis.
* Normalize text encoding, line endings, and trailing whitespace, and add provenance comments.

Diamond uses the selected archived implementation's constraints.
FOSS uses a separate constraint file that omits ``JTAG_PORT=DISABLE`` and explicitly preserves Diamond's two bank-2 open-drain outputs.
Source provenance does not establish identical Diamond and FOSS bitstreams or electrical behavior.

December 2024 validation limits
-------------------------------

The inherited controller leaves both ``CarrierReady`` outputs and the front-panel user LEDs undriven.
Its source records a ``ReqSafeState`` limitation while the 1.8 V bank is unpowered.
The program-level cocotb test checks startup outputs only.
A separate GHDL integration test couples the controller to ``cvg_tx30_stateful`` and checks startup, ready operation, soft stop, and re-enable with an accelerated oscillator model.
These tests do not cover the complete error and shutdown sequences or establish hardware qualification.
The FOSS initialized-state equivalence check records a startup counterexample.
See :doc:`validation` and :doc:`foss` for the scope of build and simulation evidence, and :doc:`programmer` for hardware programming commands.

Rev06 beta snapshot
-------------------

``programs/original/s3c_rev6_beta/`` contains renamed copies of ``UZ_S3C_toplevel.vhd``, ``lib_sXc.vhd``, ``s3c_fsm.vhd``, and ``UZ_S3C.lpf`` from **commit 2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae** (31 October 2025, Martin Geier, ``cleanup``).
`Browse that source revision <https://github.com/ultrazohm/uz_cpld/tree/2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_Rev06_beta/source>`_.
The sole source edit comments out ``tristate_signals <= (others => 'Z');``, removing a second driver of an unused internal vector.
All other source bytes and the LPF are unchanged.
``upstream.json`` records the original-to-local filename mapping, original and current hashes, and the edit.

The preceding commit ``41235c6`` split the controller into reusable entities; ``2107cd5`` itself is cleanup without an identified functional change.
The FSM file matches ``develop`` at ``886271c6325146231b8384330083021b5356afb2`` exactly, while the heartbeat wrappers added by ``f399720`` and ``524df52`` are absent.
The local library predates its export to the ``xo2_libraries`` submodule in ``acbd6c7``.

.. list-table:: Controller behavior
   :header-rows: 1
   :widths: 25 35 40

   * - Function
     - ``s3c_power_on_debounce``
     - ``s3c_rev6_beta``
   * - Startup
     - Power-button waiting state
     - Supply and released-button check before startup
   * - Hard error
     - Immediate carrier power removal
     - Shutdown request, five-second delay, then power removal
   * - Error handling
     - Basic acknowledgement
     - Supply-failure detection and previous/boot-error acknowledgement
   * - STOP and ENABLE
     - ENABLE can leave soft error while STOP remains pressed
     - STOP must be released before ENABLE resumes operation
   * - User LEDs
     - Undriven
     - Error indications
   * - D-slot protocol
     - Static ``ReqSafeState``; no heartbeat
     - Static ``ReqSafeState``; no heartbeat
   * - Firmware build
     - Diamond or FOSS
     - Diamond or FOSS, with separate LPFs

The Rev06 snapshot retains the historical FlexLIO mapping (``FlexLIO[2]`` on pin 75 and ``FlexLIO[3]`` on pin 76); the later correction in ``ab25b4f`` is intentionally not applied.
Its manifest uses VHDL-2008 and the tooling's Diamond LSE strategy, rather than the historical Synplify project.
Diamond JEDEC programming is supported through either programmer backend.
FOSS bitstream generation and programming use a separate LPF that retains JTAG access, explicitly preserves Diamond's two bank-2 open-drain outputs, and translates one-based vector indices for GHDL's Verilog output.
The packed electrical configuration of those two outputs is checked against Diamond before export; see :doc:`/foss`.
The shared FOSS backend supports its hierarchical oscillator and uses the primitive's default 2.08 MHz frequency when the historical synthesis directives hide the generic.
Sequential induction with undefined-value modeling passes, excluding two truncated internal subtraction results from signal matching while retaining all top-level output checks.
The strict eight-step startup comparison records an output counterexample, as it does for the December 2024 controller; see :doc:`validation` for the diagnostic result and proof limits.
GHDL simulation covers startup, ready operation, soft stop, STOP/ENABLE priority, and supply-failure shutdown with an accelerated timebase.
Commenting out the unused high-impedance driver enables GHDL RTL schematic generation; the remaining assignment only reads pins into an unused internal vector and does not drive physical pins.
No automatic FSM diagram is generated because the transition extractor does not expand procedures.
Neither controller has comprehensive hardware qualification; consult each program's description and :doc:`validation`.
