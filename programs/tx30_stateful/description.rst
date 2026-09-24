Purpose
-------

``tx30_stateful`` demonstrates CSV-generated routing for 30 FPGA-to-adapter channels with a shared NORMAL, SAFE, and ERROR state controller.
It is a new program and changes the original combinational ``tx30`` startup and reaction timing.

Behavior
--------

The selected ``s3c_power_on_debounce_v1`` contract treats ReqSafeState as active high and ignores the legacy controller's undriven CarrierReady output.
All transmit outputs are low in SAFE and ERROR and follow their matching FPGA input in NORMAL.
SlotOK is high only in NORMAL, while ReqOE remains high in all states to allow defined output levels.
The top level supplies a nominal 2.08 MHz oscillator and startup reset, followed by synchronization warmup.
A stable safe-state request is reflected in the registered state after three receiving-clock edges from its first sampling edge, excluding metastability delay.
Pilot monitoring is explicitly disabled for this example.
Errors latch until the fault clears and a safe-request/release cycle is observed, or the controller is reset.

Editing
-------

Edit ``routing.csv`` for pin behavior and ``generator.toml`` for the S3C contract and controller policy.
The generator writes ``s3c_logic.vhdl``, ``tx30_stateful.vhdl``, and ``generator-output.json`` directly into this program directory.
``s3c_logic.vhdl`` contains only the selected S3C contract's interpretation and the three-state controller.
The top level instantiates that controller and implements the CSV routes.
There are no custom logic hooks or heartbeat implementation.
With pilot monitoring disabled, ERROR is retained in the state machine but is unreachable in this program.
The generator's behavioral tests exercise pilot error entry, latching, and safe-cycle recovery separately.

Verification
------------

The program testbench verifies startup, every transmit route, soft-stop gating, and re-enable behavior.
The repository integration test connects the generated top level to the actual S3C controller through startup, front-panel soft stop, and enable.
The program selects Diamond for JEDEC and bitstream exports, which require a valid license to build.
The FOSS firmware backend remains disabled pending sequential equivalence validation.
