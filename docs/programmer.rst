Programming CPLDs
=================

Run ``make programmer`` to create ``selection.toml`` in the current directory.
If it already exists, the command keeps its contents. New files contain these
defaults, which you can edit for your hardware::

   release = ""
   s3c = "s3c_power_on_debounce"

   [slots]
   "1" = "tx30"
   "2" = "tx30"
   "3" = "tx30"
   "4" = "tx30"
   "5" = "tx30"

``release = ""`` (or an omitted field) uses the current release from
``programs/releases.toml``. Set ``release = "NAME"`` to select another release.
The command-line ``release_cycle=NAME`` takes precedence over the file. Both
programming and project generation use this setting for every selected program.
Use ``make release-list`` to see releases and ``make list release_cycle=NAME`` to
see their programs. Scans do not use the selection file or release.

Fill ``s3c`` for S3C programming, or all five slots for D-slot programming.
The unused target can remain blank or be omitted. Slot numbers are physical
JTAG positions, not catalog order. Each selected program must have a successful,
current build for the chosen backend; build it with
``make build program=NAME backend=diamond|foss`` if needed.

The UltraZohm must be in different physical states for S3C and D-slot access.
Prepare it for one target and run one command at a time::

   make programmer program target=s3c
   make programmer program target=dslot

These commands immediately erase, program, and verify the selected target's
Flash. ``backend=diamond`` is the default. Use ``dry_run=1`` to validate the
selection and print the programming plan without accessing hardware. Programming
requires an explicit ``target`` and never proceeds to the other target.

To read JTAG IDs without a selection file or firmware builds::

   make programmer scan
   make programmer scan target=s3c

The first command scans only D-slots. Both scans contact hardware immediately;
add ``dry_run=1`` to print the scan plan instead. Diamond checks IDs against the
expected chain; FOSS reports the devices it discovers.

Optional arguments include ``backend=diamond|foss``, ``selection=FILE``,
``release_cycle=NAME``, and ``probe_index=N``. FOSS additionally accepts
``cable=NAME`` and ``usb_serial=SERIAL`` (instead of ``probe_index``). For example,
the S3C connection verified on this station uses::

   make programmer scan target=s3c backend=diamond probe_index=1
   make programmer program target=s3c backend=diamond probe_index=1 dry_run=1
   make programmer scan target=s3c backend=foss cable=ft4232_b usb_serial=0100206000050

``make programmer selection=FILE`` creates a template at a custom path.
``make program=NAME`` remains the firmware-build shortcut.
``make programmer program target=...`` selects hardware programming.

Generating Lattice Programmer projects
-------------------------------------

``programmer_helper`` generates separate five-device D-slot and one-device S3C XCF files from published Diamond JEDEC exports. Its programming command can erase, program and verify device Flash through Diamond Programmer or openFPGALoader.

Positions 1 through 5 are the JTAG positions in the archived D-slot chain, not catalog order. Run ``make programmer selection=my_programmer_selection.toml``, review or edit the six default programs, then run::

   make programmer lattice_xcf selection=my_programmer_selection.toml

The TOML file has top-level ``release`` and ``s3c`` fields and a ``[slots]`` table with keys ``"1"`` through ``"5"``. Each program name is resolved within the selected release. ``make programmer lattice_xcf`` defaults to ``selection.toml`` and requires all six assignments. It validates board compatibility and checks that each Diamond JEDEC matches a successful, current build. Add ``rebuild=1`` to rebuild the selected Diamond programs before those checks. Project generation does not contact hardware.

Release selection follows command-line ``release_cycle``, then TOML ``release``, then the repository's current release. All selected programs come from that cycle.

The generated files are ``toolchain/build/programmer/<release_cycle>/dslots.xcf``, ``s3c.xcf`` and ``selection.json``. The receipt records the chosen programs and SHA-256 hashes of the JEDEC and XCF files. The helper copies device positions and programming options from the archived XCFs, replaces each JEDEC path, time, fuse checksum and usercode, and removes archived USB serial numbers. Both generated chains default to USB2 port ``FTUSB-1``, matching the verified UltraZohm connection; confirm the port on your programming station. The generated XCFs contain absolute paths and must be regenerated after moving the checkout or rebuilding the firmware.

