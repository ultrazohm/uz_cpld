Windows standalone programmer
=============================

The standalone ``uz_cpld`` application downloads and programs published CPLD firmware using the included patched openFPGALoader by default.
It includes Python and does not require Git, a source checkout or synthesis tools.
Standalone downloads target Windows 11 x64, using Diamond Programmer 3.14.0.75.2 as the validation baseline.
Windows and Linux users can install the same application through Python packages; see :doc:`user/index`.
The Windows FOSS download includes a statically linked native loader.
Linux uses the Python wheels and their bundled shared runtime libraries; Linux standalone archives are no longer produced.
MSYS2 and Diamond are unnecessary on the workstation.
USB drivers/permissions require the one-time setup below. Diamond remains an optional backend.
The repository CLI retains generation, builds, simulation, documentation and existing programming commands.

Downloads
---------

Successful push workflows publish a testing GitHub Release with three downloads:

* Windows tool-only ZIP.
* Windows tool plus firmware ZIP.
* Platform-independent ``uz-cpld-firmware.zip``.

``SHA256SUMS.txt`` covers all three assets.
The combined archives reuse the exact application files and firmware ZIP offered separately.
``application.json`` records the application version, source commit, runtime and platform.
``bundle.json`` additionally records the included firmware commit and checksum.
Application and firmware versions are independent; firmware-only updates do not require replacing the application.
Release assembly rejects application or firmware artifacts from a different workflow commit.

Extract the complete application archive. On Windows, double-click ``uz_cpld.exe``
to open a persistent PowerShell programmer terminal in the application folder.
You can type commands such as ``uz_cpld doctor`` and ``uz_cpld init_programmer``
there; type ``exit`` to close it. No separate launcher is needed.
Invocations from an existing PowerShell/cmd terminal retain normal CLI behavior,
including printing help and returning immediately when no command is supplied.
Redirected/noninteractive invocations never open another shell.
Use ``.\uz_cpld.exe`` in PowerShell when it is not on PATH.
Linux wheels preserve the native programmer executable and library layout.
The Windows executable is currently unsigned.

Optional desktop programmer
---------------------------

Double-click ``uz_cpld_gui.exe`` on Windows, or run ``uz_cpld programmer_gui``
from the programmer terminal. The Python package also provides ``uz_cpld_gui``.
The CLI and its existing double-click terminal remain available independently.
Opening the GUI does not change drivers or program hardware.

The window provides firmware ZIP selection/download, release and program
dropdowns, assignment saving, driver setup, chain scanning, identification and
programming. The six program dropdowns represent S3C and D1 through D5.
``Download`` fetches a list of available GitHub firmware versions and opens a
dropdown, newest first, with publication date, branch/tag, commit and release
tag. It shows stable firmware by default; enable **Include testing prereleases** to include testing releases across branches;
no branch name is required. Only published releases with the firmware ZIP and
recorded source commit are offered. Selecting ``Download & select`` downloads
that exact release and validates its commit and checksums before saving the
workspace snapshot. Cancellation or a failed download preserves selected
firmware. CLI downloads default to stable firmware; ``--branch`` explicitly selects testing firmware.
Available programs come from the validated ZIP and are filtered by release and
target. Changing release clears incompatible choices; no program is silently
selected. D-slot programming operates on the complete five-device chain.

Select included or downloaded firmware, choose assignments, and click
``Save assignments`` to initialize or update ``selection.toml`` and persist a
firmware snapshot. Replacing existing assignments requires confirmation.
The top row contains ``1 Setup`` and ``2 Firmware``; ``3 Program`` with the
vertical assignment dropdowns is below. Configure the backend and Windows
drivers, then choose firmware when needed. The action row places ``Scan``,
``Identify S3C``, ``Program S3C``, ``Identify D-slots`` and ``Program D-slots``
in that order beside a compact purple activity indicator. A note below indicates
the physical access state: S3C uses the blue LED; D-slots use the green LED.
Identification reads identities even before a firmware package is selected.
Without a registry, raw IDs and USERCODEs are
shown with unknown firmware names. CLI ``identify`` discovers the chain when
``--target`` is omitted. Prepare the physical JTAG access state before reading.
``Program S3C`` and ``Program D-slots`` always ask for confirmation of the
displayed assignments and default to cancellation. Programming uses the
displayed choices; saving them is optional.
The window opens centered at the measured layout size, bounded by the display
and Windows work area. Its page can scroll on small displays; the fixed-height
device table has no scrollbars. Frozen downloads retain system trust
and ship a Mozilla CA bundle; HTTPS certificate verification remains enabled.

