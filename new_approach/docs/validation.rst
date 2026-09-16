Validation and release acceptance
=================================

Evidence
--------

.. list-table:: Validation scope
   :header-rows: 1

   * - Check
     - Evidence
   * - Tooling regressions
     - 22 tests covering manifest validation, cloning, locking, cleanup, failure handling, Tcl quoting, VCD interpretation and static-site publishing checks.
   * - RTL simulation
     - Passing routing, enable and safe-state tests for all three catalog programs.
   * - Diamond builds
     - Fresh JEDEC and bitstream exports for all three programs with Diamond 3.14.0.75.2.
   * - Legacy comparison
     - Matching JEDEC programming records, pin-table rows and resource counts against rebuilt legacy projects.
   * - Portability
     - Standalone checkout paths with spaces, cloned-program simulation and generated documentation.
   * - Documentation
     - Strict Sphinx 7.4.7 build, 33 HTML files checked for local links, and Chromium checks of all three program pages under ``/uz_cpld/`` with external requests blocked.
   * - Publishing configuration
     - Actionlint validation and Dev Container build-path checks; a fresh Docker build and hosted deployment remain unverified.

These comparisons concern rebuilt legacy projects, not proof that every committed firmware binary matches its source.
Whole-file JEDEC hashes can differ because of metadata, and bitstream payload equivalence is not established.
Saved local evidence is under ``toolchain/build/validation/`` and historical ``build/validation/`` directories; a clean checkout must regenerate it.

Repeat the licensed comparison after ``make build-all``::

   python3 toolchain/tests/validate_diamond.py --legacy-project /path/to/uz_d_slots.ldf

Without ``--legacy-project``, the command checks a cloned program in a relocated checkout.
Legacy inputs remain untouched, and integration logs/results are retained under ``toolchain/build/validation/``.

Release acceptance
------------------

* Review pin/electrical settings against the board and adapter.
* Define timing budgets and compare reports against them.
* Verify native GUI source editing, Spreadsheet View save destinations and subsequent headless rebuilding.
* Validate the adapter on hardware and preserve its release evidence with firmware and source revision.

The recorded maximum enumerated delays are 13.905 ns for ``tx30``, 10.544 ns for ``rx30`` and 16.043 ns for ``tx26_w_enable``; these are observations rather than acceptance limits.
The LPFs define no timing budget, and successful export does not establish timing closure.
Known review items are nonexistent ``CPLD_DIGOUT_01`` references in ``rx30``/``tx26_w_enable``, ignored slow-slew preferences on ``rx30`` LVCMOS18 outputs, the SPI SN pull-up warning and the strategy's permissive preference-error setting.
Native GUI round-trip checks, hardware qualification and a hosted Pages deployment require their respective environments.
