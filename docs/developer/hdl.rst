HDL developer
=============

Use this guide to create programs by writing VHDL or by generating routing logic from CSV and TOML.
For changes to the generator implementation or build tooling, see :doc:`toolchain`.
Run commands from the repository root and select the release explicitly.

Quick start reference
---------------------

Use **Dev Containers: Reopen in Container** for the bundled HDL and Python tools.
For native setup, run ``python -m cpld_toolchain setup`` and install the native tools described in :doc:`../environments`.
Diamond builds additionally require Diamond and its license.

Create a handwritten program from an existing template::

   uz_cpld new --name my_adapter --template tx30 --release-cycle heartbeat
   # Edit programs/heartbeat/my_adapter/ sources, constraints and testbench.
   uz_cpld check --program my_adapter --release-cycle heartbeat
   uz_cpld sim --program my_adapter --release-cycle heartbeat
   uz_cpld build --program my_adapter --release-cycle heartbeat

Create a generated program::

   uz_cpld new --name my_slot --template generator --release-cycle heartbeat_cvg
   # Edit programs/heartbeat_cvg/cvg_my_slot/routing.csv and generator.toml.
   # Set contract = "s3c_heartbeat_v1", standard = "2008", synthesis = "synplify".
   uz_cpld generate --program cvg_my_slot --release-cycle heartbeat_cvg
   uz_cpld check --program cvg_my_slot --release-cycle heartbeat_cvg
   uz_cpld sim --program cvg_my_slot --release-cycle heartbeat_cvg
   uz_cpld build --program cvg_my_slot --release-cycle heartbeat_cvg

The generator starter defaults to the static ``s3c_power_on_debounce_v1`` contract, regardless of the release directory.
Select the intended S3C contract explicitly before generating a heartbeat program.
Use VHDL-2008 and Synplify to match the existing heartbeat programs.
Build commands above use Diamond by default.

Develop handwritten HDL
-----------------------

Clone a program with the right board target and S3C protocol as a starting point.
Edit its VHDL, LPF constraints, build manifest, cocotb testbench and ``description.rst`` together.
The manifest declares the top entity, source files, target, synthesis settings and simulation settings.
Add shared HDL through the manifest's source list; see :doc:`../configuration` and :doc:`../xo2-library`.

Check every physical pin direction and board constraint against the adapter wiring.
Define normal routing, safe-state behavior, startup behavior and any heartbeat-fault behavior in both HDL and tests.
Use :doc:`../s3c` to choose a compatible controller and understand the control signals.
Run ``check``, ``sim`` and ``build`` after changing the design.
A passing simulation establishes the behavior exercised by its tests; review implementation timing reports and validate the intended hardware separately.

Develop generated HDL
---------------------

Treat ``routing.csv`` and ``generator.toml`` as the editable source for generated projects.
The CSV describes normal and safe routes; TOML selects the clock, S3C contract, target and generator policy.
Run ``generate`` after changing either input.
It updates VHDL, LPF constraints, the build manifest, testbench and ``generator-output.json`` together, and registers the completed program in the release catalog.
The generator protects manually edited output files from overwriting.
Do not maintain generated output by hand; change the inputs and regenerate.
See :doc:`../vhdl-generator` for supported routes, contracts and validation rules.

Validate and document a program
-------------------------------

Document the hardware purpose, routing, control behavior and validation limits in the program's ``description.rst``.
Generate a focused documentation preview after tests pass::

   uz_cpld docs --program cvg_my_slot --release-cycle heartbeat_cvg

Open ``docs/_build/html/index.html`` to inspect its description, simulation waveform and available RTL diagrams.
Run ``uz_cpld docs`` to rebuild documentation for all releases.
Commit authored files, generated files and receipts, catalog changes, and ``programs/usercodes.json`` together.
To create an independent release instead of adding to an existing one, see :doc:`release-management`.
For hardware programming, follow the :doc:`../user/index`.

HDL reference
-------------

.. toctree::
   :maxdepth: 1

   ../quick-start
   ../configuration
   ../vhdl-generator
   ../xo2-library
   ../s3c
   ../simulation
   ../validation
   release-management
