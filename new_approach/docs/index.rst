UltraZohm CPLD
==============

This workspace builds firmware for the Rev05+ D-slot ``LCMXO2-2000HC-4TG100C`` with Diamond and verifies its VHDL with GHDL/cocotb.
The supported catalog contains ``tx30``, ``rx30`` and ``tx26_w_enable``.
Legacy projects remain in ``MACHXO2/`` and ``ispMACH/``; their presence does not imply support by the headless toolchain.

Quick start
-----------

With Docker installed, run these commands from the repository root::

   make test-container
   make sim
   make docs

Open ``new_approach/docs/_build/html/index.html`` for the complete site, including program diagrams and interactive waveforms.
Firmware builds require :doc:`Diamond setup <environments>` and never program hardware::

   make list
   make build PROGRAM=tx30
   make build-all

Commands work from the repository root or the standalone ``new_approach/`` directory.
Paths in this documentation are relative to ``new_approach/`` unless stated otherwise.

.. toctree::
   :maxdepth: 1

   environments
   builds
   simulation
   program-documentation
   _generated/programs/index
   configuration
   architecture
   validation
   publishing
   legacy
   roadmap
   api
