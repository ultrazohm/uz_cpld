Purpose and source revision
---------------------------

``s3c_heartbeat`` imports the Rev06 S3C controller from
``feature/add_dig3v35v_configs_heartbeat`` at commit
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7``.
It targets ``LCMXO2-4000HC-4TG144C`` and retains the top entity name ``S3C``.

The top-level source, FSM and LPF are byte-for-byte copies from
``MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_Rev06_beta/source/``:

* ``UZ_S3C_toplevel.vhd`` becomes ``s3c_heartbeat.vhdl``.
* ``s3c_fsm.vhd`` becomes ``s3c_heartbeat_fsm.vhdl``.
* ``UZ_S3C.lpf`` becomes ``s3c_heartbeat_constraints.lpf``.

The program-local ``s3c_heartbeat_lib.vhdl`` comes from ``lib_sXc.vhd`` in
``ultrazohm/xo2_libraries`` at the branch's pinned submodule commit
``74c74460171527ff17ce074ae38ac34e14e3baec``.
Two compiler compatibility edits are necessary in this dependency:

* Qualify ``USE sXc_hbgen_pkg.ALL;`` with ``work.`` for GHDL.
* Give ``sXc_tickgen.tickin`` an all-zero default, allowing the unchanged
  ``tickin => OPEN`` mapping in GHDL and Diamond LSE. The top level sets
  ``CASCADE=0``, so this port is a null vector and is not used by the circuit.

All other bytes, including original encodings and line endings, are preserved.
``upstream.json`` records original names, revisions, original and current
SHA-256 hashes, and these two library edits. The manifest, testbench and
documentation are integration additions.

Heartbeat and safe-state behavior
---------------------------------

The digital ``CarrierReady`` output (pin 94) carries a nominal 49.5 kHz
heartbeat, with one transition every 21 cycles of the 2.08 MHz clock.
Heartbeat generation requires the FSM enable, debounced power-panic input
``ppn6v`` and debounced module power-good ``pg_som``. When disabled, the
physical heartbeat output is held low.

``ReqSafeState`` (pin 93) remains a separate active-high static request.
A soft stop can assert this request while the heartbeat continues.
Physical D-slot output enables remain masked by ``forceoutputdisable``.
Use D-slot firmware expecting heartbeat on ``CarrierReady`` and an independent
static ``ReqSafeState``. This release also includes the 29 heartbeat D-slot ports listed in the release description.

Known Diamond LSE startup failure (30 September 2026)
-----------------------------------------------------

The previously built Diamond LSE image has a reproduced startup defect matching the
reported hardware symptom: the power LED is red immediately after power-up,
Carrier_PwrOn stays low, and the power button has no effect. This finding
applies to ``s3c_heartbeat``. The earlier investigation of the separate
December 2024 ``s3c_power_on_debounce`` program does not explain this failure.

The FSM source requests ``syn_encoding = "safe,gray"`` and explicitly warns
against one-hot encoding with LSE because of register startup state. However,
the retained Diamond 3.14 synthesis report states:

* Gray encoding is unsupported for this FSM because it has more than four
  states, and the requested encoding will not be honored.
* The FSM is extracted with one-hot encoding instead.
* ``s3c_fsm/fsm_state_FSM_i1`` is stuck at zero.

The synthesized ``sXc_clkrst`` contains only the oscillator: its RTL startup
reset has been optimized away, and the synthesized FSM has no reset input.
The surviving one-hot state registers all power up at zero. No state becomes
active and normal startup cannot proceed. The resulting LED outputs select
red even though the controller has not entered the intended Harderror state.
Thus the LED color alone must not be interpreted as evidence of a detected
supply or external-stop fault.

The failure was reproduced using the retained ``S3C_prim.v`` netlist and
Lattice's installed MachXO2 Verilog primitive models, including OSCH and
power-up reset. With released buttons and good supply inputs, followed by a
12 ms power-button press, the original netlist produced:

::

   WAIT_SUPPLY: power=0 RGB=100 safe=1
   STANDBY:     power=0 RGB=100 safe=1
   PRESSED:    power=0 RGB=100 safe=1

As a diagnostic experiment, a disposable copy was built with only
``"safe,gray"`` changed to ``"safe,sequential"``. The identical testbench then
produced:

::

   WAIT_SUPPLY: power=0 RGB=110 safe=1
   STANDBY:     power=0 RGB=001 safe=1
   PRESSED:    power=1 RGB=101 safe=1

RGB lists red, green and blue in that order. The experiment confirms a
candidate correction for startup; it is not a full test of the shutdown,
error or heartbeat sequences. LSE still reports no reset state and ignores
the ``safe`` part of the encoding request in that disposable build. A robust
startup-reset implementation and any other ignored initialization values
therefore deserve separate review. No diagnostic source change or test image
was applied to this release or programmed onto hardware.

The upstream project selects Synplify. The earlier toolchain hardcoded LSE;
the program manifest now explicitly selects Synplify. The top-level source and FSM still match feature-branch commit
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` byte-for-byte. The GitHub
``ultrazohm/xo2_libraries`` HEAD was checked directly and remains
``74c74460171527ff17ce074ae38ac34e14e3baec``; the imported library matches after
undoing its two documented compiler compatibility edits. This is a
reproduced failure of our LSE build of those sources, not evidence that the
feature branch's historical Synplify bitstream has the same fault.

The existing cocotb and GHDL interaction tests simulate VHDL before LSE FSM
extraction, so they cannot detect this encoding/reset failure. Successful
firmware export and USERCODE readback also do not test the startup behavior.
Synthesis-netlist startup verification is needed alongside those checks.

Build and validation
--------------------

::

   make check program=s3c_heartbeat release_cycle=heartbeat
   make sim program=s3c_heartbeat release_cycle=heartbeat
   make build program=s3c_heartbeat release_cycle=heartbeat backend=diamond

The manifest now selects Synplify, matching the upstream project.
The LSE failure documented here applies to the earlier LSE build; changing the engine does not establish hardware qualification.
Preserving sources therefore does not imply identical historical bitstreams.
The imported LPF is unchanged, including its original JTAG settings; managed
builds insert the newly allocated firmware identity into a generated LPF copy.

The cocotb test exercises startup, 21-clock heartbeat edge spacing,
module-power suppression and recovery, independent soft-stop signaling,
STOP/ENABLE priority, and delayed power removal after supply failure.
The vendor oscillator is driven by the test and the millisecond tick is
accelerated. This is behavioral simulation, not physical timing validation.
No hardware programming or qualification is implied.

The unchanged top level retains two drivers of the unused internal
``tristate_signals`` vector. GHDL synthesis does not support this structure,
so the manifest declares Diamond support only and records why RTL schematic
export is skipped. GHDL simulation retains both original drivers.
