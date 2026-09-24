Simulation and tests
====================

::

   make test-container
   make sim
   make sim program=tx26_w_enable seed=42
   make sim program=tx30 wave_format=ghw
   make sim program=rx30 wave_format=fst

``make test`` runs Python tooling regressions, including mocked vendor failures and VCD interpretation; it does not establish synthesis success.
``make sim`` runs the catalog, or the single selected program, using the actual manifest HDL and its cocotb testbench.
The runner selects each program's declared target and accepts ``work`` sources; Make target/backend overrides are not simulation parameters.
A missing program or failed assertion produces a failing command.

Behavior
--------

The ``tx30`` test drives all inputs low and high, then raises and lowers each input separately while checking every route.
It requests safe state with all inputs high and checks that all outputs fall low and recover afterward.
The other D-slot testbenches apply all-zero, all-one, walking-one and walking-zero data patterns with safe-state transitions ``0 → 1 → 0``.
``s3c_toolchain_test_program`` checks its fixed safe-state outputs.
``s3c_power_on_debounce`` drives the archived controller's internal clock and checks its initial safe-state request, disabled slot outputs, and carrier power request. It does not cover the ready or shutdown transitions.
``tx26_w_enable`` additionally tests all 16 combinations of its four enable pins.
The D4 and D5 resolver tests check their adapter routes, physical wire-swap compensation and safe-state status without gating data.
Pilot, carrier-ready and I2C inputs are held low; exhaustive auxiliary-input combinations and randomized stimulus are excluded.
The tests are deterministic, while ``seed`` is recorded for programs that use random stimulus.

Cocotb drives inputs and checks outputs while GHDL executes the VHDL.
``await Timer(1, unit="ns")`` advances simulated time by 1 ns; the test ends when its coroutine completes or an assertion fails.
The simulated duration of each run is recorded in ``metadata/run.json``.
These waits allow combinational logic to settle and are not device timing requirements.

Results
-------

``programs/<name>/build/simulation/`` contains compiler/simulation logs, cocotb result XML and ``waves.vcd``; ``metadata/run.json`` records provenance.
VCD is a portable text waveform; optional GHW preserves GHDL/VHDL type information and optional FST is more compact.
Selecting GHW or FST emits that file alongside VCD.
``toolchain/build/simulation/junit.xml`` is the aggregate pytest report.
Reruns replace program results, and concurrent managed operations on the same program/target are rejected.

Open VCD with GTKWave or use the interactive :doc:`program pages <program-documentation>`::

   gtkwave programs/tx26_w_enable/build/simulation/waves.vcd
