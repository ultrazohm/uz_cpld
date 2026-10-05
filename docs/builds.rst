Build and author programs
=========================

Pipeline task inventory
-----------------------

The automation is defined in ``.github/workflows/toolchain.yml``; the Makefile forwards commands to ``python -m cpld_toolchain``.
The workflow runs on pushes, pull requests and manual dispatches.

.. list-table:: CI tasks
   :header-rows: 1
   :widths: 24 76

   * - Job
     - Tasks, in execution order
   * - ``windows-python``
     - Check out sources; install Python 3.10; preview environment bootstrap without third-party packages; create the native venv; run the Windows tooling test subset; check tracked generated files for ``heartbeat_cvg/cvg_tx30``; preview catalog builds; preview D-slot programming.
   * - ``checks``
     - Check out sources; build the license-free Docker toolchain image; run Python tooling tests; build the FOSS-supported ``original`` catalog; build ``heartbeat_cvg/cvg_tx30``; compare the pilot against its RTL reference; generate documentation and run HDL simulations for all release cycles; retain diagnostics and the HTML preview; upload the Pages site on successful ``master`` runs.
   * - ``diamond-build``
     - On pushes and manual runs, authenticate using ``DIAMOND_GHCR_TOKEN``; build the image from ``DIAMOND_IMAGE`` once; check Diamond startup and synthesis; attempt every release catalog; package all verified Diamond exports into one ZIP; retain firmware and diagnostics.
   * - ``publish-firmware``
     - On every push, after successful Diamond, Linux and Windows jobs, publish the firmware ZIP as a uniquely named GitHub testing prerelease.
   * - ``deploy``
     - After successful Linux and Windows checks on ``master``, configure Pages and deploy the uploaded HTML through the ``github-pages`` environment.

Diamond jobs require the private image credentials and its bundled license and run independently of the documentation deployment gate.
Pull requests omit Diamond builds, firmware publication and Pages deployment.
Manual runs build and retain Diamond firmware without publishing a GitHub Release.
Release catalogs are attempted sequentially even if an earlier catalog fails; any failure prevents ZIP publication.
After the license-free image succeeds, independent firmware and documentation steps still run if an earlier check fails, so their diagnostics are available.
The pilot comparison runs only after its firmware build succeeds.
Artifact retention is attempted even after failures, with a 14-day retention period.

Each firmware build performs these shared tasks:

#. Resolve the release, catalog entry, manifest, target, sources, constraints and backend; validate inputs and check generator-managed files for drift.
#. Obtain workspace and build locks, reload the configuration and protect externally edited generated project settings.
#. Clear previous published firmware and reports, mark the attempt running and hash the inputs and build implementation.
#. Reserve the registered firmware identity and prepare the backend project with generated constraints containing its USERCODE.
#. Execute the backend stages listed below and retain tool logs.
#. Check that inputs stayed unchanged and fresh, nonempty firmware exports exist; for Diamond, verify the tool version and JEDEC USERCODE.
#. Publish firmware and reports, record artifact hashes, tool information, identity, warnings and source provenance, and mark success.
#. On failure, remove published outputs and record the error while retaining logs and intermediates.

Diamond compilation performs these tasks in order:

#. Synthesize VHDL with the configured LSE or Synplify engine.
#. Translate and map the design; export and retain the mapped Verilog simulation netlist.
#. Place and route, then run ``PARTrace`` for timing reports.
#. Export routed Verilog and SDF using ``TimingSimFileVlg``.
#. Export the ``.bit`` and ``.jed`` firmware files using ``Bitgen`` and ``Jedecgen``.

FOSS compilation performs these tasks in order:

