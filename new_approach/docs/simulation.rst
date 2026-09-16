Simulation and tests
====================

::

   make test-container
   make sim
   make sim PROGRAM=tx26_w_enable SEED=42
   make sim PROGRAM=tx30 WAVE_FORMAT=ghw
   make sim PROGRAM=rx30 WAVE_FORMAT=fst

``make test`` runs Python tooling regressions, including mocked vendor failures and VCD interpretation; it does not establish synthesis success.
``make sim`` runs the catalog, or the single selected program, using the actual manifest HDL and its cocotb testbench.
The runner selects ``uz_dslot_xo2`` and accepts ``work`` sources; Make target/backend overrides are not simulation parameters.
A missing program or failed assertion produces a failing command.

Behavior
--------

The tests apply all-zero, all-one, walking-one and walking-zero data patterns with safe-state transitions ``0 → 1 → 0``.
``tx26_w_enable`` additionally tests all 16 combinations of its four enable pins.
Pilot, carrier-ready and I2C inputs are held low; exhaustive auxiliary-input combinations and randomized stimulus are excluded.
The tests are deterministic, while ``SEED`` is recorded for programs that use random stimulus.

Cocotb drives inputs and checks outputs while GHDL executes the VHDL.
``await Timer(1, unit="ns")`` advances simulated time by 1 ns; the test ends when its coroutine completes or an assertion fails.
The complete tests span 186 ns for ``tx30`` and ``rx30``, and 2592 ns for ``tx26_w_enable``.
These waits allow combinational logic to settle and are not device timing requirements.

Results
-------

``programs/<name>/build/simulation/`` contains compiler/simulation logs, cocotb result XML, ``run.json`` provenance and ``waves.vcd``.
VCD is a portable text waveform; optional GHW preserves GHDL/VHDL type information and optional FST is more compact.
Selecting GHW or FST emits that file alongside VCD.
``toolchain/build/simulation/junit.xml`` is the aggregate pytest report.
Reruns replace program results, and concurrent managed operations on the same program/target are rejected.

Open VCD with GTKWave or use the interactive :doc:`program pages <program-documentation>`::

   gtkwave programs/tx26_w_enable/build/simulation/waves.vcd
