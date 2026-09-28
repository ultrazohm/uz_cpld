Programming CPLDs
=================

Run these commands from the repository inside the USB-enabled devcontainer.
``programmer_backend=diamond`` is the default programming and scan tool. The container user needs permission to open
the USB device; see :doc:`environments`. Diamond also requires the mounted Linux
installation and license.

The UltraZohm must be in different physical states for S3C and D-slot access.
Prepare it for one target at a time and change its physical state before
accessing the other target.

Create and edit the selection
-----------------------------

Run::

   make programmer

This creates ``selection.toml`` in the current directory and preserves an
existing file. New files contain these editable defaults::

   release = ""
   build_backend = "diamond"
   s3c = "s3c_power_on_debounce"

   [slots]
   "1" = "tx30"
   "2" = "tx30"
   "3" = "tx30"
   "4" = "tx30"
   "5" = "tx30"

``release = ""`` (or an omitted field) uses the current release from
``programs/releases.toml``. Set ``release = "NAME"`` to select another release.
The command-line ``release_cycle=NAME`` takes precedence over the file.
Programming and XCF export use this release for every selected program.
Discover available releases and programs with::

   make release-list
   make list
   make list release_cycle=NAME

Fill ``s3c`` for S3C programming, or all five slots for D-slot programming.
The unused target can remain blank or be omitted. Slot numbers are physical
JTAG positions, not catalog order. XCF export requires all six assignments.

Use ``make programmer selection=FILE`` to create a template at a custom path.
Pass ``selection=FILE`` to programming or XCF export to use that file.

Choose the build and programmer independently
---------------------------------------------

``build_backend = "diamond"`` or ``"foss"`` in ``selection.toml`` selects the
existing firmware builds to use. It defaults to ``diamond`` when omitted.
The command-line ``build_backend=NAME`` overrides the file. This setting applies
to all selected programs, independently of the programming tool.

``programmer_backend=diamond|foss`` on programmer commands selects the hardware
tool: Lattice Programmer or openFPGALoader. Its default is ``diamond``.

.. list-table:: Supported combinations
   :header-rows: 1

   * - Build backend
     - Programmer backend
     - Firmware used
   * - ``diamond``
     - ``diamond``
     - Diamond ``.jed`` through an XCF
   * - ``diamond``
     - ``foss``
     - Diamond ``.jed`` directly through openFPGALoader
   * - ``foss``
     - ``foss``
     - FOSS ``.bit`` through openFPGALoader

FOSS builds with the Diamond programmer are unsupported. The helper rejects
that combination before contacting hardware. It never substitutes builds from
another backend.

For example, with ``build_backend = "diamond"`` in the selection file::

   make build program=tx30 backend=diamond
   make programmer program target=dslot programmer_backend=foss dry_run=1
   make programmer program target=dslot programmer_backend=foss

To use FOSS builds for one invocation instead::

   make programmer program target=dslot programmer_backend=foss build_backend=foss

Build those programs with ``make build program=NAME backend=foss`` first.
The firmware build commands continue to use ``backend=``. For programmer
commands, the old ``backend=`` option is rejected with guidance to use the
explicit ``programmer_backend=`` and ``build_backend=`` names.

Scan the connected chain
------------------------

Read JTAG IDs with Diamond::

   # D-slots are the default target.
   make programmer scan

   # Change the UltraZohm physical state before accessing S3C.
   make programmer scan target=s3c

Or use FOSS::

   make programmer scan target=dslot programmer_backend=foss
   # Change the UltraZohm physical state before accessing S3C.
   make programmer scan target=s3c programmer_backend=foss

Scans execute immediately and require neither a selection file nor firmware
builds. They ignore the release and build-backend settings. Add ``dry_run=1`` to preview the scan
without contacting hardware. Diamond checks IDs against the expected chain;
FOSS reports the devices it discovers.

.. list-table:: Expected JTAG chains
   :header-rows: 1

   * - Target
     - Devices
     - ID code per device
   * - ``dslot``
     - Five LCMXO2-2000HC
     - ``0x012BB043``
   * - ``s3c``
     - One LCMXO2-4000HC
     - ``0x012BC043``

Build the selected firmware
---------------------------

Programming requires successful, current builds for the selected
``build_backend``, regardless of the programmer tool.
With the default selection, build each distinct program once::

   make build program=tx30 backend=diamond
   make build program=s3c_power_on_debounce backend=diamond

When selecting ``build_backend = "foss"``, use ``backend=foss`` on each build
instead. Build any other programs chosen in the selection file in the same way.

**Build commands do not read selection.toml.** If its release differs from the
repository default, pass the same ``release_cycle=NAME`` to each build::

   make build program=tx30 backend=diamond release_cycle=NAME
   make build program=s3c_power_on_debounce backend=diamond release_cycle=NAME

``make program=NAME`` remains the firmware-build shortcut. Programming commands
do not automatically build firmware and reject missing or stale build evidence.

Preview and program Flash
-------------------------

Validate the selection and print a plan without contacting hardware::

   make programmer program target=dslot dry_run=1
   make programmer program target=s3c dry_run=1

