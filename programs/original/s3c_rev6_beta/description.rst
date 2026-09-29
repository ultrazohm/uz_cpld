Purpose and source revision
---------------------------

``s3c_rev6_beta`` imports the modular Rev06 S3C power controller from **commit 2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae** (31 October 2025, Martin Geier, ``cleanup``).
It targets the ``LCMXO2-4000HC-4TG144C`` and retains the static safe-state protocol used before heartbeat signaling was introduced.

The following files are imported from ``MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_Rev06_beta/source/`` at that commit:

* ``s3c_rev6_beta.vhdl``: top-level wiring, button processing, and module instances.
* ``s3c_rev6_beta_lib.vhdl``: local clock/reset, millisecond tick, and debounce entities.
* ``s3c_rev6_beta_fsm.vhdl``: power and error state machine.
* ``s3c_rev6_beta_constraints.lpf``: original pin and electrical constraints.

`Browse the pinned source files <https://github.com/ultrazohm/uz_cpld/tree/2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_Rev06_beta/source>`_.
``upstream.json`` records the source commit, original directory, filename mapping, original and current SHA-256 hashes, and the single source edit.
Files use the flat program layout and naming convention of this catalog.
The sole source edit comments out ``tristate_signals <= (others => 'Z');``.
The original had two concurrent drivers of this unused internal vector. The remaining assignment reads the pins; it does not drive them.
The commented high-impedance driver does not affect the resolved value or physical outputs, and removing it enables GHDL synthesis.
All other source bytes, including text encodings and line endings, and the LPF are unchanged.
The manifest, testbench, descriptions, and provenance record are tooling additions outside those files.
The library is local to the program; no ``xo2_libraries`` submodule is required.

Historical context
------------------

Commit ``41235c6`` immediately before this revision split the controller into the three VHDL files.
Commit ``2107cd5`` reordered concurrent declarations and statements and formatted numeric literals without an identified logic change.
Its ``s3c_fsm.vhd`` is byte-for-byte identical to the file in ``develop`` at commit ``886271c6325146231b8384330083021b5356afb2``.
The later library export in ``acbd6c7`` and heartbeat changes in ``f399720`` (S3C sender) and ``524df52`` (D-slot receivers) are not included.
The later ``FlexLIO[2]``/``FlexLIO[3]`` pin correction in ``ab25b4f`` is also not included: this snapshot maps them to pins 75 and 76 respectively.

Behavior and comparison
-----------------------

Compared with ``s3c_power_on_debounce`` from December 2024, this controller:

* Waits for supply availability and a released power button before accepting startup.
* Uses press-edge and continuous two-second hold detection for the power button.
* Uses millisecond ticks for debounce and state delays, with a nominal 2.08 MHz internal oscillator.
* Detects supply failure from debounced ``PG_VIN`` and external stop by level after observing a connected stop device.
* Requests SoM shutdown and retains carrier power for five seconds after a hard error, then switches off.
* Records errors and distinguishes previous-error and boot-error acknowledgement states.
* Requires STOP to be released before ENABLE can leave soft-error state.
* Drives front-panel user LEDs with error indications.

Both programs use active-high, static ``ReqSafeState`` and leave ``CarrierReady`` undriven.
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

The manifest selects VHDL-2008 and the current tooling's Diamond LSE strategy.
The historical project selected Synplify; the new tooling supplies its own project and strategy, so identical source does not imply identical historical bitstreams.
GHDL uses Synopsys-package compatibility for the preserved imports and reads the original source encoding without rewriting it.

Set ``s3c = "s3c_rev6_beta"`` and ``build_backend = "diamond"`` in ``selection.toml`` for release ``original``, then use ``make programmer program target=s3c``.
Add ``dry_run=1`` to preview or ``programmer_backend=foss`` to program the same Diamond JEDEC with FOSS tools.
The default selection remains ``s3c_power_on_debounce``.

FOSS builds export a ``.bit`` file; select ``build_backend = "foss"`` and use ``programmer_backend=foss`` to program it.
The original Diamond LPF retains ``JTAG_PORT=DISABLE`` and the historical bank settings.
The separate FOSS LPF retains JTAG access, explicitly preserves Diamond's open-drain configuration for ``FlexMio61ExternalStop`` and ``SD_SEL`` in their 1.8 V bank, and translates one-based vector indices to GHDL/Verilog zero-based indices.
These outputs retain ``LVCMOS33`` with explicit open-drain, no pull, 12 mA drive and slow slew. Their packed electrical fields are checked against Diamond before firmware export; see :doc:`/foss`.
Physical pin assignments, including the historical FlexLIO mapping, are preserved.
The FOSS backend uses the OSCH primitive's default 2.08 MHz frequency because the historical synthesis directives hide the generic.
Documentation generates the GHDL RTL schematic and simulation waveform.
The source-level FSM diagram extractor does not expand procedure calls, so no automatic state diagram is published for this controller.

Verification and inherited limits
---------------------------------

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
The retained LPF predates the FlexLIO pin correction noted above.
A successful build and simulation do not establish hardware qualification; see :doc:`/validation`.
