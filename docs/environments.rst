Environment setup
=================

See :doc:`tool-environments` for which tools each workflow needs, what the
venv includes, and how to enter a container explicitly.

Use ``python -m cpld_toolchain doctor`` for a non-failing inventory of the current
environment, including missing optional tools. To inspect the toolchain image
explicitly, enter the container and run ``python -m cpld_toolchain doctor`` there. The report does not check out a Diamond license or contact hardware.

Containers
----------

The Dockerfile has one Linux amd64 runtime image, ``toolchain``, used by Make, CI and the Dev Container.
An intermediate ``foss-builder`` stage compiles the pinned XO2 tools; it is not a separate runtime image.
The runtime image includes GHDL, Yosys, nextpnr-machxo2, Trellis, openFPGALoader, OpenOCD, Graphviz, Python, Sphinx, GTKWave, development utilities and Diamond runtime libraries.
The Dev Container setup installs the developer CLI for its user after creation.
By default Diamond itself and its license remain external. An optional Diamond
image base includes both; the other tools and commands are the same.
Build the image explicitly before using container execution::

   make image

This creates the local image ``uz-cpld-toolchain``. Re-run the command after changing image dependencies.
VS Code Dev Containers builds the image automatically when reopening the workspace.
At startup the container prints whether the Diamond launcher was found, then runs the requested command.
This reports installation availability, not license validity; missing Diamond does not prevent container startup or FOSS use.
Backend selection is unchanged: ``backend`` defaults to ``diamond``; use ``backend=foss`` for FOSS firmware builds.
Requesting Diamond without an installation fails with a setup error.

All workflow commands use tools installed in the calling environment.
Start a container explicitly using a Dev Container profile or the manual commands below.
Missing tools produce an error; commands do not launch Docker or Podman automatically.
``CPLD_TOOLCHAIN_CONTAINER=1`` identifies the installed environment for diagnostics.

For ``image`` only, ``container_engine`` selects Docker or Podman, ``container_platform`` defaults to ``linux/amd64``, and ``toolchain_image`` selects the image tag.
For manual rootless Podman runs, use ``--userns=keep-id`` to preserve workspace ownership.
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
     --network=name=bridge,mac-address=10:91:d1:3d:14:ae \
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
The host-mounted profiles run ``.devcontainer/prepare-host.sh`` on the host before
startup. They detect a full Linux Diamond installation at
``$HOME/lscc/diamond/3.14`` automatically. No export is needed for that layout.
The selected directory is mounted read-only at ``/opt/diamond``; inside the
container, ``DIAMOND_ROOT`` is always ``/opt/diamond``.

For another installation, run this **in a host terminal**, from the repository::

   DIAMOND_HOST_ROOT=/absolute/path/to/diamond/3.14 bash .devcontainer/prepare-host.sh

The host setup accepts ``DIAMOND_HOST_ROOT``, then ``DIAMOND_ROOT``, then the
saved selection, then the standard location. Empty variables are treated as
unset. It checks for an executable ``bin/lin64/diamondc``; a typo or a standalone
Programmer path fails before container creation. The selected path is saved in
the ignored ``.devcontainer/.local/diamond-root`` file and linked from
``.devcontainer/.local/diamond``. Docker follows that host link for the bind mount.
This preserves the selection even when an existing VS Code process has not
inherited the terminal's environment. These host-mounted profiles need Bash and
a Docker host that can access the checkout and Linux installation.

For FOSS-only use, a missing standard installation automatically supplies an
empty directory. To explicitly disable a saved installation, run on the host::

   DIAMOND_HOST_ROOT=none bash .devcontainer/prepare-host.sh

To enable Diamond again, run the same command with its installation path.
The image profiles described below do not run this host setup or use its selection.

All profiles use bridge networking and set ``eth0`` to
``10:91:d1:3d:14:ae`` with Docker's per-network
``--network=name=bridge,mac-address=10:91:d1:3d:14:ae`` option (Docker 25+).
Docker 25.0.2 loses even per-network MAC settings after a restart; it can report
the requested address in ``Config.MacAddress`` while ``eth0`` uses another one.
The profiles therefore include ``NET_ADMIN`` in the container's own network
namespace and run ``setup-network.sh`` after every Dev Container start. This
checks the actual interface and, only when needed, uses ``sudo ip link`` to
restore its address. VS Code waits for this check before attaching. The host's
interfaces are not changed. Docker fixed the restart bug in 25.0.3; see the
`Docker 25 release notes <https://docs.docker.com/engine/release-notes/25.0/>`_.
The IP address remains dynamically assigned; Diamond's Ethernet host ID uses
the MAC, not the IP.

