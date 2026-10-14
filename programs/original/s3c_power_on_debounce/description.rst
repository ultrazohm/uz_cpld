Purpose
-------

``s3c_power_on_debounce`` implements S3C power sequencing and static active-high ReqSafeState signaling.
It generates no heartbeat; pair it with compatible static D-slot firmware.
See :doc:`/s3c` for controller compatibility.

Behavior
--------

The MachXO2 ``OSCH`` primitive supplies a nominal 2.08 MHz clock to the debounce counters and power-state machine.
The controller synchronizes and debounces the power button, external stop, front-panel stop and enable buttons, ``PG_VIN``, and ``PPn_VIN``.
At startup it requests safe state, masks the five digital slot output enables, and keeps the carrier power request low.
Its later states sequence carrier power, a 1.8 V reset output, ready operation, stop and error handling, and shutdown requests.
The ready-state slot mask uses the raw ``PPn_VIN`` input, while ``warning`` is hardcoded low.

Implementation limits
---------------------

The controller declares both ``CarrierReady`` outputs and the front-panel user LEDs without driving them.
Its source comment reports that ``ReqSafeState`` did not work while the 1.8 V bank was unpowered.
The state named ``Waiting_for_Powerbutton_released`` checks for the button being pressed again, so the name does not describe its actual transition condition.
Diamond uses the program-local LPF pin and bank settings.
The FOSS constraints omit ``JTAG_PORT=DISABLE`` and explicitly preserve Diamond's two bank-2 open-drain outputs.
``FlexMio61ExternalStop`` and ``SD_SEL`` retain ``LVCMOS33`` with explicit open-drain, no pull, 12 mA drive and slow slew.
Their packed electrical fields are checked against Diamond before firmware export; see :doc:`/foss`.
The FOSS build proves mapped sequential equivalence with a shared abstract clock and excludes seven optimized internal signals from proof cutpoint matching.
Both firmware backends build this program; their bitstreams and electrical behavior have not been shown equivalent.

Verification
------------

The cocotb test drives the internal clock and checks only startup power, safe-state, slot-enable, and passthrough outputs.
That test does not verify the ready, stop, error, or shutdown transitions.
A separate GHDL integration test checks startup, ready operation, soft stop, and re-enable with the generated D-slot controller and an accelerated oscillator model.
Neither test establishes hardware safety.
