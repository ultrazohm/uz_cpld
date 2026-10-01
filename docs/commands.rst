Command reference
=================

Use ``python -m toolchain ACTION --option value`` from the repository root.
``python -m toolchain help`` lists all commands; add ``--command ACTION`` for
required and optional arguments. Options use hyphens, for example
``--release-cycle original`` and ``--dry-run 1``. See :doc:`windows` for native
Windows setup and :doc:`environments` for Linux and container setup.

The shared definitions in ``toolchain/commands.py`` drive help, validation,
backend resolution and execution. ``python -m toolchain.commands`` remains
an equivalent entry point. On Linux, ``make ACTION key=value`` is an optional
wrapper around the same dispatcher; its option names use underscores.
For example, ``make build program=tx30 release_cycle=original`` is equivalent
to ``python -m toolchain build --program tx30 --release-cycle original``.

From a clean clone to programmed hardware
-----------------------------------------

Configure the Diamond installation and license as described in :doc:`environments`,
or reopen in the configured Dev Container. Then::

   python -m toolchain doctor
   python -m toolchain list
   python -m toolchain build-all
   python -m toolchain report

``build-all`` compiles every supported catalog program in the current release.
It does not flash hardware. For simulation, diagrams, documentation, or FOSS
builds on a host, run ``python -m toolchain image`` once first. Rebuild the image explicitly
when its tool dependencies change.

Create the programming selection and project::

   python -m toolchain init
   # Edit selection.toml: choose the programs for S3C and all five slots.
   python -m toolchain programmer-project

``init`` preserves existing selections. ``programmer-project`` exports both
Diamond XCF files from current firmware builds without accessing hardware.
It is optional for command-line programming, which creates its own verified
project and firmware snapshots. ``--rebuild 1`` rebuilds the selected firmware
before exporting XCFs; it is specific to ``programmer-project``.

Prepare the hardware for one physical chain, then::

   python -m toolchain scan --target dslot
   python -m toolchain identify --target dslot
   python -m toolchain program --target dslot --dry-run 1
   python -m toolchain program --target dslot

Use ``--target s3c`` when the hardware is prepared for S3C access. Programming
requires an explicit target; scanning and identification default to D-slots.

Shared option rules
-------------------

* ``--target dslot|s3c`` is consistent across builds, simulation, diagrams,
  documentation and hardware commands. The longer names ``uz_dslot_xo2`` and
  ``uz_s3c_xo2`` remain accepted aliases.
* ``--backend diamond`` is the default. ``--backend foss`` sets both firmware and
  programmer defaults where applicable. ``build_backend`` and
  ``programmer_backend`` override their respective parts. For example,
  ``python -m toolchain program --target dslot --programmer-backend foss`` programs Diamond builds
  through the FOSS programmer. Diamond cannot program FOSS firmware exports.
* Selection files hold assignments and a release. Legacy ``build_backend``
  fields are accepted but do not change the command's backend.
* ``--dry-run 1`` prints resolved commands without running tools, writing plans,
  creating selections, or accessing hardware. It is available for every action.
  It validates command options; build freshness and hardware checks occur during
  execution. ``--execute 0`` is no longer a public option.
* Unsupported options and misspelled names are errors. For example,
  ``python -m toolchain build-all --program tx30`` fails; use ``python -m toolchain build --program tx30``.
* Run actions sequentially. Supplying multiple actions in one invocation is rejected. ``--jobs N`` controls parallel work only for commands that
  document it: simulation, documentation, and ``flasher-build``.

Program and release scope
-------------------------

``--release-cycle NAME`` selects a release without changing the default.
Programming and XCF export resolve the release from the command line, then
``selection.toml``, then the repository's current release.
Other program commands use the command line, then the current release.

``build``, ``check``, ``generate``, ``project``, ``gui`` and ``clean`` require
``--program NAME``. ``new`` requires ``--name NAME`` for the new program.
``list``, ``build-all`` and ``report`` operate on the catalog, optionally filtered
by target. ``netlist`` uses the catalog unless a program is selected.
Simulation and documentation discover complete program manifests, including
uncatalogued programs, and accept program and target filters.
``docs`` and ``docs-assets`` default to the current release; ``--release-cycle all``
explicitly includes all releases. CI uses that explicit all-release scope.
Filtered documentation replaces generated assets with the selected scope.

Execution environments
----------------------

``python -m toolchain venv`` creates or updates the native Python environment and opens an
activated shell. Use ``--activate 0`` for installation only; see
:doc:`environments` for system prerequisites and manual activation.

``--runner auto|local|container`` selects where commands execute independently of
the backend. Auto uses the configured Dev Container directly. On a host, FOSS
firmware tools, simulation, diagrams and documentation use the toolchain image;
other commands run locally. ``python -m toolchain image`` must build that image first.

``--runner local`` uses the installed tools. ``--runner container`` is supported for
FOSS firmware tools, simulation, diagrams, documentation and utility tests.
Inside the configured Dev Container it uses the current container rather than
starting another one. Generic container execution does not expose USB or mount
Diamond and its license; those actions require a native setup or the configured
Dev Container. Unsupported combinations fail before launching tools.

``container_engine``, ``container_platform`` and ``toolchain_image`` customize
``image`` and host container execution. The repository is mounted at ``/work``.
The optional ``flasher-build`` action compiles openFPGALoader locally; it never
programs a device and requires native compiler/development dependencies.

Migration from older commands
-----------------------------

Use ``init`` instead of bare ``programmer``; use ``scan``, ``identify`` and
``program`` directly instead of ``programmer ACTION``. Use
``programmer-project`` instead of ``programmer lattice_xcf``.
Use ``release-select`` instead of ``release-current`` and ``flasher-build``
instead of ``flasher``. Single-action legacy aliases remain available with a
migration message. The grouped ``programmer ACTION`` syntax is rejected with
the replacement names before doing any work.

Use ``runner=local`` instead of ``docs-local`` or ``netlist-local``, and
``make test runner=container`` instead of ``test-container``. These old
single-action aliases also remain available. The shorthand ``make program=NAME``
still means ``make build program=NAME``; explicit actions are preferred in guides.
