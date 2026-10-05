Purpose
-------

``s3c_rev6_beta`` implements a modular S3C power controller for ``LCMXO2-4000HC-4TG144C``.
The top-level VHDL uses the program-local ``s3c_rev6_beta_lib.vhdl`` and ``s3c_rev6_beta_fsm.vhdl``.
Its LPF maps FlexLIO[2] to pin 75 and FlexLIO[3] to pin 76.

Behavior
--------

This controller:

* Waits for supply availability and a released power button before accepting startup.
* Uses press-edge and continuous two-second hold detection for the power button.
* Uses millisecond ticks for debounce and state delays, with a nominal 2.08 MHz internal oscillator.
* Detects supply failure from debounced ``PG_VIN`` and external stop by level after observing a connected stop device.
* Requests SoM shutdown and retains carrier power for five seconds after a hard error, then switches off.
* Records errors and distinguishes previous-error and boot-error acknowledgement states.
* Requires STOP to be released before ENABLE can leave soft-error state.
* Drives front-panel user LEDs with error indications.

The controller uses active-high, static ``ReqSafeState`` and leaves ``CarrierReady`` undriven.
This program generates no heartbeat and must not be paired with D-slot firmware that requires one.
Physical D-slot output enables are still the requested enables masked by ``forceoutputdisable``; forwarding restrictions also depend on the selected D-slot firmware.
See :doc:`/s3c` for the controller comparison.

Build and programming
---------------------

::

   make check program=s3c_rev6_beta release_cycle=original
   make sim program=s3c_rev6_beta release_cycle=original
   make build program=s3c_rev6_beta release_cycle=original backend=diamond
   make build program=s3c_rev6_beta release_cycle=original backend=foss

The manifest selects VHDL-2008 and Synplify.
GHDL uses Synopsys-package compatibility for the preserved imports and reads the original source encoding without rewriting it.

Set ``release = "original"`` and ``s3c = "s3c_rev6_beta"`` in ``selection.toml``, then run::

   python -m cpld_toolchain program --target s3c --dry-run 1
   python -m cpld_toolchain program --target s3c

Use ``--programmer-backend foss`` to program Diamond JEDEC with FOSS tools, or ``--backend foss`` to program a current FOSS build.
The Diamond LPF retains ``JTAG_PORT=DISABLE`` and the configured bank settings.
The separate FOSS LPF retains JTAG access, explicitly preserves Diamond's open-drain configuration for ``FlexMio61ExternalStop`` and ``SD_SEL`` in their 1.8 V bank, and translates one-based vector indices to GHDL/Verilog zero-based indices.
These outputs retain ``LVCMOS33`` with explicit open-drain, no pull, 12 mA drive and slow slew.
Their packed electrical fields are checked against Diamond before firmware export; see :doc:`/foss`.
Both LPFs use the same physical pin assignments.
The FOSS backend uses the OSCH primitive's default 2.08 MHz frequency because the synthesis directives hide the generic.
Documentation generates the GHDL RTL schematic and simulation waveform.
The source-level FSM diagram extractor does not expand procedure calls, so no automatic state diagram is published for this controller.

Verification and limits
-----------------------

The cocotb test exercises the top level, checking initial safe-state outputs, supply-dependent startup, ready operation, soft stop, STOP/ENABLE priority, and delayed power removal after supply failure.
The test drives the unbound vendor oscillator output and accelerates the millisecond tick for state-sequence coverage; it does not measure real debounce or shutdown durations on hardware.
External-stop connection detection, long-press shutdown, and all error acknowledgement paths are not fully covered.

The FOSS mapped sequential induction check passes with explicit undefined-value modeling.
Its internal matching blacklist contains ``s3c_tick1ms.n302_o`` and ``s3c_fsm.n970_o``, 32-bit subtraction intermediates whose consumers retain only 12 and 13 bits respectively.
Synthesis removes their unused upper bits; excluding these internal match points keeps the underlying logic and all top-level outputs in the proof.
The strict eight-step startup check records an output counterexample: some reference output registers remain unspecified until assigned by the clocked controller, while mapped models have definite initial values.
A diagnostic eight-step check that treats unspecified initial registers as unknown and compares only defined reference outputs passes.
That diagnostic does not prove exact initial-state alignment, physical high-impedance behavior, or board startup; the build retains the strict failure in ``metadata/reports/equivalence.json``.

Both ``CarrierReady`` outputs remain undriven.
Temperature and slot-error categories are declared, but the implemented hard-error detector checks supply failure and external stop; the ``SlotOK`` inputs do not cause those fault decisions.
Warnings are hardcoded off, and the original source records the ``ReqSafeState`` limitation while its 1.8 V bank is unpowered.
A successful build and simulation do not establish hardware qualification; see :doc:`/validation`.
