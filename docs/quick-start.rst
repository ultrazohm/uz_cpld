Quick start
===========

This guide follows a D-slot program from authored files through RTL simulation to a firmware export.
Run every command from the repository root.
The D-slot target is ``uz_dslot_xo2`` (``LCMXO2-2000HC-4TG100C``); the S3C target is ``uz_s3c_xo2`` (``LCMXO2-4000HC-4TG144C``).

Choose CSV generation or clone a program for manual VHDL editing.
Simulation checks the behavior exercised by the testbench; a firmware build implements the design for the device.
Neither step programs hardware.

.. _generator-quickstart:

Generate a program from CSV
---------------------------

Use the generator starter for a D-slot program with normal and safe routing states::

   make new name=my_slot template=generator
   # Edit programs/my_slot/routing.csv
   make generate program=my_slot
   make sim program=my_slot
   make build program=my_slot backend=diamond

The starter in ``programs/my_slot/`` contains:

* ``routing.csv``: output pins and their normal-state and safe-state values.
* ``generator.toml``: program name, clock, S3C contract, pilot policy and target.
* ``description.rst``: program documentation.

``make generate program=my_slot`` creates:

* ``my_slot.vhdl``: VHDL matching the routing.
* ``my_slot_tb.py``: a matching cocotb testbench.
* ``my_slot_constraints.lpf``: D-slot board constraints.
* ``my_slot.toml``: the build manifest.
* ``generator-output.json``: the generation receipt with input and output hashes.

Generation validates the project and registers it in ``programs/catalog.toml``.
The starter is excluded from catalog commands until generation succeeds.
Edit ``routing.csv`` and, when needed, ``generator.toml``, then rerun ``make generate`` to update the generated files together.
The generator protects manually edited output files from overwriting.
The generated testbench checks input/output directions, normal and safe routing, and configured control conditions.
This workflow uses the ``uz_dslot_xo2`` board constraints, internal MachXO2 clock and Diamond backend.
Diamond requires a licensed installation; see :doc:`environments` for setup and :doc:`vhdl-generator` for routing and configuration details.

Clone a program for manual editing
----------------------------------

Clone an existing program, replacing ``my_adapter`` with your program name::

   make new name=my_adapter template=tx30

``template`` defaults to ``tx30`` and can name another program to clone.
The clone is added to ``programs/catalog.toml``, so catalog-wide commands and CI will include it.
``make list`` shows the current catalog.
Edit these files in ``programs/my_adapter/``:

* ``my_adapter.vhdl``: implement the logic.
* ``my_adapter_constraints.lpf``: assign pins and other physical constraints.
* ``my_adapter.toml``: list sources, top entity, VHDL standard, target and testbench.
* ``my_adapter_tb.py``: drive inputs and assert expected outputs with cocotb.
* ``description.rst``: describe the program on its generated documentation page.

The clone retains the template's VHDL entity name.
If you rename the entity, update ``top`` in the manifest as well.
See :doc:`configuration` for the manifest and target fields.

Validate and simulate
---------------------

Validate the manifest and input files, then run the testbench::

   make check program=my_adapter
   make sim program=my_adapter

``check`` does not compile or simulate HDL.
``sim`` compiles the manifest's VHDL with GHDL and runs its cocotb testbench; a failed assertion fails the command.
The simulator writes logs, result XML, ``waves.vcd`` and ``metadata/run.json`` under ``programs/my_adapter/build/simulation/``.
Open the VCD in GTKWave or use ``make docs`` to generate an interactive waveform page.
Simulation is independent of the firmware backend and does not use LPF placement or device timing.
See :doc:`simulation` for waveform formats and test limits.

Choose a firmware backend
-------------------------

Select the toolchain and check that it starts before building::

   make doctor backend=diamond
   make build program=my_adapter backend=diamond

``diamond`` is the default backend.
It requires an accessible, licensed Diamond installation; see :doc:`environments`.
Diamond creates a project, then runs synthesis, translate, map, place-and-route, timing reporting, Bitgen and Jedecgen.
The exports are ``my_adapter_uz_dslot_xo2_diamond.bit`` and ``my_adapter_uz_dslot_xo2_diamond.jed``.

The open-source option uses the same authored VHDL and LPF::

   make doctor backend=foss
   make build program=my_adapter backend=foss

The FOSS pipeline uses GHDL, Yosys, nextpnr-machxo2 and Project Trellis to export ``my_adapter_uz_dslot_xo2_foss.bit``.
It also checks synthesis equivalence and unpacks the bitstream as a format check.
It does not export JEDEC; its MachXO2 support is experimental.
On a host, Make runs FOSS firmware commands in the toolchain container; inside a Dev Container it uses installed tools.
See :doc:`foss` for constraints and validation limits.

Inspect the result
------------------

Each backend keeps its result in ``programs/my_adapter/build/uz_dslot_xo2_<backend>/``.
The directory contains the named firmware file or files, ``project/`` inputs and intermediates, ``logs/``, ``reports/`` and ``metadata/``.
Read ``metadata/status.json`` for the outcome and ``metadata/build.json`` for the inputs, tools, warnings and hashes of a successful export.
Review the reports before treating the firmware as ready for hardware; this repository defines no timing acceptance budget.
A successful build does not flash a device.

Other commands and options
--------------------------

* ``make sim`` and ``make build-all backend=foss`` process the catalog; ``program=NAME`` selects one program for ``sim`` or ``build``.
* ``make sim program=NAME seed=42 wave_format=ghw`` sets the simulation seed and emits GHW alongside VCD; ``wave_format`` accepts ``vcd`` (default), ``ghw`` or ``fst``.
  The FOSS place-and-route seed is a separate setting in the target manifest.
* ``make project program=NAME backend=diamond`` prepares a project without exporting firmware.
  ``make project program=NAME backend=foss`` prepares its scripts and build plan without exporting firmware.
  ``make gui program=NAME backend=diamond`` opens a Diamond project when a display is available; the FOSS backend has no GUI command.
* ``make netlist program=NAME`` generates a generic RTL diagram without device placement.
  ``make docs`` generates program pages, diagrams and simulation waveforms for every program manifest, then builds the Sphinx site.
* ``make test-container`` runs the Python tooling tests in the container; these tests are separate from HDL simulation.
* ``make clean program=NAME backend=diamond`` removes only that backend's generated directory.
  ``make clean-all`` removes all generated build and documentation files.
* Each program selects its declared target automatically. ``target=uz_dslot_xo2|uz_s3c_xo2`` selects or filters it explicitly; ``backend=diamond|foss`` selects implementation.
* ``make new name=my_s3c template=s3c_toolchain_test_program`` creates an S3C program. The template holds the carrier power request and slot output enables inactive; replace its logic and testbench for an operating S3C controller.

See :doc:`builds` for generated-project handling and failure behavior.