The result table reserves a fixed height for S3C and D1 through D5, with empty
values before the first read. Reading one chain retains the other chain's
results. The table shows device positions, IDCODEs, installed programs, revisions
and USERCODEs. Unknown identities remain explicitly unknown. Full operation
logs and structured results are retained in the workspace under
``build/programmer/gui``; ``Open diagnostics`` opens the operation folder.
Operations run in an isolated worker process; the window remains responsive,
but changing settings and closing it are disabled until the operation finishes.
Driver setup reports restart requirements and retains the CLI's administrator
prompt, selected-interface restriction and driver restoration behavior.
With multiple programmers, enter the USB serial for FOSS operations and the
Windows device instance ID for driver setup.

After repository setup, the same interface is available with::

   uz_cpld programmer_gui
   uz_cpld --workspace C:/programming-station programmer_gui

Repository usage defaults to the checkout workspace; standalone usage defaults
to the per-user workspace below. The GUI uses published ZIP firmware in both
environments. Synthesis and local-build programming remain CLI workflows.
Tk is imported only when launching the GUI. If repository Python lacks Tk,
install a Python distribution with Tcl/Tk support (``python3-tk`` on Ubuntu);
CLI use and repository setup do not require it. No extra Python GUI package is
installed by setup. ``gui`` continues to open Diamond projects.
Some managed Python installations expose Tk without its Tcl scripts. The
repository launcher can use an already installed Python 3.11+ with working Tk
for the window while keeping the configured checkout interpreter for every
worker operation. It installs nothing and prints the chosen interpreter.
``UZ_CPLD_GUI_PYTHON`` can specify that optional UI interpreter explicitly.
Standalone bundles use their included runtime and do not discover another Python.

USB setup
---------

On Windows, first try ``.\uz_cpld.exe scan --target dslot`` with the correct physical JTAG access state.
If the expected chain is detected, keep the existing driver. Otherwise, close
Diamond and other programmer applications and run::

   uz_cpld setup_foss_drivers
   uz_cpld doctor
   uz_cpld scan --target dslot

Approve the Windows administrator prompt. The download includes a static libwdi
helper that prepares the WinUSB package and binds it to the selected FT4232
channel B / Interface 1 (``VID_0403&PID_6011&MI_01``). No Zadig download or manual
Device Manager selection is needed. Channels A, C and D are left unchanged.
With multiple programmers connected, the command lists their instance IDs and
requires ``--device-id "ID"`` to select one.

To switch the same interface back to Diamond::

   uz_cpld setup_diamond_driver
   uz_cpld scan --target dslot --programmer-backend diamond

The FOSS setup preserves the original FTDI INF reference in the device's Windows
registry key. Diamond setup restores that exact package; for devices previously
changed using Zadig, it selects a compatible FTDI package already in Windows'
driver store. It does not download or install Diamond. If the saved package was
removed, or no compatible FTDI package exists, install the Diamond/FTDI driver
package first. Setup reports failure instead of claiming the driver was restored.

These are explicit setup commands; ``doctor``, ``scan`` and ``program`` never
change Windows driver bindings. Both setup commands are idempotent and support
``--dry-run 1``. If Windows requests a restart, restart before programming.
Driver packages remain in Windows' driver store; they may influence the default
binding of newly connected devices with the same hardware ID.

Static linking includes application libraries; WinUSB is the Windows USB driver.
If a FOSS scan reports ``usb_open() failed``, close other probe users, run
``doctor``, and use ``setup_foss_drivers`` if the driver is incompatible.
See the `libusb Windows guide <https://github.com/libusb/libusb/wiki/Windows>`_.

Linux Python-package users run ``uz_cpld setup_drivers`` to install the packaged udev rules, then reconnect USB.
See :doc:`user/index`.

