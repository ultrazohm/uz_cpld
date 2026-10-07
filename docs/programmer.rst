Programmer reference
====================

For the build/select/program workflow, see :doc:`user/index`.
Run from the checkout with Diamond Programmer and its cable driver, or the pinned FOSS tools.
Containers also need USB access and device permissions; see :doc:`environments`.
S3C and D-slots require different physical UltraZohm access states.

Selection and release
---------------------

::

   uz_cpld init_programmer
   uz_cpld list --release-cycle heartbeat_cvg
   # Edit selection.toml for this release before building and programming.
   uz_cpld build_selection
   uz_cpld program --target dslot --selection selection.toml

``init_programmer`` creates ``selection.toml`` and preserves an existing file.
The template contains ``release = ""``, ``s3c = "s3c_power_on_debounce"`` and ``tx30`` for slots 1 through 5.
These program names belong to ``original``; edit the release and assignments before using another cycle.
``--release-cycle`` takes precedence over the selection's ``release``, then the current cycle in ``programs/releases.toml``.
``build_selection`` reads the selection and builds every distinct assignment in its release.
``build`` and ``build_all`` use their command-line release or the current release; they do not read the selection.
Local programming requires current successful builds and never builds automatically.
If the selection is absent, ``program`` creates a template and exits without accessing hardware.

D-slot programming requires all five ``[slots]`` entries (keys ``"1"`` through ``"5"``).
S3C programming requires only ``s3c``; the unused chain may be omitted.
Slots identify physical JTAG positions, not catalog order.
All selected programs come from one release.

Program a downloaded release ZIP
--------------------------------

``program`` defaults to ``source=local``, retaining the local-build checks above.
Use ``source=zip`` with an explicit firmware archive to program a published release without local firmware builds or matching source files::

   make firmware_download
   # Use the ZIP path printed by the downloader:
   make program target=s3c source=zip firmware=build/downloads/<release-tag>/uz-cpld-firmware.zip
   make program target=dslot source=zip firmware=/path/to/uz-cpld-firmware.zip programmer_backend=foss

The equivalent native command (including Windows) is::

   uz_cpld program --target s3c --source zip --firmware /path/to/uz-cpld-firmware.zip

``selection.toml`` still supplies the program assignments.
The release cycle is chosen from ``release_cycle``, then the selection's ``release``, then the checkout's current release.
Without a checkout default, a ZIP containing exactly one cycle can supply that default; otherwise select a cycle explicitly.
The selected names and device targets must exist in the ZIP manifest, not in the local catalog.

The firmware build backend comes from the ZIP.
An explicit ``build_backend`` must match it.
``backend`` sets the programmer default for ZIP programming; ``programmer_backend`` overrides it.
Diamond-built JEDEC releases can use either programmer; FOSS bitstream releases require the FOSS programmer.
Programmer tools, USB drivers and permissions remain prerequisites; downloading firmware does not install them.

The archive must use the repository's release format: ``manifest.json``, declared firmware files, checksums, successful build provenance and an identity registry.
Validation rejects malformed archives, inconsistent targets or identities, changed payloads and JEDEC USERCODE mismatches before hardware access.
Only the selected firmware is extracted into a private directory under ``build/programmer/packages/``.
The manifest is retained there, and the run record includes the ZIP path and SHA-256, release commit, selected programs and readback.
These checks establish package consistency; use release ZIPs from a trusted source.

The ZIP registry is used for this run's identity validation and readback.
Conflicts with local identities are reported and recorded; ``programs/usercodes.json`` is never overwritten.
Subsequent standalone ``identify`` commands still use the local registry and may report different or unknown labels until it is reconciled.

``firmware`` is rejected with ``source=local``.
No ZIP is selected or downloaded implicitly.
``dry_run=1`` remains a command preview: it does not open or validate the ZIP, extract files, or access hardware.

Backends and probes
-------------------

For local programming, ``--backend`` defaults to ``diamond`` and sets both firmware and programmer defaults.
``--build-backend`` and ``--programmer-backend`` override them independently on programming commands.
Selection files do not select backends.

.. list-table:: Supported combinations
   :header-rows: 1

   * - Firmware backend
     - Programmer backend
     - Artifact
   * - Diamond
     - Diamond
     - ``.jed`` through XCF
   * - Diamond
     - FOSS
     - ``.jed`` through patched openFPGALoader
   * - FOSS
     - FOSS
     - ``.bit`` through patched openFPGALoader

Diamond cannot program FOSS exports.
Missing tools never cause an automatic backend change.
FOSS identity reads use OpenOCD; managed FOSS programming requires the verified USERCODE-capable loader, supplied in the image or built with ``flasher_build``.
See :doc:`firmware-identity` for installation and identity checks.

