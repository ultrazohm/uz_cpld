Standalone programming CLI
==========================

The standalone ``uz_cpld`` application downloads and programs published CPLD firmware using the included patched openFPGALoader by default.
It includes Python and does not require Git, a source checkout or synthesis tools.
The initial targets are Windows 11 x64 and Ubuntu 24.04 x64, using Diamond Programmer 3.14.0.75.2 as the validation baseline.
The FOSS download includes the native loader and its runtime libraries; MSYS2 and Diamond are unnecessary on the workstation.
USB drivers/permissions require the one-time setup below. Diamond remains an optional backend.
The repository CLI retains generation, builds, simulation, documentation and existing programming commands.

Downloads
---------

Successful push workflows publish a testing GitHub Release with five downloads:

* Windows tool-only ZIP.
* Ubuntu tool-only TAR.GZ.
* Windows tool plus firmware ZIP.
* Ubuntu tool plus firmware TAR.GZ.
* Platform-independent ``uz-cpld-firmware.zip``.

``SHA256SUMS.txt`` covers all five assets.
The combined archives reuse the exact application files and firmware ZIP offered separately.
``application.json`` records the application version, source commit, runtime and platform.
``bundle.json`` additionally records the included firmware commit and checksum.
Application and firmware versions are independent; firmware-only updates do not require replacing the application.
Release assembly rejects application or firmware artifacts from a different workflow commit.

Extract the complete application archive and run it from a terminal.
Use ``.\uz_cpld.exe`` in PowerShell or ``./uz_cpld`` on Ubuntu when it is not on PATH.
Ubuntu TAR archives preserve executable permissions and internal symbolic links.
The Windows executable is currently unsigned.

USB setup
---------

On Windows, install WinUSB for **only FT4232 channel B / Interface 1** using
`Zadig <https://zadig.akeo.ie/>`_: enable Options → List All Devices, match the
UltraZohm VID ``0403``, PID ``6011`` and interface ``MI_01`` in Device Manager,
and select WinUSB. Leave channels A, C and D with their existing drivers.
Restore the FTDI/vendor driver on Interface 1 before using Diamond again.
The application never installs or changes Windows drivers automatically.
See the `libusb Windows guide <https://github.com/libusb/libusb/wiki/Windows>`_.

On Ubuntu, use the included upstream rules as described in the
`openFPGALoader installation guide <https://trabucayre.github.io/openFPGALoader/guide/install.html>`_::

   # Run from the extracted uz_cpld directory:
   getent group plugdev || sudo groupadd --system plugdev
   sudo cp _internal/cpld_toolchain/bundled_tools/openFPGALoader/99-openfpgaloader.rules /etc/udev/rules.d/
   sudo usermod -aG plugdev "$USER"
   sudo udevadm control --reload-rules
   sudo udevadm trigger

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

   ./uz_cpld programmer_path=/opt/diamond/programmer/bin/lin64/pgrcmd

The command checks that the file is executable without starting it or contacting hardware.
The path persists per user across application upgrades and workspaces.
``programmer_path=auto`` clears the saved setting.
``CPLD_PGRCMD`` takes precedence over the saved setting, followed by normal Diamond discovery.
A missing explicitly configured executable fails rather than falling back to another installation.
The shared repository programmer also honors this setting.
``doctor --programmer-backend diamond`` prints Diamond discovery and the saved configuration.
Plain ``doctor`` verifies the bundled FOSS loader, runtime checksums and capability version without USB access.
Neither establishes driver compatibility or physical hardware readiness.

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
use ``--selection another.toml`` to create another configuration.

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

GitHub Actions builds native PyInstaller directory bundles on ``ubuntu-24.04`` and ``windows-2025`` using the pinned tools in ``distribution/requirements.txt``.
The loader build verifies the upstream archive and patch pins, runs protocol tests,
collects the dependency closure and notices, and tests the portable executable with a clean PATH.
Windows uses upstream's native MSYS2 UCRT64 route with DLLs beside the executable.
Linux bundles shared libraries with ``$ORIGIN`` runpaths and uses Ubuntu's glibc.
The receipt covers the executable and every bundled runtime library.
Upstream source, our patch, library notices and package versions are retained with the loader.
Windows Server hosts the x64 CI job; passing that job is not a Windows 11 hardware test.
The executable smoke test runs outside the checkout with Python/MSYS2 absent from PATH.
It verifies loader discovery, executes the native parser, checks rejection of modified
loader/runtime/firmware files, selects fixture firmware and exercises persistent settings.
CI also extracts and tests the tool archives on each platform and both combined archives.
The release publication job waits for both standalone jobs and the existing Diamond, Linux and Windows checks.
Pull requests and manual workflow runs retain tool archives as CI artifacts without publishing a release.
Physical programming and driver behavior still need acceptance testing on the intended workstation and boards.

To build the current platform locally in an isolated packaging environment::

   python -m pip install -r distribution/requirements.txt
   python distribution/loader.py
   python distribution/build.py
   python distribution/smoke.py build/standalone/dist/uz_cpld/uz_cpld
   python distribution/archive.py pack --application build/standalone/dist/uz_cpld --output build/standalone/assets

Use ``uz_cpld.exe`` in the smoke-test path on Windows.
Run ``distribution/loader.py`` under MSYS2 UCRT64 on Windows with GCC, CMake, Ninja, pkgconf, patch, libftdi, libusb, zlib and Python installed.
Ubuntu builds need CMake, g++, pkg-config, patch, libftdi1/libusb/zlib development packages and patchelf.
These commands produce directory application bundles (the executable and ``_internal``), not a single-file executable; no Python wheel or PyPI publication is part of this distribution.