Log out/in after changing groups, then unplug/replug USB. Programming runs as
your normal user. The FOSS bundle includes libusb for the channel-B driver guard;
no system libusb installation is needed. Physical JTAG access states still differ
between S3C and D-slots; see :doc:`programmer`.

Persistent programmer configuration
-----------------------------------

For the optional Diamond backend, install Diamond Programmer and its drivers separately.
Set the path to the actual ``pgrcmd`` executable, not the Diamond installation directory::

   uz_cpld programmer_path="C:\lscc\diamond\3.14\programmer\bin\nt64\pgrcmd.exe"
   uz_cpld doctor --programmer-backend diamond

On Ubuntu, for example::

   uz_cpld programmer_path=/opt/diamond/programmer/bin/lin64/pgrcmd

The command checks that the file is executable without starting it or contacting hardware.
The path persists per user across application upgrades and workspaces.
``programmer_path=auto`` clears the saved setting.
``CPLD_PGRCMD`` takes precedence over the saved setting, followed by normal Diamond discovery.
A missing explicitly configured executable fails rather than falling back to another installation.
The shared repository programmer also honors this setting.
``doctor --programmer-backend diamond`` prints Diamond discovery and the saved configuration.
Plain ``doctor`` verifies the bundled FOSS loader, runtime checksums and capability version without USB access.
The Windows driver report checks the binding; neither command establishes physical hardware readiness.

Firmware download and selection
-------------------------------

With no arguments, the downloader uses the newest published CI firmware from ``master`` in ``https://github.com/ultrazohm/uz_cpld``::

   uz_cpld firmware_download

Repository and branch overrides are independent; omitted values retain those defaults::

   uz_cpld firmware_download --branch topic
   uz_cpld firmware_download --git-url https://github.com/owner/repo --branch master

The downloader retains the existing release-commit, archive and checksum checks.
It never selects or programs a download automatically.
The repository CLI continues to infer its default repository/branch from Git; these fixed defaults belong to the standalone application.

Inspect the downloaded ZIP and explicitly select it::

   uz_cpld firmware_list --firmware /path/to/uz-cpld-firmware.zip
   uz_cpld firmware_select --firmware /path/to/uz-cpld-firmware.zip

For a combined application/firmware download::

   uz_cpld firmware_list --included
   uz_cpld firmware_select --included

Included firmware is found beside the executable, independently of the terminal's current directory.
``firmware_list`` without a path inspects the selected package, or the included package if none is selected.
It prints the source commit, ZIP checksum, release/program names, targets and expected USERCODEs.
Selection copies the validated ZIP into the workspace and records its checksum in ``firmware.json``.
Snapshot paths are relative to the workspace, so the selection also works when
the workspace is mounted at a different path inside a container. Older absolute-path
selections locate the same checksum-addressed snapshot under the current workspace.
If the saved ZIP is missing, interactive programming opens the package chooser;
noninteractive commands fail with instructions. Invalid or modified packages remain
errors and are never silently replaced.
This snapshot remains usable after the original download or application directory is replaced.
Selecting a package does not change slot assignments.

Alternatively, run ``uz_cpld program --target dslot`` in an interactive terminal.
If no package is selected, it offers downloaded packages, included firmware when
available, a new download (with a branch prompt), or a ZIP path. The chosen package
is validated and saved as a workspace snapshot. Subsequent invocations reuse that
selection; downloading another package does not replace it.

To explicitly use the newest recorded local download from the default repository
and ``master`` branch for one invocation::

   uz_cpld program --target dslot --firmware latest-downloaded

This does not contact GitHub or change the saved selection. It uses publication
metadata recorded by ``firmware_download``, not file modification times. Older
downloads without that metadata remain selectable in the interactive list or by
path, but cannot be chosen by ``latest-downloaded``.

Missing release/program choices are offered interactively from the validated ZIP.
Valid existing ``selection.toml`` assignments are reused. Guided assignments apply
to this invocation only and require an explicit choice to proceed with programming;
the selection file is not rewritten. Choices are filtered by cycle and device target,
not by the S3C firmware currently installed on the board.

Prompts require both terminal input and output (use ``docker run -it`` in a container).
Without a terminal, supply a ZIP path, a saved selection, or ``latest-downloaded``
and complete program assignments. ``--dry-run 1`` never prompts or downloads.

Programming
-----------

