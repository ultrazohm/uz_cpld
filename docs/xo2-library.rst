Shared MachXO2 HDL library
==========================

``xo2_library`` owns reusable HDL components for generated and handwritten programs.
Its VHDL sources do not depend on the generator, Python, or the repository build system.
The generator consumes this library and includes it in its Python distribution so installed generation also works outside the checkout.
The library directory can be copied into another HDL project and compiled directly.

S3C slot controller
-------------------

``s3c/s3c_logic.vhdl`` defines the interface and ``s3c/level_signals.vhdl`` implements level-based control of a D-slot program.
Compile the entity first, then the architecture, both into VHDL library ``s3c``.
Compile your top level afterward into ``work``.
The directory name ``xo2_library`` is the shared source collection; ``s3c`` is the VHDL compilation library for this component.
This component is not the S3C board's power sequencer and does not implement a heartbeat receiver.

For a handwritten program under ``programs/<cycle>/<name>/``, include these entries in its manifest:

.. code-block:: toml

   sources = [
     {path = "../../../xo2_library/s3c/s3c_logic.vhdl", library = "s3c"},
     {path = "../../../xo2_library/s3c/level_signals.vhdl", library = "s3c"},
     {path = "my_program.vhdl", library = "work"},
   ]

Use the normal manifest fields for your top level, target, constraints and testbench.
A handwritten program needs no ``generator`` field, routing CSV, generator configuration or generation receipt.
The build system hashes shared sources like other HDL inputs, so changes invalidate existing firmware evidence.

In the handwritten top level, declare ``library s3c;`` and instantiate the controller:

.. code-block:: vhdl

   controller: entity s3c.s3c_logic(level_signals)
       generic map (
           REQUEST_SAFE_LEVEL => '1',
           USE_CARRIER_READY => false,
           REQUIRE_PILOT => false
       )
       port map (
           clk => clk, reset => reset,
           reqsafestate => request_safe,
           carrierrdy => '0', pilot_in => '0', card_enable => '1',
           state_normal => normal_state, state_safe => safe_state,
           slotok => slot_ok, reqoe => request_oe
       );

   adapter_output <= fpga_input when normal_state = '1' else '0';

Declare the referenced signals in your top level and connect the physical ports through your board constraints.
The component takes a supplied clock; oscillator instantiation belongs to the consuming program.
Reset is active high: assertion immediately forces safe outputs and a rising clock edge resets the internal state.
Initialized registers and a three-edge warmup hold safe state through startup, with normal operation possible on the fourth edge when controls permit it.
Programs tying reset low rely on synthesis preserving register initialization.
Controls are synchronized; after startup, a stable control change affects state on the third clock edge counting its first sampling edge, excluding metastability delay.
Normal operation resumes automatically when all required conditions hold.

The default status outputs assert SlotOK only in normal state and keep ReqOE high in both states.
Generics configure request/readiness polarity, readiness and pilot requirements, and normal/safe status levels.
Data routing and the electrical definition of a safe output remain the consuming program's responsibility.

Standalone compilation and tests
--------------------------------

With GHDL, run from the repository root:

.. code-block:: sh

   mkdir -p /tmp/xo2-s3c-work
   ghdl -a --std=93 --work=s3c --workdir=/tmp/xo2-s3c-work xo2_library/s3c/s3c_logic.vhdl
   ghdl -a --std=93 --work=s3c --workdir=/tmp/xo2-s3c-work xo2_library/s3c/level_signals.vhdl
   # Add -P/tmp/xo2-s3c-work when analyzing/elaborating your consuming top level.
   python3 -m unittest discover -s xo2_library/tests -v

The handwritten testbench exercises startup, reset, state/status outputs, synchronization, polarity, readiness, pilot and enable behavior without invoking the generator.
``make test`` includes these library tests.
Generated programs use these same sources; ``s3c_library`` can select another source directory in their generator configuration.
