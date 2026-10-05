Command reference
=================

Use ``python -m cpld_toolchain ACTION --option value`` from the repository root.
``python -m cpld_toolchain help`` lists all commands; add ``--command ACTION`` for required and optional arguments.
Options use hyphens, for example ``--release-cycle original`` and ``--dry-run 1``.
See :doc:`windows` for native Windows setup and :doc:`environments` for Linux and container setup.

The shared definitions in ``cpld_toolchain/toolchain/commands.py`` drive help, validation, backend resolution and execution.
``python -m cpld_toolchain.toolchain.commands`` remains an equivalent entry point.
On Linux, ``make ACTION key=value`` is an optional wrapper around the same dispatcher; its option names use underscores.
For example, ``make build program=tx30 release_cycle=original`` is equivalent to ``python -m cpld_toolchain build --program tx30 --release-cycle original``.

Standalone generation uses ``python -m cpld_toolchain generator CONFIG --output DIRECTORY``; add ``--check`` to verify freshness.
This interface does not require a repository catalog.
The installed ``cpld-toolchain`` executable accepts the same arguments.
Python imports use the ``cpld_toolchain`` package.
The ``cpld-vhdl-generator`` executable exposes standalone generation.

Inspect the current environment
-------------------------------

Run::

   python -m cpld_toolchain doctor

``doctor`` reports the current operating environment, Python executable, active venv, Python packages, Diamond executables, simulation/FOSS tools, Docker/Podman clients, FOSS installation receipts and selected catalog.
It lists all tool groups even when one backend is selected.
``--backend``, ``--target`` and ``--release-cycle`` scope the catalog check.

Example status rows (actual paths and versions depend on the installation)::

   FOUND        Diamond build CLI          .../diamondc (startup not tested)
   MISSING      Diamond Programmer         ...
   OK           GHDL                       .../ghdl; GHDL 4.1.0 ...
   FAILED       Yosys (RTL diagrams)       ...: exit 1; ...
   MISSING      Sphinx                     not installed in this Python environment

``FOUND`` means a package or executable was located, without testing its imports or startup.
``OK`` for an external tool means its version command succeeded.
``MISSING``, ``FAILED`` and ``TIMEOUT`` distinguish absent tools from tools that could not run; each version check has a five-second timeout.
``MATCH``/``MISMATCH`` compare installation receipts against repository pins; ``INVALID`` identifies an unreadable receipt or invalid catalog.
A configured license is reported separately from license validity.

Missing optional tools and diagnostic findings do not make the report fail: ``doctor`` returns zero when it completes.
This is an inventory, not a build readiness gate.
Build, simulation and programming commands retain their strict dependency and provenance checks.
No Diamond process or hardware operation is started.
License validity, synthesis, USB permissions, Docker daemon access and image availability are not tested.

``doctor`` always reports the current environment for both backends.
To inspect container tools, enter the container and run ``python -m cpld_toolchain doctor`` there.
To inspect a venv, activate it first or run its Python executable directly.
Creating a venv alone does not change the interpreter running ``doctor``.

From a clean clone to programmed hardware
-----------------------------------------

Configure the Diamond installation and license as described in :doc:`environments`, or reopen in the configured Dev Container.
Then::

   python -m cpld_toolchain doctor
   python -m cpld_toolchain list
   python -m cpld_toolchain build-all
   python -m cpld_toolchain report

``build-all`` compiles every supported catalog program in the current release.
It does not flash hardware.
Install the tools required for simulation, diagrams, documentation and FOSS builds, or enter the toolchain container before running those commands.
Rebuild the image explicitly when its tool dependencies change.

Create the programming selection and project::

   python -m cpld_toolchain init
   # Edit selection.toml: choose the programs for S3C and all five slots.
   python -m cpld_toolchain programmer-project

``init`` preserves existing selections.
``programmer-project`` exports both Diamond XCF files from current firmware builds without accessing hardware.
It is optional for command-line programming, which creates its own verified project and firmware snapshots.
``--rebuild 1`` rebuilds the selected firmware before exporting XCFs; it is specific to ``programmer-project``.

Prepare the hardware for one physical chain, then::

   python -m cpld_toolchain scan --target dslot
   python -m cpld_toolchain identify --target dslot
   python -m cpld_toolchain program --target dslot --dry-run 1
   python -m cpld_toolchain program --target dslot

Use ``--target s3c`` when the hardware is prepared for S3C access.
Programming requires an explicit target; scanning and identification default to D-slots.

Shared option rules
-------------------

* ``--target dslot|s3c`` is consistent across builds, simulation, diagrams, documentation and hardware commands.
  The longer names ``uz_dslot_xo2`` and ``uz_s3c_xo2`` remain accepted aliases.
* ``--backend diamond`` is the default.
  ``--backend foss`` sets both firmware and programmer defaults where applicable.
  ``build_backend`` and ``programmer_backend`` override their respective parts.
  For example, ``python -m cpld_toolchain program --target dslot --programmer-backend foss`` programs Diamond builds through the FOSS programmer.
  Diamond cannot program FOSS firmware exports.
* Selection files hold assignments and a release; choose backends on the command line.
* ``--dry-run 1`` prints resolved commands without running tools, writing plans, creating selections, or accessing hardware.
  It is available for every action.
  It validates command options; build freshness and hardware checks occur during execution.
* Unsupported options and misspelled names are errors.
  For example, ``python -m cpld_toolchain build-all --program tx30`` fails; use ``python -m cpld_toolchain build --program tx30 --release-cycle original``.
* Run actions sequentially.
  Supplying multiple actions in one invocation is rejected.
  ``--jobs N`` controls parallel work only for commands that document it: simulation, documentation, and ``flasher-build``.

Program and release scope
-------------------------

``--release-cycle NAME`` selects a release without changing the default.
Programming and XCF export resolve the release from the command line, then ``selection.toml``, then the repository's current release.
Other program commands use the command line, then the current release.

``build``, ``check``, ``generate``, ``project``, ``gui`` and ``clean`` require ``--program NAME``.
``new`` requires ``--name NAME`` for the new program.
``list``, ``build-all`` and ``report`` operate on the catalog, optionally filtered by target.
``netlist`` uses the catalog unless a program is selected.
Simulation and documentation discover complete program manifests, including uncatalogued programs, and accept program and target filters.
``docs`` and ``docs-assets`` default to the current release; ``--release-cycle all`` explicitly includes all releases.
CI uses that explicit all-release scope.
Filtered documentation replaces generated assets with the selected scope.

Netlist comparison
------------------

``make compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss`` checks the FOSS pilot's mapped logic against its VHDL-derived reference.
The Python equivalent is ``python -m cpld_toolchain compare --program cvg_tx30 --release-cycle heartbeat_cvg --backend foss``.
Diamond comparison is currently unsupported; selecting ``backend=diamond`` or omitting the backend returns an error before running tools.
See :doc:`foss` for the export/modeling limitation and the scope of the functional checks.
``make check`` validates manifests and inputs for both firmware backends; it is not a netlist equivalence test.

Execution environments
----------------------

``python -m cpld_toolchain venv`` creates or updates the native Python environment and opens an activated shell.
Use ``--activate 0`` for installation only; see :doc:`environments` for system prerequisites and manual activation.

Commands always use tools installed in the calling environment.
Enter a Dev Container or start Docker manually to use container tools; see :doc:`environments`.
Missing tools are errors and do not cause a switch to another environment or backend.
``container_engine``, ``container_platform`` and ``toolchain_image`` customize the explicit ``image`` build action only.

The optional ``flasher-build`` action compiles openFPGALoader locally; it never programs a device and requires native compiler/development dependencies.
