Architecture and tradeoffs
==========================

Source layout
-------------

::

   repository root/
   ├── Makefile
   ├── cpld_toolchain/         unified Python package and CLI
   │   ├── cpld_vhdl_generator/ standalone generator, contracts and board profiles
   │   ├── programmer_helper/ selection, JTAG identification and programming
   │   └── toolchain/
   │       ├── buildsystem/    validated model, lifecycle and firmware backends
   │       ├── foss/           pinned installers and device-specific source build
   │       ├── simulation/     pytest/GHDL runner
   │       ├── analysis/       RTL export, VCD viewer and Sphinx page generation
   │       ├── targets/        board manifests and strategy inputs
   │       └── tests/          tooling regressions and integration checks
   ├── xo2_library/            shared HDL components and behavioral tests
   ├── .devcontainer/          shared image and Dev Container configuration
   ├── programs/
   │   ├── releases.toml      current release cycle
   │   ├── usercodes.json     permanent program numbers and build identities
   │   └── <release_cycle>/
   │       ├── catalog.toml   firmware catalog
   │       └── <name>/        TOML, VHDL, LPF, testbench and description.rst
   ├── docs/                  shared Sphinx source
   └── archive/               vendor reference projects and material

Run ``python -m cpld_toolchain`` or the installed ``cpld-toolchain`` command.
The three components retain separate modules and tests within one package.
The workspace can be copied or renamed.
Manually maintained programs contain editable HDL, constraints, manifests and testbenches.
Generator-managed projects use editable CSV/TOML inputs to produce the VHDL, testbench, board constraints, manifest and generation receipt.
Generated VHDL references the shared S3C entity and selected architecture in ``xo2_library/s3c``.
The build system validates generated files through the standalone package, while the generator itself has no build-system dependency.
Firmware build artifacts live under each program's ignored ``build/`` directory, while aggregate reports use ``cpld_toolchain/toolchain/build/`` and documentation uses ``docs/_generated/`` and ``docs/_build/``.
The repository has one Makefile and one Dockerfile, with a default Dev Container configuration and an optional Linux USB configuration.

Design decisions
----------------

Explicit manifests avoid accidentally combining programs that share the same top-level entity name.
Per-program LPFs preserve adapter electrical settings; sharing constraints requires reviewed conflict handling.
Cloning editable files keeps authoring simple but deliberately duplicates code and requires independent maintenance.
Generated Diamond metadata keeps builds scriptable while retaining GUI access; useful GUI settings require manual transfer to authored configuration.
Board and backend settings are separate; device-specific HDL requires matching program inputs.

The workflow validates inputs, acquires a lock, rechecks the loaded build configuration, protects edited generated settings and creates a fresh project.
The Diamond backend runs synthesis, translation, mapping, place-and-route, timing reporting and both firmware exports without a display or interactive stdin.
The :doc:`FOSS backend <foss>` shares the build lifecycle and adds synthesis equivalence, LPF translation and bitstream packing.
Because Diamond's Tcl interface treats ``def_top`` as internal, preparation sets it in the saved LDF XML.
Publication requires nonempty exports, the configured tool version and unchanged input hashes.
``metadata/build.json`` records inputs, options, tool/launcher identity, Git state, reports and output hashes; it is an audit record rather than proof of reproducibility.
The build hash covers common workflow code and the selected backend, so a FOSS-only implementation edit does not invalidate Diamond evidence.
The external Diamond installation, mutable base image and OS packages are environmental inputs.

Python integration
------------------

::

   from pathlib import Path
   from cpld_toolchain.toolchain.buildsystem.model import load_build
   from cpld_toolchain.toolchain.buildsystem.workflow import build_program

   config = load_build(Path("/path/to/uz_cpld"), "tx30")
   output_dir = build_program(config)

Use workflow functions to retain locking and provenance checks; backend methods are lower-level interfaces.
Importing build modules does not launch Diamond, and expected configuration failures raise ``BuildError``.
See :doc:`api` for signatures.
