Verification and limits
=======================

Run the tooling tests, HDL simulations, FOSS firmware builds and documentation checks from the repository root::

   make test
   make sim
   make build_all backend=foss
   make docs

``make test`` runs the Python tooling tests with installed dependencies.
Firmware catalog commands (``list``, ``build_all``, ``report`` and catalog netlist export) select programs from ``programs/<release_cycle>/catalog.toml``.
Simulation and documentation discover all complete program manifests, including programs outside that catalog.
``target=uz_dslot_xo2`` or ``target=uz_s3c_xo2`` filters firmware builds, and backend selection respects each program's ``backends`` list.
``make generate program=NAME`` registers completed generator projects in the catalog; unfinished starters are excluded.
``make check program=tx30 release_cycle=original`` validates a manifest and its input files, while ``make doctor backend=foss`` inventories tools and the selected catalog without serving as a readiness gate.
``make compare program=cvg_tx30 release_cycle=heartbeat_cvg backend=foss`` is a separate FOSS-only functional netlist check.
Diamond and implicit combined comparison requests fail explicitly because real Diamond exports are not yet supported by the comparison importer.
This does not affect ``make check`` or Diamond firmware builds.
See :doc:`foss` for the limitation and CI coverage.
For Diamond, run ``make doctor backend=diamond`` and ``make build_all backend=diamond`` in a licensed environment.
The GitHub Actions Diamond job temporarily disables host ASLR before launching the build container, then restores the recorded setting in an ``always()`` cleanup step.
Diamond project-cleanup failures remain build failures; the workflow does not treat a firmware export as successful after a vendor error.
Diamond commands run once without automatic retries, including native local builds; failures retain their logs and partial project state and prevent firmware publication.
Local builds do not change the host ASLR setting automatically.
Generated firmware provenance, tool identity, input hashes and output hashes are in each backend directory's ``metadata/build.json``; simulation provenance is in ``build/simulation/metadata/run.json``.
A passing simulation checks the behavior exercised by its testbench.
A successful firmware build verifies fresh exports and unchanged authored inputs; the FOSS build also checks synthesis equivalence and bitstream format.
Both firmware backends embed the registry-assigned USERCODE; managed programming checks the selected identities against post-write device readback.
The flasher's native tests mock JTAG operations, and parser-only checks do not access hardware.
These software checks do not establish live programming or identity-readback behavior; see :doc:`firmware-identity`.
For both S3C controllers, FOSS also verifies the packed electrical fields of the two bank-2 open-drain outputs against Diamond before export.
This check covers pins 41 and 50; it does not compare all electrical settings.
Details and per-pin results are in :doc:`/foss` and ``metadata/reports/constraints.json``.
The sequential FOSS induction check alone does not prove startup alignment.
The initialized-state miter passes for ``cvg_tx30_stateful`` and records output counterexamples for both ``s3c_power_on_debounce`` and ``s3c_rev6_beta``; a successful export does not establish initial-state equivalence for either controller.
Both controllers leave some output registers unspecified before their startup assignments execute.
The strict startup comparison allows arbitrary binary values for uninitialized reference registers, while mapped flip-flop models supply definite initial values.
FOSS builds reject unexpected startup counterexamples before exporting firmware.
The only accepted exceptions are output counterexamples for ``original/s3c_power_on_debounce`` and ``original/s3c_rev6_beta`` on ``uz_s3c_xo2``.
Tool errors and internal match-point counterexamples still fail, including for these controllers.
Accepted exceptions are recorded explicitly in ``equivalence.json`` and printed as warnings; they do not establish startup equivalence.
Each exception in ``cpld_toolchain/toolchain/foss/startup-exceptions.json`` is tied to SHA-256 fingerprints of the reviewed sources, manifests, build/proof code, pinned tool inputs and the GHDL/Yosys versions and binaries.
Changing those inputs invalidates the waiver.
Review the new proof and counterexample before updating a fingerprint; CI never refreshes it.
An eight-step diagnostic comparison that marks unspecified initial registers unknown and ignores undefined reference outputs passes for both controllers; it does not replace the strict check or establish hardware startup behavior.
The 18 combinational D-slot programs in ``original`` use combinational equivalence checks and have no sequential startup check.
``make report backend=foss`` or ``make report backend=diamond`` checks existing build evidence for stale inputs and outputs without rebuilding.
Neither command establishes hardware behavior or a timing acceptance limit.
Diamond builds require a recognizable final routed ``firmware_impl.twr`` report with scored paths and no timing errors.
Missing reports, unrecognized reports or failed final constraints prevent firmware publication.
Intermediate synthesis estimates are not used for this gate.
The result is saved in ``metadata/reports/timing.json``.
This validates the tool's routed constraints; the authored LPFs contain no board timing budget, so inspect board-specific electrical settings and define those budgets before hardware acceptance.

Recorded hardware test
----------------------

See :doc:`hardware-test-2026-10-07` for the completed Diamond/FOSS programming, identity cross-reading and power-cycle checks on one UltraZohm system.

CI coverage and release gates
----------------------------------------

``bash ci.sh`` runs the Linux checks locally and in GitHub Actions.
On a Linux host it builds and enters the shared container; inside the Dev Container it runs directly.
It requires no native Python setup on the host.
It retains each check's log and attempts independent checks after failures, but returns failure if any check fails.
See :doc:`builds` for coverage and the checks that need other environments.

The main workflow calls the native Windows FOSS programmer workflow on every push, pull request and manual run.
The programmer workflow can also be dispatched manually.
Testing release publication requires its success alongside Diamond, Linux checks, Windows Python and standalone packaging jobs.
Release publication is serialized per branch and Pages deployment is serialized for the site.
Immediately before publishing, each job checks the current branch head through the GitHub API.
An obsolete commit is skipped; an API failure blocks publication.
Testing releases are published from branch pushes, not tag pushes.

Job summaries list skipped tooling tests, firmware warnings, startup exceptions and validation limits.
Linux retains the tooling test log in program diagnostics.
Four optional browser tests require Playwright/Chromium and ``CPLD_BROWSER_TESTS=1``; the normal Linux job does not enable them.
Windows skips HDL tests when GHDL is unavailable; those checks run in the Linux toolchain environment.
Summaries describe coverage and do not replace job exit-status checks.
HDL simulation summaries read cocotb XML results separately from tooling tests.
Every HDL case must pass; skipped, failed and errored cases block simulation and documentation generation.
Successful simulation metadata records the case count.

Board timing acceptance still requires program timing budgets; the Diamond gate checks only the constraints already present in the final routed report.
Standalone smoke checks use fixtures and dry runs.
Native programmer tests run inside MSYS2 without USB hardware; they do not qualify Windows hardware drivers or a redistributable programmer bundle.
