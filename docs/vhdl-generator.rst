Generated slot programs
=======================

``cpld_vhdl_generator`` generates VHDL-1993 from CSV and TOML independently of the build toolchain.
The repository checks generated sources for freshness before building.

Quick start
-----------

Create a D-slot program from CSV routing::

   make new name=my_slot template=generator
   # Edit programs/my_slot/routing.csv
   make generate program=my_slot
   make sim program=my_slot
   make build program=my_slot backend=diamond

The starter contains ``routing.csv``, ``generator.toml`` and ``description.rst`` in ``programs/my_slot/``.
The CSV starts with 30 transmit routes whose safe-state outputs are low.
Generation creates:

* ``my_slot.vhdl``: VHDL matching the routing.
* ``my_slot_tb.py``: a matching cocotb testbench.
* ``my_slot_constraints.lpf``: D-slot board constraints.
* ``my_slot.toml``: the build manifest.
* ``generator-output.json``: the generation receipt.

``make generate`` validates the completed project and adds it to the catalog.
The unfinished starter is excluded from catalog builds and simulations.
Run the same generation command after editing the CSV or configuration.
The testbench initializes data inputs and checks the generated outputs against both CSV states using all-zero, all-one, walking-one and walking-zero patterns.
It also exercises safe requests, pilot, carrier readiness and enable conditions.
Constraints use the ``uz_dslot_xo2`` board pin map and electrical settings; the generated project supports Diamond and the internal MachXO2 clock.

Generation and file ownership
-----------------------------

The standalone command generates the same project files without changing the repository catalog::

   python3 -m cpld_vhdl_generator programs/my_slot/generator.toml --output programs/my_slot

Add ``--check`` to that command to verify freshness without writing files.
All four generated project files are tracked by the receipt.
Manually edited or unowned files are protected from overwriting.
To clone a program, select its name as the template: ``make new name=my_slot template=tx30_stateful``.
Shared sources live in ``cpld_vhdl_generator/hdl`` and are referenced by each program's manifest.
The shared entity ``s3c_logic.vhdl`` and selected architecture ``level_signals.vhdl`` compile into library ``s3c`` before the top level in library ``work``.
The top level contains clock setup and routing and instantiates ``s3c.s3c_logic(level_signals)``.
The contract selects the architecture; its levels and the program's pilot policy are passed as generics.
The JSON record tracks paths, libraries, and hashes, including shared sources.
Changing shared HDL requires regenerating and validating dependent programs.
Diamond builds require a valid license.

Routing
-------

::

   output,normal_state,safe_state
   d_00,fpga_00,0
   d_01,fpga_01,fpga_01
   fpga_02,d_02,0
   d_29,0,0

Each row defines one output in normal_state and safe_state.
Only ``d_00``–``d_29`` and ``fpga_00``–``fpga_29`` are valid pin names, with exactly two digits and lowercase letters.
State values accept input names, ``0``, ``1``, or uppercase ``Z``.
Outputs cannot also serve as inputs, including in ``enable``.
Multiple outputs may share an input.
Expressions and bidirectional ports are unsupported.

The interface includes all 60 data pins.
Pins omitted from the output column are inputs and have no HDL output driver.
Use a constant output row when a pin must be driven to a defined level.
Physical pulls and unused-pad settings belong to board constraints and synthesis configuration.
The fixed S3C signals and unused I2C inputs are provided separately and cannot appear in the CSV.

Configuration and states
------------------------

.. literalinclude:: ../programs/tx30_stateful/generator.toml
   :language: toml

``clock`` selects ``machxo2`` for an internal nominal 2.08 MHz oscillator or ``external`` for clock/reset ports.
The optional ``enable`` table specifies required data input levels, for example ``enable = {fpga_29 = 1}``.
``pilot_policy = "required"`` requires a high synchronized pilot input for normal operation; ``unused`` ignores it.
The controller starts in ``safe_state`` and enters ``normal_state`` when synchronized S3C controls, the pilot policy, and the enable pattern permit operation.
It returns to ``safe_state`` when any condition fails and resumes ``normal_state`` automatically when all conditions are satisfied.
After startup, control changes reach the state on the third clock edge counting their first sampling edge.
Data forwarding is combinational.

The built-in contract uses active-high ReqSafeState, ignores CarrierReady, asserts SlotOK only in normal_state, and keeps ReqOE high.
Additional contract files support active-high or active-low requests and unused, active-high, or active-low readiness.
``s3c_library`` selects the shared HDL directory and defaults to the standalone package's ``hdl`` directory.
``target = "uz_dslot_xo2"`` selects generation of the manifest, testbench and constraints along with the VHDL.
Configurations without ``target`` generate VHDL and provenance and may use an external clock.
The complete contract schema and standalone commands are documented in ``cpld_vhdl_generator/README.md``.

Generated programs use the supported routing and controller functions.
For manual VHDL, stop regenerating and remove the program manifest's optional ``generator`` field.
The generator refuses to overwrite manually edited output files.

Testbenches
-----------

The direct shared-controller testbench checks startup/reset, state/status outputs, control latency, polarity, readiness, pilot, and enable behavior::

   python3 -m unittest cpld_vhdl_generator.tests.test_s3c_logic -v

The interaction testbench connects the generated slot to the actual S3C sources and checks startup, soft stop, and re-enable::

   python3 -m unittest toolchain.tests.test_s3c_interaction -v

It uses an accelerated simulation oscillator while retaining the S3C's original counters.
Both testbenches require GHDL and run under ``make test``.
