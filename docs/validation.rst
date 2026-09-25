Verification and limits
=======================

Run the tooling tests, HDL simulations, FOSS firmware builds and documentation checks from the repository root::

   make test-container
   make sim
   make build-all backend=foss
   make docs

``make test`` runs the Python tooling tests with installed dependencies.
Catalog-wide commands now include the D-slot programs and both S3C programs;
``target=uz_dslot_xo2`` or ``target=uz_s3c_xo2`` filters firmware builds.
FOSS ``build-all`` includes all catalog programs, including ``tx30_stateful`` and ``s3c_power_on_debounce``.
``make check program=tx30`` validates a manifest and its input files, while ``make doctor backend=foss`` checks the FOSS tool installation.
For Diamond, run ``make doctor backend=diamond`` and ``make build-all backend=diamond`` in a licensed environment.
Generated firmware provenance, tool identity, input hashes and output hashes are in each backend directory's ``metadata/build.json``; simulation provenance is in ``build/simulation/metadata/run.json``.
A passing simulation checks the behavior exercised by its testbench.
A successful firmware build verifies fresh exports and unchanged authored inputs; the FOSS build also checks synthesis equivalence and bitstream format.
Neither command establishes hardware behavior or a timing acceptance limit.
The authored LPFs contain no timing budget, so inspect the reports and board-specific electrical settings before using firmware on hardware.
