S3C controllers and compatibility
=================================

S3C programs target ``LCMXO2-4000HC-4TG144C``.
The shared ``xo2_library/s3c`` implements the D-slot receiver; each S3C program supplies its own power controller.
Pair firmware by its signaling protocol and adapter routing.

.. list-table:: Current controllers
   :header-rows: 1

   * - Release/program
     - D-slot protocol
     - Firmware backends
   * - ``heartbeat_cvg/s3c_heartbeat`` and ``heartbeat/s3c_heartbeat``
     - CarrierReady heartbeat and independent active-high ReqSafeState
     - Diamond (Synplify)
   * - ``original/s3c_power_on_debounce``
     - Static active-high ReqSafeState; CarrierReady undriven
     - Diamond (LSE), FOSS
   * - ``original/s3c_rev6_beta``
     - Static active-high ReqSafeState; CarrierReady undriven
     - Diamond (Synplify), FOSS
   * - ``original/s3c_toolchain_test_program``
     - Fixed inactive power/output-enable example
     - Diamond, FOSS

Heartbeat controller
--------------------

``s3c_heartbeat.vhdl`` wires the program-local clock/debounce library and ``s3c_heartbeat_fsm.vhdl``.
Digital CarrierReady (pin 94) changes every 21 cycles of the nominal 2.08 MHz clock, giving approximately 49.5 kHz.
Heartbeat requires FSM enable, debounced power-panic input and debounced module power-good; otherwise the output is low.
ReqSafeState (pin 93) is independent and can request safe state while heartbeat continues during a soft stop.
Physical D-slot enables are masked by ``forceoutputdisable``.

Use with ``heartbeat`` D-slot programs or generated ``heartbeat_cvg`` receivers using ``s3c_heartbeat_v1``.
Before qualification those receivers inhibit outputs; after qualification heartbeat faults latch system error.
Static safe state alone does not disable every route: the selected program's routing policy still applies.
See :doc:`xo2-library` for qualification, reset, power and clock limits.

The sender gates heartbeat using debounced power-good, and enable can produce a one-clock startup pulse.
A healthy heartbeat cannot detect a ReqSafeState wire stuck low.
RTL tests exercise startup, heartbeat timing, module-power suppression/recovery, soft stop, STOP/ENABLE priority and delayed shutdown with accelerated ticks.
The manifest selects Synplify; the FSM requests ``safe,gray`` encoding, so fitted startup/reset behavior needs synthesis-level and hardware verification.
Two drivers of the unused ``tristate_signals`` vector prevent GHDL synthesis: the manifest permits Diamond only and declares a netlist omission.

Static controllers
------------------

``s3c_power_on_debounce.vhdl`` implements debounce, carrier power sequencing, ready/stop/error states and shutdown requests in one source.
It removes carrier power immediately on hard error; ENABLE can leave soft error while STOP remains pressed.
CarrierReady and user LEDs are undriven.
Its program test checks startup outputs; a separate integration test couples it to ``original/cvg_tx30_stateful`` and checks startup, ready, soft stop and re-enable.

``s3c_rev6_beta.vhdl`` uses a program-local library and FSM.
It waits for supply and a released power button, detects supply failure and external stop, indicates errors with LEDs, and delays power removal five seconds after a hard error.
STOP must be released before ENABLE resumes operation.
Its tests cover startup, ready, soft stop, STOP/ENABLE priority and supply-failure shutdown with accelerated ticks.
CarrierReady is undriven; SlotOK does not drive the implemented hard-error detector.
Its LPF assigns FlexLIO[2] to pin 75 and FlexLIO[3] to pin 76.

Both static controllers leave some RTL startup values unspecified and have strict FOSS initialized-state counterexamples.
Their separate FOSS LPFs retain JTAG access and explicitly configure open-drain outputs on pins 41 and 50; the backend checks those packed electrical fields.
See :doc:`foss` and :doc:`validation` for proof scope and electrical limits.
Neither static controller supplies the heartbeat required by heartbeat D-slot receivers.
