Lattice Programmer projects
===========================

``programmer_helper`` generates separate five-device D-slot and one-device S3C XCF files from published Diamond JEDEC exports. Its programming command can erase, program and verify device Flash through Diamond Programmer or openFPGALoader.

Select every program explicitly. Positions 1 through 5 are the JTAG positions in the archived D-slot chain, not an automatically chosen catalog order. Copy ``programmer_helper/selection.example.toml``, fill all six values, then run::

   make programmer-project selection=my_programmer_selection.toml

The TOML file has a top-level ``s3c`` program and a ``[slots]`` table with keys ``"1"`` through ``"5"``. Each value is a program name from the selected release. No name is filled in by the helper. You can also supply all names on the command line::

   make programmer-project slot1=tx30 slot2=tx30 slot3=rx30 \
       slot4=uz_d_resolver_d4_4inverter_sdifix \
       slot5=uz_d_resolver_d5_4inverter_sdifix s3c=s3c_power_on_debounce

These command-line names are an example of an operator-supplied selection. The helper has no default mapping. Each selected program must have a successful, current Diamond build with a recorded JEDEC file. To rebuild all selected programs in the same command, add ``rebuild=1``. This requires a working Diamond installation.

Omit ``release_cycle`` to use ``programs/releases.toml``. To select an older cycle, add ``release_cycle=NAME``. All six programs are resolved within that cycle; the helper never mixes release cycles. The source release must be present in this checkout and its Diamond builds must be available or rebuilt.

The generated files are ``toolchain/build/programmer/<release_cycle>/dslots.xcf``, ``s3c.xcf`` and ``selection.json``. The receipt records the chosen programs and SHA-256 hashes of the JEDEC and XCF files. The helper copies device positions and programming options from the archived XCFs, replaces each JEDEC path, time, fuse checksum and usercode, and removes archived USB serial numbers. It retains the archived USB2 port addresses (``FTUSB-1`` for D-slots and ``FTUSB-0`` for S3C); confirm those addresses on the programming station. The generated XCFs contain absolute paths and must be regenerated after moving the checkout or rebuilding the firmware.

Programming from the container
------------------------------

Both backends erase, program and verify the nonvolatile Flash. Diamond runs ``pgrcmd`` on the generated XCF and uses the selected Diamond ``.jed`` builds. FOSS runs openFPGALoader with ``--write-flash --verify`` on the selected FOSS ``.bit`` builds. There is no SRAM programming mode in this helper.

Choose a complete TOML selection and one chain per command. For example::

   make programmer-scan chain=dslots backend=foss execute=1
   make programmer-scan chain=s3c backend=diamond execute=1
   make programmer-program selection=my_programmer_selection.toml chain=dslots backend=foss
   make programmer-program selection=my_programmer_selection.toml chain=dslots backend=foss execute=1
   make programmer-program selection=my_programmer_selection.toml chain=s3c backend=diamond execute=1

Without ``execute=1``, commands only print their plan. ``programmer-scan`` with ``execute=1`` is read-only for both backends. FOSS uses openFPGALoader ``--detect`` and reports the ID codes it sees, including unexpected devices. Diamond makes a temporary XCF containing only ``FLASH Display ID`` operations and runs ``pgrcmd``; its output and the exact XCF are retained under ``toolchain/build/programmer/scans/``. Diamond uses the archived expected chain positions, so its result is an ID check against that chain rather than unrestricted chain discovery. Neither scan command needs firmware builds or a selection file. For programming, the FOSS path first scans and checks the entire JTAG chain: five 2000HC devices at indices 0–4 for D-slots, or one 4000HC at index 0 for S3C. It stops before writing if the scan does not match. The Diamond programming path uses the device and position checks built into the generated XCF. Run ``make programmer-project selection=...`` first if you want to inspect Diamond's programming XCF independently. The programming command regenerates it from the supplied selection.

The FOSS cable defaults to ``ft2232`` and selects USB probe index 1 for D-slots and index 0 for S3C. These openFPGALoader probe indices do not necessarily match Diamond's ``FTUSB-N`` ports, which can enumerate interfaces of a single FTDI chip. Confirm with the scan on your station; for FOSS, use ``probe_index=N`` or ``usb_serial=SERIAL`` to select a probe and ``cable=NAME`` to select the cable type and channel. For Diamond scans, ``probe_index=N`` selects ``FTUSB-N``. A past cycle can be chosen with ``release_cycle=NAME``. The relevant backend must have successful, current builds for the selected programs. The command writes logs and a ``result.json`` receipt under ``toolchain/build/programmer/<cycle>/runs/``.

On the UltraZohm FT4232 with serial ``0100206000050``, both commands below read the S3C ``LCMXO2-4000HC`` ID ``0x012BC043`` in a live container check::

   make programmer-scan chain=s3c backend=foss cable=ft4232_b usb_serial=0100206000050 execute=1
   make programmer-scan chain=s3c backend=diamond probe_index=1 execute=1

Here, FOSS uses FT4232 channel B and Diamond uses ``FTUSB-1``. The archived S3C default ``FTUSB-0`` returned an all-zero ID on this setup. ``FLASH Display ID`` is the MachXO2 operation name; the generic ``Display ID`` is rejected by Diamond. Despite its name, ``FLASH Display ID`` only reads the ID and does not program Flash.

The container needs access to the USB device and its user must have permission to open it; see :doc:`environments`. Diamond additionally needs the mounted Linux installation and license. The host's ``ftdi_sio`` serial driver can also claim the FTDI interfaces and interfere with programmer access. If this causes a cable-access failure, close applications using those serial ports and run ``sudo rmmod ftdi_sio`` on the host before retrying. Unloading it affects all FTDI serial ports on that host; ``sudo modprobe ftdi_sio`` restores the driver. The live scan above succeeded with ``ftdi_sio`` unloaded; the helper does not change host kernel modules. Successful build evidence and a completed tool command do not establish hardware qualification. The imported ``s3c_power_on_debounce`` program has unresolved startup validation and requires ``allow_unqualified_s3c=1`` for programming.