The host-mounted profiles forward ``LM_LICENSE_FILE``.
When the license is in the installation's ``license/license.dat``, the mount
already includes it and no additional variable is necessary. A host path
outside the installation is not made accessible by forwarding an environment
variable: mount that file separately and use its container path, or use a
reachable ``port@server`` for a floating license.
The image adds ``/opt/diamond/bin/lin64`` to ``PATH``, making the mounted
``diamond`` and ``diamondc`` launchers available in terminals.
The startup availability message appears in the container log; Diamond checks are run explicitly with ``check-diamond``.
After changing the selected installation, network settings or image, use
**Dev Containers: Rebuild Container**. Reloading the window or opening another
terminal does not change an existing container's mounts or network configuration.
Repository files persist, while unmounted container state can be replaced.
Changes to forwarded variables such as ``LM_LICENSE_FILE`` still require VS Code
to inherit them: close it fully and relaunch it from the configured host shell.
The default user is ``vscode``; VS Code adjusts its UID/GID to the host user.
``USER_UID`` and ``USER_GID`` are build arguments for direct container use.

``echo "$DIAMOND_ROOT"`` reports the configured path even when no installation
is mounted. To distinguish a missing mount from a shell path problem, run::

   cat /sys/class/net/eth0/address
   ls -l "$DIAMOND_ROOT/bin/lin64/diamond" "$DIAMOND_ROOT/bin/lin64/diamondc"
   command -v diamond diamondc
   check-diamond --synthesis
   make build-all

The first command must show ``10:91:d1:3d:14:ae``. If it shows ``02:42:...``
or the launcher files are missing, run ``bash .devcontainer/prepare-host.sh``
on the host and rebuild the container with the updated configuration.
After a manual ``docker restart`` outside VS Code on an affected Docker version,
run ``bash .devcontainer/setup-network.sh`` inside the container before building,
or reconnect with Dev Containers to run its startup lifecycle.
An old container mounted to the empty ``uz-cpld-no-diamond`` volume must be
recreated; exporting a variable inside it cannot add the installation.
If the mounted files exist but the launchers are absent from ``PATH``, rebuild the Dev Container to apply its configured environment.

Using the Diamond image
~~~~~~~~~~~~~~~~~~~~~~~

The existing ``.devcontainer/devcontainer.json`` and
``.devcontainer/usb/devcontainer.json`` profiles keep using the host-mounted
installation described above. To include Diamond and its license in the
container instead, select one of these configurations when reopening in VS Code:

* ``.devcontainer/diamond/devcontainer.json``: Diamond image, without USB access.
* ``.devcontainer/diamond-usb/devcontainer.json``: Diamond image, with the same
  USB settings as the host USB profile. Set ``USB_DEVICE_GID`` as described above.

The image profiles default to the locally built
``lattice-diamond:3.14.0.75.2`` image. They inherit its Ubuntu 22.04 runtime,
Diamond installation at ``/opt/diamond``, and embedded license, then add the
repository's FOSS tools and development environment. The Diamond image must be
available to the same Docker daemon that builds the Dev Container.
These profiles do not mount anything over ``/opt/diamond`` and use
``/opt/diamond/license/license.dat`` as ``LM_LICENSE_FILE``. They ignore
``DIAMOND_HOST_ROOT`` and the host's ``LM_LICENSE_FILE``.

To use a different compatible image, including a future GHCR image, export
``DIAMOND_IMAGE`` (repository name without a tag) and optionally
``DIAMOND_TAG`` before launching VS Code::

   export DIAMOND_IMAGE=ghcr.io/yourname/lattice-diamond
   export DIAMOND_TAG=3.14.0.75.2
   docker pull "$DIAMOND_IMAGE:$DIAMOND_TAG"
   code .

