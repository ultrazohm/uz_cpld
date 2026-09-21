Quick start
===========

Create a program for the Rev05+ UltraZohm D-slot (``uz_dslot_xo2``) and build
its JEDEC file with Diamond using the steps below.

Set up Diamond
--------------

Install and license Diamond as described in :doc:`environments`, or open the
Diamond Dev Container with your installation mounted. Run all commands below
from ``new_approach/``. For a native installation, set its location first::

   export DIAMOND_ROOT="$HOME/lscc/diamond/3.14"

Check that the Diamond command-line tools start::

   make doctor backend=diamond

Create and edit a program
----------------------------

Clone an existing program, replacing ``my_adapter`` with your program name::

   make new NAME=my_adapter TEMPLATE=tx30

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

   make check PROGRAM=my_adapter
   make build PROGRAM=my_adapter backend=diamond

The generated JEDEC file is::

   programs/my_adapter/build/uz_dslot_xo2/diamond/artifacts/firmware.jed

The same ``artifacts/`` directory contains ``firmware.bit``, reports and
``build.json``. Build logs are in the adjacent ``diamond/logs/`` directory.
These commands generate firmware; they do not program hardware.

To run the testbench before building, use ``make sim PROGRAM=my_adapter``
(requires the :doc:`simulation` environment).

Build all catalog programs
--------------------------

To include your reviewed program in batch builds, add ``"my_adapter"`` to the
``programs`` list in ``programs/catalog.toml``. Then run::

   make build-all backend=diamond

Each catalog program gets its own
``programs/<name>/build/uz_dslot_xo2/diamond/artifacts/firmware.jed``.
You can build an individual program without adding it to the catalog.
