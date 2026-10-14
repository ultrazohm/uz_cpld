User guide
==========

The recommended path downloads published firmware binaries and programs them with Diamond Programmer, without local synthesis.
Choose firmware for your adapter wiring and a matching S3C/D-slot protocol; see :doc:`../releases`.
For an application with Python included and no checkout, use :doc:`../standalone`.

Quick start reference
---------------------

Install Git, Python 3.8+ for setup, and Diamond Programmer 3.14.0.75.2 with its cable drivers and runtime dependencies.
Linux also needs Bash, libusb-1.0 and USB device permissions; see :doc:`../environments` for USB/container setup or :doc:`../windows` for native Windows setup.
Run these commands in Bash or PowerShell::

   git clone https://github.com/ultrazohm/uz_cpld.git
   cd uz_cpld
   python -m cpld_toolchain setup

Use ``python3`` if Linux has no ``python`` command.
Setup downloads pinned uv and Python 3.10.12, installs locked dependencies into ``.venv``, and opens an activated shell with ``uz_cpld`` available.
Initial setup and firmware downloads require internet access.
In later shells, activate with ``source .venv/bin/activate`` in Bash or ``& .\.venv\Scripts\Activate.ps1`` in PowerShell.

Set ``CPLD_PGRCMD`` to your installed Programmer executable, adjusting the example path.
In Bash::

   export CPLD_PGRCMD="$HOME/lscc/programmer/diamond/3.14/bin/lin64/pgrcmd"

In PowerShell::

   $env:CPLD_PGRCMD = 'C:\lscc\programmer\diamond\3.14\bin\nt64\pgrcmd.exe'

For full Diamond installations, the executable is normally under ``programmer/bin/lin64`` or ``programmer/bin/nt64`` within the installation root.
Check discovery and download the newest published CI firmware for the checkout's branch::

   uz_cpld doctor
   uz_cpld firmware_download --output build/firmware.zip
   uz_cpld init_programmer --release heartbeat_cvg

``doctor`` reports tool discovery without testing the license or hardware.
The download validates the ZIP and checksums; it does not install Programmer or program hardware.
If your branch has no published firmware, explicitly choose a published branch with ``--branch master``; see :doc:`../publishing` for repository and authentication options.

Edit ``selection.toml`` for your adapters and a release present in the downloaded ZIP.
This example uses the ``heartbeat_cvg`` release and TX30 firmware in all five D-slots::

   release = "heartbeat_cvg"
   s3c = "s3c_heartbeat"

   [slots]
   "1" = "cvg_tx30"
   "2" = "cvg_tx30"
   "3" = "cvg_tx30"
   "4" = "cvg_tx30"
   "5" = "cvg_tx30"

``init_programmer`` preserves existing files, so always check the selection.
Slot numbers are physical JTAG chain positions.
Prepare the UltraZohm for D-slot JTAG access, then run::

   uz_cpld scan --target dslot
   uz_cpld program --target dslot --source zip --firmware build/firmware.zip

``program`` immediately erases, writes and verifies Flash, then checks firmware identity readback.
It validates the selected package and assignments before hardware access.
Both chains use FT4232 channel B; Diamond uses ``FTUSB-1``.
For S3C, change the hardware to its S3C JTAG access state and run::

   uz_cpld scan --target s3c
   uz_cpld program --target s3c --source zip --firmware build/firmware.zip

Add ``--dry-run 1`` to preview a programming command without validating firmware or contacting hardware.
To read identities later against the same package, use ``uz_cpld identify --target dslot --source zip --firmware build/firmware.zip`` (or ``--target s3c``).

Build firmware locally
----------------------

Install full Diamond 3.14.0.75.2 and its synthesis license only if you need local builds.
Set ``DIAMOND_ROOT`` to the installation directory; see :doc:`../environments` or :doc:`../windows`.
After editing ``selection.toml``::

   uz_cpld build_selection
   uz_cpld program --target dslot

``build_selection`` builds each distinct assignment once.
Programming defaults to local firmware and requires current successful builds; it never builds automatically.
Use ``--target s3c`` after preparing the S3C chain.
See :doc:`../quick-start` to author programs, :doc:`../commands` for command options, and :doc:`../programmer` for programming details.
