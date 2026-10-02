Verification and limits
=======================

Run the tooling tests, HDL simulations, FOSS firmware builds and documentation checks from the repository root::

   make test
   make sim
   make build-all backend=foss
   make docs

``make test`` runs the Python tooling tests with installed dependencies.
Firmware catalog commands (``list``, ``build-all``, ``report`` and catalog netlist export) select programs from ``programs/<release_cycle>/catalog.toml``.
Simulation and documentation discover all complete program manifests, including programs outside that catalog.
``target=uz_dslot_xo2`` or ``target=uz_s3c_xo2`` filters firmware builds, and backend selection respects each program's ``backends`` list.
``make generate`` registers completed generator projects in the catalog; unfinished starters are excluded.
``make check program=tx30`` validates a manifest and its input files, while ``make doctor backend=foss`` checks the FOSS tool installation.
For Diamond, run ``make doctor backend=diamond`` and ``make build-all backend=diamond`` in a licensed environment.
Generated firmware provenance, tool identity, input hashes and output hashes are in each backend directory's ``metadata/build.json``; simulation provenance is in ``build/simulation/metadata/run.json``.
A passing simulation checks the behavior exercised by its testbench.
A successful firmware build verifies fresh exports and unchanged authored inputs; the FOSS build also checks synthesis equivalence and bitstream format.
Both firmware backends embed the registry-assigned USERCODE; managed programming checks the selected identities against post-write device readback.
The flasher's native tests mock JTAG operations, and parser-only checks do not access hardware.
These software checks do not establish live programming or identity-readback behavior; see :doc:`firmware-identity`.
For both S3C controllers, FOSS also verifies the packed electrical fields of the two bank-2 open-drain outputs against Diamond before export.
This check covers pins 41 and 50; it does not compare all electrical settings. Details and per-pin results are in :doc:`/foss` and ``metadata/reports/constraints.json``.
The sequential FOSS induction check alone does not prove startup alignment.
The initialized-state miter passes for ``cvg_tx30_stateful`` and records output counterexamples for both ``s3c_power_on_debounce`` and ``s3c_rev6_beta``; a successful export does not establish initial-state equivalence for either controller.
Both controllers leave some output registers unspecified before their startup assignments execute.
The strict startup comparison allows arbitrary binary values for uninitialized reference registers, while mapped flip-flop models supply definite initial values.
An eight-step diagnostic comparison that marks unspecified initial registers unknown and ignores undefined reference outputs passes for both controllers; it does not replace the strict check or establish hardware startup behavior.
The other 18 D-slot programs use combinational equivalence checks and have no sequential startup check.
``make report backend=foss`` or ``make report backend=diamond`` checks existing build evidence for stale inputs and outputs without rebuilding.
Neither command establishes hardware behavior or a timing acceptance limit.
The authored LPFs contain no timing budget, so inspect the reports and board-specific electrical settings before using firmware on hardware.
