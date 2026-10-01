Native Windows setup
====================

The primary repository interface is ``python -m toolchain`` on Windows and
Linux. Run it from the checkout root with Python 3.10 or later. GNU Make,
Bash and Docker are not needed for native VHDL generation, Diamond builds,
or Diamond programming. The Makefile remains an optional Linux wrapper.

See :doc:`tool-environments` for the workflow and environment matrix.

Install Python and Git, and install the Windows edition of Diamond matching
the version in ``toolchain/targets/*/target.toml`` (currently 3.14.0.75.2).
Install Diamond's programming cable drivers and configure its license.
The Python environment does not install Diamond or its drivers.
See the `Diamond downloads and installation guides
<https://www.latticesemi.com/Diamond>`_.

Python environment
------------------

From PowerShell in the checkout::

   python -m toolchain venv

This creates or updates ``.venv``, installs the standalone generator and native
workflow Python dependencies, and opens PowerShell with the environment
activated. Type ``exit`` to return to the original terminal. Without an
interactive terminal, setup prints an activation command instead.

To stay in the current PowerShell session::

   python -m toolchain venv --activate 0
   & .\.venv\Scripts\Activate.ps1

Activation is subject to your PowerShell execution policy. If scripts are
restricted, use ``.\.venv\Scripts\python.exe`` in place of ``python`` below;
activation is optional when using that interpreter directly. Setup does not
change the execution policy. Recreate the virtual environment when moving
between Windows and Linux; their environments are not interchangeable.

Configure Diamond
-----------------

Set the installation root in the same terminal::

   $env:DIAMOND_ROOT = 'C:\lscc\diamond\3.14'
   # Optional extra license file or floating server:
   $env:LM_LICENSE_FILE = 'C:\licenses\diamond.lic'
   python -m toolchain doctor

Adjust these example paths to your installation. The default root is
``C:/lscc/diamond/3.14``. The launcher looks for ``bin/nt64/pnmainc.exe`` for
builds and ``bin/nt64/pnmain.exe`` for the GUI. Programmer discovery checks
``programmer/bin/nt64/pgrcmd.exe`` and ``bin/nt64/pgrcmd.exe``. If no root is
specified it also checks PATH. ``DIAMOND_CLI``, ``DIAMOND_GUI`` and
``CPLD_PGRCMD`` override the individual executables; supply an executable path,
not a command with arguments. Windows launchers must be ``.exe`` files.

The launcher supplies Diamond and foundry DLL paths, ``FOUNDRY``, and the
installation's ``license/license.dat`` when present, preserving any additional
``LM_LICENSE_FILE`` entries. The launcher and environment conventions follow
Lattice's `Scripting Lattice FPGA Build Flow
<https://www.latticesemi.com/view_document?document_id=54075>`_.
``doctor`` lists installed and missing tools plus catalog state. It does not
start Diamond or validate a license; a successful build is still required to
validate synthesis, licensing and firmware exports. See :doc:`commands` for
the report states and exit behavior.

Generate and build
------------------

For an existing program::

   python -m toolchain list
   python -m toolchain build --program tx30
   python -m toolchain build-all

To create a CSV-based program::

   python -m toolchain new --name my_slot --template generator
   # Edit the new program's routing.csv and generator.toml.
   python -m toolchain generate --program cvg_my_slot
   python -m toolchain build --program cvg_my_slot

Use ``--release-cycle NAME`` when selecting a cycle other than the repository
current cycle. Generated manifests use forward slashes, and generated files
use UTF-8 with LF line endings. Git attributes preserve tracked bytes across
platforms because generation receipts hash the exact source contents.
Rebuild firmware on the programming station: existing build receipts and
XCFs may contain machine-specific paths and tool identities.

Program hardware
----------------

Create and edit the selection, then inspect the connected D-slot chain::

   python -m toolchain init
   # Edit selection.toml.
   python -m toolchain scan --target dslot
   python -m toolchain identify --target dslot
   python -m toolchain program --target dslot --dry-run 1

After checking the selection and preparing the hardware::

   python -m toolchain program --target dslot

The last command erases, programs and verifies Flash. Use ``--target s3c`` only
when the hardware is prepared for S3C access. The selection's programs must
have successful, current Diamond builds. Source hashes, firmware snapshots,
JTAG checks and post-programming USERCODE readback remain mandatory.
``--dry-run 1`` only previews the command; it does not validate firmware or
contact hardware. ``programmer-project`` exports XCFs without accessing USB.

Windows uses the installed vendor driver and invokes ``pgrcmd.exe`` directly.
Linux-only USB bus checks and FTDI driver detachment are not used on Windows.
Concurrent managed Diamond USB operations are serialized. Confirm the actual
programmer port with a read-only scan: the existing managed identity/programming
mapping is ``FTUSB-1`` and must be validated on the Windows station.

Scope and validation
--------------------

Native Windows support covers the Python CLI, generator and Diamond workflow.
The FOSS compiler/source-build installers remain Linux tools. FOSS builds,
simulation and documentation retain their container defaults; the Windows
host runner omits Unix user/group flags and requires a Linux Docker engine
with access to the checkout. Native FOSS hardware drivers and programming are
outside the Windows validation scope.

``python -m toolchain test`` on Windows runs the native Python suite without
Make, Bash or Linux HDL tools. Windows CI uses this same command. It checks
generation, shared/exclusive
process locks, concurrent identity allocation and mocked programmer behavior.
It does not install licensed Diamond or connect physical hardware. Before
using a Windows station, validate one Diamond build, scan, identity read and
program/verify cycle there. The implementation was developed and regression
tested on Linux; Windows CI and vendor/hardware results must be reviewed on
Windows before claiming end-to-end validation.

``clean-all`` preserves the virtual environment when its Python interpreter
is currently running the command. Exit that environment before deleting it.

Use ``python -m toolchain help`` or
``python -m toolchain help --command ACTION`` for the available arguments.
