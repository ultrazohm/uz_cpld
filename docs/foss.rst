FOSS firmware pipeline
======================

::

   make doctor backend=foss
   make build program=tx30 backend=foss
   make build-all backend=foss
   make clean program=tx30 backend=foss

``backend`` defaults to ``diamond``; ``backend=foss`` selects the same program HDL, authored LPF and board target through the open-source pipeline.
FOSS compilation and tool checks use installed tools in the calling environment; enter the toolchain container explicitly if the host lacks them.
The Python CLI accepts ``--backend foss`` for native use.
Make variables use lowercase names; ``backend`` selects the firmware flow.
Simulation and generic RTL documentation use the shared GHDL flow independently of the firmware backend.

Tools and installation
----------------------

The container installs checksum-pinned OSS CAD Suite 2026-09-16 for Yosys, Project Trellis, OpenOCD and the stock openFPGALoader, alongside GHDL 4.1.0.
The stock nextpnr binary omits the two board devices, so the ``foss-builder`` Docker stage builds a pinned nextpnr revision with XO2-2000 and XO2-4000 support.
That stage builds the Trellis Python module to generate the device database, links Boost statically into nextpnr and excludes its GUI/Python integration.
It also compiles a separately pinned openFPGALoader v1.1.1 with the repository's MachXO2 USERCODE patch for managed programming.
Compiler dependencies remain in the builder stage; the single runtime image receives the resulting tools.
``FOSS_BUILD_JOBS`` controls build parallelism and defaults to 2.
The bundle is large and the first image build includes C++ compilation; subsequent image builds reuse Docker layers.

For native Linux amd64 setup, install GHDL and the shared Python requirements, then install the source-build prerequisites::

   sudo apt-get install build-essential python3-dev libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev libboost-thread-dev libeigen3-dev pybind11-dev curl pkg-config patch libftdi1-dev libusb-1.0-0-dev zlib1g-dev
   python3 -m pip install cmake==3.31.6
   python3 toolchain/foss/install.py --prefix /your/writable/path/oss-cad-suite
   python3 toolchain/foss/build_nextpnr.py --suite /your/writable/path/oss-cad-suite
   export FOSS_ROOT=/your/writable/path/oss-cad-suite
   make flasher-build
   python3 -m toolchain.buildsystem doctor --backend foss
   python3 -m toolchain.buildsystem build --program tx30 --backend foss

The suite and nextpnr installers refuse existing destinations and verify archive checksums before extraction.
``make flasher-build`` verifies its source and patch checksums and replaces its local installation after compilation and tests pass.
Release and source pins are in ``toolchain/foss/toolchain.json``, ``toolchain/foss/sources.json`` and ``toolchain/foss/openfpgaloader.json``.
``FOSS_ROOT`` defaults to ``/opt/oss-cad-suite``; tools are selected by absolute paths without replacing the system Python environment.
RTL schematic generation also uses this Yosys installation when available, falling back to Yosys on ``PATH`` for native setups without the suite.
The container does not install a second Yosys from Ubuntu packages.
Native nextpnr resides in ``$FOSS_ROOT/native/``, while the bundle's executables reside in ``$FOSS_ROOT/bin/``.
The image's patched loader resides in ``$FOSS_ROOT/native/openfpgaloader/``; ``make flasher-build`` installs a workspace override in ``toolchain/build/openfpgaloader/``.
See :doc:`firmware-identity` for loader selection and rebuilding.

Build stages and outputs
------------------------

.. mermaid::

   flowchart LR
      host[Native shell] --> cli[Python build CLI]
      dev[Container shell] --> cli
      inputs[Program VHDL, LPF, target] --> cli
      cli --> ghdl[GHDL: VHDL to Verilog]
      ghdl --> synth[Yosys: XO2 synthesis]
      ghdl --> proof[Yosys: RTL equivalence and startup checks]
      synth --> proof
      synth --> pins[Python: LPF and package translation]
      inputs --> pins
      pins --> pnr[nextpnr-machxo2: place and route]
      synth --> pnr
      pnr --> config[Python: complete device configuration]
      config --> pack[Project Trellis ecppack: bitstream]
      pack --> unpack[Project Trellis ecpunpack: format and CRC check]
      unpack --> artifacts[BIT file, reports, metadata and logs]
      proof --> artifacts
      artifacts -. separate manual step .-> loader[openFPGALoader: optional device programming]

