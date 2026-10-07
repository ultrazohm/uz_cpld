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
   └── docs/                  user guide, developer guide and Sphinx references

Run ``uz_cpld`` in the activated environment.
``python -m cpld_toolchain`` and ``cpld-toolchain`` remain equivalent entry points.
The three components retain separate modules and tests within one package.
The workspace can be copied or renamed.
Manually maintained programs contain editable HDL, constraints, manifests and testbenches.
Generator-managed projects use editable CSV/TOML inputs to produce the VHDL, testbench, board constraints, manifest and generation receipt.
Generated VHDL references the shared S3C entity and selected architecture in ``xo2_library/s3c``.
The build system validates generated files through the standalone package, while the generator itself has no build-system dependency.
Firmware artifacts live under ``build/<backend>/<release>/<program>/<target>/``, with a shared ``build/<backend>/manifest.json`` and no separate publication copy. Analysis, reports, programmer outputs and tool builds also use the top-level ``build/`` directory. Documentation uses ``docs/_generated/`` and ``docs/_build/``.
The repository has one Makefile and one Dockerfile, with host-mounted and Diamond-image Dev Container profiles, each with an optional Linux USB configuration.

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

   config = load_build(Path("/path/to/uz_cpld"), "cvg_tx30", release_cycle="heartbeat_cvg")
   output_dir = build_program(config)

Use workflow functions to retain locking and provenance checks; backend methods are lower-level interfaces.
Importing build modules does not launch Diamond, and expected configuration failures raise ``BuildError``.
See :doc:`api` for signatures.

CLI and command availability
----------------------------

The application always exposes the complete command set.
``cpld_toolchain/cli.py`` uses Typer to parse command-specific options, including numeric ranges and backend choices.
The shared contract in ``toolchain/commands.py`` supplies the option signatures and retains Make-compatible help, cross-option validation, and side-effect-free command planning.
``uz_cpld ACTION --help`` shows the options for that action; ``uz_cpld help --command ACTION`` also explains shared defaults and rules.
Make translates its ``key=value`` options into the same CLI options.

``capabilities.py`` checks only the selected command's prerequisites before execution.
``runtime.py`` lazily imports the selected component and invokes its callable entry point in-process, restoring the caller's working directory afterward.
The component entry points remain usable independently and retain their workflow validation and locking.
External tools and isolated pytest/unittest runners still use subprocesses; documentation also retains its worker processes.
Help, listing and selection initialization do not import the simulation or documentation dependencies.
Dry runs do not check tool availability, start tools, or import the selected workflow.

The normal Python package includes the dependencies for the complete application, including simulation and documentation.
Lazy imports isolate commands and reduce startup work; they do not define separate reduced-functionality editions.
``doctor`` reports located command prerequisites without claiming that licenses, tool versions, drivers or hardware have passed validation.
Missing dependencies affect only commands that need them, and the requested backend is never changed automatically.
Diamond build tools and Diamond Programmer are independent requirements.
FOSS programming requires the patched openFPGALoader for programming and identity readback.

``tools.py`` resolves programmer executables and the RTL Yosys executable without importing workflows.
An explicit ``CPLD_OPENFPGALOADER`` takes priority and does not silently fall back if invalid.
Then the resolver checks packaged tool resources, existing tool installation locations and PATH.
The packaged resource directory defaults to ``cpld_toolchain/bundled_tools`` and may be supplied with ``CPLD_BUNDLED_TOOLS``.
It accepts executables directly in that directory or under a tool-named subdirectory, including Windows ``.exe`` names.
Companion libraries, scripts and the patched flasher receipt must accompany any future bundled tools.
The pinned FOSS build installation and its receipt checks remain separate and unchanged.

This establishes discovery and execution boundaries for future distributions; it does not produce a standalone executable or bundle native tools.
Repository workflows still require the checkout and existing build provenance.
Consuming CI firmware independently of a checkout, packaging simulation workers, and producing OS-specific executable distributions remain future work.
