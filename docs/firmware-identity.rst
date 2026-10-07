Firmware identity and USERCODE
==============================

Read the firmware currently reported by each device without erasing or programming it::

   make identify target=dslot
   make identify target=s3c
   make identify target=s3c source=zip firmware=/path/to/uz-cpld-firmware.zip

These commands read the device IDCODE, 32-bit USERCODE and 64-bit TraceID over JTAG.
They resolve the USERCODE through the tracked ``programs/usercodes.json`` registry by default
(``source=local``), or through the validated archive registry with ``source=zip firmware=PATH.zip``,
and print the program, release cycle and build revision. The ZIP option does not modify the local registry.
No selection file or local firmware exports are required.
Unknown codes and unregistered revisions are reported explicitly.
``dry_run=1`` previews the selected backend’s read operations without accessing USB.
The current physical UltraZohm chain must match the selected target, as for programming.

USERCODE layout
---------------

The upper 16 bits hold a permanent program number; the lower 16 bits hold a build revision.
For example, program number 11, revision 1 is ``0x000B0001``.
Program numbers are unique across all release cycles in this repository.
Revision zero is reserved, and both counters stop at 65535 rather than wrapping.

List the assigned program numbers::

   make usercodes

All existing complete programs have numbers, including templates.
``make new`` assigns a fresh number to handwritten clones and generator starters automatically.
``make generate`` preserves the starter's number.
A clone or copied release receives new numbers, while references to ``xo2_library`` remain shared.
For programs added manually, run::

   make usercodes_assign

This includes complete manifests outside the catalog and unfinished generator starters.
Build preparation also registers an unregistered program when needed.
Numbers remain reserved after a failed operation or deletion; do not remove registry entries or reset counters.
``make clean`` and ``make clean_all`` preserve the registry.

Build revisions and provenance
------------------------------

``make project`` or ``make build`` reserves a revision for a fingerprint of the qualified program name, target, backend and recorded input hashes.
Those hashes include HDL, shared-library sources, constraints, manifests, generator provenance and the relevant build implementation.
Identical recorded inputs reuse their revision, including when rebuilding after cleanup.
Changed recorded inputs or a different backend get a new revision.
A failed build can reserve a revision without producing an artifact.

Both Diamond and FOSS builds embed the allocated USERCODE.
Diamond uses a generated ``project/constraints.lpf`` containing the authored electrical constraints and the assigned code.
The FOSS packer receives the allocated value.
Authored ``USERCODE`` preferences in authored LPFs are replaced in the generated build inputs; the registry owns firmware identification.
``TRACEID`` preferences are separate and retain their existing backend behavior.
The standalone VHDL generator does not allocate identities; allocation belongs to the repository workflow.

``metadata/identity.json`` records the prepared identity, and ``metadata/build.json`` records the successful build identity alongside its provenance.
Before publishing Diamond firmware, the workflow checks the USERCODE embedded in the JEDEC export.
The tracked registry retains each revision's fingerprint, target, backend and successful artifact SHA-256 hashes with its Git revision and completion time.
Keep and commit the registry with program changes, and share it with programming stations.
The code identifies recorded build inputs, not an individual invocation: repeated builds can produce different artifact hashes under one revision, and all observed hashes are retained.
USERCODE is a label, not a cryptographic verification of the device contents.

Allocation and collaboration
----------------------------

Allocation uses an exclusive lock on the ``programs/`` directory and atomically replaces the registry.
Concurrent allocators in one checkout cannot reserve the same number or revision for different entries.
Registry validation rejects duplicate program numbers, duplicate JSON keys, invalid counters and exhausted number spaces.
A missing registry is an error; it is not silently recreated with reused numbers.

Independent Git checkouts do not share a lock or central allocation service.
Coordinate allocation through the shared branch and resolve registry merge conflicts before building or programming.
Do not renumber an identity already programmed or published: retain its history and allocate a new number for the conflicting new program.
A merged registry with duplicate numbers is rejected rather than silently identifying two programs as one.

Identity reads and programming records
--------------------------------------

Identification defaults to Diamond Programmer, including readback after Diamond programming.
It uses native ``FLASH Display ID``, ``XFLASH Display USERCODE`` and ``Security Display TraceID`` operations.
The USERCODE read uses transparent background access; the nontransparent ``FLASH Display USERCODE`` operation is deliberately excluded because its vendor algorithm erases SRAM.
Diamond identification does not require or invoke openFPGALoader.
Its slot labels follow the native Diamond XCF device positions.

