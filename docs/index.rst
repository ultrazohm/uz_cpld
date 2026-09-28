UltraZohm CPLD
==============

This workspace builds firmware for the Rev05+ D-slot ``LCMXO2-2000HC-4TG100C`` and S3C ``LCMXO2-4000HC-4TG144C`` with Diamond or the FOSS pipeline, and verifies VHDL with GHDL/cocotb.
``programs/<release_cycle>/catalog.toml`` lists the supported D-slot and S3C programs.
The VHDL generator creates D-slot projects from CSV routing and TOML configuration.

Quick start
-----------

See :doc:`quick-start` for the path from a new program through simulation to a Diamond ``.jed`` or FOSS ``.bit`` export.
The :ref:`generator-quickstart` covers creating a starter, editing its routing, generating the project files, simulating and building with Diamond.

Run ``make`` to see all commands. With Docker installed, run these commands from the repository root::

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
   releases
   foss
   simulation
   program-documentation
   _generated/programs/index
   configuration
   vhdl-generator
   architecture
   validation
   publishing
   api
