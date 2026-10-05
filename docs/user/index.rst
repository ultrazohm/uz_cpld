User guide
==========

Run commands from the repository root with Python 3.10+ (``python3`` on Linux if ``python`` is unavailable).
Use firmware for your adapter wiring and a matching S3C/D-slot protocol; the example below uses the heartbeat release.

Quick start reference
---------------------

Install Diamond 3.14.0.75.2, its license and programming cable drivers, then create the Python environment::

   python -m cpld_toolchain venv
   python -m cpld_toolchain doctor
   python -m cpld_toolchain list --release-cycle heartbeat_cvg

``venv`` opens an activated shell when run interactively.
It installs Python dependencies only.
For installation paths, licensing and USB access, see :doc:`../windows` or :doc:`../environments`.
``doctor`` reports available tools; it does not test the license or hardware and missing tools do not make it fail.

Build the programs you need and create your selection::

   python -m cpld_toolchain build --program cvg_tx30 --release-cycle heartbeat_cvg
   python -m cpld_toolchain build --program s3c_heartbeat --release-cycle heartbeat_cvg
   python -m cpld_toolchain init

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

   python -m cpld_toolchain scan --target dslot
   python -m cpld_toolchain identify --target dslot
   python -m cpld_toolchain program --target dslot --dry-run 1
   python -m cpld_toolchain program --target dslot

``program`` immediately erases, writes and verifies Flash, including firmware identity readback.
``--dry-run 1`` only previews the command; firmware freshness and hardware checks happen during execution.
To program S3C, change the UltraZohm to its S3C access state and use ``--target s3c``.
Both targets use FT4232 channel B; Diamond defaults to ``FTUSB-1``.

Useful commands
---------------

::

   python -m cpld_toolchain release-list
   python -m cpld_toolchain build-all --release-cycle heartbeat_cvg
   python -m cpld_toolchain report --release-cycle heartbeat_cvg
   python -m cpld_toolchain programmer-project
   python -m cpld_toolchain help --command program

``programmer-project`` optionally exports both Diamond XCF files and requires all six assignments and current builds.
CLI programming creates its own project, so this export is optional.

Diamond firmware uses ``.jed`` files; FOSS firmware uses ``.bit`` files.
``--backend foss`` selects FOSS for builds and programming where the program supports it.
To program Diamond firmware using FOSS tools, use ``--programmer-backend foss``.
FOSS programming requires the repository's patched openFPGALoader and OpenOCD; see :doc:`../firmware-identity`.

Simulation and successful exports do not establish board timing or hardware qualification.
See :doc:`../s3c` for controller compatibility and :doc:`../validation` for verification limits.
Detailed options are in :doc:`../commands` and :doc:`../programmer`.
