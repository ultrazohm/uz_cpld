Program authoring walkthrough
=============================

This guide follows a D-slot program from authored files through RTL simulation to a firmware export.
Run every command from the repository root.
For native Windows setup, see :doc:`windows`.
Examples explicitly use the ``original`` cycle; they do not depend on the tracked default.
Use ``--release-cycle NAME`` to choose another; see :doc:`releases`.

Choose CSV generation or clone a program for manual VHDL editing.
Simulation checks the behavior exercised by the testbench; a firmware build implements the design for the device.
Neither step programs hardware.

Project flow
------------

.. mermaid::

   flowchart LR
      csv[CSV routing and generator TOML] --> gen[cpld_vhdl_generator]
      gen --> files[Program VHDL, LPF, manifest and cocotb testbench]
      manual[Cloned program files edited by hand] --> files
      description[Authored description.rst] --> docs
      files --> check[make check: validate inputs]
      files --> sim[make sim: pytest, cocotb and GHDL]
      sim --> waves[Simulation results and VCD waveform]
      files --> build[make build: Diamond or FOSS backend]
      build --> firmware[Firmware export, reports and metadata]
      files --> docs[make docs: pytest, cocotb, GHDL, Yosys, Graphviz, Plotly and Sphinx]
      docs --> waves
      docs --> site[Program pages, RTL diagrams and interactive waveforms]

The same authored program can be simulated, exported as firmware, and included in the generated documentation.
See :doc:`program-documentation` for the documentation stages and :doc:`foss` for the open-source firmware path.

.. _generator-quickstart:

Generate a program from CSV
---------------------------

Use the generator starter for a D-slot program with normal and safe routing states::

   uz_cpld new --name my_slot --template generator --release-cycle original
   # Edit programs/original/cvg_my_slot/routing.csv
   uz_cpld generate --program cvg_my_slot --release-cycle original
   uz_cpld sim --program cvg_my_slot --release-cycle original
   uz_cpld build --program cvg_my_slot --release-cycle original --backend diamond

The starter CSV has 30 transmit routes with low safe-state outputs.
The directory ``programs/original/cvg_my_slot/`` contains:

* ``routing.csv``: output pins and their normal-state and safe-state values.
* ``generator.toml``: program name, clock, S3C contract, pilot policy and target.
* ``description.rst``: program documentation.

``uz_cpld generate --program cvg_my_slot --release-cycle original`` creates:

* ``cvg_my_slot.vhdl``: VHDL matching the routing.
* ``cvg_my_slot_tb.py``: a matching cocotb testbench.
* ``cvg_my_slot_constraints.lpf``: D-slot board constraints.
* ``cvg_my_slot.toml``: the build manifest.
* ``generator-output.json``: the generation receipt with input and output hashes.

Generation validates the project and registers it in ``programs/<release_cycle>/catalog.toml``.
The starter is excluded from catalog commands until generation succeeds.
Edit ``routing.csv`` and, when needed, ``generator.toml``, then rerun ``uz_cpld generate --program cvg_my_slot --release-cycle original`` to update the generated files together.
The generator protects manually edited output files from overwriting.
The generated testbench checks input/output directions, normal and safe routing, and configured control conditions.
This workflow uses the ``uz_dslot_xo2`` board constraints, internal MachXO2 clock and Diamond backend.
Diamond requires a licensed installation; see :doc:`environments` for setup and :doc:`vhdl-generator` for routing and configuration details.

Clone a program for manual editing
----------------------------------

Clone an existing program, replacing ``my_adapter`` with your program name::

   uz_cpld new --name my_adapter --template tx30 --release-cycle original
   # Edit the cloned files listed below
   uz_cpld check --program my_adapter --release-cycle original
   uz_cpld sim --program my_adapter --release-cycle original
   uz_cpld build --program my_adapter --release-cycle original --backend diamond

``template`` defaults to ``tx30`` and can name another program to clone.
The clone is added to ``programs/<release_cycle>/catalog.toml``, so catalog-wide commands and CI include it.
``uz_cpld list`` shows the current catalog.
Edit these files in ``programs/original/my_adapter/``:

* ``my_adapter.vhdl``: implement the logic.
* ``my_adapter_constraints.lpf``: assign pins and other physical constraints.
* ``my_adapter.toml``: list sources, top entity, VHDL standard, target and testbench.
* ``my_adapter_tb.py``: drive inputs and assert expected outputs with cocotb.
* ``description.rst``: describe the program on its generated documentation page.

The clone retains the template's VHDL entity name.
Both clones and generator starters automatically receive a fresh program number in ``programs/usercodes.json``.
Commit that registry with the program; builds also record their USERCODE revisions there, as described in :doc:`firmware-identity`.
If you rename the entity, update ``top`` in the manifest as well.
See :doc:`configuration` for the manifest and target fields.

Inspect the result
------------------

Simulation writes logs, result XML and ``waves.vcd`` under ``programs/<release_cycle>/<name>/build/simulation/``.
Open the VCD in GTKWave or use ``uz_cpld docs`` to generate an interactive waveform page.
A failed test assertion fails the simulation command.

Diamond exports ``<name>_uz_dslot_xo2_diamond.jed`` and ``<name>_uz_dslot_xo2_diamond.bit`` under ``programs/<release_cycle>/<name>/build/uz_dslot_xo2_diamond/``.
That directory also contains logs, reports and metadata.
``metadata/status.json`` records the outcome; ``metadata/build.json`` records the inputs, tools and output hashes of a successful build.
See :doc:`validation` for what these checks establish.

Next steps
----------

* Run ``make`` for the command overview and ``uz_cpld list`` for catalog programs.
* Use :doc:`builds` for catalog builds, reports, the Diamond GUI and cleanup.
* Use :doc:`simulation` for test coverage, seeds and waveform formats.
* Use :doc:`program-documentation` for RTL diagrams and generated program pages.
* Use :doc:`foss` for the alternative firmware backend and its supported programs.
