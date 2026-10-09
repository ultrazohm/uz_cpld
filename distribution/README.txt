UltraZohm CPLD programmer (standalone CLI)

Windows 11 x64 / Ubuntu 24.04 x64.
Extract the complete archive before use.
Python and Git are not required.
Install Diamond Programmer 3.14.0.75.2 and its cable drivers separately.
Ubuntu also needs Bash and libusb-1.0.

Run in a terminal (use ./uz_cpld on Ubuntu or .\uz_cpld.exe in PowerShell):

  uz_cpld --version
  uz_cpld programmer_path="C:\path\to\pgrcmd.exe"
  uz_cpld doctor
  uz_cpld firmware_download
  uz_cpld firmware_list --firmware "path/to/uz-cpld-firmware.zip"
  uz_cpld firmware_select --firmware "path/to/uz-cpld-firmware.zip"

For a tool+firmware download, use instead:

  uz_cpld firmware_list --included
  uz_cpld firmware_select --included

Then create/edit selection.toml in the workspace printed by doctor:

  uz_cpld init_programmer
  uz_cpld scan --target dslot
  uz_cpld identify --target dslot
  uz_cpld program --target dslot --dry-run 1
  uz_cpld program --target dslot

The final command immediately erases, programs and verifies Flash.
There is no confirmation prompt.
Prepare the correct physical JTAG access state first.
Use --target s3c for S3C.
Program/release names come from firmware_list.

The default download is the newest published CI firmware from master in https://github.com/ultrazohm/uz_cpld.
Override with --git-url and/or --branch.
Downloads do not change the selected firmware or slot assignments.

Use the global --workspace DIRECTORY before a command to choose another workspace.
Explicit file paths are relative to the terminal directory.
Selection copies the verified ZIP into the workspace.
Settings and selected firmware survive replacing the application folder or deleting a download.
programmer_path=auto clears the saved executable; CPLD_PGRCMD overrides it.

Source and documentation: https://github.com/ultrazohm/uz_cpld

Application provenance is in application.json; combined bundle provenance is in bundle.json.
The firmware ZIP retains its own manifest and checksums.
The CLI uses Diamond installed on the system; no vendor tool is redistributed.