Both chains use FT4232 channel B.
Diamond defaults to ``--probe-index 1`` (``FTUSB-1``); FOSS defaults to ``--cable ft4232_b --probe-index 0`` at 1 MHz.
Managed programming and identification support these mappings; FOSS also accepts ``--usb-serial SERIAL`` instead of the probe index.
FOSS scans permit other cable/index selections, but those do not extend the managed reader's supported wiring.

Scan, identify and program
--------------------------

::

   uz_cpld scan --target dslot
   uz_cpld identify --target dslot
   uz_cpld program --target dslot --dry-run 1
   uz_cpld program --target dslot

``scan`` and ``identify`` default to D-slots and execute immediately.
Neither needs firmware builds or a selection file.
They do not accept release or build-backend options.
``program`` requires an explicit target and immediately erases, programs and verifies Flash; it has no SRAM mode.
After changing the hardware access state, use ``--target s3c`` for S3C.
``--dry-run 1`` validates CLI options and prints the resolved invocation without writes or hardware access.
It does not validate selection contents, firmware freshness or hardware readiness.

Diamond scans check expected XCF device positions; FOSS scans report discovered IDs.
The expected D-slot chain has five LCMXO2-2000HC devices (``0x012BB043``); S3C has one LCMXO2-4000HC (``0x012BC043``).
FOSS programming checks the whole chain before writing.
Diamond execution validates its XCF positions and verified JEDEC snapshots.
Both paths check the selected source's provenance and verify its expected USERCODE after programming.
A readback failure marks the run failed even if the Flash write completed.

Export Diamond projects
-----------------------

::

   uz_cpld diamond_xcf_programming_chain
   uz_cpld diamond_xcf_programming_chain --selection selection.toml --rebuild 1

XCF export requires Diamond for both backends, all six assignments, and current JEDEC builds.
``--rebuild 1`` builds the selected programs before exporting.
It writes ``dslots.xcf``, ``s3c.xcf`` and ``selection.json`` under ``build/programmer/<release>/`` without contacting hardware.
XCFs reference absolute firmware paths; regenerate them after moving the checkout or rebuilding firmware.
Their operation is ``FLASH Erase,Program,Verify`` when executed in Lattice Programmer.
CLI programming creates separate target-specific plans, so prior XCF export is optional.

Execution and logs
------------------

Diamond runs ``pgrcmd`` with a generated XCF; FOSS runs openFPGALoader with ``--write-flash --verify --usercode``.
Diamond scan, identity and programming operations on Linux temporarily detach ``ftdi_sio`` from interface 1 and attempt to restore it on exit, errors and interruption.
Other FTDI interfaces remain attached; an already unbound interface stays unbound.
The helper rejects ambiguous probes and concurrent operations on the same interface.
Driver cleanup cannot complete after a forced kill or USB disconnection; reconnect the probe if needed.
Running XCFs directly in the vendor GUI does not use this wrapper.

Outputs are relative to ``build/programmer/``:

* Diamond scans: ``scans/<timestamp>/`` with XCF and logs.
* FOSS scans: ``scan.log``, replaced by the next scan.
* Identity reads: ``identification/read-*/``.
* Diamond programming: ``<release>/<chain>/plans/plan-*/runs/<timestamp>/`` with logs and ``result.json``.
* FOSS programming: ``<release>/runs/<timestamp>/`` with detection/programming logs and ``result.json``.
* XCF export: ``<release>/`` with both XCFs and ``selection.json``.

The internal chain names are ``dslots`` and ``s3c``.
Programming receipts record both backends, firmware hashes and observed device identities.
A firmware rebuild that changes a snapshot's inputs or artifact invalidates its execution plan.

Build selected firmware
-----------------------

``build_selection`` builds only the programs in ``selection.toml``, once per distinct
program and target, without programming hardware.
It uses the selection's release, or the current release when that field is empty.
``--release-cycle NAME`` overrides it.
``--backend foss`` selects FOSS builds; Diamond is the default, and ``--build-backend`` overrides the firmware backend.
By default all six assignments are required.
An optional ``--target dslot|s3c`` restricts the build and required assignments to that chain.
For example::

   uz_cpld build_selection
   uz_cpld build_selection --selection custom.toml --target s3c
   make build_selection selection=custom.toml

``init_programmer`` accepts ``--s3c NAME``, ``--dslot-1 NAME`` through
``--dslot-5 NAME``, and ``--release NAME``. ``--release ""`` uses the current
release. With Make, use ``s3c=NAME``, ``dslot_1=NAME`` through ``dslot_5=NAME``,
and ``release=""``. Existing files are preserved even when options are supplied.

For example, initialize a new file with optional assignments::

   uz_cpld init_programmer --selection custom.toml --release original --s3c s3c_power_on_debounce --dslot-1 rx30

The other four slots retain ``tx30`` in this example.