#. Check tool versions and device support; analyze VHDL libraries with GHDL and synthesize Verilog.
#. Run Yosys MachXO2 synthesis and retain the RTL reference and mapped JSON netlist.
#. Prove RTL-to-mapped equivalence; for sequential designs, run eight-cycle initialized-output and retained-match-point checks and record their results.
#. Remove unused input ports from the routing copy, normalize oscillator configuration and translate LPF/package constraints.
#. Run ``nextpnr-machxo2`` placement, routing and timing reporting.
#. Complete device, bank and electrical configuration, including open-drain settings.
#. Pack a compressed bitstream with USERCODE using ``ecppack``; unpack it with ``ecpunpack`` to check format/CRC and verify open-drain configuration.

Startup counterexamples are recorded by the FOSS build; the pilot ``compare`` command requires passing initialized-state checks as well as equivalence and six event-driven heartbeat scenarios.
This CI comparison uses only the FOSS backend and does not establish Diamond equivalence.

The documentation command performs these tasks for each selected program:

#. Validate program inputs, export generic RTL schematics where supported and extract state diagrams.
#. Run GHDL/cocotb simulations through pytest and verify that analysis and simulation used the same HDL inputs.
#. Generate interactive waveform and RTL viewers, copy SVG/PDF/VCD files and provenance, and assemble program pages grouped by release.
#. Clear the previous HTML output, build Sphinx with warnings treated as errors and check local page, image, iframe and download links.

The retained diagnostics include firmware projects, logs, reports and metadata, simulation traces, netlists, state diagrams, comparison evidence, catalog summaries and the CI identity registry.
These tasks do not program hardware or establish board timing acceptance; see :doc:`validation` and :doc:`foss` for qualification limits.

Firmware commands
-----------------

::

   make help
   make list
   make check program=tx30
   make doctor
   make program=tx30
   make build-all
   make report backend=foss
   make build program=tx30 backend=foss

``check`` validates manifests and files; ``doctor`` also checks the selected tools.
The FOSS doctor requires a selected cycle containing at least one FOSS program so it can check the declared device and tool version.
``build-all`` processes the explicit ``programs/<release_cycle>/catalog.toml`` list and fails if any entry fails.
It also writes ``cpld_toolchain/toolchain/build/validation/<release_cycle>/<backend>-catalog/report.md`` and ``report.json`` after attempting every valid selected build, even if a tool fails. Invalid program manifests appear as failed report rows and do not prevent other programs from building.
``make report backend=diamond|foss`` refreshes the selected catalog report from existing build records without invoking firmware tools.
Invalid manifests and stale generator outputs appear as failed rows; the report includes the other programs, and the command exits with a failure status after writing the report.
The report checks recorded input and output hashes, lists missing or failed builds, proof and startup results, warning counts, and the recorded timing acceptance status.
Use ``target=...`` to write a separate target-filtered report.
Bare ``make`` shows the command overview; ``make program=tx30`` builds one program.
The target is inferred from each program manifest; ``target=uz_dslot_xo2`` or
``target=uz_s3c_xo2`` selects or filters it explicitly. ``backend`` selects
``diamond`` (default) or ``foss``.
See :doc:`foss` for open-source setup, artifacts and validation limits.
Diamond and FOSS commands use installed tools in the calling environment.
Firmware commands never flash a device.

Create a program
----------------

Use :ref:`generator-quickstart` to create a D-slot project from CSV routing.
See :doc:`vhdl-generator` for routing, configuration and generated-file ownership.

To clone a program for manual logic and testbench editing::

   make new name=my_adapter template=tx30

