Program existing firmware
=========================

Install the user application on Windows x64 or Linux x86-64 (glibc 2.28 or newer).
It includes our patched FOSS programmer automatically; no checkout, compiler, or Diamond installation is required.
Use a graphical desktop for the optional Tk GUI.
Python 3.12 or newer with working Tcl/Tk is required; uv-managed Python 3.12 is the recommended runtime.

Install
-------

Install uv, then run in PowerShell or a Linux terminal::

   uv tool install --managed-python --python 3.12 --prerelease allow ultrazohm-cpld-user
   ultrazohm-cpld-user --version
   ultrazohm-cpld-user doctor

This branch publishes prereleases only, so ``--prerelease allow`` is currently explicit.
The wheel bundles the FOSS programmer, its native libraries and USB setup materials directly.
uv selects the Windows or Linux wheel automatically; no separate programmer package is needed.
If uv reports that its executable directory is absent from PATH, run ``uv tool update-shell`` and open a new terminal.
For a one-off invocation::

   uvx --managed-python --python 3.12 --prerelease allow ultrazohm-cpld-user programmer_gui

An existing Python 3.12+ virtual environment can instead use ``pip install --pre ultrazohm-cpld-user``.
Its base Python must supply working Tk for the GUI; the CLI does not require Tk.
Windows also has a standalone download with Python included; see :doc:`../standalone`.
There is no Linux standalone archive.

Driver setup
------------

Connect one programmer and run::

   ultrazohm-cpld-user setup_drivers

On Windows this requests administrator approval only when the selected channel B needs its WinUSB binding changed.
It preserves the other interfaces.
With multiple matching devices, specify ``--device-id`` using the identity shown by the diagnostic.
On Linux this installs the packaged udev rules using sudo; reconnect USB afterward and ensure membership of any group named by those rules.
Package installation never changes host drivers or permissions.
Normal programming runs without administrator privileges once setup is complete.

Select firmware and program
---------------------------

The GUI supports firmware downloads, assignments, identification, and programming::

   ultrazohm-cpld-user programmer_gui

Downloads show stable firmware by default.
Enable **Include testing prereleases** to deliberately select testing firmware.
The CLI has the same stable default::

   ultrazohm-cpld-user firmware_download --output firmware.zip
   ultrazohm-cpld-user firmware_select --firmware firmware.zip
   ultrazohm-cpld-user init_programmer
   ultrazohm-cpld-user program

There is no automatic fallback to testing firmware when no stable release exists.
For explicit branch testing, download with ``firmware_download --branch feature/add_heartbeat --output firmware.zip`` and select that ZIP.
Local firmware ZIPs produced by developers can also be selected.
The application's PyPI prerelease status does not change firmware selection policy.

Select the correct adapter routing and compatible S3C/D-slot programs; see :doc:`../releases`.
The GUI confirms programming assignments before writing.
The guided ``program`` command asks for assignments and confirmation.
Commands supplying a target and complete assignments can program immediately; use ``--dry-run 1`` to preview first.
Prepare the board's physical JTAG access state for S3C or D-slots before each operation.

Settings, selected firmware snapshots, and logs live in the user's application data directory.
Use ``ultrazohm-cpld-user --workspace DIRECTORY ...`` to select another workspace.
Neither installation nor upgrades require a source checkout or write into the installed packages.

Optional Diamond backend
------------------------

Full Diamond is unnecessary for FOSS programming.
To use an existing Diamond Programmer installation, configure its executable and select it explicitly::

   ultrazohm-cpld-user programmer_path=PATH_TO_PGRCMD
   ultrazohm-cpld-user doctor --programmer-backend diamond
   ultrazohm-cpld-user scan --target dslot --programmer-backend diamond

On Windows, ``ultrazohm-cpld-user setup_diamond_driver`` restores a compatible FTDI driver already installed in Windows.
If none exists, install the Diamond/FTDI driver package first.
Return to ``setup_drivers`` before using FOSS again.
The bundled FOSS programmer remains available regardless of the selected backend.

Development
-----------

The public application programs existing firmware only.
Generating, building, simulating, and changing firmware or the CLI still uses the checkout's developer environment.
See :doc:`../developer/hdl`, :doc:`../developer/toolchain`, and :doc:`../windows` for native Windows Diamond builds.
Do not install the checkout's editable ``cpld-toolchain`` package into the user application's uv tool environment.

Python and alternate interfaces
-------------------------------

Use the :doc:`python-api` to script programmer operations or build another interface.

.. toctree::
   :hidden:

   python-api