GHDL elaborates VHDL to Verilog, Yosys maps logic with ``synth_lattice -family xo2``, nextpnr places/routes the selected device, and Trellis packs the configuration into a compressed bitstream suitable for the MachXO2 internal-flash loader.
Yosys checks mapped logic against the GHDL-generated Verilog before routing, and Trellis unpacks the resulting bitstream as a format/CRC check.
Sequential programs use the MachXO2 flip-flop and carry-cell simulation models with temporal induction and explicit undefined-value modeling (``equiv_simple -undef`` and ``equiv_induct -undef -seq 8``).
An internal oscillator, including one inside a flattened submodule, is replaced in the proof copies by the same arbitrary input while preserving its clock aliases and clock-dependent data outputs.
The firmware netlist retains the oscillator.
``s3c_power_on_debounce`` excludes seven optimized autogenerated internal signals from induction cutpoint matching; ``s3c_rev6_beta`` excludes two internal subtraction results whose unused upper bits are removed during synthesis.
These exclusions remove internal matching boundaries, not the underlying logic or top-level output checks; top-level outputs cannot be placed on the blacklist.
The induction proof establishes that matched observation points cannot diverge after eight equal cycles.
A separate bounded miter checks defined top-level RTL outputs for eight cycles from the initial values in the Yosys simulation models, with the same arbitrary clock on both sides.
If it passes, a second bounded check verifies every retained internal match point for eight cycles; together these establish the base case needed by the induction proof.
``cvg_tx30_stateful`` passes this check; both S3C controllers have startup counterexamples, so their initial alignment is not proven.
The S3C miter explicitly excludes wholly undefined or high-impedance RTL output ports and lists them in ``equivalence.json``.
These proofs do not establish oscillator startup, place-and-route behavior, or hardware behavior.
Unknown RTL values remain unspecified for synthesis and do not establish physical output levels.

Outputs live under ``programs/<release_cycle>/<name>/build/<target>_foss/`` with ``<name>_<target>_foss.bit``, ``reports/``, ``metadata/``, project files and logs under the same directory.
The FOSS build plan and generated JSON reports live in ``metadata/``.
Reports include synthesized/routed JSON, timing, completed/unpacked configuration, equivalence evidence and method, tool versions/hashes and the constraint translation record.
``make build-all backend=foss`` writes a catalog report under ``toolchain/build/validation/<release_cycle>/foss-catalog/``; ``make report backend=foss`` refreshes that report from existing evidence without rebuilding.
``project backend=foss`` prepares the synthesis script and build plan; the equivalence script is generated during a build after mapped cells are known.
``gui`` requires ``backend=diamond``.
Cleanup affects only the selected backend, so Diamond and FOSS results can coexist.
The FOSS backend exports ``.bit``; Diamond exports JEDEC files.

Constraints and limits
----------------------

Diamond PIO names such as ``PT22A`` are translated through the selected XO2-2000 TQFP100 or XO2-4000 TQFP144 package database. Numeric package pins are accepted for either target.
For the S3C target, the LPF must declare the Rev05 board's six bank voltages. The FOSS flow checks each assigned pin's ``IO_TYPE`` against its bank and writes the three 1.8 V bank enums using locations decoded from the archived Diamond S3C image.
The verified exception is the pair of LVCMOS33 open-drain outputs on bank-2 pins 41 and 50, described below.
Unloaded input ports are removed before routing; remaining IO must have explicit pin constraints, with automatic unconstrained placement disabled.
Constraints for absent ports are listed in the report, including the inherited ``CPLD_DIGOUT_01`` entries.
IO type, slew, pull mode and drive directives pass through; unsupported LPF commands or attributes fail the build.
Explicit ``OPENDRAIN=ON`` is supported only for the verified S3C output configuration below; other combinations fail instead of assuming electrical compatibility.
Conflicting pin locations and IOBUF settings are rejected.
Vector bit constraints use the synthesized port index range, including nonzero offsets.