Edit the cloned VHDL, LPF, cocotb testbench and optional ``description.rst``, then validate, simulate and build as shown in :doc:`quick-start`.
``template`` defaults to ``tx30``.
For an S3C program, use ``template=s3c_toolchain_test_program``; its starter logic holds carrier power and slot output enables inactive.
Cloning copies the selected program's current files, preserves entity names and libraries, and excludes generated ``build/`` directories and Python caches.
The source declaring the top entity in library ``work`` becomes ``<name>.vhdl``; its original filename can differ from the template name.
Cloning requires a program-local top-level source, constraints and testbench, and no authored symlinks, and refuses an existing destination.
Shared HDL references, including ``xo2_library``, remain shared for both handwritten and generated programs; they are resolved relative to the clone without copying the library.
Generated templates require program-local ``generator.toml`` and routing CSV files.
The shared S3C HDL and selected contract retain their configured locations.
A clone owns its local files and continues to use the shared dependencies declared by the template.
It is added to ``programs/<release_cycle>/catalog.toml`` after its manifest validates.
It also receives a new permanent program number in ``programs/usercodes.json``; commit that registry with the new program.
Catalog registration includes the program in ``build-all``, netlist export and firmware CI for the selected cycle.
Simulation and documentation discover complete program manifests independently of catalog membership.
Documentation groups program manifests by release cycle, including programs created outside ``make new``.

Outputs and failures
--------------------

``programs/<release_cycle>/<name>/build/<target>_<backend>/`` contains the generated ``project/``, retained ``logs/``, published ``reports/`` and ``metadata/`` directories.
Diamond publishes ``<name>_<target>_diamond.jed`` and ``<name>_<target>_diamond.bit`` at this directory level; FOSS publishes ``<name>_<target>_foss.bit``.
``metadata/`` contains ``build.json``, ``identity.json``, ``configuration.json``, ``status.json``, the FOSS build plan and generated JSON reports.
The backend directory itself contains only the named firmware files; ``project/`` retains other tool inputs and intermediates.

A build that passes the lock/configuration guards removes previous firmware, reports and provenance before invoking the selected backend.
Preparation or compilation failure preserves logs without publishing stale firmware.
An earlier rejection, such as an invalid manifest or edited generated settings, leaves previous outputs untouched.
``project`` regenerates project files without refreshing firmware; consult ``metadata/build.json`` for the inputs used by an export.

GUI and cleanup
---------------

With a native Diamond installation and display::

   make project program=tx30
   make gui program=tx30
   make clean program=tx30

Diamond projects reference authored HDL and a generated copy of the LPF containing the allocated USERCODE.
For manually maintained programs, edit the authored HDL and LPF, then regenerate the project.
See :doc:`firmware-identity` for program numbers and automatic build revisions.
For generator-managed programs, edit the CSV or generator configuration and run ``make generate program=NAME``.
Check the destination when saving from Spreadsheet View, because an exported LPF does not replace the authored input automatically.
Transfer useful project/strategy changes into manifests or the target strategy before regenerating.
``gui`` preserves an existing project, while ``project``, ``build`` and ordinary ``clean`` reject edited generated settings.
After preserving useful changes, ``make clean program=tx30 discard_project_changes=1`` explicitly discards them.
``clean`` removes only the selected backend firmware directory and preserves simulation, netlist and shared lock files in ``cpld_toolchain/toolchain/build/locks/``.
Cleanup does not require fresh generated VHDL or present HDL input files; it still validates the output location, obtains the build lock and protects edited generated project settings.
Build, GUI, simulation and netlist operations use advisory locks in ``cpld_toolchain/toolchain/build/locks/`` to prevent concurrent changes to one program; independently launched GUI sessions cannot honor them and must be closed before a build.

Remove all generated files
--------------------------

Run ``make clean-all`` from the repository root.
It removes every program ``build/`` directory, ``cpld_toolchain/toolchain/build/``, ``docs/_build/``, ``docs/_generated/``, ``.venv/`` and Python caches within the repository.
It refuses to run while a managed build, project, GUI, simulation, netlist or clean operation is active. A lock on the checkout directory also prevents new operations from starting during cleanup, even while generated lock files are removed.
It discards generated project edits and validation evidence; authored HDL, constraints, manifests and testbenches remain.
The tracked identity registry remains, including allocated numbers and recorded build revisions.
Cleanup removes a local ``make flasher-build`` installation under ``cpld_toolchain/toolchain/build/``; the container's installed patched loader is unaffected.
