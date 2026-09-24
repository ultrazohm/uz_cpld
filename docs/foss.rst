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
The stock nextpnr binary includes other devices but omits XO2-2000, so the ``foss-builder`` Docker stage builds a pinned nextpnr revision with ``MACHXO2_DEVICES=2000``.
That stage builds the Trellis Python module to generate the device database, links Boost statically into nextpnr and excludes its GUI/Python integration.
Compiler dependencies remain in the build stage; the three runtime stages share the resulting tools.
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

Outputs live under ``programs/<name>/build/uz_dslot_xo2_foss/`` with ``<name>_uz_dslot_xo2_foss.bit``, ``reports/``, ``metadata/``, project files and logs under the same directory.
The FOSS build plan and generated JSON reports live in ``metadata/``.
Reports include synthesized/routed JSON, timing, completed/unpacked configuration, equivalence evidence, tool versions/hashes and the constraint translation record.
``project backend=foss`` prepares scripts and a build plan; ``gui`` requires ``backend=diamond``.
Cleanup affects only the selected backend, so Diamond and FOSS results can coexist.
The FOSS backend exports ``.bit``; JEDEC export remains available through Diamond.

Constraints and limits
----------------------

Diamond PIO names such as ``PT22A`` are translated to TQFP100 package pins using the pinned Trellis database.
Unloaded input ports are removed before routing; remaining IO must have explicit pin constraints, with automatic unconstrained placement disabled.
Constraints for absent ports are listed in the report, including the inherited ``CPLD_DIGOUT_01`` entries.
IO type, slew, pull mode and drive directives pass through; unsupported LPF commands or attributes fail the build.

``SDM_PORT`` and ``SLAVE_SPI_PORT`` are applied as database-validated CFG tile enums before packing.
``MCCLK_FREQ=2.08`` uses the default MachXO2 oscillator/control encoding checked against the Diamond reference; other configuration frequencies are rejected.
``TRACEID`` is retained in provenance but is not encoded by this backend.
The LPF reset/asynchronous-path exclusions are recorded without establishing a timing acceptance budget.

Upstream MachXO2 support is experimental.
Successful exports and synthesis equivalence do not establish matching Diamond bitstreams, electrical defaults, timing closure or hardware qualification.
The current flow supports the catalog programs with ``work`` library sources and the LPF subset described above.

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
