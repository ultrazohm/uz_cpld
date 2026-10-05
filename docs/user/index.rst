User guide
==========

Run commands from the repository root with Python 3.8+ for setup (``python3`` on Linux if ``python`` is unavailable).
Use firmware for your adapter wiring and a matching S3C/D-slot protocol; compare the available :doc:`releases </releases>` before selecting programs.
The example below uses ``heartbeat_cvg``.

Quick start reference
---------------------

Install Diamond 3.14.0.75.2, its license and programming cable drivers, then create the Python environment::

   python -m cpld_toolchain setup

Setup downloads uv and Python 3.10.12 as needed, installs all locked Python dependencies into ``.venv``, and opens an activated shell with ``uz_cpld`` available.
Internet access is required for initial downloads.
In a new Bash shell, run ``source .venv/bin/activate``; in PowerShell, run ``& .\.venv\Scripts\Activate.ps1``.
Use ``--activate 0`` to install without opening a shell.
Set ``DIAMOND_ROOT`` in the activated terminal to your actual Diamond installation directory, not its ``bin`` directory or an executable.
The following are example paths; adjust them to match your installation.

On Ubuntu (Bash)::

   export DIAMOND_ROOT="$HOME/lscc/diamond/3.14"
   echo "$DIAMOND_ROOT"
   ls "$DIAMOND_ROOT/bin/lin64/diamondc"

Bash uses ``export NAME=value`` to make a variable available to commands started from that shell.
``set DIAMOND_ROOT=...`` sets a positional argument instead of the environment variable.
Use ``$HOME`` inside double quotes: ``"~/lscc/diamond/3.14"`` contains a literal ``~`` and will not resolve to your home directory.
To keep this setting for new interactive Bash terminals, add the same ``export`` line to ``~/.bashrc`` and run ``source ~/.bashrc``.
The native Linux default, when no root is set, is ``/opt/diamond``.

On Windows (PowerShell)::

   $env:DIAMOND_ROOT = 'C:\lscc\diamond\3.14'
   echo $env:DIAMOND_ROOT
   Test-Path "$env:DIAMOND_ROOT\bin\nt64\pnmainc.exe"

For Windows Command Prompt (``cmd.exe``), use its own syntax::

   set "DIAMOND_ROOT=C:\lscc\diamond\3.14"
   echo %DIAMOND_ROOT%

These Windows assignments apply to the current terminal and commands started from it.
For a persistent user setting, see :doc:`../windows`.
The native Windows default is ``C:/lscc/diamond/3.14``.

A path such as ``$HOME/lscc/programmer/diamond/3.14`` may be a standalone Programmer installation.
Check that the build executable shown above exists: ``build`` and ``build-all`` require full Diamond; standalone Programmer only provides programming tools.
For licensing, container paths and USB access, see :doc:`../windows` or :doc:`../environments`.

Check discovery after setting the path::

   uz_cpld doctor
   uz_cpld list --release-cycle heartbeat_cvg

``doctor`` reports available tools; it does not test the license or hardware and missing tools do not make it fail.

Build the programs you need and create your selection::

   uz_cpld build --program cvg_tx30 --release-cycle heartbeat_cvg
   uz_cpld build --program s3c_heartbeat --release-cycle heartbeat_cvg
   uz_cpld init

Edit ``selection.toml`` to match your adapters (this example uses TX30 in all five slots)::

   release = "heartbeat_cvg"
   s3c = "s3c_heartbeat"

   [slots]
   "1" = "cvg_tx30"
   "2" = "cvg_tx30"
   "3" = "cvg_tx30"
   "4" = "cvg_tx30"
   "5" = "cvg_tx30"

``init`` preserves an existing file; its template defaults must be edited for this release.
Build every distinct selected program in the same release before programming.
Build commands do not read ``selection.toml``.

Prepare the UltraZohm for D-slot JTAG access, then run::

   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1
   uz_cpld program --target dslot

``program`` immediately erases, writes and verifies Flash, including firmware identity readback.
``--dry-run 1`` only previews the command; firmware freshness and hardware checks happen during execution.
To program S3C, change the UltraZohm to its S3C access state and use ``--target s3c``.
Both targets use FT4232 channel B; Diamond defaults to ``FTUSB-1``.

Useful commands
---------------

::

   uz_cpld release-list
   uz_cpld build-all --release-cycle heartbeat_cvg
   uz_cpld report --release-cycle heartbeat_cvg
   uz_cpld programmer-project
   uz_cpld help --command program

``programmer-project`` optionally exports both Diamond XCF files and requires all six assignments and current builds.
CLI programming creates its own project, so this export is optional.

Diamond firmware uses ``.jed`` files; FOSS firmware uses ``.bit`` files.
``--backend foss`` selects FOSS for builds and programming where the program supports it.
To program Diamond firmware using FOSS tools, use ``--programmer-backend foss``.
FOSS programming requires the repository's patched openFPGALoader and OpenOCD; see :doc:`../firmware-identity`.

Simulation and successful exports do not establish board timing or hardware qualification.
See :doc:`../s3c` for controller compatibility and :doc:`../validation` for verification limits.
Detailed options are in :doc:`../commands` and :doc:`../programmer`.
