Native Windows setup
====================

The primary interface after setup is ``uz_cpld`` on Windows and Linux.
Use ``python -m cpld_toolchain setup`` from a fresh checkout to install and activate it.
Run setup from the checkout root with Python 3.8 or later; setup downloads the selected modern Python as needed.
GNU Make, Bash and Docker are not needed for native VHDL generation, Diamond builds, or Diamond programming.
The Makefile remains an optional Linux wrapper.

See :doc:`tool-environments` for the workflow and environment matrix.

Install Python and Git, and install the Windows edition of Diamond matching the version in ``cpld_toolchain/toolchain/targets/*/target.toml`` (currently 3.14.0.75.2).
Install Diamond's programming cable drivers and configure its license.
The Python environment does not install Diamond or its drivers.
See the `Diamond downloads and installation guides <https://www.latticesemi.com/Diamond>`_.

Python environment
------------------

From PowerShell in the checkout::

   python -m cpld_toolchain setup

This creates or updates ``.venv``, installs the editable project and all locked Python dependencies, and opens PowerShell with the environment activated.
Type ``exit`` to return to the original terminal.
Without an interactive terminal, setup prints an activation command instead.

To stay in the current PowerShell session::

   python -m cpld_toolchain setup --activate 0
   & .\.venv\Scripts\Activate.ps1

Activation is subject to your PowerShell execution policy.
If scripts are restricted, use ``.\.venv\Scripts\python.exe`` in place of ``python`` below; activation is optional when using that interpreter directly.
Setup does not change the execution policy.
Recreate the virtual environment when moving between Windows and Linux; their environments are not interchangeable.

Configure Diamond
-----------------

Set the installation root in the same terminal::

   $env:DIAMOND_ROOT = 'C:\lscc\diamond\3.14'
   # Optional extra license file or floating server:
   $env:LM_LICENSE_FILE = 'C:\licenses\diamond.lic'
   uz_cpld doctor

Adjust these example paths to your installation.
``DIAMOND_ROOT`` names the installation directory, not ``bin\nt64`` or an executable.
Check the current PowerShell setting and build executable::

   echo $env:DIAMOND_ROOT
   Test-Path "$env:DIAMOND_ROOT\bin\nt64\pnmainc.exe"

``$env:DIAMOND_ROOT`` applies to this terminal and its child processes.
To save the current value for future Windows sessions, run this in PowerShell::

   [Environment]::SetEnvironmentVariable('DIAMOND_ROOT', $env:DIAMOND_ROOT, 'User')

Restart the terminal application (and VS Code if using its integrated terminal) to inherit the saved value.
In Command Prompt (``cmd.exe``), the equivalent current-session commands are::

   set "DIAMOND_ROOT=C:\lscc\diamond\3.14"
   echo %DIAMOND_ROOT%

The default root is ``C:/lscc/diamond/3.14``.
The launcher looks for ``bin/nt64/pnmainc.exe`` for builds and ``bin/nt64/pnmain.exe`` for the GUI.
Programmer discovery checks ``programmer/bin/nt64/pgrcmd.exe`` and ``bin/nt64/pgrcmd.exe``.
If no root is specified it also checks PATH.
``DIAMOND_CLI``, ``DIAMOND_GUI`` and ``CPLD_PGRCMD`` override the individual executables; supply an executable path, not a command with arguments.
Windows launchers must be ``.exe`` files.

The launcher supplies Diamond and foundry DLL paths, ``FOUNDRY``, and the installation's ``license/license.dat`` when present, preserving any additional ``LM_LICENSE_FILE`` entries.
The launcher and environment conventions follow Lattice's `Scripting Lattice FPGA Build Flow <https://www.latticesemi.com/view_document?document_id=54075>`_.
``doctor`` lists installed and missing tools plus catalog state.
It does not start Diamond or validate a license; a successful build is still required to validate synthesis, licensing and firmware exports.
See :doc:`commands` for the report states and exit behavior.

Generate and build
------------------

For an existing program::

   uz_cpld list
   uz_cpld build --program cvg_tx30 --release-cycle heartbeat_cvg
   uz_cpld build_all

To create a CSV-based program::

   uz_cpld new --name my_slot --template generator
   # Edit the new program's routing.csv and generator.toml.
   uz_cpld generate --program cvg_my_slot
   uz_cpld build --program cvg_my_slot

Use ``--release-cycle NAME`` when selecting a cycle other than the repository current cycle.
Generated manifests use forward slashes, and generated files use UTF-8 with LF line endings.
Git attributes preserve tracked bytes across platforms because generation receipts hash the exact source contents.
For ``source=local``, rebuild firmware on the programming station: existing build receipts and XCFs may contain machine-specific paths and tool identities.
Alternatively, use a published release ZIP as described below.

Program hardware
----------------

Create and edit the selection, then inspect the connected D-slot chain::

   uz_cpld init_programmer
   # Edit selection.toml.
   uz_cpld build_selection
   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1

After checking the selection and preparing the hardware::

   uz_cpld program --target dslot

The last command erases, programs and verifies Flash.
Use ``--target s3c`` only when the hardware is prepared for S3C access.
With the default ``source=local``, the selection's programs must have successful, current Diamond builds.
Source hashes, firmware snapshots, JTAG checks and post-programming USERCODE readback remain mandatory.
``--dry-run 1`` only previews the command; it does not validate firmware or contact hardware.
``diamond_xcf_programming_chain`` exports XCFs without accessing USB.

To program a downloaded release without local builds::

   uz_cpld program --target dslot --source zip --firmware C:\releases\uz-cpld-firmware.zip

Select programs and a release cycle present in the archive using ``selection.toml``.
The ZIP's manifest and registry supply the firmware checksums and expected identities;
the local registry is preserved. See :doc:`programmer` for ZIP validation and backend rules.
This option still requires the installed programmer and its cable driver.

Windows uses the installed vendor driver and invokes ``pgrcmd.exe`` directly.
Linux-only USB bus checks and FTDI driver detachment are not used on Windows.
Concurrent managed Diamond USB operations are serialized.
Confirm the actual programmer port with a read-only scan: the existing managed identity/programming mapping is ``FTUSB-1`` and must be validated on the Windows station.

Scope and validation
--------------------

Native Windows support covers the Python CLI, generator and Diamond workflow.
The FOSS compiler/source-build installers remain Linux tools.
All commands use the current environment; enter the Linux toolchain container explicitly for workflows whose tools are unavailable natively.
Native FOSS hardware drivers and programming are outside the Windows validation scope.

``uz_cpld test`` on Windows runs the native Python suite without Make, Bash or Linux HDL tools.
Windows CI uses this same command.
It checks generation, shared/exclusive process locks, concurrent identity allocation and mocked programmer behavior.
It does not install licensed Diamond or connect physical hardware.
Before using a Windows station, validate one Diamond build, scan, identity read and program/verify cycle there.
The implementation was developed and regression tested on Linux; Windows CI and vendor/hardware results must be reviewed on Windows before claiming end-to-end validation.

``clean_all`` preserves the virtual environment when its Python interpreter is currently running the command.
Exit that environment before deleting it.

Use ``uz_cpld help`` or ``uz_cpld help --command ACTION`` for the available arguments.

Troubleshooting Windows installations
-------------------------------------

A standalone Lattice Programmer installation does not contain the synthesis and build tools.
Point the programmer override at its actual executable::

   $env:CPLD_PGRCMD = 'C:\path\to\programmer\bin\nt64\pgrcmd.exe'
   uz_cpld doctor

The report can show Programmer as FOUND and the Diamond build CLI as MISSING.
Generation needs Python only; ``build`` and ``build_all`` require full Diamond.
Managed programming with ``source=local`` still requires the current build artifacts and provenance described above.
For a Programmer-only station, use ``source=zip`` with a published release archive.
Copying a JEDEC file alone does not satisfy the managed checks.

``DIAMOND_ROOT`` must name an existing installation.
Setting it to a 3.14 path does not install or upgrade Diamond 3.13.
The repository currently requires 3.14.0.75.2; an older installation is not accepted merely because it starts.
Build commands check vendor installation metadata and CLI startup before starting builds.
``build_all`` performs this shared check once.
If version metadata is unavailable, the full version is still checked in every build log.
Startup failures include the vendor's license error.
``doctor`` reads version metadata without starting Diamond or testing its license.

Use ``uz_cpld build_all`` (one action with an underscore), not ``uz_cpld build -all``.

``Generation inputs changed`` is a repository provenance issue, independent of whether Diamond or Programmer is installed.
The message alone does not identify whether the cause is edited inputs, a generator update or changed checkout bytes.
Review ``git status`` and your intended generator inputs, then regenerate the affected program, for example::

   uz_cpld generate --program cvg_optical_14tx_4rx --release-cycle heartbeat_cvg
   uz_cpld check --program cvg_optical_14tx_4rx --release-cycle heartbeat_cvg

Review the generated diff.
Regeneration refreshes generated outputs and their receipt; it does not install missing tools.
Avoid deleting receipts or weakening version checks to suppress these diagnostics.
