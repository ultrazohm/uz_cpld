Simulation and tests
====================

::

   make test
   make sim jobs=4
   make sim program=tx26_w_enable seed=42
   make sim program=tx30 wave_format=ghw
   make sim program=rx30 wave_format=fst

``make test`` runs Python tooling regressions, including mocked vendor failures and VCD interpretation; it does not establish synthesis success.
``make sim`` discovers every program manifest in the selected release cycle, or runs the single selected program, using the actual manifest HDL and its cocotb testbench.
The runner selects each program's declared target, compiles sources in their declared libraries and elaborates the top entity in ``work``.
Make target/backend overrides are not simulation parameters.
A missing program or failed assertion produces a failing command.

Parallel execution
------------------

``jobs`` limits the number of programs simulated concurrently (default: 4).
Use ``make sim jobs=1`` for one worker. Pytest-xdist assigns each program to a separate worker process;
each cocotb testbench and its GHDL simulation run normally within that worker.
Programs keep separate build directories, waveforms and logs; pytest combines their results into one JUnit report.
Generator configurations without a generated program manifest are skipped.

Behavior
--------

The ``tx30`` test drives all inputs low and high, then raises and lowers each input separately while checking every route.
It requests safe state with all inputs high and checks that all outputs fall low and recover afterward.
D-slot routing testbenches exercise data patterns and safe-state transitions.
``s3c_toolchain_test_program`` checks its fixed safe-state outputs.
``s3c_power_on_debounce`` drives the archived controller's internal clock and checks its initial safe-state request, disabled slot outputs, and carrier power request. It does not cover the ready or shutdown transitions.
``s3c_rev6_beta`` checks startup, ready operation, soft stop, STOP/ENABLE priority and supply-failure shutdown with an accelerated timebase.
A separate GHDL integration test in ``make test`` couples ``s3c_power_on_debounce`` to ``cvg_tx30_stateful`` and exercises startup, ready operation, soft stop and re-enable.
``tx26_w_enable`` additionally tests all 16 combinations of its four enable pins.
The D4 and D5 resolver tests check their adapter routes, physical wire-swap compensation and safe-state status without gating data.
Testbenches produced by ``make generate`` follow the CSV input/output directions and check both routing states using all-zero, all-one, walking-one and walking-zero patterns.
They hold enable inputs at the configured pattern while testing data routes, then exercise enable failures, pilot policy and carrier readiness separately.
Heartbeat contracts additionally exercise initial qualification, static safe-state requests while heartbeat continues, timeout and recovery.
A separate integration test connects ``s3c_heartbeat`` to a generated heartbeat slot and checks startup, soft stop, re-enable and module-power heartbeat gating.
Their I2C inputs are held low.
Program-specific testbenches define their own auxiliary-input stimulus.
The tests are deterministic, while ``seed`` is recorded for programs that use random stimulus.

Cocotb drives inputs and checks outputs while GHDL executes the VHDL.
``await Timer(1, unit="ns")`` advances simulated time by 1 ns; the test ends when its coroutine completes or an assertion fails.
The simulated duration of each run is recorded in ``metadata/run.json``.
These waits allow combinational logic to settle and are not device timing requirements.

Results
-------

``programs/<release_cycle>/<name>/build/simulation/`` contains compiler/simulation logs, cocotb result XML and ``waves.vcd``; ``metadata/run.json`` records provenance.
VCD is a portable text waveform; optional GHW preserves GHDL/VHDL type information and optional FST is more compact.
Selecting GHW or FST emits that file alongside VCD.
``cpld_toolchain/toolchain/build/simulation/<release_cycle>/junit.xml`` is the aggregate pytest report.
Reruns replace program results, and concurrent managed operations on the same program/target are rejected.
Each run recreates its simulation directory and GHDL libraries from the declared sources.
Changes to authored inputs during compilation or simulation fail the run; successful provenance describes the inputs used by that run.

Open VCD with GTKWave or use the interactive :doc:`program pages <program-documentation>`::

   gtkwave programs/original/tx26_w_enable/build/simulation/waves.vcd