Program D-slots with Diamond::

   make programmer program target=dslot

After changing the UltraZohm to its S3C access state, program S3C::

   make programmer program target=s3c

The default ``s3c_power_on_debounce`` firmware uses the normal programming
command with no program-specific override. Build freshness, artifact hashes,
board compatibility and JTAG chain checks still apply.

To use the FOSS programmer with the selected builds, use::

   make programmer program target=dslot programmer_backend=foss
   # Change the UltraZohm physical state before programming S3C.
   make programmer program target=s3c programmer_backend=foss

These commands **immediately erase, program, and verify Flash**. Programming
requires an explicit target and only operates on that target. The Diamond programmer uses Diamond
``.jed`` builds. The FOSS programmer uses Diamond ``.jed`` or FOSS ``.bit``
builds according to ``build_backend``. There is no SRAM programming mode.
``execute=0`` is also accepted as a preview, equivalent to ``dry_run=1``.

A custom selection and release can be supplied together::

   make programmer program target=dslot selection=my_selection.toml release_cycle=NAME

Generating Lattice Programmer projects
--------------------------------------

``programmer_helper`` generates separate five-device D-slot and one-device S3C XCF files from published Diamond JEDEC exports. Its programming command can erase, program and verify device Flash through Diamond Programmer or openFPGALoader.

Review the six assignments in ``selection.toml``, then run::

   make programmer lattice_xcf

Or use a custom selection file::

   make programmer lattice_xcf selection=my_programmer_selection.toml

To build the selected Diamond firmware before exporting::

   make programmer lattice_xcf rebuild=1

The TOML file has top-level ``release`` and ``s3c`` fields and a ``[slots]`` table with keys ``"1"`` through ``"5"``. Each program name is resolved within the selected release. ``make programmer lattice_xcf`` defaults to ``selection.toml`` and requires all six assignments. It validates board compatibility and checks that each Diamond JEDEC matches a successful, current build. Add ``rebuild=1`` to rebuild the selected Diamond programs before those checks. Project generation does not contact hardware.

Release selection follows command-line ``release_cycle``, then TOML ``release``, then the repository's current release. All selected programs come from that cycle.

The generated files are ``toolchain/build/programmer/<release_cycle>/dslots.xcf``, ``s3c.xcf`` and ``selection.json``. The receipt records the chosen programs and SHA-256 hashes of the JEDEC and XCF files. The helper copies device positions and programming options from the archived XCFs, replaces each JEDEC path, time, fuse checksum and usercode, and removes archived USB serial numbers. Both generated chains default to USB2 port ``FTUSB-1``, matching the verified UltraZohm connection; confirm the port on your programming station. The generated XCFs contain absolute paths and must be regenerated after moving the checkout or rebuilding the firmware.

Open the XCFs in Lattice Programmer to inspect or program each chain manually.
Their configured operation is ``FLASH Erase,Program,Verify``. Generating the
files does not perform that operation. The CLI's ``make programmer program``
generates its own target-specific XCF, so running ``make programmer lattice_xcf`` first is optional.
XCF export requires ``programmer_backend=diamond`` and
``build_backend=diamond``. A selection file choosing FOSS builds is rejected;
use ``make programmer lattice_xcf build_backend=diamond`` to explicitly export
the Diamond builds instead. ``rebuild=1`` rebuilds those Diamond programs.

Backend execution details
-------------------------

Diamond runs ``pgrcmd`` on a generated XCF. FOSS runs openFPGALoader with
``--write-flash --verify`` on the selected builds. It accepts Diamond JEDEC files
as supported by the `openFPGALoader Lattice implementation
<https://github.com/trabucayre/openFPGALoader/blob/master/src/lattice.cpp>`_,
and continues to use bitstreams for FOSS builds.

``make programmer scan`` reads IDs and ``make programmer program`` writes Flash; both execute by default. Use ``dry_run=1`` for a preview. FOSS uses openFPGALoader ``--detect`` and reports the ID codes it sees, including unexpected devices. Diamond makes a temporary XCF containing only ``FLASH Display ID`` operations and runs ``pgrcmd``; its output and the exact XCF are retained under ``toolchain/build/programmer/scans/``. Diamond uses the archived expected chain positions, so its result is an ID check against that chain rather than unrestricted chain discovery. Neither scan command needs firmware builds or a selection file. For programming, the FOSS path first scans and checks the entire JTAG chain: five 2000HC devices at indices 0–4 for D-slots, or one 4000HC at index 0 for S3C. It stops before writing if the scan does not match. The Diamond path generates an XCF for only the selected chain under ``toolchain/build/programmer/<cycle>/<chain>/`` and applies ``probe_index`` to its USB2 port. It uses the device and position checks built into that XCF. The separate ``make programmer lattice_xcf`` command generates both XCFs and requires all six assignments.

Connection defaults and overrides
---------------------------------