``SDM_PORT``, ``SLAVE_SPI_PORT`` and ``I2C_PORT`` are applied as database-validated CFG tile enums before packing.
``MCCLK_FREQ`` accepts only ``2.08``, using the default MachXO2 encoding checked against a Diamond reference.
The backend converts the oscillator's packed ASCII ``NOM_FREQ`` parameter to the string expected by nextpnr and checks it against ``MCCLK_FREQ``.
An omitted ``NOM_FREQ`` uses the MachXO2 primitive's 2.08 MHz default, including the preserved Rev06 source whose synthesis directives hide its generic.
The managed build replaces authored ``USERCODE`` values with the code allocated by ``programs/usercodes.json`` and passes it to the packer; see :doc:`firmware-identity`.
``TRACEID`` is retained in provenance but is not encoded by this backend.
The LPF reset/asynchronous-path exclusions are recorded without establishing a timing acceptance budget.

Upstream MachXO2 support is experimental.
Successful exports and synthesis equivalence do not establish matching Diamond bitstreams, electrical defaults, timing closure or hardware qualification.

``s3c_power_on_debounce`` extracts the archived ``S3C_171224`` controller for both firmware backends and simulation.
Its FOSS LPF omits ``JTAG_PORT=DISABLE``, which Trellis cannot reproduce, explicitly preserves Diamond's two bank-2 open-drain outputs, and translates one-based VHDL vector indices to zero-based Verilog indices.
``s3c_rev6_beta`` uses the same adaptations in its separate FOSS LPF while retaining the original Diamond LPF and imported HDL bytes.
The remaining configuration differences, startup proof counterexample, and incomplete safety outputs require review before hardware use.

S3C output electrical configuration
-----------------------------------

Both S3C controllers declare bank 2 at 1.8 V but assign ``LVCMOS33`` to ``SD_SEL`` (pin 41) and ``FlexMio61ExternalStop`` (pin 50).
Diamond 3.14 selects open-drain operation when ``OPENDRAIN`` is unspecified for this combination.
An isolated Diamond build rejects the same combination with ``OPENDRAIN=OFF``; changing it to ``LVCMOS18`` instead produces ordinary push-pull outputs.
The original author's intent is not established by those constraints alone. The FOSS port preserves the observed Diamond behavior.

The FOSS LPFs therefore retain ``LVCMOS33`` and explicitly request ``OPENDRAIN=ON PULLMODE=NONE DRIVE=12 SLEWRATE=SLOW`` on these two outputs.
The original Diamond LPFs remain unchanged.

The pinned Trellis ``DRIVE`` encoding was characterized with LVCMOS33 at its normal bank voltage and overlaps the open-drain field.
Packing nextpnr's unmodified ``OPENDRAIN`` and ``DRIVE`` enums therefore does not reproduce Diamond's bank-2 configuration.
The build completes these two output encodings using the Diamond reference and checks the entire relevant electrical field after packing and decoding.
A mismatch fails the build before firmware export. ``metadata/reports/constraints.json`` records each verified pin.
This is a check of these two output buffers, separate from the logic-equivalence proof; it does not establish equivalence of every device setting or board behavior.

The reference can be reproduced by building either S3C program with ``backend=diamond`` and decoding its exported ``.bit`` with ``ecpunpack``.
The relevant tiles are ``PB4:PIC_B0`` and ``PB13:PIC_B0``, both PIOB.
Diamond's pad report specifies open drain, 12 mA and slow slew. The set electrical bits are ``F0B18 F5B10 F5B12 F5B14 F5B20 F5B24 F5B36``.
The decoder represents this as ``PIOB.BASE_TYPE INPUT_LVCMOS18``, ``PIOB.OPENDRAIN ON``, ``PIOB.PULLMODE NONE`` and unknown bits ``F0B18`` and ``F5B10``.
The apparent input type is an overlapping decoder alias; ``F0B18`` enables the output.
The regression test packs and decodes this configuration, rejects the uncorrected drive overwrite, and detects a changed drive encoding even when open-drain remains enabled.

Programming and CI
------------------

Firmware builds do not access a device or select a cable, JTAG chain or programming mode.
Managed FOSS programming uses the patched loader to write and verify USERCODE and then checks device identities using OpenOCD.
The stock loader remains usable for scans but is rejected by managed flash programming; see :doc:`programmer`.
The CI workflow builds catalog programs that support ``backend=foss`` and retains their artifacts alongside simulation and documentation diagnostics.
GitHub Pages publishes documentation after successful checks; firmware is retained as a workflow artifact rather than published to Pages.

References
----------

