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

Build and validation
--------------------

::

   make check program=s3c_heartbeat release_cycle=heartbeat
   make sim program=s3c_heartbeat release_cycle=heartbeat
   make build program=s3c_heartbeat release_cycle=heartbeat backend=diamond

The current toolchain uses Diamond LSE; the upstream project used Synplify.
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