Open the XCFs in Lattice Programmer to inspect or program each chain manually.
Their configured operation is ``FLASH Erase,Program,Verify``. Generating the
files does not perform that operation. The CLI's ``make programmer program``
generates its own target-specific XCF, so running ``project`` first is optional.

Programming from the container
------------------------------

Both backends erase, program and verify the nonvolatile Flash. Diamond runs ``pgrcmd`` on the generated XCF and uses the selected Diamond ``.jed`` builds. FOSS runs openFPGALoader with ``--write-flash --verify`` on the selected FOSS ``.bit`` builds. There is no SRAM programming mode in this helper.

Populate the target's TOML entries and choose one chain per command. For example::

   make programmer scan target=dslot backend=foss
   make programmer scan target=s3c backend=diamond
   make programmer program selection=my_programmer_selection.toml target=dslot backend=foss dry_run=1
   make programmer program selection=my_programmer_selection.toml target=dslot backend=foss
   make programmer program selection=my_programmer_selection.toml target=s3c backend=diamond

``make programmer scan`` reads IDs and ``make programmer program`` writes Flash; both execute by default. Use ``dry_run=1`` for a preview. FOSS uses openFPGALoader ``--detect`` and reports the ID codes it sees, including unexpected devices. Diamond makes a temporary XCF containing only ``FLASH Display ID`` operations and runs ``pgrcmd``; its output and the exact XCF are retained under ``toolchain/build/programmer/scans/``. Diamond uses the archived expected chain positions, so its result is an ID check against that chain rather than unrestricted chain discovery. Neither scan command needs firmware builds or a selection file. For programming, the FOSS path first scans and checks the entire JTAG chain: five 2000HC devices at indices 0–4 for D-slots, or one 4000HC at index 0 for S3C. It stops before writing if the scan does not match. The Diamond path generates an XCF for only the selected chain under ``toolchain/build/programmer/<cycle>/<chain>/`` and applies ``probe_index`` to its USB2 port. It uses the device and position checks built into that XCF. The separate ``make programmer lattice_xcf`` command generates both XCFs and requires all six assignments.

The FOSS cable defaults to ``ft2232`` and selects USB probe index 1 for D-slots and index 0 for S3C. These openFPGALoader probe indices do not necessarily match Diamond's ``FTUSB-N`` ports, which can enumerate interfaces of a single FTDI chip. Confirm with the scan on your station; for FOSS, use ``probe_index=N`` or ``usb_serial=SERIAL`` to select a probe and ``cable=NAME`` to select the cable type and channel. Diamond defaults to ``FTUSB-1`` for both chains; ``probe_index=N`` overrides the port for scans and programming. A past cycle can be chosen with ``release_cycle=NAME``. The relevant backend must have successful, current builds for the selected programs. Programming writes logs and a ``result.json`` receipt under ``toolchain/build/programmer/<cycle>/runs/`` for FOSS and ``toolchain/build/programmer/<cycle>/<chain>/runs/`` for Diamond.

On the UltraZohm FT4232 with serial ``0100206000050``, both commands below read the S3C ``LCMXO2-4000HC`` ID ``0x012BC043`` in a live container check::

   make programmer scan target=s3c backend=foss cable=ft4232_b usb_serial=0100206000050
   make programmer scan target=s3c backend=diamond probe_index=1

Here, FOSS uses FT4232 channel B and Diamond uses ``FTUSB-1``. The old archived S3C port ``FTUSB-0`` returned an all-zero ID on this setup, so generated XCFs and scans now default to ``FTUSB-1``. ``FLASH Display ID`` is the MachXO2 operation name; the generic ``Display ID`` is rejected by Diamond. Despite its name, ``FLASH Display ID`` only reads the ID and does not program Flash.

The container needs access to the USB device and its user must have permission to open it; see :doc:`environments`. Diamond additionally needs the mounted Linux installation and license. The host's ``ftdi_sio`` serial driver can also claim the FTDI interfaces and interfere with programmer access. If this causes a cable-access failure, close applications using those serial ports and run ``sudo rmmod ftdi_sio`` on the host before retrying. Unloading it affects all FTDI serial ports on that host; ``sudo modprobe ftdi_sio`` restores the driver. The live scan above succeeded with ``ftdi_sio`` unloaded; the helper does not change host kernel modules. Successful build evidence and a completed tool command do not establish hardware qualification. The imported ``s3c_power_on_debounce`` program has unresolved startup validation and requires ``allow_unqualified_s3c=1`` for programming.