Run ``uz_cpld init_programmer`` without assignment arguments in a terminal to
choose the release cycle, S3C program and D1 through D5 from the selected firmware
package. If no package is selected, the package chooser opens first, including
bundled firmware when available. The completed choices are saved to
``selection.toml`` without accessing hardware. An existing file is kept unchanged;
use ``--selection another.toml`` to create another configuration, or
``uz_cpld init_programmer --override`` to choose assignments again and replace it.
The complete new selection is collected and validated before an atomic replacement.
Cancellation or write failure leaves the existing file intact.
``--override --selection PATH`` replaces only that specified selection; it never programs hardware.

Run ``uz_cpld program`` without a target for guided programming. First choose
``Manual selection`` or ``Use selection.toml``, then D1–D5 or S3C and the firmware
source (ZIP firmware in the standalone application). Package selection follows
when needed. Manual mode asks for the release and program assignments; file mode
reuses them from ``selection.toml`` without asking again. Missing files or
assignments incompatible with the package cause an error. ``--selection PATH``
can name another selection file. Review the summary and explicitly choose
``Program`` to proceed; the default final choice is ``Cancel``. These assignments
apply to this invocation and do not rewrite the selection file.

Create and edit ``selection.toml`` in the workspace shown by ``doctor``::

   uz_cpld init_programmer
   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1
   uz_cpld program --target dslot

Choose program names and a release cycle present in ``firmware_list``.
With complete selections, the last command immediately erases, writes and verifies
Flash after the managed preflight checks; there is no additional confirmation prompt.
S3C uses ``--target s3c`` and its own physical JTAG access state.
FOSS is the default for scan, identify and program: FT4232 channel B, ``--probe-index 0``, at 1 MHz.
Use ``--usb-serial SERIAL`` to select a probe explicitly.
``--programmer-backend diamond`` uses Diamond port ``FTUSB-1`` (``--probe-index 1``).
Managed identification/programming enforce these supported mappings; scans accept other probe indices.
``scan`` reads device IDs without requiring a firmware selection.
``identify`` and ``program`` use the saved ZIP; ``--firmware FILE`` overrides it for one invocation without changing the saved selection.
An altered saved ZIP is rejected before hardware access.
``--dry-run 1`` previews the invocation without contacting hardware; an explicit ZIP is not validated by that preview.
Direct assignments remain available, for example::

   uz_cpld program --target s3c --release heartbeat_cvg --s3c-program s3c_heartbeat

The application preserves the shared firmware validation, immutable execution snapshots, USB locking, logs and post-programming identity checks.
See :doc:`programmer` and :doc:`firmware-identity` for the underlying protocol.

Workspace and updates
---------------------

Windows stores configuration under ``%LOCALAPPDATA%\uz_cpld`` and the default workspace under its ``workspace`` subdirectory.
Ubuntu uses ``$XDG_CONFIG_HOME/uz_cpld`` (default ``~/.config/uz_cpld``) for configuration and ``$XDG_DATA_HOME/uz_cpld/workspace`` (default ``~/.local/share/uz_cpld/workspace``) for work.
``UZ_CPLD_CONFIG_DIR`` and ``UZ_CPLD_DATA_DIR`` override these application directories when needed.
The global workspace option takes precedence::

   uz_cpld --workspace /path/to/station init_programmer
   uz_cpld --workspace /path/to/station program --target s3c

The workspace contains firmware snapshots, selections, downloads and programming logs.
Explicit file arguments remain relative to the terminal's current directory.
To update the application, replace its extracted directory; configuration and workspace data remain separate.

Build and validation
--------------------

CI first builds and tests the ``ultrazohm-cpld-user`` wheel, including its bundled FOSS programmer.
Windows standalone is frozen from that installed wheel, outside the checkout's import path.
It is not built from a separate copy of application source.
The native programmer and driver helper must match the same source commit.
See :doc:`developer/python-packaging` for wheel builds and PyPI publication.

The Windows loader uses upstream's MinGW-w64 cross-compilation route on Ubuntu.
It statically links its dependencies and rejects non-system DLL imports.
The cross-built executable and protocol tests run on native Windows CI.
Sources, licenses, static archives and object files are retained for relinking.
Linux programmer wheels use bundled shared libraries with ``$ORIGIN`` runpaths and are built and exercised on glibc 2.28.

