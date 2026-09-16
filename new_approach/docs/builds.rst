Build and author programs
=========================

Firmware commands
-----------------

::

   make list
   make check PROGRAM=tx30
   make doctor
   make build PROGRAM=tx30
   make build-all

``check`` validates manifests and files; ``doctor`` also checks Diamond Tcl startup.
``build-all`` processes the explicit ``programs/catalog.toml`` list and fails if any entry fails.
The default Make target is ``build`` and requires ``PROGRAM``.
``TARGET`` defaults to ``uz_dslot_xo2`` and ``TOOLCHAIN`` selects the implemented backend, ``diamond``.
Firmware commands run in the calling environment and never flash a device.

Create a program
----------------

::

   make new NAME=my_adapter TEMPLATE=tx30
   make check PROGRAM=my_adapter
   make sim PROGRAM=my_adapter
   make build PROGRAM=my_adapter

Edit the cloned VHDL, LPF, cocotb testbench and optional ``description.rst`` before validation.
Cloning copies the selected program's current files, preserves entity names and libraries, and excludes generated ``build/`` directories and Python caches.
It requires a listed ``<template>.vhdl`` primary source, program-local inputs and no authored symlinks, and refuses an existing destination.
A clone is independent of its source and must be reviewed before adding it to the firmware catalog.
Documentation includes all program manifests, including uncatalogued clones.

Outputs and failures
--------------------

``programs/<name>/build/<target>/diamond/`` contains the generated ``project/``, retained ``logs/`` and published ``artifacts/``.
Artifacts include ``firmware.jed``, ``firmware.bit``, reports and a ``build.json`` provenance record.
``configuration.json`` detects changes to generated settings; ``status.json`` records builds that passed the initial guards.

A build that passes the lock/configuration guards removes previous artifacts before invoking Diamond.
Preparation or compilation failure preserves logs without publishing stale firmware.
An earlier rejection, such as an invalid manifest or edited generated settings, leaves previous outputs untouched.
``project`` regenerates project files without refreshing firmware; consult ``build.json`` for the inputs used by an export.

GUI and cleanup
---------------

With a native Diamond installation and display::

   make project PROGRAM=tx30
   make gui PROGRAM=tx30
   make clean PROGRAM=tx30

Generated projects reference authored HDL and LPFs; edits to those files persist.
Check the destination when saving from Spreadsheet View, because an exported LPF does not replace the authored input automatically.
Transfer useful project/strategy changes into manifests or the target strategy before regenerating.
``gui`` preserves an existing project, while ``project``, ``build`` and ordinary ``clean`` reject edited generated settings.
After preserving useful changes, ``make clean PROGRAM=tx30 DISCARD_PROJECT_CHANGES=1`` explicitly discards them.
Cleanup removes only the selected firmware directory and preserves simulation, netlist and lock files.
Managed operations share a program/target lock; independently launched GUI sessions cannot honor it and must be closed before a build.
