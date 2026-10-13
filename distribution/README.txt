UltraZohm CPLD programmer (standalone CLI)

Windows 11 x64 / Ubuntu 24.04 x64.
Extract the complete archive before use; the executable needs its _internal directory.
Python, Git, MSYS2 and Diamond are not required for the default FOSS backend.
The application includes our pinned patched openFPGALoader and runtime libraries.

One-time USB setup:
Windows: use Zadig (https://zadig.akeo.ie/), Options > List All Devices, and select
ONLY the UltraZohm FT4232 channel B / Interface 1 (USB VID 0403, PID 6011,
interface MI_01). Install WinUSB for that interface. Verify the device and
interface in Device Manager before changing the driver. Leave channels A, C and
D with their existing drivers. Restoring the FTDI/vendor driver on Interface 1
is necessary before using Diamond on that interface again.
No driver is installed or replaced automatically by this application.

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
