Windows Docker USB access without WSL2
======================================

Use USB/IP to connect a Windows USB programmer to Linux containers running in
Docker Desktop with the Hyper-V backend. WSL2 is not required.
The connection is Windows USB port -> usbipd-win -> Docker's Linux VM ->
openFPGALoader container.

The repository's ``toolchain`` image already includes the patched openFPGALoader
and its dependencies. Use the repository CLI inside that image; the standalone
Windows executable currently exposes only Diamond programming.
This guide describes the Docker-supported USB/IP mechanism. The UltraZohm FT4232
programming workflow over Hyper-V USB/IP still requires hardware validation.

Prerequisites
-------------

* Docker Desktop configured for Linux containers with the Hyper-V backend.
* Administrator access to install usbipd-win and share the USB device.
* The UltraZohm FT4232 connected to the Windows workstation.
* The repository's toolchain image and checkout available for the programming
  container; see :doc:`environments` for container setup.

Share the USB device from Windows
---------------------------------

In Administrator PowerShell, install usbipd-win::

   winget install usbipd

Reopen Administrator PowerShell so the updated PATH is available, then list
devices and share the FT4232::

   usbipd list
   usbipd bind --busid 2-3

Replace ``2-3`` in all commands with the FT4232 bus ID reported on your machine.
Sharing with ``bind`` persists across reboots. The device is forwarded as a
whole, so do not expect its other interfaces to remain available to Windows
applications while attached to Linux.

Attach the device to Docker's Linux VM
--------------------------------------

In PowerShell, start a helper container::

   docker run --rm -it --privileged --pid=host alpine

Inside that container, enter the Linux VM's mount namespace and use its USB/IP
tools::

   nsenter -t 1 -m
   usbip list -r host.docker.internal
   usbip attach -r host.docker.internal -b 2-3

Keep this terminal and helper container running while using the programmer.
Docker's documented procedure requires the helper to remain running to maintain
device access. No ``usbipd attach --wsl`` command is used in this workflow.
The helper's privileged access applies to Docker's Linux VM.

Expose USB to the programming container
---------------------------------------

Add these arguments to the programming container's ``docker run`` invocation::

   --mount type=bind,source=/dev/bus/usb,target=/dev/bus/usb
   --device-cgroup-rule="c 189:* rwm"

The source path belongs to Docker's Linux VM, where the device was attached.
The repository's ``.devcontainer/usb/devcontainer.json`` already contains these
arguments. Its existing host setup and other mounts still need to be configured;
these USB arguments alone do not configure the complete development container.

The programming container user must also have read/write permission on the
forwarded USB device nodes. Inspect their ownership inside the container::

   ls -l /dev/bus/usb/*/*

When access is granted through a device group, add its numeric GID using
``--group-add=GID`` when creating the container. Do not assume the devcontainer's
default USB group matches the forwarded device's ownership.

Check access before programming
-------------------------------

With the hardware in D-slot JTAG access mode, run this inside the configured
toolchain container from the mounted checkout::

   uz_cpld scan --target dslot --programmer-backend foss

Expect five LCMXO2-2000HC devices. For S3C, select its physical JTAG access mode
and scan separately::

   uz_cpld scan --target s3c --programmer-backend foss

Expect one LCMXO2-4000HC device. Scanning reads device IDs without programming
Flash. See :doc:`programmer` for firmware selection, identity reads and managed
programming with ``--programmer-backend foss``.

Reconnect and troubleshoot
--------------------------

* After a reboot, device reset or unplug/replug, repeat the attachment step.
  Check ``usbipd list`` again because the bus ID may have changed.
* If ``usbip list`` cannot reach the Windows host, check that the usbipd service
  is running and Windows Firewall permits TCP port 3240 from Docker's VM.
  The installer adds a firewall rule; third-party firewalls may need configuration.
* If attachment succeeds but the programming container cannot access USB, check
  its device mount, cgroup rule and device-node permissions.
* If a scan sees the wrong chain, check the board's physical JTAG access mode.
* Docker does not guarantee compatibility with every USB device. Validate scan,
  identity, program/verify and reconnection on the intended workstation before
  treating this workflow as qualified.

References
----------

* `Docker Desktop USB/IP guide (including Windows Hyper-V)
  <https://docs.docker.com/desktop/features/usbip/>`_.
* `usbipd-win installation, sharing and non-WSL clients
  <https://github.com/dorssel/usbipd-win#how-to-use>`_.
