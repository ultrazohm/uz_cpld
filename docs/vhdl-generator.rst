Generated slot programs
=======================

``cpld_vhdl_generator`` generates VHDL-1993 from CSV and TOML independently of the build toolchain.
The repository checks generated sources for freshness before building.

Start with :ref:`generator-quickstart` for the command flow, editable inputs and generated files.
This reference describes routing, configuration and standalone use.

Generation and file ownership
-----------------------------

The standalone command generates the same project files without changing the repository catalog::

   python3 -m cpld_vhdl_generator programs/original/cvg_my_slot/generator.toml --output programs/original/cvg_my_slot

Add ``--check`` to that command to verify freshness without writing files.
All four generated project files are tracked by the receipt.
Manually edited or unowned files are protected from overwriting.
Shared sources live in ``cpld_vhdl_generator/hdl`` and are referenced by each program's manifest.
The shared entity ``s3c_logic.vhdl`` and selected architecture ``level_signals.vhdl`` compile into library ``s3c`` before the top level in library ``work``.
The top level contains clock setup and routing and instantiates ``s3c.s3c_logic(level_signals)``.
The contract selects the architecture; its levels and the program's pilot policy are passed as generics.
Each implementation must provide the shared entity's interface in a same-named architecture file.
``source_entries(load_config(config_path), output_directory)`` returns ordered source paths and libraries for standalone build tools.
The JSON record tracks paths, libraries, and hashes, including shared sources.
Changing shared HDL requires regenerating and validating dependent programs.
For manual VHDL, stop regenerating and remove the program manifest's optional ``generator`` field.

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
Every output requires both state values and must appear only once.
Outputs cannot also serve as inputs, including in ``enable``.
Multiple outputs may share an input.
Expressions and bidirectional ports are unsupported.

The interface includes all 60 data pins.
Pins omitted from the output column are inputs and have no HDL output driver.
A header-only CSV leaves all data pins as inputs.
Use a constant output row when a pin must be driven to a defined level.
Physical pulls and unused-pad settings belong to board constraints and synthesis configuration.
The fixed S3C signals and unused I2C inputs are provided separately and cannot appear in the CSV.

Configuration and states
------------------------

.. literalinclude:: ../programs/original/cvg_tx30_stateful/generator.toml
   :language: toml

``name`` must be a lowercase VHDL identifier.
VHDL keywords, the ``s3c_`` prefix, and names used by generated declarations (``ieee``, ``std``, ``work``, ``s3c``, ``s3c_logic``, ``std_logic``, ``natural``, ``string``, ``rising_edge``, ``true``, ``false`` and ``osch``) are reserved.
``clock`` selects ``machxo2`` for an internal nominal 2.08 MHz oscillator or ``external`` for ``clk`` and active-high ``reset`` ports.
The optional ``enable`` table specifies required data input levels, for example ``enable = {fpga_29 = 1}``.
``pilot_policy = "required"`` requires a high synchronized pilot input for normal operation; ``unused`` ignores it.
The controller starts in ``safe_state`` and enters ``normal_state`` when synchronized S3C controls, the pilot policy, and the enable pattern permit operation.
It returns to ``safe_state`` when any condition fails and resumes ``normal_state`` automatically when all conditions are satisfied.
After startup, control changes reach the state on the third clock edge counting their first sampling edge.
Data forwarding is combinational.

``s3c_library`` selects the shared HDL directory and defaults to the standalone package's ``hdl`` directory.
``target = "uz_dslot_xo2"`` selects generation of the manifest, testbench and constraints along with the VHDL.
This project mode requires ``clock = "machxo2"`` and uses the packaged D-slot board pin map, electrical settings and Diamond backend.
Configurations without ``target`` generate VHDL and provenance and may use an external clock.

S3C contract
------------

The built-in ``s3c_power_on_debounce_v1`` contract uses active-high ReqSafeState, ignores CarrierReady, asserts SlotOK only in normal_state, and keeps ReqOE high.
To select another level-based contract, set ``contract`` to a relative TOML path containing these fields:

.. code-block:: toml

   id = "my_s3c_v1"
   compatible_s3c = ["my_s3c"]
   implementation = "level_signals"
   request_mode = "active_low"
   carrier_ready = "active_high"
   slotok = [1, 0]
   reqoe = [1, 1]

``request_mode`` accepts ``active_high`` or ``active_low``.
``carrier_ready`` accepts ``unused``, ``active_high`` or ``active_low``.
Status levels are listed in normal_state, safe_state order.
Unknown request levels or inactive/unknown readiness request safe_state.
Compatibility names declare the intended firmware pairing; they do not detect installed firmware.

Testbenches
-----------

See :doc:`simulation` for the generated cocotb testbench's routing patterns and control checks.

The direct shared-controller testbench checks startup/reset, state/status outputs, control latency, polarity, readiness, pilot, and enable behavior::

   python3 -m unittest cpld_vhdl_generator.tests.test_s3c_logic -v

The interaction testbench connects the generated slot to the actual S3C sources and checks startup, soft stop, and re-enable::

   python3 -m unittest toolchain.tests.test_s3c_interaction -v

It uses an accelerated simulation oscillator while retaining the S3C's original counters.
Both testbenches require GHDL and run under ``make test``.

Program naming
--------------

Generated programs use a ``cvg_`` prefix for their directory, manifest, top entity and emitted filenames.
``make new name=my_slot template=generator`` creates ``cvg_my_slot``; supplying ``name=cvg_my_slot`` gives the same name.
Internal signals use ``s3c_``: ``s3c_normal_state``, ``s3c_card_enable``, ``s3c_clk``, ``s3c_reset`` and ``s3c_startup``.
Pass ``release_cycle=NAME`` to ``make new`` and ``make generate`` to select a cycle explicitly.
The standalone generator continues to take explicit configuration and output paths.
