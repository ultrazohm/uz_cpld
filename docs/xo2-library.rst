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
This component runs on the D-slot, not on the S3C power-sequencer board.
The alternative ``heartbeat.vhdl`` architecture implements the heartbeat protocol described below.

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
``make new name=my_copy template=my_program`` preserves these shared references when cloning a handwritten program, including across release cycles.

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

Heartbeat implementation
------------------------

Compile ``s3c_logic.vhdl`` followed by ``heartbeat.vhdl`` into library ``s3c``
and instantiate ``entity s3c.s3c_logic(heartbeat)``. The ports and state/status
outputs are identical to ``level_signals``, including ``state_system_error``.
The level-based architecture holds that output low because it has no heartbeat
fault source. Neither architecture requires the historical ``xo2_libraries`` Git
submodule. The heartbeat receiver is implemented in this shared library.

The protocol comes from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` and its ``xo2_libraries`` dependency
``74c74460171527ff17ce074ae38ac34e14e3baec``. It pairs with
``programs/heartbeat/s3c_heartbeat``:

* ``carrierrdy`` receives the toggling digital CarrierReady signal. It is not
  interpreted as a static ready level.
* ``reqsafestate`` remains an independent static request, active high by default.
  The S3C may keep sending heartbeat while requesting safe state.
* Normal operation requires a qualified heartbeat, a released safety gate,
  synchronized ``card_enable='1'``, and the configured pilot condition.
* Before the first complete qualification, missing or malformed heartbeat
  asserts ``system_error`` and inhibits all outputs. This startup inhibition
  clears automatically on the first complete qualification; it is not a latched fault.
* After qualification, an active or unknown request, reset, or unmet enable/pilot condition selects
  safe state, with automatic recovery while heartbeat remains healthy.
* The first qualified sequence permanently arms fault detection. A later
  timeout, malformed edge interval or unknown heartbeat value latches
  ``system_error``, including during reset or a static safe request.

The default outputs are ``state_normal/SlotOK=1`` only in normal state,
``state_safe=1`` only in safe state, and ``ReqOE=1`` in normal and safe states. Keeping ReqOE high
lets the program drive its selected safe values; safe state does not inherently
mean high impedance. To retain an RX path in safe state, use the same source
in both CSV columns. In system_error, only ``state_system_error`` is high;
``state_normal``, ``state_safe``, ``SlotOK`` and ``ReqOE`` are all zero,
regardless of configured normal/safe status levels. Every consuming slot must
override all its data outputs to zero in this state. CVG always generates this
override, including for RX, constant-one and high-impedance routes.
ReqOE low asks the S3C to disable the physical output drivers; the RTL zero
values do not imply a driven-low level beyond a disabled buffer.

Heartbeat recovery, runtime reset, safe requests, pilot and card enable cannot
clear the fault or disarm detection. Only CPLD power-on initialization clears
the sticky flags. Reconfiguration can also reinitialize them. A local latch
cannot distinguish a full-system power cycle from independent D-slot power
loss: full-system-only recovery requires the appropriate supply/retention
arrangement. Verify initialization in the fitted design. The S3C intentionally
stops heartbeat during shutdown, which latches a fault in slots still powered.

Example instantiation:

.. code-block:: vhdl

   controller: entity s3c.s3c_logic(heartbeat)
       generic map (
           REQUEST_SAFE_LEVEL => '1', REQUIRE_PILOT => false,
           HB_TIMEOUT_CLKS => 208,
           HB_MIN_EDGE_CLKS => 10, HB_MAX_EDGE_CLKS => 52,
           HB_VALID_EDGES_REQUIRED => 16
       )
       port map (
           clk => clk, reset => reset,
           reqsafestate => request_safe, carrierrdy => carrier_ready,
           pilot_in => pilot, card_enable => enable,
           state_normal => normal_state, state_safe => safe_state,
           state_system_error => system_error,
           slotok => slot_ok, reqoe => request_oe
       );

   adapter_output <= '0' when system_error = '1' else
                     fpga_input when normal_state = '1' else '0';

Heartbeat is always required by this architecture, regardless of the legacy
``USE_CARRIER_READY`` generic; ``CARRIER_READY_LEVEL`` is also ignored because
both rising and falling edges count. The other polarity, pilot and status
configuration generics retain their meanings. ``level_signals`` ignores the
new ``HB_*`` generics.

Timing and qualification
~~~~~~~~~~~~~~~~~~~~~~~~

The defaults assume a 2.08 MHz receiver clock and the S3C's nominal 21-clock
heartbeat half-period (approximately 10.1 microseconds). Timing parameters count
receiver clocks; an external clock at another frequency requires corresponding
contract/generic values. The receiver uses a two-register input synchronizer.

An initial edge starts a sequence at count one. Sixteen edges with all fifteen
intervening intervals in the inclusive 10--52-clock window qualify it. Normal
operation also requires the safety gate to be released and the other controls
to permit forwarding. The release synchronizer and initial heartbeat
qualification provide startup protection without a separate state register
or warmup counter. Heartbeat monitoring continues during a static safe-state
request, including initial qualification, malformed-edge rejection and timeout.

Asserting ``ReqSafeState`` asynchronously clears both stages of the release
synchronizer. After initial qualification, unless system_error is latched, state/status outputs
select their safe values without waiting for a clock edge. An unknown request
also forces safe outputs in simulation. A latched error always takes priority.
Deasserting the request releases the gate on the second rising clock edge,
without requiring a new heartbeat qualification if the monitor is still valid.
An assertion entirely between clock edges still closes the gate and requires
two subsequent edges after deassertion to reopen it. Assertion therefore works
with a stopped clock, while deassertion cannot resume forwarding until the
clock runs again. Asynchronous assertion still has physical propagation delay.

A missing edge revokes qualification on clock 208 after the last observed edge
(approximately 100 microseconds), whether CarrierReady is stuck high or low.
Out-of-window edges revoke qualification immediately when observed and start
a new sequence at count one. Unknown heartbeat values clear qualification.
Before arming, reset clears heartbeat history. After arming, the monitor keeps
running through reset, and any fault is permanent until power-on initialization;
a fresh qualified sequence cannot restore permission. Enable and pilot inputs retain their two-register
synchronizers; their state/status effects now occur on the second sampling
edge because output selection is combinational. ``level_signals`` retains its
original three-edge control latency.

Clock-dependent monitoring does not detect a failure of the receiver's own clock.
When that clock stops, qualification and timeout counters freeze. After the
clock resumes, a previously qualified heartbeat can temporarily remain valid
until the monitor observes a malformed edge or reaches its timeout. There is
deliberately no fresh-qualification requirement on safe-state request release.
The feature-branch router also permits request assertion without a clock, but
its combinational gate permits request release without a clock as well.

This is protocol-compatible with the imported sender, but deliberately does
not copy two receiver defects from the branch: the original keeps its valid
flag on malformed intervals and can qualify a malformed final edge using the
previous edge count. The new receiver also measures actual edge-to-edge clock
counts; the old counter comparison was shifted by one clock. Thresholds are
inclusive and tested at the boundaries. These changes do not modify the
imported ``s3c_heartbeat`` program or its local library snapshot.

Standalone compilation and tests
--------------------------------

With GHDL, run from the repository root:

.. code-block:: sh

   mkdir -p /tmp/xo2-s3c-work
   ghdl -a --std=93 --work=s3c --workdir=/tmp/xo2-s3c-work xo2_library/s3c/s3c_logic.vhdl
   ghdl -a --std=93 --work=s3c --workdir=/tmp/xo2-s3c-work xo2_library/s3c/level_signals.vhdl
   # Add -P/tmp/xo2-s3c-work when analyzing/elaborating your consuming top level.
   python3 -m unittest discover -s xo2_library/tests -v

The handwritten testbenches exercise both architectures, including heartbeat qualification, exact interval and timeout boundaries, malformed pulses, reset, state/status outputs, synchronization, polarity, pilot and enable behavior without invoking the generator.
``make test`` includes these library tests.
Generated programs use these same sources; ``s3c_library`` can select another source directory in their generator configuration.
