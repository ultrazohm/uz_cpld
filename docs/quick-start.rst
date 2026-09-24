Quick start
===========

Create a program for the Rev05+ UltraZohm D-slot (``uz_dslot_xo2``) and build its JEDEC file with Diamond using the steps below.

Set up Diamond
--------------

Install and license Diamond as described in :doc:`environments`, or open the Diamond Dev Container with your installation mounted.
Run all commands below from the repository root.
For a native installation, set its location first::

   export DIAMOND_ROOT="$HOME/lscc/diamond/3.14"

Check that the Diamond command-line tools start::

   make doctor backend=diamond

Create and edit a program
----------------------------

Clone an existing program, replacing ``my_adapter`` with your program name::

   make new name=my_adapter template=tx30

Edit these files in ``programs/my_adapter/``:

* ``my_adapter.vhdl``: implement your logic.
* ``my_adapter_constraints.lpf``: set the pin assignments and constraints.
* ``my_adapter.toml``: update the source list or top-level entity if needed.
* ``my_adapter_tb.py``: adapt the testbench to your logic.
* ``description.rst``: describe the new program.

The clone keeps the template's VHDL entity name (``SignalRouter`` for ``tx30``).
If you rename it, also update ``top`` in ``my_adapter.toml``.

Check and build
---------------

Validate the manifest and input files, then build with Diamond::

   make check program=my_adapter
   make build program=my_adapter backend=diamond

The generated JEDEC file is::

   programs/my_adapter/build/uz_dslot_xo2_diamond/my_adapter_uz_dslot_xo2_diamond.jed

The same ``uz_dslot_xo2_diamond/`` directory contains ``my_adapter_uz_dslot_xo2_diamond.bit``, ``reports/`` and ``metadata/``.
Build logs are in its ``logs/`` directory.
These commands generate firmware; they do not program hardware.

To run the testbench before building, use ``make sim program=my_adapter`` (requires the :doc:`simulation` environment).

Build all catalog programs
--------------------------

``make new`` adds the clone to ``programs/catalog.toml`` after validating its manifest.
Review the copied logic, constraints and testbench before running catalog-wide commands::

   make build-all backend=diamond

Each catalog program gets its own ``programs/<name>/build/uz_dslot_xo2_diamond/<name>_uz_dslot_xo2_diamond.jed``.
You can build an individual program with ``program`` even if it is absent from the catalog.
