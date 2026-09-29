Environment setup
=================

Containers
----------

The Dockerfile has one Linux amd64 runtime image, ``toolchain``, used by Make, CI and the Dev Container.
An intermediate ``foss-builder`` stage compiles the pinned XO2 tools; it is not a separate runtime image.
The runtime image includes GHDL, Yosys, nextpnr-machxo2, Trellis, openFPGALoader, OpenOCD, Graphviz, Python, Sphinx, GTKWave, development utilities and Diamond runtime libraries.
The Dev Container setup installs the developer CLI for its user after creation.
Diamond itself and its license remain external.
Build the image explicitly before starting a container manually::

   make image

This creates the local image ``uz-cpld-toolchain``. Re-run the command after changing image dependencies.
VS Code Dev Containers builds the image automatically when reopening the workspace.
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

USB programming from a Linux host also requires exposing the USB bus to the container. Add these arguments to the manual ``docker run`` command above::

   --mount type=bind,source=/dev/bus/usb,target=/dev/bus/usb \
   --device-cgroup-rule='c 189:* rwm' \
   --group-add "$(stat -c %g /dev/bus/usb/BBB/DDD)"

Replace ``BBB/DDD`` with the bus/device path for the connected programmer. The USB node must grant group read and write access on the host (normally through a host udev rule for the probe); ``--group-add`` gives the container user that numeric group. If the node has no group write permission, correct its host udev rule before programming. When a probe is replugged, its bus/device number can change; the cgroup rule allows the new USB node, while the host udev rule must assign it the same group.

The default Dev Container omits this host-specific mount. On a Linux host with ``/dev/bus/usb``, choose the ``.devcontainer/usb/devcontainer.json`` configuration when reopening in VS Code. Before launching VS Code, set ``USB_DEVICE_GID`` to the programmer node's numeric group ID, for example::

   export USB_DEVICE_GID="$(stat -c %g /dev/bus/usb/BBB/DDD)"
   code .

The USB configuration defaults to group 46 (the usual ``plugdev`` GID on Ubuntu) if the variable is unset; check the actual node instead of relying on that default. Rebuild the container after changing the group. Inside the container, ``id`` should show that group and ``ls -l /dev/bus/usb/BBB/DDD`` should show group read/write permission. On non-Linux Docker hosts, USB forwarding depends on the Docker VM or host configuration.

Before a JTAG scan, check that the container can see the USB bus and the probe::

   ls -l /dev/bus/usb/*/*
   /opt/oss-cad-suite/bin/openFPGALoader --scan-usb

If ``/dev/bus/usb`` is absent or empty, the container has no USB device nodes; reopen it with the USB profile and check that the Docker host sees the probe. If the node appears but the scanner cannot open it, compare its group and permissions with ``id``. ``--scan-usb`` lists USB probes, not the JTAG devices behind them.

VS Code
-------

Open the repository in VS Code and select **Dev Containers: Reopen in Container**. VS Code builds the toolchain image from ``.devcontainer/Dockerfile`` automatically; no separate ``make image`` step is required.
The single configuration uses bridge networking with ``eth0`` assigned the MAC address ``10:91:d1:3d:14:ae``.
For Diamond, export the absolute host installation root, which is the parent of ``bin``, before launching VS Code::

   export DIAMOND_HOST_ROOT="$HOME/lscc/diamond/3.14"
   code .

The configuration mounts that directory read-only at ``/opt/diamond`` and forwards ``LM_LICENSE_FILE``.
The image adds ``/opt/diamond/bin/lin64`` to ``PATH``, making the mounted
``diamond`` and ``diamondc`` launchers available in terminals.
For FOSS-only use, leave ``DIAMOND_HOST_ROOT`` unset (``unset DIAMOND_HOST_ROOT``); the mount uses an empty Docker volume named ``uz-cpld-no-diamond``.
Do not set the variable to an empty string.
The startup availability message appears in the container log; Diamond checks are run explicitly with ``check-diamond``.
If VS Code was started without the variable, close it fully and relaunch it from this shell.
After rebuilding the image or changing mount or license settings, use **Rebuild Container** to recreate the container from the image; repository files persist, while unmounted container state can be replaced.
The default user is ``vscode``; VS Code adjusts its UID/GID to the host user.
``USER_UID`` and ``USER_GID`` are build arguments for direct container use.

``echo "$DIAMOND_ROOT"`` reports the configured path even when no installation
is mounted. To distinguish a missing mount from a shell path problem, run::

   ls -l "$DIAMOND_ROOT/bin/lin64/diamond" "$DIAMOND_ROOT/bin/lin64/diamondc"
   command -v diamond diamondc
   check-diamond

If the files are missing, check ``DIAMOND_HOST_ROOT`` on the host and recreate
the container.
If the mounted files exist but the launchers are absent from ``PATH``, rebuild the Dev Container to apply its configured environment.

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
