Programmer reference
====================

For the build/select/program workflow, see :doc:`user/index`.
Run from the checkout with Diamond Programmer and its cable driver, or the pinned FOSS tools.
Containers also need USB access and device permissions; see :doc:`environments`.
S3C and D-slots require different physical UltraZohm access states.

Selection and release
---------------------

::

   python -m cpld_toolchain init
   python -m cpld_toolchain list --release-cycle heartbeat_cvg
   python -m cpld_toolchain program --target dslot --selection selection.toml

``init`` creates ``selection.toml`` and preserves an existing file.
The template contains ``release = ""``, ``s3c = "s3c_power_on_debounce"`` and ``tx30`` for slots 1 through 5.
These program names belong to ``original``; edit the release and assignments before using another cycle.
``--release-cycle`` takes precedence over the selection's ``release``, then the current cycle in ``programs/releases.toml``.
Build commands do not read the selection: build every distinct assignment with the same explicit release.
Programming requires current successful builds and never builds automatically.
If the selection is absent, ``program`` creates a template and exits without accessing hardware.

D-slot programming requires all five ``[slots]`` entries (keys ``"1"`` through ``"5"``).
S3C programming requires only ``s3c``; the unused chain may be omitted.
Slots identify physical JTAG positions, not catalog order.
All selected programs come from one release.

Backends and probes
-------------------

``--backend`` defaults to ``diamond`` and sets both firmware and programmer defaults.
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
FOSS identity reads use OpenOCD; managed FOSS programming requires the verified USERCODE-capable loader, supplied in the image or built with ``flasher-build``.
See :doc:`firmware-identity` for installation and identity checks.

Both chains use FT4232 channel B.
Diamond defaults to ``--probe-index 1`` (``FTUSB-1``); FOSS defaults to ``--cable ft4232_b --probe-index 0`` at 1 MHz.
Managed programming and identification support these mappings; FOSS also accepts ``--usb-serial SERIAL`` instead of the probe index.
FOSS scans permit other cable/index selections, but those do not extend the managed reader's supported wiring.

Scan, identify and program
--------------------------

::

   python -m cpld_toolchain scan --target dslot
   python -m cpld_toolchain identify --target dslot
   python -m cpld_toolchain program --target dslot --dry-run 1
   python -m cpld_toolchain program --target dslot

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
Both paths check build provenance and verify the registered USERCODE after programming.
A readback failure marks the run failed even if the Flash write completed.

Export Diamond projects
-----------------------

::

   python -m cpld_toolchain programmer-project
   python -m cpld_toolchain programmer-project --selection selection.toml --rebuild 1

XCF export requires Diamond for both backends, all six assignments, and current JEDEC builds.
``--rebuild 1`` builds the selected programs before exporting.
It writes ``dslots.xcf``, ``s3c.xcf`` and ``selection.json`` under ``cpld_toolchain/toolchain/build/programmer/<release>/`` without contacting hardware.
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

Outputs are relative to ``cpld_toolchain/toolchain/build/programmer/``:

* Diamond scans: ``scans/<timestamp>/`` with XCF and logs.
* FOSS scans: ``scan.log``, replaced by the next scan.
* Identity reads: ``identification/read-*/``.
* Diamond programming: ``<release>/<chain>/plans/plan-*/runs/<timestamp>/`` with logs and ``result.json``.
* FOSS programming: ``<release>/runs/<timestamp>/`` with detection/programming logs and ``result.json``.
* XCF export: ``<release>/`` with both XCFs and ``selection.json``.

The internal chain names are ``dslots`` and ``s3c``.
Programming receipts record both backends, firmware hashes and observed device identities.
A firmware rebuild that changes a snapshot's inputs or artifact invalidates its execution plan.
