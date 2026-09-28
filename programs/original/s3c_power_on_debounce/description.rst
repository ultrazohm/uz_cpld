Purpose
-------

``s3c_power_on_debounce`` ports the ``Power_on_debounce.vhd`` controller selected by the archive's default ``S3C_171224`` Diamond implementation.
The older root-level archive file with the same name belongs to a different implementation and is not the source of this program.

Behavior
--------

The MachXO2 ``OSCH`` primitive supplies a nominal 2.08 MHz clock to the debounce counters and power-state machine.
The controller synchronizes and debounces the power button, external stop, front-panel stop and enable buttons, ``PG_VIN``, and ``PPn_VIN``.
At startup it requests safe state, masks the five digital slot output enables, and keeps the carrier power request low.
Its later states sequence carrier power, a 1.8 V reset output, ready operation, stop and error handling, and shutdown requests.
The ready-state slot mask uses the raw ``PPn_VIN`` input, while ``warning`` is hardcoded low.

Archive limits
--------------

The archived controller declares both ``CarrierReady`` outputs and the front-panel user LEDs without driving them.
Its source comment reports that ``ReqSafeState`` did not work while the 1.8 V bank was unpowered.
The state named ``Waiting_for_Powerbutton_released`` checks for the button being pressed again, so the name does not describe its actual transition condition.
Diamond uses constraints copied from the selected archive implementation, including its pin and bank settings.
The FOSS constraints omit ``JTAG_PORT=DISABLE`` and correct the two bank-2 ``IO_TYPE`` settings.
The FOSS build proves mapped sequential equivalence with a shared abstract clock and excludes seven optimized internal signals from proof cutpoint matching.
Both firmware backends build this program; their bitstreams and electrical behavior have not been shown equivalent.

Verification
------------

The cocotb test drives the internal clock and checks only startup power, safe-state, slot-enable, and passthrough outputs.
It does not verify the ready, stop, error, or shutdown transitions, and it does not establish hardware safety.