* `nextpnr MachXO2 implementation <https://github.com/YosysHQ/nextpnr/tree/main/machxo2>`_
* `Project Trellis <https://github.com/YosysHQ/prjtrellis>`_
* `OSS CAD Suite releases <https://github.com/YosysHQ/oss-cad-suite-build/releases>`_
* `openFPGALoader <https://github.com/trabucayre/openFPGALoader>`_

Heartbeat comparison pilot
--------------------------

``heartbeat_cvg/cvg_tx30`` opts into FOSS. Other heartbeat slots and the S3C
remain Diamond-only. Build and check the pilot with installed tools::

   make build program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss
   make compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss

On a machine with Diamond and the FOSS tools, build the same source with Diamond
and omit ``backend`` from the comparison command to check both implementations::

   make build program=cvg_tx30 release_cycle=heartbeat_cvg backend=diamond
   make compare program=cvg_tx30 release_cycle=heartbeat_cvg

``compare`` consumes firmware builds and writes ``build/comparison/``; it never
programs hardware. Both builds must have current input/output hashes. Missing or
stale Diamond evidence leaves the combined comparison incomplete and returns a
nonzero exit code. The FOSS-only command can pass without claiming Diamond
equivalence. Each run replaces its comparison artifacts under the build locks.

Diamond exports mapped Verilog using ``MapVerilogSimFile`` and routed Verilog/SDF
using ``TimingSimFileVlg``. The mapped snapshot is retained as
``reports/comparison_mapped.v``. FOSS retains ``reports/reference.v`` from GHDL
alongside synthesized and routed JSON. These exports are hashed in build records.

The command expands mapped cell models using the pinned Yosys MachXO2 library;
unsupported primitives fail elaboration. It replaces the single always-enabled
OSCH with a common ideal clock in comparison copies only. The firmware oscillator
is unchanged. Each netlist runs six Icarus Verilog scenarios: timeout, too-fast
and too-slow heartbeat, each introduced in normal and safe state. Tests cover
unarmed startup, invalid startup traffic, qualification, inclusive 10/52-clock
intervals, walking data patterns, safe pulses between clock edges, and error
persistence after heartbeat recovery and control changes. Output traces must
match the reference at every checkpoint. Each scenario starts a fresh process
with declared initial values. This tests initialization, not physical power
sequencing. The slot ties reset low; runtime reset remains covered by controller
RTL tests.

The FOSS proof checks all outputs and retained internal match points. Asynchronous
FFs use Yosys ``async2sync`` in proof copies only, with its negative-hold-time
assumption. Event-driven simulation retains the asynchronous FF semantics. The
pilot blacklist removes only ``controller.n226_o`` as an internal matching point:
GHDL emits this conditional edge-counter increment, whose unused intermediate
value can change after optimization without changing the consuming registers.
No output is excluded and no logic is removed. A changed compiled signal name
fails blacklist validation and requires re-evaluation. Initialized-state checks
must also pass for ``compare`` to pass.

For Diamond, the command attempts output-only induction against the GHDL-derived
reference and an eight-cycle initialized-output proof. Unproven obligations,
timeouts and unsupported cells prevent a passing combined comparison, even if
simulation passes. Actual Diamond exports still need validation on a machine
with Diamond; primitive fixture tests do not establish that integration.

``report.json`` records checks, tool/model hashes, build-record hashes, artifacts
and FOSS clock timing. With both bitstreams, it also unpacks and lists decoded
PIO, bank and global-setting differences. These require review: unused-pin
defaults, decoder aliases and undecoded bits are not automatically qualified.
USERCODE differs by build identity and is excluded.

Remaining qualification steps are explicit in the report:

* Review electrical settings, package pins and output-enable behavior.
* Define board input/output and asynchronous-path timing budgets and check both
  timing reports. The oscillator clock limit alone is insufficient.
* If needed, simulate Diamond's routed netlist with its SDF and vendor timing
  models in a supported simulator. Automated post-route timing simulation is not
  implemented here; FOSS routed JSON is retained for further work.
* Program each image on the same board and check heartbeat boundaries, data
  outputs, SlotOK/ReqOE, startup, fault persistence and recovery after slot power
  is removed and restored.

Passing functional checks does not mark those remaining steps complete.
The S3C toolchain test program exercises the second device and package but does not implement the carrier's operating state machine.