.. list-table:: Current backend defaults for both targets
   :header-rows: 1

   * - Setting
     - Diamond
     - FOSS
   * - Connection
     - ``FTUSB-1``
     - ``ft4232_b``, USB probe index ``0``
   * - FTDI channel
     - B / USB interface 1
     - B / USB interface 1
   * - JTAG clock
     - ``TCKDelay=3``; observed 7.5 MHz on this station
     - 1 MHz

FOSS defaults to ``ft4232_b`` (FT4232 channel B) and USB probe index 0 for both targets. Both physical CPLD chains use the same programmer; change the UltraZohm physical state between targets. The defaults are ``DEFAULT_FOSS_CABLE`` and ``DEFAULT_FOSS_PROBE_INDEX`` in ``programmer_helper/program.py``. These openFPGALoader probe indices do not necessarily match Diamond's ``FTUSB-N`` ports, which can enumerate interfaces of a single FTDI chip. Confirm with the scan on your station; for FOSS, use ``probe_index=N`` or ``usb_serial=SERIAL`` to select a probe and ``cable=NAME`` to select the cable type and channel. Diamond uses ``FTUSB-1`` for both chains. The automatic detach mapping is fixed to that port and USB interface 1; a different ``probe_index`` requires updating the mapping constants described below. A past cycle can be chosen with ``release_cycle=NAME``. The selected build backend must have successful, current builds for the selected programs. Programming writes logs and a ``result.json`` receipt under ``toolchain/build/programmer/<cycle>/runs/`` for FOSS and ``toolchain/build/programmer/<cycle>/<chain>/runs/`` for Diamond.

On the UltraZohm FT4232 with serial ``0100206000050``, both commands below read the S3C ``LCMXO2-4000HC`` ID ``0x012BC043`` in a live container check::

   make programmer scan target=s3c programmer_backend=foss cable=ft4232_b usb_serial=0100206000050
   make programmer scan target=s3c programmer_backend=diamond probe_index=1

Here, FOSS uses FT4232 channel B and Diamond uses ``FTUSB-1``. The old archived S3C port ``FTUSB-0`` returned an all-zero ID on this setup, so generated XCFs and scans now default to ``FTUSB-1``. ``FLASH Display ID`` is the MachXO2 operation name; the generic ``Display ID`` is rejected by Diamond. Despite its name, ``FLASH Display ID`` only reads the ID and does not program Flash.

The container needs access to the USB device and its user must have permission to open it; see :doc:`environments`. Diamond additionally needs the mounted Linux installation and license.

Automatic FTDI driver handling
------------------------------

Diamond scans and programming temporarily detach ``ftdi_sio`` from the UltraZohm
FT4232 JTAG interface through libusb. The driver is restored after Diamond exits,
including after a command failure or interruption. An interface that was already
unbound is left unbound. Channels A, C, and D are not detached. No host module
unloading, added container capabilities, writable sysfs, or container rebuild is
needed. The container image already includes ``libusb-1.0``.

The fixed wiring is ``FTUSB-1`` on USB interface ``1`` (channel B). For future
hardware changes, edit ``DEFAULT_DIAMOND_PORT`` in ``programmer_helper/helper.py``
and ``JTAG_INTERFACE`` in ``programmer_helper/usb.py``. That module also defines
the FT4232 vendor/product IDs (``0403:6011``). The helper requires a single matching
FT4232 device and refuses ambiguous device selection. Concurrent helper operations
on the same interface are rejected. ``dry_run=1`` and ``lattice_xcf`` never detach
a driver. Running an exported XCF directly in the Diamond GUI does not use this
Python wrapper.

Restoration is attempted after normal errors, Ctrl-C, and SIGTERM. A forced kill
or USB disconnection can prevent cleanup; reconnect the device if the driver
cannot be restored. The live integrated D-slot scan detected all five
``LCMXO2-2000HC`` devices while ``ftdi_sio`` stayed loaded, then restored channel B.

The S3C controller's validation coverage and inherited design limitations are
documented in ``programs/original/s3c_power_on_debounce/description.rst``.
Programming does not change those validation records.

Logs and receipts
-----------------

Before contacting hardware, programming prints the selected release and program
name for S3C or each D-slot, followed by both backend choices and artifact paths.
The same summary appears with ``dry_run=1``. Each programming ``result.json``
also records ``programmer_backend`` and ``build_backend`` alongside artifact
paths and hashes.

All programmer outputs are under ``toolchain/build/programmer/``:

* Diamond scans: ``scans/<timestamp>/``, containing ``scan.xcf``, ``stdout.log``
  and ``pgrcmd.log``.
* FOSS scans: ``scan.log`` (replaced by the next scan).
* Diamond programming: ``<release>/<chain>/runs/<timestamp>/``, containing logs
  and ``result.json``. The internal chain name is ``dslots`` or ``s3c``.
* FOSS programming: ``<release>/runs/<timestamp>/``, containing detection and
  programming logs and ``result.json``.
* XCF export: ``<release>/dslots.xcf``, ``<release>/s3c.xcf`` and
  ``<release>/selection.json``.

Use ``make help`` for the command summary. The programmer subcommands are
``scan``, ``program`` and ``lattice_xcf``; run one per invocation.
