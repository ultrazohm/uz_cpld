Environment setup
=================

Containers
----------

The Dockerfile has one Linux amd64 runtime image, ``toolchain``, used by Make, CI and the Dev Container.
An intermediate ``foss-builder`` stage compiles the pinned XO2 tools; it is not a separate runtime image.
The runtime image includes GHDL, Yosys, nextpnr-machxo2, Trellis, openFPGALoader, Graphviz, Python, Sphinx, GTKWave, development utilities and Diamond runtime libraries.
The Dev Container setup installs the developer CLI for its user after creation.
Diamond itself and its license remain external.
Build the image explicitly before starting it manually or from VS Code::

   make image

This creates the local image ``uz-cpld-toolchain``. Re-run the command after changing image dependencies.
At startup the container prints whether the Diamond launcher was found, then runs the requested command.
This reports installation availability, not license validity; missing Diamond does not prevent container startup or FOSS use.
Backend selection is unchanged: ``backend`` defaults to ``diamond``; use ``backend=foss`` for FOSS firmware builds.
Requesting Diamond without an installation fails with a setup error.

``make sim``, ``make netlist`` and ``make docs`` build the cached ``toolchain`` image on the host and run directly inside a toolchain container.
``make test-container`` follows the same rule; ``make test``, ``make netlist-local`` and ``make docs-local`` always use installed tools.
``CPLD_TOOLCHAIN_CONTAINER=1`` identifies the installed environment and avoids nested Docker.

``container_engine`` selects Docker or Podman, ``container_platform`` defaults to ``linux/amd64``, ``toolchain_image`` selects the image tag and ``sim_workspace`` selects the host bind source.
Rootless Podman runs use ``--userns=keep-id`` to preserve workspace ownership.
The daemon must be able to access the checkout; ARM hosts require amd64 emulation.
GHDL library paths cannot contain double quotes; use checkout and source paths without them.
Spaces and apostrophes in checkout paths are supported.

Manual startup
--------------

Start an interactive shell from the repository directory::

   docker run --rm -it --init --platform=linux/amd64 \
     --user "$(id -u):$(id -g)" \
     --mount "type=bind,source=$PWD,target=/work" \
     uz-cpld-toolchain bash

To use Diamond, mount a Linux installation read-only at the image's default ``DIAMOND_ROOT``, ``/opt/diamond``::

   export DIAMOND_HOST_ROOT="$HOME/lscc/diamond/3.14"
   docker run --rm -it --init --platform=linux/amd64 \
     --user "$(id -u):$(id -g)" \
     --network=bridge --mac-address=10:91:d1:3d:14:ae \
     --mount "type=bind,source=$PWD,target=/work" \
     --mount "type=bind,source=$DIAMOND_HOST_ROOT,target=/opt/diamond,readonly" \
     --env LM_LICENSE_FILE \
     uz-cpld-toolchain bash

For a different container mount location, also pass ``--env DIAMOND_ROOT=/that/location``.
An environment variable alone does not mount the host installation.

VS Code
-------

After ``make image``, open the repository in VS Code and select **Dev Containers: Reopen in Container**.
The single configuration uses the local ``uz-cpld-toolchain`` image and bridge networking with ``eth0`` assigned the MAC address ``10:91:d1:3d:14:ae``.
For Diamond, export the absolute host installation root, which is the parent of ``bin``, before launching VS Code::

   export DIAMOND_HOST_ROOT="$HOME/lscc/diamond/3.14"
   code .

The configuration mounts that directory read-only at ``/opt/diamond`` and forwards ``LM_LICENSE_FILE``.
For FOSS-only use, leave ``DIAMOND_HOST_ROOT`` unset (``unset DIAMOND_HOST_ROOT``); the mount uses an empty Docker volume named ``uz-cpld-no-diamond``.
Do not set the variable to an empty string.
The startup availability message appears in the container log; Diamond checks are run explicitly with ``check-diamond``.
If VS Code was started without the variable, close it fully and relaunch it from this shell.
After rebuilding the image or changing mount or license settings, use **Rebuild Container** to recreate the container from the image; repository files persist, while unmounted container state can be replaced.
The default user is ``vscode``; VS Code adjusts its UID/GID to the host user.
``USER_UID`` and ``USER_GID`` are build arguments for direct container use.

Diamond and licensing
---------------------

.. list-table:: Runtime configuration
   :header-rows: 1

   * - Variable
     - Meaning
   * - ``DIAMOND_HOST_ROOT``
     - Optional absolute host installation path mounted by the Dev Container.
   * - ``DIAMOND_ROOT``
     - Runtime installation root, defaulting to ``/opt/diamond``.
   * - ``DIAMOND_CLI`` / ``DIAMOND_GUI``
     - Python frontend executable overrides; values are paths, not shell commands.
   * - ``LM_LICENSE_FILE``
     - Additional license file path or ``port@server``.

The vendor ``diamondc`` wrapper configures libraries and includes its installation's ``license/license.dat`` in the license search path.
Additional license files need their own mount and a container-visible path.
The Dev Container and manual Diamond example expose the fixed container MAC for node-locked license detection.
Floating-license configurations can use a server address reachable from the container; ``localhost`` refers to the container itself with bridge networking.

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
