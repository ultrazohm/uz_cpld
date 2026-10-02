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

Investigating Diamond preparation crashes
-----------------------------------------

The temporary **Diagnose Diamond preparation crashes** Actions workflow runs manually.
Start with the ``baseline`` variant and 100 attempts. It runs ordinary and traced
preparation in the normal image, then ordinary and GDB preparation in a separate
debugger image. Both debugger-image experiments use the same traced Tcl, allowing
comparison of normal/traced, debugger-image/traced and debugger-image/GDB runs
one variable at a time. Each attempt starts with a fresh project and has no automatic retry.
If the isolated baseline runs pass, the optional catalog step exercises the original full
build sequence. The workflow fails on every observed crash, including crashes
recovered by the catalog's existing retry. It does not publish firmware.

Use ``seed_run_id`` to replay the ``baseline.sty``, ``constraints.lpf`` and
``prepare.tcl`` from an earlier run's ``diamond-diagnostics`` artifact. Check out
matching HDL sources when comparing with that run; the evidence records source
hashes. Without a seed, the reproducer uses the current production preparation
commands and an existing registered USERID, without allocating an identity or
producing firmware.

For a local comparison in a licensed Linux environment::

   python3 -m toolchain.diagnose_diamond replay --attempts 100 --mode plain --output /tmp/diamond-plain
   python3 -m toolchain.diagnose_diamond replay --attempts 100 --mode traced --output /tmp/diamond-traced

Output directories must be new. ``--program`` defaults to
``original/uz_d_voltage_013_tx30``. ``--seed-project PATH`` accepts the extracted
project directory from the diagnostic archive. Compare the same image contents,
source revision and runtime flags before attributing a difference to the CI host.
The ``private-home`` and ``fresh-tmp`` variants change only ``HOME`` or ``TMPDIR``;
run them separately after establishing a failing baseline.

The ``diamond-crash-investigation`` artifact contains image identities,
environment and native-library fingerprints, per-attempt results, flushed Tcl
markers, generated projects and available stack traces. Ordinary-process core
dumps stay on the disposable runner and are excluded from uploads; at most three
cores are kept per isolated experiment. GDB preserves address randomization and
records the actual inferior exit or signal. Missing debugger results are failures.
Compare ``environment.json`` files from the normal and debugger images, since
installing debugger dependencies may also change libraries. Startup library
fingerprints come from ``ldd`` under the vendor environment; crash reports include
the libraries actually loaded at the failure.

Normal CI also enables ``CPLD_DIAMOND_TRACE=1``. Failed preparations are retained in
``logs/*-crash`` before a retry resets the working project. Trace markers locate
the last Tcl command; a native stack trace is still needed to identify the fault.
``CPLD_DIAMOND_KEEP_CORES=1`` is used only by the diagnostic catalog run.

After identifying a candidate fix, compare failing and fixed configurations on
the same runner, then require zero crashes over at least 300 preparations across
three fresh runners and successful full-catalog builds with verified exports.
Remove the temporary workflow, reproducer and debugger Dockerfile once the cause
and fix are established; keep the useful failure logging.

The **Trace Diamond close and exit crashes** workflow is retained for manual runs. The previous comparison observed 11/300 crashes
with explicit close and 13/300 without it, all no-close failures after the
``BEFORE_EXIT`` marker. Removing close is therefore not a workaround. Production
preparation always saves and explicitly closes the project; ``--no-close`` is
retained only in the diagnostic reproducer.

Three fresh runners each execute 100 preparations per arm in one normal image,
retaining at most three cores per arm. A temporary GDB layer analyzes those
cores, then traces another 100 no-close attempts live. The middle runner reverses
the ordinary arms' order. Core capture uses a temporary runner configuration
which is restored afterward. The ``diamond-exit-traces-N`` artifacts contain
native stacks, runtime fingerprints, scripts and results, but exclude raw cores.
Observed crashes keep the diagnostic red; zero crashes do not establish a fix.
No firmware catalog is built or published by this trace workflow.

The **Compare Diamond glibc runtimes** workflow now runs on pushes to
``codex/diamond-diagnosis``. Each of three fresh runners builds the normal
image and derives a candidate by upgrading only ``libc6`` and ``libc-bin``
from ``2.35-0ubuntu3.14`` to ``2.35-0ubuntu3.15``. Package inventories and
native-library hashes must confirm that unrelated dependencies and Diamond
libraries are unchanged. The experiment fails setup if these exact versions
are unavailable or the control has already changed.

Both arms use explicit close, identical preparation inputs and runtime options,
with 100 attempts per arm and reversed order on the middle runner. A clean
candidate proceeds to all catalogs and firmware packaging checks. Any catalog
retry or crash rejects it. Control segfaults are expected evidence, but other
control failures invalidate the comparison. No control crashes makes an
otherwise passing comparison inconclusive. The ``diamond-runtime-comparison-N``
artifacts retain fingerprints, attempt logs and catalog results. Normal images
and published firmware continue to use the existing production configuration.
