Generated slot programs
=======================

``cpld_vhdl_generator`` is an independent Python package that emits VHDL-1993 from a CSV routing table and a TOML configuration.
It does not import the build toolchain or invoke synthesis tools.
The repository build system consumes its emitted sources and checks that they match their specification.

Create and regenerate
---------------------

The catalog example ``tx30_stateful`` uses NORMAL, SAFE, and ERROR states and the ``s3c_power_on_debounce_v1`` contract.
Clone it through the normal program workflow::

   make new name=my_slot template=tx30_stateful
   python3 -m cpld_vhdl_generator programs/my_slot/generator.toml --output programs/my_slot
   make sim program=my_slot
   make build program=my_slot backend=diamond

Edit ``routing.csv`` and ``generator.toml`` to describe routing and controller policy, then regenerate.
The generator writes ``s3c_logic.vhdl`` and ``my_slot.vhdl`` directly into the program directory.
The S3C file contains the selected contract's signal interpretation, synchronization, state machine, and status outputs.
The top level supplies the clock/reset, evaluates the optional enable pattern, instantiates ``s3c_logic`` once, and implements the CSV routes.
Only the selected contract's logic is emitted, with no alternative adapters or protocol-selection generics.
``generator-output.json`` records source order and generator, specification, and contract hashes.
Compile ``s3c_logic.vhdl`` before the top level in library ``work``.
``make new`` updates the program name and regenerates its sources.

Standalone generation needs no repository manifest::

   python3 -m cpld_vhdl_generator path/to/my_slot/generator.toml --output path/to/my_slot
   python3 -m cpld_vhdl_generator path/to/my_slot/generator.toml --output path/to/my_slot --check

Installing with ``pip install .`` provides the equivalent ``cpld-vhdl-generator`` command.
Constraints remain the responsibility of the consuming board build.

Supported functions
-------------------

.. literalinclude:: ../programs/tx30_stateful/generator.toml
   :language: toml

The CSV header is ``pin,direction,normal,safe,error``.
Directions are ``in`` and ``out`` from the CPLD's perspective.
Output actions are declared input names, ``0``, ``1``, or ``Z``.
Every output requires all three state actions, while input rows leave those fields empty.
Output-to-output references, arbitrary expressions, conflicting declarations, unknown signals, and bidirectional ports are rejected.
The optional ``enable`` table maps declared input pins to required levels and keeps the slot in SAFE unless all levels match.

There are no custom logic hooks or generated extension stubs.
Users needing additional behavior can manually edit VHDL or create fully custom programs.
To convert a repository program to manual VHDL, remove the optional ``generator`` field from its program manifest, maintain its source list explicitly, and stop regenerating its sources.
The generator refuses to overwrite manually edited or unowned files.

Controller behavior
-------------------

The controller starts in SAFE and requires initialized, synchronized control inputs before entering NORMAL.
Faults take priority and latch ERROR.
``fault_recovery = "safe_cycle"`` is the only supported recovery policy.
It requires observing the normalized S3C safe request in ERROR, then its release after the fault clears.
A release while the fault persists does not acknowledge later fault clearance.
Recovery passes through SAFE for at least one clock, and reset clears the error latch.
``pilot_policy = "required"`` treats a low synchronized pilot as a fault when the S3C permits operation.
With ``pilot_policy = "unused"``, ERROR remains part of the state machine but is unreachable with the currently supported contracts.

``clock = "external"`` adds ``clk`` and a synchronous active-high ``reset`` input.
``clock = "machxo2"`` supplies a nominal 2.08 MHz OSCH clock and startup reset sequence.
Controls use two synchronization registers and three warmup clocks after reset.
A stable request reaches the registered state on the third receiving-clock edge counting its first sampling edge, excluding metastability delay.
Routed data remains combinational.

S3C contracts
-------------

The built-in legacy contract treats ReqSafeState as active high, ignores CarrierReady, drives SlotOK high only in NORMAL, and keeps ReqOE high in all states.
This allows the CSV to drive defined safe/error levels even when the S3C leaves SlotOE asserted during a soft stop.
The S3C can still disable the physical driver independently.

A separate contract TOML file can define an identifier, compatible S3C program names, request polarity, CarrierReady interpretation, and the three SlotOK and ReqOE levels.
Request mode supports ``active_high`` and ``active_low``.
CarrierReady supports ``unused``, ``active_high``, and ``active_low``.
Unknown request levels and inactive or unknown readiness levels request SAFE.
Heartbeat support is a possible future extension and is not implemented.
Heartbeat configuration is rejected.
Compatibility declarations do not detect the firmware actually loaded on a board.

Validation
----------

``make test`` includes validation, polarity, readiness, routing, safe-state, error-latching, and recovery tests.
The integration test exercises the actual S3C debounce/startup counters and confirms that soft stop gates slot data even with SlotOE asserted.
The example selects the Diamond firmware backend, which requires a valid license for synthesis and export validation.
Its FOSS firmware backend remains disabled pending sequential equivalence validation.
Existing archived programs retain their original sources and behavior.
See the standalone package's ``README.md`` for the complete configuration and contract schema.
