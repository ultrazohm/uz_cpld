Firmware identity and USERCODE
==============================

Read the firmware currently reported by each device without erasing or programming it::

   make programmer identify target=dslot
   make programmer identify target=s3c

These commands read the device IDCODE, 32-bit USERCODE and 64-bit TraceID over JTAG.
They resolve the USERCODE through the tracked ``programs/usercodes.json`` registry and print the program, release cycle and build revision.
No selection file or local firmware exports are required.
Unknown codes and unregistered revisions are reported explicitly; historical hard-coded values are not guessed.
``dry_run=1`` prints the identification script without accessing USB.
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

   make usercodes-assign

This includes complete manifests outside the catalog and unfinished generator starters.
Build preparation also registers an unregistered program when needed.
Numbers remain reserved after a failed operation or deletion; do not remove registry entries or reset counters.
``make clean`` and ``make clean-all`` preserve the registry.

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
Historical ``USERCODE`` preferences in authored LPFs are replaced in the generated build inputs; the registry owns firmware identification.
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

Identification uses OpenOCD from the pinned OSS CAD Suite, independently of the firmware build backend.
Native hosts need OpenOCD on ``PATH``, under ``FOSS_ROOT/bin``, or at ``CPLD_OPENOCD``.
The supported reader wiring is the UltraZohm FT4232 channel B at 1 MHz: Diamond ``probe_index=1`` or FOSS ``probe_index=0``.
For multiple probes, the FOSS interface accepts ``usb_serial=SERIAL``; an ambiguous unselected probe is rejected.
Other cable types or probe-index mappings require extending the reader and are rejected before managed programming starts.
Managed FOSS programming requires the pinned USERCODE-capable openFPGALoader build included in the toolchain image.
On a native host, ``make flasher`` builds it under ``toolchain/build/openfpgaloader/`` (requires a C++ compiler, CMake, pkg-config, patch, libftdi1/libusb development headers and zlib).
The managed loader selection prefers that local build, then the image's ``FOSS_ROOT/native/openfpgaloader/`` installation; ``CPLD_OPENFPGALOADER`` can select another verified installation.
The wrapper checks the binary and patch provenance and parses every selected input before accessing USB.
Stock or modified loaders are rejected before flash writes.
The patch accepts ``--usercode``, writes the MachXO2 register, waits for completion and verifies it before finishing flash programming.
JEDEC input must contain the same code; bitstream input uses the code from verified build provenance.
FOSS builds now emit compressed bitstreams, as required by the MachXO2 internal-flash parser.
Plain ``scan`` retains its existing cable options.
The Linux FTDI interface lock and driver restoration also cover identity reads.

The reader checks the expected chain and issues only IDCODE, USERCODE, TraceID and BYPASS instructions after JTAG initialization.
It does not issue erase, program, configuration-refresh or device-reset commands.
Identification receipts and logs are retained under ``toolchain/build/programmer/identification/read-*/``.
TraceID's lower 56 bits are the immutable silicon identity; its upper eight bits are user configurable.
The receipt stores both the full TraceID and its immutable part as ``silicon_id``.

After managed programming, the reader checks every device's USERCODE against the selected build and stores the observed identifiers in ``result.json``.
The run is only marked successful after this check passes.
A mismatch or read failure marks the run failed even if the flash write already completed; inspect the logs before retrying.
Programming old exports without registered identity provenance requires rebuilding them first.

The read commands and register semantics follow the `MachXO2 Programming and Configuration User Guide <https://www.latticesemi.com/view_document?document_id=39085>`_,
`Using TraceID <https://www.latticesemi.com/view_document?document_id=39093>`_ and
`OpenOCD JTAG command reference <https://openocd.org/doc/html/JTAG-Commands.html>`_.
Hardware-independent tests exercise allocation, generated scripts, parsing and programming readback decisions.
Live identity readback on the UltraZohm hardware remains to be validated.
