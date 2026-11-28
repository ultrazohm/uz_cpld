Purpose
-------

``s3c_toolchain_test_program`` is a fixed-output example for building and simulating the S3C ``LCMXO2-4000HC-4TG144C`` target.

It is not an S3C power controller; see :doc:`/s3c` for the implemented controllers and their protocols.

Behavior
--------

It holds ``Carrier_PwrOn`` and both carrier-ready outputs low, asserts ``DIGS3C_Shared_ReqSafeState``, and holds all five digital slot output enables low.
It has no inputs, debounce logic, power-up sequence, or shutdown state machine.

Verification
------------

The cocotb test checks the constant values of all nine outputs.
