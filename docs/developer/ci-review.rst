CI review and remaining work
============================

This review covers commit ``ff9a106`` and `CI run 37774270420 <https://github.com/ultrazohm/uz_cpld/actions/runs/37774270420>`_ on 2026-10-08.
The run passed and published its release: 81 Diamond builds passed routed timing checks, 23 FOSS builds completed, and 81 HDL simulations passed.
The fixes below are recommendations, not changes already implemented; update this page as they are resolved.
USERCODE allocation is outside this review.

Problems to fix
---------------

Skipped generated-heartbeat simulation
   ``test_heartbeat_generation.py`` accepts skipped simulations.
   Skipping its only HDL test was enough to reproduce a passing Python test without running the simulation.
   **Fix:** reuse strict simulation-result checking and reject empty, skipped, failed or errored HDL results.

Stale dependencies in a Dev Container
   ``ci.sh`` checks Python and uv versions, but not whether installed packages match the checkout.
   Automatic dependency synchronization is disabled in the image.
   **Fix:** record dependency-input hashes in the image and require a rebuild when they differ.
   Until then, rebuild after changing ``pyproject.toml`` or ``uv.lock``.

Empty Python test suites can pass
   The pinned Python 3.10 reports success when discovery finds zero tests, so moving or renaming tests can silently remove coverage.
   **Fix:** require each intended suite to contain at least one test, without hard-coding the total count.

Standalone Linux test still exposes system Python
   ``distribution/smoke.py`` uses ``PATH=/usr/bin:/bin``, which still contains Python.
   It does not prove that the packaged executable works without external Python.
   **Fix:** launch the executable by absolute path with a controlled ``PATH`` that excludes Python.

Newest publication can be cancelled while waiting
   ``cancel-in-progress: false`` protects running jobs, but GitHub normally replaces an existing pending job when another arrives.
   An older build finishing late can replace the newest pending publication, then skip itself because it is no longer the branch head.
   **Fix:** add ``queue: max`` to release and Pages concurrency groups and retain the branch-head check.
   See `GitHub concurrency rules <https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/control-workflow-concurrency>`_.

Invalid TRACEID constraints do not fail the build
   All 29 D-slot builds in ``heartbeat`` specify a ten-bit ``TRACEID``; Diamond accepts only eight bits and warns, then continues building.
   TRACEID is separate from USERCODE.
   **Fix:** correct the authored LPFs to a supported value and reject unexpected constraint errors before publishing firmware.

Deprecated GitHub Action runtimes
   Checkout, Python setup and artifact actions declare Node 20, while the runner forces them to use Node 24.
   They worked in this run but rely on an automatic runtime override.
   **Fix:** update the affected actions to releases supporting Node 24 and rerun their jobs.
   See `GitHub's Node 20 removal notice <https://github.blog/changelog/2026-09-23-node-20-is-no-longer-available-in-github-actions/>`_.

Warning totals hide useful information
   The Diamond summary counts 3,695 warning lines, including 154 lines reporting zero errors and zero warnings.
   It mixes rejected settings with unused ports and inapplicable slew settings.
   **Fix:** count actual warnings, group repeats, show affected programs, and clean up unnecessary constraints.
   Reject unexpected discarded settings; do not make every existing warning fatal without reviewing it.

Known hardware limits
---------------------

* **Startup:** ``s3c_power_on_debounce`` and ``s3c_rev6_beta`` have documented FOSS startup-proof exceptions.
  Diamond also ignores initial values in the former.
  Define the intended startup outputs, correct the RTL, and repeat proof and hardware checks before removing the exceptions.
* **S3C JTAG access:** four Diamond builds retain ``JTAG_PORT=DISABLE`` and depend on physical ``JTAGENB`` configuration.
  Verify access and recovery on the board before changing it; see :doc:`../hardware-test-2026-10-07`.
* **Timing:** Diamond checks existing routed constraints, while FOSS timing is not an acceptance gate.
  Define and validate board I/O timing budgets before claiming hardware timing acceptance.

Expected log messages
---------------------

* Checksum mismatches, malformed archives and ``Failed programs`` messages appear in passing tests that deliberately supply bad inputs.
  Capture and assert those diagnostics to reduce misleading output.
* Windows skips eight GHDL-dependent tests; Linux runs the HDL checks.
  Four browser tests are optional and skipped on Linux.
  Keep exclusions visible, or move browser checks into an explicitly optional suite.
* uv successfully falls back from hardlinks to copying.
  Set ``UV_LINK_MODE=copy`` where copying is expected to suppress the warning.
* The Windows executable passed its smoke test despite an ``api-ms-win-core-path-l1-1-0.dll`` warning.
  This matches a `known PyInstaller API-set warning <https://github.com/orgs/pyinstaller/discussions/6200>`_; it does not by itself show a broken executable.

Simplification candidates
-------------------------

* Replace exhaustive Make help/preview subprocess loops with representative wrapper cases.
  The two loops took about 27 seconds locally; retain cheap exhaustive command-contract tests and cases for quoting, invalid arguments and working directories.
* Remove Windows workflow dry runs already covered by its test suite.
  Keep actual environment setup, native programmer checks and packaged-executable smoke tests.
* Remove obsolete Diamond startup-marker formatting checks now that the marker no longer controls retries.
  Keep failure-propagation, no-retry and diagnostic-preservation tests.
* Remove literal Dockerfile and ``.dockerignore`` assertions where image builds already check the requirement.
  Retain useful container-startup behavior tests.

Older firmware catalogs are still published, so their HDL, routing, timing and archive checks remain relevant.
Keep the shared ``ci.sh`` entry point; these fixes do not require a new CI framework.

Checking fixes
--------------

From the repository root, run::

   bash ci.sh

On the host this builds and runs the toolchain container; inside a Dev Container it uses the existing environment.
It covers Linux tooling, FOSS builds, simulations and documentation.
Windows, licensed Diamond builds and publication still need their corresponding jobs.
Check retained reports as well as job status, and update resolved items above with the evidence that closes them.
