FOSS firmware pipeline
======================

::

   make doctor backend=foss
   make build program=tx30 backend=foss
   make build-all backend=foss
   make clean program=tx30 backend=foss

``backend`` defaults to ``diamond``; ``backend=foss`` selects the same program HDL, authored LPF and board target through the open-source pipeline.
On the host, FOSS compilation and tool checks run in the toolchain container; inside the Dev Container they use installed tools.
The Python CLI accepts ``--backend foss`` for native use.
Make variables use lowercase names; ``backend`` selects the firmware flow.
Simulation and generic RTL documentation use the shared GHDL flow independently of the firmware backend.

Tools and installation
----------------------

The container installs checksum-pinned OSS CAD Suite 2026-09-16 for Yosys, Project Trellis and openFPGALoader, alongside GHDL 4.1.0.
The stock nextpnr binary omits the two board devices, so the ``foss-builder`` Docker stage builds a pinned nextpnr revision with XO2-2000 and XO2-4000 support.
That stage builds the Trellis Python module to generate the device database, links Boost statically into nextpnr and excludes its GUI/Python integration.
Compiler dependencies remain in the builder stage; the single runtime image receives the resulting tools.
``FOSS_BUILD_JOBS`` controls build parallelism and defaults to 2.
The bundle is large and the first image build includes C++ compilation; subsequent image builds reuse Docker layers.

For native Linux amd64 setup, install GHDL and the shared Python requirements, then install the source-build prerequisites::

   sudo apt-get install build-essential python3-dev libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev libboost-thread-dev libeigen3-dev pybind11-dev curl
   python3 -m pip install cmake==3.31.6
   python3 toolchain/foss/install.py --prefix /your/writable/path/oss-cad-suite
   python3 toolchain/foss/build_nextpnr.py --suite /your/writable/path/oss-cad-suite
   export FOSS_ROOT=/your/writable/path/oss-cad-suite
   python3 -m toolchain.buildsystem doctor --backend foss
   python3 -m toolchain.buildsystem build --program tx30 --backend foss

The installers refuse existing destinations and verify archive checksums before extraction.
Release and source pins are in ``toolchain/foss/toolchain.json`` and ``toolchain/foss/sources.json``.
``FOSS_ROOT`` defaults to ``/opt/oss-cad-suite``; tools are selected by absolute paths without replacing the system Python environment.
Native nextpnr resides in ``$FOSS_ROOT/native/``, while the bundle's other executables reside in ``$FOSS_ROOT/bin/``.

Build stages and outputs
------------------------

GHDL elaborates VHDL to Verilog, Yosys maps logic with ``synth_lattice -family xo2``, nextpnr places/routes the selected device, and Trellis packs the configuration into a bitstream.
Yosys proves the mapped logic equivalent to the GHDL-generated Verilog before routing, and Trellis unpacks the resulting bitstream as a format/CRC check.
The equivalence check covers synthesis, not place-and-route or hardware behavior.
Unknown RTL values remain unspecified for synthesis and do not establish physical output levels.

Outputs live under ``programs/<name>/build/<target>_foss/`` with ``<name>_<target>_foss.bit``, ``reports/``, ``metadata/``, project files and logs under the same directory.
The FOSS build plan and generated JSON reports live in ``metadata/``.
Reports include synthesized/routed JSON, timing, completed/unpacked configuration, equivalence evidence, tool versions/hashes and the constraint translation record.
``project backend=foss`` prepares scripts and a build plan; ``gui`` requires ``backend=diamond``.
Cleanup affects only the selected backend, so Diamond and FOSS results can coexist.
The FOSS backend exports ``.bit``; JEDEC export remains available through Diamond.

Constraints and limits
----------------------

Diamond PIO names such as ``PT22A`` are translated through the selected XO2-2000 TQFP100 or XO2-4000 TQFP144 package database. Numeric package pins are accepted for either target.
For the S3C target, the LPF must declare the Rev05 board's six bank voltages. The FOSS flow checks each assigned pin's ``IO_TYPE`` against its bank and writes the three 1.8 V bank enums using locations decoded from the archived Diamond S3C image.
Unloaded input ports are removed before routing; remaining IO must have explicit pin constraints, with automatic unconstrained placement disabled.
Constraints for absent ports are listed in the report, including the inherited ``CPLD_DIGOUT_01`` entries.
IO type, slew, pull mode and drive directives pass through; unsupported LPF commands or attributes fail the build.

``SDM_PORT``, ``SLAVE_SPI_PORT`` and ``I2C_PORT`` are applied as database-validated CFG tile enums before packing.
``MCCLK_FREQ=2.08`` uses the default MachXO2 encoding checked against a Diamond reference; other values, including the archived S3C LPF's ``7``, need a device-specific comparison before support is added. ``USERCODE HEX`` is passed to the packer.
``TRACEID`` is retained in provenance but is not encoded by this backend.
The LPF reset/asynchronous-path exclusions are recorded without establishing a timing acceptance budget.

Upstream MachXO2 support is experimental.
Successful exports and synthesis equivalence do not establish matching Diamond bitstreams, electrical defaults, timing closure or hardware qualification.
The S3C toolchain test program exercises the second device and package but does not implement the carrier's operating state machine. ``s3c_power_on_debounce`` extracts the archived ``S3C_171224`` controller for Diamond and simulation. Its FOSS firmware backend is disabled because mapped sequential equivalence remains unproven. A prepared FOSS LPF omits ``JTAG_PORT=DISABLE``, which Trellis cannot reproduce, corrects two bank-2 ``IO_TYPE`` declarations to 1.8 V, and translates one-based VHDL vector indices to zero-based Verilog indices. These differences and the archive's incomplete safety outputs require review before hardware use. Other archived S3C variants use ``MCCLK_FREQ=7``, which this FOSS flow still rejects.

Programming and CI
------------------

openFPGALoader is installed, but firmware builds do not access a device or select a cable, JTAG chain or programming mode.
The CI workflow builds all catalog programs with ``backend=foss`` and retains their artifacts alongside simulation and documentation diagnostics.
GitHub Pages publishes documentation after successful checks; firmware is retained as a workflow artifact rather than published to Pages.

References
----------

* `nextpnr MachXO2 implementation <https://github.com/YosysHQ/nextpnr/tree/main/machxo2>`_
* `Project Trellis <https://github.com/YosysHQ/prjtrellis>`_
* `OSS CAD Suite releases <https://github.com/YosysHQ/oss-cad-suite-build/releases>`_
* `openFPGALoader <https://github.com/trabucayre/openFPGALoader>`_
