MachXO2 hardware test — 2026-10-07
========================================

Result: PASS for Diamond builds, Diamond programming, FOSS programming,
independent identity cross-reading, and power-cycle identity persistence.
Application-level hardware behavior was not tested.

Environment and scope
---------------------

* Checkout revision: ``febf4f13df55f02232735afc17fab7a00f2d354c``.
* Diamond: 3.14.0.75.2, including Synplify builds and Diamond Programmer.
* FOSS programmer: patched openFPGALoader v1.1.1-uz-programmer3.
* USB probe: UltraZohm FT4232, channel B, serial 0100106000045.
* D-slots: five LCMXO2-2000HC devices, IDCODE 012BB043.
* S3C: one LCMXO2-4000HC device, IDCODE 012BC043.
* Operator selected access modes and confirmed each requested power cycle.
* Slots were described by the operator as empty; six CPLDs were detected across
  the separate D-slot and S3C access modes.
* Firmware used for every hardware write was built by Diamond. These tests do
  not qualify FOSS-built firmware or legacy ispLEVER devices.

Build and simulation results
----------------------------

Diamond builds and corresponding HDL simulations passed for:
``cvg_tx30``, ``cvg_rx30``, ``cvg_tx16_14rx``, ``cvg_tx20_10rx``,
``cvg_optical_14tx_4rx`` and ``s3c_heartbeat`` in ``heartbeat_cvg``.
Fresh JEDEC and bitstream checksums and build provenance were recorded.
The initial tooling audit ran 432 tests: 428 passed and four were skipped.
Build warnings are retained in the evidence, including optimized-away ports and
S3C's JTAGENB-dependent access configuration. Successful builds do not establish
board I/O timing acceptance.

Programming matrix
------------------

All four programmer/reader combinations passed independently for both chains,
before and after the operator-confirmed power cycles:

* Diamond writes, Diamond reads: PASS.
* Diamond writes, FOSS reads: PASS.
* FOSS writes, Diamond reads: PASS.
* FOSS writes, FOSS reads: PASS.

This comprises eight cross-check records, each containing two reader results:
16 reader checks in total. Managed writes performed flash erase/program/verify.
Independent reads checked device ID, chain position, original silicon TraceID,
and expected firmware USERCODE. Every FOSS read additionally checked the SRAM
USERCODE against the Flash USERCODE. Post-cycle persistence here means identity
persistence; a separate post-cycle full-flash byte comparison was not performed.

Distinct D-slot assignments
----------------------------------------

Diamond wrote assignment A. After both readers confirmed A and its persistence,
FOSS wrote assignment B. Every slot changed firmware. Both readers confirmed B
immediately and again after power cycling.

.. list-table:: Firmware by chain position
   :header-rows: 1

   * - Slot
     - A: Diamond write
     - B: FOSS write (final)
   * - 1
     - cvg_tx30
     - cvg_rx30
   * - 2
     - cvg_rx30
     - cvg_tx16_14rx
   * - 3
     - cvg_tx16_14rx
     - cvg_tx20_10rx
   * - 4
     - cvg_tx20_10rx
     - cvg_optical_14tx_4rx
   * - 5
     - cvg_optical_14tx_4rx
     - cvg_tx30

The mapping is verified against recorded silicon identities at JTAG positions.
Physical connector labels were not independently checked with electrical probes.
Earlier identical-image tests passed but were insufficient to establish ordering;
the distinct-image matrix above provides the ordering evidence.

Final firmware identities
-------------------------

* slot1: ``heartbeat_cvg/cvg_rx30``, USERCODE ``0036000A``, TraceID ``0144381228405816``.
* slot2: ``heartbeat_cvg/cvg_tx16_14rx``, USERCODE ``0038000A``, TraceID ``014438122840581A``.
* slot3: ``heartbeat_cvg/cvg_tx20_10rx``, USERCODE ``0039000A``, TraceID ``01443812283C5E02``.
* slot4: ``heartbeat_cvg/cvg_optical_14tx_4rx``, USERCODE ``0035000A``, TraceID ``01443812283C6005``.
* slot5: ``heartbeat_cvg/cvg_tx30``, USERCODE ``003B0011``, TraceID ``01443812283C6003``.
* s3c: ``heartbeat_cvg/s3c_heartbeat``, USERCODE ``00510009``, TraceID ``014437468658443B``.

S3C initially contained the same s3c_heartbeat identity used in these tests.
Both programmers rewrote and verified it; no S3C identity transition was tested.
The system was left in the operator-selected S3C programming mode.
The repository's default selection.toml was not changed to match the distinct
final D-slot assignment; use the recorded selection-B.toml to reproduce it.

Observed failure and recovery
-----------------------------

The first distinct-image Diamond attempt failed chain preflight because S3C was
visible instead of D-slots (012BC043 instead of 012BB043). It stopped before
erase/program. An independent FOSS scan confirmed the mode mismatch. After the
operator selected D-slot mode, all five original silicon identities matched and
the retry passed. The failed attempt is retained with the successful results.

Evidence and limitations
------------------------

Detailed session record and logs: ``build/hardware-test-20261007/``.
Portable evidence archive: ``build/hardware-test-20261007-evidence.zip``;
its SHA-256 is stored beside it in the matching ``.sha256`` file.
The archive includes cross-check scripts and results, selections, firmware,
build metadata, relevant reports, and the successful and failed programming logs.
These generated files are ignored by Git; preserve the archive separately from
cleanup commands. This report is saved in repository documentation.

No oscilloscope/logic-analyzer measurements, physical routing tests, heartbeat
boundary measurements, power-control/fault-recovery acceptance, board-level
startup qualification, or comprehensive electrical/timing qualification were
performed. No operator LED/behavior observations were supplied. Functional HDL
simulation and flash verification do not establish those hardware properties.