For the local image, leave ``DIAMOND_IMAGE`` and ``DIAMOND_TAG`` unset.
The default tag is ``3.14.0.75.2``. If VS Code is already running,
close it fully before relaunching to pick up environment changes. Use **Dev
Containers: Reopen in Container** to select the configuration, or **Dev
Containers: Rebuild Container** after changing the selected profile's image.
Inside the container verify installation and licensed synthesis with::

   check-diamond --synthesis
   python3 -m cpld_toolchain doctor

For a manual build, the Dockerfile provides ``TOOLCHAIN_BASE``; its default is
``ubuntu:22.04`` and preserves host mounting. To build the image variant::

   docker build --platform linux/amd64 --target toolchain \
     --build-arg TOOLCHAIN_BASE=lattice-diamond:3.14.0.75.2 \
     -f .devcontainer/Dockerfile -t uz-cpld-toolchain-diamond .
   docker run --rm -it --init --platform linux/amd64 \
     --network=name=bridge,mac-address=10:91:d1:3d:14:ae \
     --user "$(id -u):$(id -g)" --env HOME=/tmp \
     --mount "type=bind,source=$PWD,target=/work" \
     uz-cpld-toolchain-diamond bash

``make image`` continues to build the default host/FOSS image. Inside either
Dev Container profile, Diamond builds run through the same commands using the installed tools.
The image variant contains proprietary tools and your license; restrict access
when publishing it, just as for the Diamond base image.

Diamond and licensing
---------------------

.. list-table:: Runtime configuration
   :header-rows: 1

   * - Variable
     - Meaning
   * - ``DIAMOND_HOST_ROOT``
     - Host setup override for the Linux installation path; ``none`` disables the mount's installation.
   * - ``DIAMOND_IMAGE``
     - Optional Diamond image repository name without a tag for the image profiles.
   * - ``DIAMOND_TAG``
     - Diamond image tag for the image profiles, defaulting to ``3.14.0.75.2``.
   * - ``DIAMOND_ROOT``
     - Runtime installation root, defaulting to ``/opt/diamond``. Also accepted as a host setup fallback.
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

The full native Linux simulation and documentation workflow requires Python
3.10+, GHDL, Yosys, Graphviz and the packages in ``docs/requirements.txt``.
Generation and native Diamond work need only their workflow-specific
dependencies; see :doc:`tool-environments`.
The tooling tests also require Tcl support through ``python3-tk`` on Ubuntu.
The image and native requirements select the same Sphinx version; OS packages and the Ubuntu image tag remain mutable inputs.
Firmware and documentation commands use dependencies already installed in the image.
The C++ compiler and development headers used to build nextpnr and the patched flasher remain in the intermediate builder stage.
The runtime includes the compiled tools; ``make flasher-build`` is a separate native source build and requires those development dependencies if run there.
See :doc:`foss` for the pinned tool bundle and native source-build prerequisites.

Native Python environment for Diamond
-------------------------------------

For native Windows instructions, see :doc:`windows`.

On Linux with Python 3.10+ and its ``venv`` support installed (the
``python3-venv`` package on Ubuntu), run::

   python3 -m cpld_toolchain venv

This creates or reuses ``.venv`` in the checkout, installs the generator in
editable mode and the Python dependencies for VHDL generation, Diamond builds,
and hardware programming, then opens an activated Bash shell. Run ``make
build-all`` or the programmer commands in that shell. Use ``exit`` to return
to the previous shell. Running the command again refreshes the installation.
Use ``python3.11 -m cpld_toolchain venv`` to choose the setup interpreter when first
creating the environment.

Make cannot change its parent shell's environment. To install without opening
a shell, or to activate in your existing Bash/Zsh session, use::

   python3 -m cpld_toolchain venv --activate 0
   source .venv/bin/activate

Without an interactive terminal, ``make venv`` installs the dependencies and
prints the activation command instead of opening a shell.
``make venv dry_run=1`` previews setup without creating files.

This installs Python dependencies only. Diamond and its runtime libraries,
license configuration, ``libusb-1.0`` and USB permissions are still required
for native Diamond builds and programming. FOSS hardware programming additionally
requires the patched openFPGALoader and OpenOCD described in
:doc:`firmware-identity`. Simulation and documentation dependencies are outside
this environment's scope; install them separately or enter the toolchain container.
