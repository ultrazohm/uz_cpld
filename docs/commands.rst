Command reference
=================

Use ``uz_cpld ACTION --option value`` after running ``python -m cpld_toolchain setup`` from the repository root.
For example, ``uz_cpld setup`` creates or updates the repository's Python environment.
The equivalent ``python -m cpld_toolchain ACTION --option value`` works from a fresh checkout before installation.
The examples below use ``uz_cpld``; the module form and ``cpld-toolchain`` accept the same arguments.
Command names use lowercase letters and underscores, for example ``build_all`` and ``diamond_xcf_programming_chain``.
``uz_cpld help`` lists all commands; add ``--command ACTION`` for required and optional arguments.
Options use hyphens, for example ``--release-cycle original`` and ``--dry-run 1``.
See :doc:`windows` for native Windows setup and :doc:`environments` for Linux and container setup.

The shared definitions in ``cpld_toolchain/toolchain/commands.py`` drive help, validation, backend resolution and execution.
``python -m cpld_toolchain.toolchain.commands`` remains an equivalent entry point.
On Linux, ``make ACTION key=value`` is an optional wrapper around the same dispatcher; its option names use underscores.
For example, ``make build program=tx30 release_cycle=original`` is equivalent to ``uz_cpld build --program tx30 --release-cycle original``.

Standalone generation uses ``uz_cpld generator CONFIG --output DIRECTORY``; add ``--check`` to verify freshness.
This interface does not require a repository catalog.
The installed ``cpld-toolchain`` executable accepts the same arguments.
Python imports use the ``cpld_toolchain`` package.
The ``cpld-vhdl-generator`` executable exposes standalone generation.

Inspect the current environment
-------------------------------

Run::

   uz_cpld doctor

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
To inspect container tools, enter the container and run ``uz_cpld doctor`` there.
To inspect a venv, activate it first or run its Python executable directly.
Creating a venv alone does not change the interpreter running ``doctor``.

From a clean clone to programmed hardware
-----------------------------------------

Configure the Diamond installation and license as described in :doc:`environments`, or reopen in the configured Dev Container.
Then::

   uz_cpld doctor
   uz_cpld list
   uz_cpld build_all
   uz_cpld report

``build_all`` compiles every supported catalog program in the current release.
It does not flash hardware.
Install the tools required for simulation, diagrams, documentation and FOSS builds, or enter the toolchain container before running those commands.
Rebuild the image explicitly when its tool dependencies change.

Create the programming selection and project::

   uz_cpld init_programmer
   # Edit selection.toml: choose the release and programs for S3C and all five slots.
   uz_cpld build_selection
   uz_cpld diamond_xcf_programming_chain

``init_programmer`` preserves existing selections.
``diamond_xcf_programming_chain`` exports both Diamond XCF files from current firmware builds without accessing hardware.
It is optional for command-line programming, which creates its own verified project and firmware snapshots.
``--rebuild 1`` rebuilds the selected firmware before exporting XCFs; it is specific to ``diamond_xcf_programming_chain``.

Prepare the hardware for one physical chain, then::

   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1
   uz_cpld program --target dslot

Use ``--target s3c`` when the hardware is prepared for S3C access.
Programming requires an explicit target; scanning and identification default to D-slots.

Shared option rules
-------------------

* ``--target dslot|s3c`` is consistent across builds, simulation, diagrams, documentation and hardware commands.
  The longer names ``uz_dslot_xo2`` and ``uz_s3c_xo2`` remain accepted aliases.
* ``--backend diamond`` is the default.
  ``--backend foss`` sets both firmware and programmer defaults where applicable.
  ``build_backend`` and ``programmer_backend`` override their respective parts.
  For example, ``uz_cpld program --target dslot --programmer-backend foss`` programs Diamond builds through the FOSS programmer.
  Diamond cannot program FOSS firmware exports.
