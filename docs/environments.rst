Environment setup
=================

Containers
----------

The Dockerfile defines three Linux amd64 runtime stages sharing firmware, simulation, analysis and documentation tools, plus a ``foss-builder`` stage for compiling device support.

.. list-table:: Image stages
   :header-rows: 1

   * - Stage
     - Purpose
   * - ``toolchain``
     - CI and host Make commands; GHDL, Yosys, nextpnr-machxo2, Trellis, openFPGALoader, Graphviz, Python and Sphinx.
   * - ``development``
     - VS Code development; adds GTKWave, shell utilities, sudo and the developer CLI.
   * - ``diamond``
     - Development with vendor runtime libraries and launchers; requires an external Diamond installation and license.

``make sim``, ``make netlist`` and ``make docs`` build the cached ``toolchain`` image on the host and run directly inside a toolchain container.
``make test-container`` follows the same rule; ``make test``, ``make netlist-local`` and ``make docs-local`` always use installed tools.
``CPLD_TOOLCHAIN_CONTAINER=1`` identifies the installed environment and avoids nested Docker.

``container_engine`` selects Docker or Podman, ``container_platform`` defaults to ``linux/amd64``, ``sim_image`` selects the image tag and ``sim_workspace`` selects the host bind source.
Rootless Podman runs use ``--userns=keep-id`` to preserve workspace ownership.
The daemon must be able to access the checkout; ARM hosts require amd64 emulation.

Dev Container
-------------

Open the repository in VS Code and select **Dev Containers: Reopen in Container**.
The default configuration uses the ``development`` stage, including the FOSS firmware tools, without a Diamond mount or host networking.
Choose the **Diamond** configuration when firmware compilation is needed.
Before launching VS Code for that configuration, export the installation root, which is the parent of ``bin``::

   export DIAMOND_HOST_ROOT="$HOME/lscc/diamond/3.14"
   code .

The Diamond configuration mounts that directory read-only at ``/opt/diamond`` and checks Tcl startup after creation.
If VS Code was started without the variable, close it fully and relaunch it from this shell.
Use **Rebuild Container** after changing image dependencies; repository files persist, while unmounted container state can be replaced.
The default user is ``vscode``; VS Code adjusts its UID/GID to the host user.
``USER_UID`` and ``USER_GID`` are build arguments for direct container use.

Diamond and licensing
---------------------

.. list-table:: Runtime configuration
   :header-rows: 1

   * - Variable
     - Meaning
   * - ``DIAMOND_HOST_ROOT``
     - Host installation mounted by the Diamond Dev Container configuration.
   * - ``DIAMOND_ROOT``
     - Runtime installation root, defaulting to ``/opt/diamond``.
   * - ``DIAMOND_CLI`` / ``DIAMOND_GUI``
     - Python frontend executable overrides; values are paths, not shell commands.
   * - ``LM_LICENSE_FILE``
     - Additional license file path or ``port@server``.

The vendor ``diamondc`` wrapper configures libraries and includes its installation's ``license/license.dat`` in the license search path.
Additional license files need their own mount and a container-visible path.
Host networking in the Diamond configuration exposes host interfaces for node-locked license detection; it reduces network isolation and does not guarantee licensing on another host.
Floating-license configurations can use a server address without requiring host networking.

``check-diamond`` tests Tcl startup; ``check-diamond --synthesis`` also synthesizes a one-gate design.
These shell helpers use ``DIAMOND_ROOT`` rather than ``DIAMOND_CLI``.
Neither check performs full routing or firmware export; use ``make build-all`` for that validation.
A host-ID mismatch requires checking the authorized license/environment, not editing the signed license or host MAC.

Native tools
------------

Native use requires Python 3.10+, GHDL, Yosys, Graphviz and the packages in ``docs/requirements.txt``.
The tooling tests also require Tcl support through ``python3-tk`` on Ubuntu.
The image and native requirements select the same Sphinx version; OS packages and the Ubuntu image tag remain mutable inputs.
Build dependencies are installed in the image, not downloaded by firmware or documentation commands.
See :doc:`foss` for the pinned tool bundle and native source-build prerequisites.