After building and installing the Windows user wheel in an isolated Python 3.12 environment::

   python -m pip install -r distribution/requirements.txt
   python distribution/build.py
   python distribution/smoke.py build/standalone/dist/uz_cpld/uz_cpld.exe
   python distribution/archive.py pack --application build/standalone/dist/uz_cpld --output build/standalone/assets

These commands produce a directory bundle containing the executable and ``_internal``.
The default includes the GUI launcher and Tcl/Tk runtime; ``--without-gui`` omits them.
Windows packaging uses Python with working Tcl/Tk and retains its redistribution materials.
Pinned upstream Tcl/Tk and zlib notices cover runtimes whose Python installation omits the notices.
Unknown runtime versions or changed materials fail the build.

Smoke tests exercise the installed wheels and extracted Windows archives outside the checkout.
They validate firmware selection, worker processes, programmer integrity and native parsing without USB writes.
Windows Server hosts CI; passing CI does not establish physical Windows 11 programming or driver installation behavior.
The existing hardware acceptance checks remain necessary on a programming station.

Windows USB driver diagnostics
------------------------------

Both the standalone and repository ``uz_cpld doctor`` inspect Windows PnP
metadata for connected FT4232 channel B / Interface 1 devices
(``VID_0403&PID_6011&MI_01``), regardless of the selected backend.
The report assesses compatibility with the FOSS backend: ``CONFIGURED`` means
WinUSB is bound with no Windows device error; ``INCOMPATIBLE`` identifies the
ordinary FTDI driver. Other bindings are marked ``CHECK DRIVER``.
It lists each matching device separately, including its driver service and
Windows problem code. ``ABSENT`` means no matching connected interface was
found; ``UNKNOWN`` means the query failed or required metadata is missing.

The check uses built-in Windows PowerShell and CIM, requires no extra Python
packages, and does not change drivers or open USB interfaces. If system policy
blocks the query, doctor reports that limitation and continues. Driver findings
are informational and do not change doctor's exit status. Use ``scan`` to test
actual USB access and JTAG communication. Linux and macOS skip this Windows check.

Licenses and redistribution
---------------------------

Our original application, driver helper and HDL are Apache-2.0; see ``LICENSE``, ``NOTICE`` and ``LICENSING.md`` in the repository and programmer archive.
Third-party components retain their licenses, including LGPL libwdi, libusb and libftdi.
Historical vendor/IEEE files are excluded from the programmer source archive and retain their existing terms.
The archive includes ``THIRD_PARTY_NOTICES.txt``, ``licenses/inventory.json``, component notices and exact corresponding sources.
The inventory maps runtime files to providers and hashes both binaries and licensing/source materials; archive assembly and extracted-archive smoke tests validate it.
Missing or unattributed native dependencies fail the build.
Keep this material when redistributing the application.

Windows driver setup uses our pinned LGPL libwdi patch and Microsoft's Windows 10/11 inbox WinUSB INF pattern.
It does not download or redistribute WDK coinstallers, and no Zadig download is needed.
The static helper retains libwdi source, our patch, helper source/object files and the static library under ``_internal/cpld_toolchain/bundled_tools/windows-drivers``.
See its ``relink/RELINK.txt`` to rebuild with a modified library and update the local integrity receipt.
The Microsoft INF reference is https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/winusb-installation.
Windows provides UCRT and API-set DLLs; these are excluded from the ZIP.
Python's required Visual C runtime has separate Microsoft terms in ``licenses/Python-LICENSE.txt`` and ``licenses/WINDOWS-RUNTIME-TERMS.txt`` that apply only to Microsoft's code.
Use and redistribution of that Windows runtime require agreement to those terms; they do not restrict modification of our Apache code or LGPL dependencies.

On Ubuntu, the packaging step downloads exact source packages, including distribution patches, for the shipped native libraries.
Enable ``deb-src`` for the same repositories as the installed binary packages before building (CI does this automatically)::

   sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources
   sudo apt-get update

If the exact installed version has left the configured repositories, update the build environment to available versions and rebuild.
The build deliberately fails instead of substituting a different source version.
Source material increases download size but keeps redistribution self-contained.
