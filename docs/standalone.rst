Standalone programming CLI
==========================

The standalone ``uz_cpld`` application downloads and programs published CPLD firmware using the system's Diamond Programmer.
It includes Python and does not require Git, a source checkout or synthesis tools.
The initial targets are Windows 11 x64 and Ubuntu 24.04 x64, using Diamond Programmer 3.14.0.75.2 as the validation baseline.
Install Diamond Programmer, its runtime dependencies and cable drivers separately.
Ubuntu also requires Bash, libusb-1.0 and access to the programmer's USB device nodes.
OpenFPGALoader and a GUI are reserved for later releases.
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

Persistent programmer configuration
-----------------------------------

Set the path to the actual ``pgrcmd`` executable, not the Diamond installation directory::

   uz_cpld programmer_path="C:\lscc\diamond\3.14\programmer\bin\nt64\pgrcmd.exe"
   uz_cpld doctor

On Ubuntu, for example::

   ./uz_cpld programmer_path=/opt/diamond/programmer/bin/lin64/pgrcmd

The command checks that the file is executable without starting it or contacting hardware.
The path persists per user across application upgrades and workspaces.
``programmer_path=auto`` clears the saved setting.
``CPLD_PGRCMD`` takes precedence over the saved setting, followed by normal Diamond discovery.
A missing explicitly configured executable fails rather than falling back to another installation.
The shared repository programmer also honors this setting.
``doctor`` prints the effective configuration source, executable, installation version when available, and workspace.
It does not validate the license, cable driver or physical hardware.

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
This snapshot remains usable after the original download or application directory is replaced.
Selecting a package does not change slot assignments.

Programming
-----------

Create and edit ``selection.toml`` in the workspace shown by ``doctor``::

   uz_cpld init_programmer
   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1
   uz_cpld program --target dslot

Choose program names and a release cycle present in ``firmware_list``.
The last command immediately erases, writes and verifies Flash after the managed preflight checks; there is no confirmation prompt.
S3C uses ``--target s3c`` and its own physical JTAG access state.
Both managed chains default to Diamond port ``FTUSB-1``; ``--probe-index`` overrides the port subject to the existing wiring checks.
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
Windows Server hosts the x64 CI job; passing that job is not a Windows 11 hardware test.
The executable smoke test runs outside the checkout, selects fixture firmware, exercises persistent settings and checks rejection of modified firmware without USB access.
The release publication job waits for both standalone jobs and the existing Diamond, Linux and Windows checks.
Pull requests and manual workflow runs retain tool archives as CI artifacts without publishing a release.
Physical programming and driver behavior still need acceptance testing on the intended workstation and boards.

To build the current platform locally in an isolated packaging environment::

   python -m pip install -r distribution/requirements.txt
   python distribution/build.py
   python distribution/smoke.py build/standalone/dist/uz_cpld/uz_cpld
   python distribution/archive.py pack --application build/standalone/dist/uz_cpld --output build/standalone/assets

Use ``uz_cpld.exe`` in the smoke-test path on Windows.
These commands produce application archives; no Python wheel or PyPI publication is part of this distribution.
