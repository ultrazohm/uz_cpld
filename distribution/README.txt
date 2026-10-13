UltraZohm CPLD programmer (standalone CLI)

Windows 11 x64 / Ubuntu 24.04 x64.
Extract the complete archive before use; the executable needs its _internal directory.
On Windows, double-click uz_cpld.exe to open a PowerShell programmer terminal
that stays open. Type commands such as uz_cpld doctor, and type exit to close it.
Running the executable from an existing terminal keeps ordinary CLI behavior.
Python, Git, MSYS2 and Diamond are not required for the default FOSS backend.
The application includes our pinned patched openFPGALoader. On Windows the loader
is statically linked and imports only Windows system DLLs. Ubuntu bundles its
shared runtime libraries.

One-time USB setup:
Windows: first try uz_cpld scan --target dslot with the correct JTAG access state.
If the expected chain is detected, keep the existing driver. Otherwise close
Diamond and other programmer applications, then run:
  uz_cpld setup_foss_drivers
  uz_cpld doctor
  uz_cpld scan --target dslot
Approve the Windows administrator prompt. The included static libwdi helper
binds WinUSB to FT4232 channel B / Interface 1 only (0403:6011, MI_01).
It uses the WinUSB supplied by Windows, without WDK coinstaller binaries.
No additional download or manual driver selection is required. A, C and D stay
unchanged. If multiple programmers are present, use --device-id "ID" with an ID
printed by the command.

To use Diamond again:
  uz_cpld setup_diamond_driver
  uz_cpld scan --target dslot --programmer-backend diamond
This restores the saved original FTDI driver, or a compatible installed FTDI
package when the device was previously changed with Zadig. If no suitable package
is installed, install Diamond's cable drivers first. Removed original packages
must be installed again. Driver setup does not install Diamond itself.
Both setup commands support --dry-run 1 and skip an already matching binding.
If a restart is requested, restart Windows before programming.
Driver packages remain in Windows' driver store and may affect the default driver
for newly connected devices with the same hardware ID.
Doctor, scan and program do not change driver bindings.

Ubuntu: install the included 99-openfpgaloader.rules from
_internal/cpld_toolchain/bundled_tools/openFPGALoader/ into /etc/udev/rules.d/.
Create the plugdev group if absent, add your user to it, reload udev rules,
log out/in and reconnect USB. See docs/standalone.rst for commands.
The default FOSS path includes libusb and does not require Bash or Diamond.

Run in a terminal (use ./uz_cpld on Ubuntu or .\uz_cpld.exe in PowerShell):

  uz_cpld doctor
  uz_cpld firmware_list --included
  uz_cpld firmware_select --included
  uz_cpld init_programmer
  uz_cpld scan --target dslot
  uz_cpld identify --target dslot
  uz_cpld program --target dslot --dry-run 1
  uz_cpld program --target dslot

Use --included with a tool+firmware download. For a tool-only download:

  uz_cpld firmware_download
  uz_cpld firmware_select --firmware "path/to/uz-cpld-firmware.zip"

init_programmer guides release/program selection in a terminal.
An existing selection is preserved by default. Run init_programmer --override
to select assignments again and replace it, or use --selection PATH --override
to replace a specific selection. Cancellation/failure preserves the old file.
The final program command erases, programs and verifies Flash immediately when
all assignments are provided; there is no additional confirmation prompt.
Prepare the correct physical JTAG access state first. Use --target s3c for S3C.
The default FOSS probe is ft4232_b, index 0, at 1 MHz. Use --usb-serial SERIAL
for one probe when multiple FT4232 devices are connected.

Optional Diamond backend:
Install Diamond Programmer 3.14.0.75.2 and its cable drivers separately.
Ubuntu Diamond also requires Bash and libusb-1.0.
  uz_cpld programmer_path="C:\path\to\pgrcmd.exe"
  uz_cpld doctor --programmer-backend diamond
  uz_cpld program --target dslot --programmer-backend diamond
Diamond uses probe index 1 and requires Diamond-built JEDEC firmware.
The firmware build backend is independent of the programmer backend:
Diamond JEDEC can be flashed by FOSS; FOSS bitstreams require FOSS.

Use the global --workspace DIRECTORY before a command to choose a workspace.
Settings, selected firmware and slot assignments survive replacing the application.
Selection copies the verified ZIP into the workspace. Explicit relative paths are
relative to the terminal directory. Downloads do not change selected firmware.
CPLD_OPENFPGALOADER overrides bundled loader discovery and must have a matching
receipt. CPLD_PGRCMD overrides the saved Diamond executable.

Windows executables are unsigned. CI checks portable binaries without USB;
physical programming and USB driver compatibility require workstation acceptance.
Source and documentation: https://github.com/ultrazohm/uz_cpld
Upstream build guidance: https://trabucayre.github.io/openFPGALoader/guide/install.html
Application provenance: application.json; combined firmware provenance: bundle.json.
Loader provenance, upstream source, patch, license notices and runtime package
versions are in _internal/cpld_toolchain/bundled_tools/openFPGALoader/.

The static Windows loader also includes dependency sources, static archives and
object files for relinking; see RELINK.txt in its bundled_tools directory.

Licenses: our original code is Apache-2.0; third-party components retain their
own licenses. Read LICENSE, NOTICE, LICENSING.md and THIRD_PARTY_NOTICES.txt.
Keep licenses/ and sources/ and the native bundles' source/relinking files when
redistributing. licenses/inventory.json identifies runtime files and materials.
Use or redistribution of the Windows Microsoft runtime requires agreement to
licenses/WINDOWS-RUNTIME-TERMS.txt; these terms only apply to Microsoft's code.
