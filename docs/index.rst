UltraZohm CPLD
==============

This workspace builds firmware for the Rev05+ D-slot ``LCMXO2-2000HC-4TG100C`` with Diamond or the FOSS pipeline and verifies its VHDL with GHDL/cocotb.
The supported catalog contains ``tx30``, ``rx30``, ``tx26_w_enable``, ``uz_d_resolver_d4_4inverter_sdifix`` and ``uz_d_resolver_d5_4inverter_sdifix``.

Quick start
-----------

See :doc:`quick-start` to create a new program and build its ``.jed`` file with Diamond.

With Docker installed, run these commands from the repository root::

   make test-container
   make sim
   make docs

Open ``docs/_build/html/index.html`` for the complete site, including program diagrams and interactive waveforms.
Diamond firmware builds require :doc:`vendor setup <environments>` and never program hardware::

   make list
   make build program=tx30
   make build-all

Run commands from the repository root; paths in this documentation are relative to that directory.

.. toctree::
   :maxdepth: 1

   quick-start
   environments
   builds
   foss
   simulation
   program-documentation
   _generated/programs/index
   configuration
   architecture
   validation
   publishing
   api