* Selection files hold assignments and a release; choose backends on the command line.
* ``--dry-run 1`` prints resolved commands without running tools, writing plans, creating selections, or accessing hardware.
  It is available for every action.
  It validates command options; build freshness and hardware checks occur during execution.
* Unsupported options and misspelled names are errors.
  For example, ``uz_cpld build_all --program tx30`` fails; use ``uz_cpld build --program tx30 --release-cycle original``.
* Run actions sequentially.
  Supplying multiple actions in one invocation is rejected.
  ``--jobs N`` controls parallel work only for commands that document it: simulation, documentation, and ``flasher_build``.

Program and release scope
-------------------------

``--release-cycle NAME`` selects a release without changing the default.
``build_selection``, programming and XCF export resolve the release from the command line, then ``selection.toml``, then the repository's current release.
Other firmware commands use the command line, then the current release.

``build``, ``check``, ``generate``, ``project``, ``gui`` and ``clean`` require ``--program NAME``.
``new`` requires ``--name NAME`` for the new program.
``list``, ``build_all`` and ``report`` operate on the catalog, optionally filtered by target.
``list`` displays an aligned table with Release, Program, Target and Backend columns.
``build_selection`` uses the selection file rather than the whole catalog; repeated assignments build once per program and target.
``netlist`` uses the catalog unless a program is selected.
Simulation and documentation discover complete program manifests, including uncatalogued programs, and accept program and target filters.
``docs`` and ``docs_assets`` include all releases by default; ``--release-cycle NAME`` limits a preview to one release.
CI uses that explicit all-release scope.
Filtered documentation replaces generated assets with the selected scope.

Netlist comparison
------------------

``make compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss`` checks the FOSS pilot's mapped logic against its VHDL-derived reference.
The ``uz_cpld`` equivalent is ``uz_cpld compare --program cvg_tx30 --release-cycle heartbeat_cvg --backend foss``.
Diamond comparison is currently unsupported; selecting ``backend=diamond`` or omitting the backend returns an error before running tools.
See :doc:`foss` for the export/modeling limitation and the scope of the functional checks.
``make check`` validates manifests and inputs for both firmware backends; it is not a netlist equivalence test.

Execution environments
----------------------

``python -m cpld_toolchain setup`` creates or updates the native Python environment and opens an activated shell.
Use ``--activate 0`` for installation only; see :doc:`environments` for system prerequisites and manual activation.

Commands always use tools installed in the calling environment.
Enter a Dev Container or start Docker manually to use container tools; see :doc:`environments`.
Missing tools are errors and do not cause a switch to another environment or backend.
``container_engine``, ``container_platform`` and ``toolchain_image`` customize the explicit ``image`` build action only.

The optional ``flasher_build`` action compiles openFPGALoader locally; it never programs a device and requires native compiler/development dependencies.

Build selected firmware
-----------------------

``build_selection`` builds only the programs in ``selection.toml``, once per distinct
program and target, without programming hardware.
It uses the selection's release, or the current release when that field is empty.
``--release-cycle NAME`` overrides it.
``--backend foss`` selects FOSS builds; Diamond is the default, and ``--build-backend`` overrides the firmware backend.
By default all six assignments are required.
An optional ``--target dslot|s3c`` restricts the build and required assignments to that chain.
For example::

   uz_cpld build_selection
   uz_cpld build_selection --selection custom.toml --target s3c
   make build_selection selection=custom.toml

``init_programmer`` accepts ``--s3c NAME``, ``--dslot-1 NAME`` through
``--dslot-5 NAME``, and ``--release NAME``. ``--release ""`` uses the current
release. With Make, use ``s3c=NAME``, ``dslot_1=NAME`` through ``dslot_5=NAME``,
and ``release=""``. Existing files are preserved even when options are supplied.

For example, initialize a new file with optional assignments::

   uz_cpld init_programmer --selection custom.toml --release original --s3c s3c_power_on_debounce --dslot-1 rx30

The other four slots retain ``tx30`` in this example.