Explicit ``programmer_backend=foss`` (or ``backend=foss`` on a programmer command) selects the patched openFPGALoader for identification and programming.
OpenOCD and ``CPLD_OPENOCD`` are no longer used.
FOSS device indices now consistently follow openFPGALoader's programming order (nearest TDI first): index 0 is slot1.
Old OpenOCD identification receipts used the opposite enumeration order; do not compare their slot labels directly without matching ``silicon_id``.
The supported reader wiring is the UltraZohm FT4232 channel B at 1 MHz: Diamond ``probe_index=1`` or FOSS ``probe_index=0``.
For multiple probes, the FOSS interface accepts ``usb_serial=SERIAL``; an ambiguous unselected probe is rejected.
Other cable types or probe-index mappings require extending the reader and are rejected before managed programming starts.
Managed FOSS programming requires the pinned USERCODE-capable openFPGALoader build included in the toolchain image.
On a native host, ``make flasher_build`` builds it under ``build/openfpgaloader/`` (requires a C++ compiler, CMake, pkg-config, patch, libftdi1/libusb development headers and zlib).
This command builds the programming executable only; it does not build CPLD firmware, access USB or program a device.
The loader lookup order is described below; every loader used for managed programming must have a matching patch receipt and binary checksum.
The wrapper checks the binary and patch provenance and parses every selected input before accessing USB.
Stock or modified loaders are rejected before flash writes.
The patch accepts ``--usercode``, writes the MachXO2 register, waits for completion and verifies it before finishing flash programming.
JEDEC input must contain the same code; bitstream input uses the code from verified build provenance.
FOSS builds emit compressed bitstreams, as required by the MachXO2 internal-flash parser.
Preflight requires 128-bit JEDEC pages with contiguous section offsets.
For compressed bitstreams it decodes the complete frame structure, checks the device-specific frame count and CRCs, and requires USERCODE and DONE commands.
The embedded bitstream USERCODE and IDCODE must match the requested firmware identity and target before USB access; the native programming path rechecks IDCODE against the device before Flash erase.
Unsupported bitstream commands or formats are rejected before programming.
Plain ``scan`` retains its existing cable options.
The FTDI interface lock covers the entire managed operation: initial identity read, all writes and final readback.
On Linux the existing driver guard detaches and restores channel B; on Windows the existing process lock is reused.
Every firmware input is copied into a private per-run directory and parsed before acquiring the probe.
The selected executable is fixed for the session and its receipt is rechecked before each invocation.
Each flash write checks the exact chain and the selected device's immutable TraceID again before programming.

Flasher builds and container rebuilds
-------------------------------------

``cpld_toolchain/toolchain/foss/openfpgaloader.json`` pins upstream v1.1.1 and the SHA-256 hashes of its source archive and ``openfpgaloader-usercode.patch``.
``flasher.py`` verifies both, applies the patch to a fresh source tree, runs the USERCODE, identity sequencing and transfer-failure tests, compiles Lattice/FTDI support, and runs the real CLI/parser tests without USB.
It installs a binary reporting ``v1.1.1-uz-programmer3``, its license and a readable ``usercode-support.json`` receipt containing the pin and binary checksum.
Concurrent installers serialize publication of the binary and receipt.
The separate ``foss-programmer.yml`` CI workflow builds the Windows executable with MSYS2 and runs the same native tests without USB.
That job checks compilation and parser/protocol behavior; it does not establish hardware or driver compatibility.

The Docker builder stage runs this automatically and copies the installation into the runtime image.
Rebuilding the image reapplies the patch and recompiles when the source pin or patch changes; unchanged inputs can reuse Docker's cached layer.
No manual ``make flasher_build`` step is needed in a fresh container.
The runtime lacks the compiler/development headers from the builder stage; use a container rebuild to update its bundled loader.

The loader lookup order is:

#. Explicit ``CPLD_OPENFPGALOADER`` override.
#. Bundled tools under ``CPLD_BUNDLED_TOOLS`` or the package's ``bundled_tools/`` directory.
#. Workspace installation at ``build/openfpgaloader/openFPGALoader``.
#. Container installation at ``FOSS_ROOT/native/openfpgaloader/openFPGALoader``.
#. ``FOSS_ROOT/bin/openFPGALoader``, then ``PATH``.

An explicit override is authoritative; an unavailable override does not fall back to another loader.
Managed programming verifies the selected executable's receipt regardless of its location;
stock executables can be used for scans but fail managed programming verification.
A stale selected installation is rejected rather than silently skipped.
Rebuild it, or select another verified installation using ``CPLD_OPENFPGALOADER``.
``make clean_all`` removes the workspace installation along with other generated outputs.
Calling the stock executable directly bypasses these checks and does not provide the managed workflow's identity guarantee.

Device readback
---------------

Both readers check the expected chain and read IDCODE, USERCODE and TraceID.
Both readers enter and leave transparent Flash access for stored USERCODE readback.
FOSS also reads the active SRAM USERCODE before entering transparent mode, and stores it separately as ``sram_usercode``.
Its native protocol emits ``UZ_IDENTITY_V1 index idcode flash_usercode sram_usercode traceid`` rows followed by ``UZ_IDENTITY_END_V1 count``.
Missing, malformed, duplicated, reordered or unexpected rows cause failure.
Neither reader issues erase, program, configuration-refresh or device-reset commands.
Identification receipts and logs are retained under ``build/programmer/identification/read-*/``.
TraceID's lower 56 bits are the immutable silicon identity; its upper eight bits are user configurable.
The receipt stores both the full TraceID and its immutable part as ``silicon_id``.

After managed programming, the reader checks every device's USERCODE against the selected build and stores the observed identifiers in ``result.json``.
For FOSS, success additionally requires the SRAM code to match and every lower-56-bit silicon identity to remain unchanged.
A bounded ten-second retry window allows the active SRAM code to settle; a Flash mismatch, changed silicon or read error fails immediately.
Each native read also has a process timeout. USB reads, writes and busy polling have bounded timeouts and incomplete transfers fail.
No flash write is automatically retried.
A mismatch or read failure marks the run failed even if the flash write already completed; inspect the logs before retrying.
Exports without registered identity provenance must be rebuilt before managed programming.

The read commands and register semantics follow the `MachXO2 Programming and Configuration User Guide <https://www.latticesemi.com/view_document?document_id=39085>`_, `Using TraceID <https://www.latticesemi.com/view_document?document_id=39093>`_.
Hardware-independent tests exercise allocation, native instruction sequencing, cleanup on failures, parsing and programming readback decisions.
The FOSS migration still requires bench acceptance on both chains: compare distinct device TraceIDs to physical positions, identify without changing running logic, program and check both USERCODE stores, and verify driver restoration after disconnects.
Windows additionally needs a compatible libusb driver for FT4232 channel B; the executable cannot provide a kernel driver.
Diamond identity readback has been validated on the five-device UltraZohm D-slot chain.
