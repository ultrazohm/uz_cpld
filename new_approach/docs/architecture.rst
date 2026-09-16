Architecture and tradeoffs
==========================

Source layout
-------------

::

   new_approach/
   ├── Makefile
   ├── .devcontainer/          image stages and optional Diamond configuration
   ├── toolchain/
   │   ├── buildsystem/        validated model, CLI, lifecycle and firmware backends
   │   ├── foss/               pinned tool installers and device-specific source build
   │   ├── simulation/         pytest/GHDL runner
   │   ├── analysis/           RTL export, VCD viewer and Sphinx page generation
   │   ├── targets/            board manifests and strategy inputs
   │   └── tests/              tooling regressions and licensed integration check
   ├── programs/<name>/        TOML, VHDL, LPF, testbench and description.rst
   └── docs/                  shared Sphinx source

The workspace can be copied or renamed without the legacy repository.
Program inputs are independent copies; changes to legacy projects do not synchronize automatically.
Generated files live under each program's ignored ``build/`` directory, while aggregate reports use ``toolchain/build/`` and documentation uses ``docs/_generated/`` and ``docs/_build/``.
The repository-root Makefile forwards requested targets in one sub-make so shared prerequisites run once.

Design decisions
----------------

Explicit manifests avoid accidentally combining programs that share the same top-level entity name.
Per-program LPFs preserve adapter electrical settings; sharing constraints requires reviewed conflict handling.
Cloning editable files keeps authoring simple but deliberately duplicates code and requires independent maintenance.
Generated Diamond metadata keeps builds scriptable while retaining GUI access; useful GUI settings require manual transfer to authored configuration.
Board and backend separation permits extensions, but changing a target flag cannot make device-specific HDL portable.

The workflow validates inputs, acquires a lock, protects edited generated settings and creates a fresh project.
The Diamond backend runs synthesis, translation, mapping, place-and-route, timing reporting and both firmware exports without a display or interactive stdin.
The :doc:`FOSS backend <foss>` shares the build lifecycle and adds synthesis equivalence, LPF translation and bitstream packing.
Because Diamond's Tcl interface treats ``def_top`` as internal, preparation sets it in the saved LDF XML.
Publication requires nonempty exports, the configured tool version and unchanged input hashes.
``build.json`` records inputs, options, tool/launcher identity, Git state, reports and output hashes; it is an audit record rather than proof of reproducibility.
The external Diamond installation, mutable base image and OS packages remain environmental inputs.

Python integration
------------------

::

   from pathlib import Path
   from toolchain.buildsystem.model import load_build
   from toolchain.buildsystem.workflow import build_program

   config = load_build(Path("/path/to/new_approach"), "tx30")
   artifacts = build_program(config)

Use workflow functions to retain locking and provenance checks; backend methods are lower-level interfaces.
Importing build modules does not launch Diamond, and expected configuration failures raise ``BuildError``.
See :doc:`api` for signatures and :doc:`roadmap` for extensions.
