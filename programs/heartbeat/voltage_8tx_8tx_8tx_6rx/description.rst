Purpose
-------

``voltage_8tx_8tx_8tx_6rx`` is a handwritten MachXO2 D-slot program using ``s3c.s3c_logic(heartbeat)``.
Pair it with ``s3c_heartbeat``; its VHDL, LPF, manifest and testbench live in this directory.

Routing and safe state
----------------------

Outputs forced low in safe state: ``d_00``, ``d_01``, ``d_02``, ``d_03``, ``d_04``, ``d_05``, ``d_06``, ``d_07``, ``d_08``, ``d_09``, ``d_10``, ``d_11``, ``d_12``, ``d_13``, ``d_14``, ``d_15``, ``d_16``, ``d_17``, ``d_18``, ``d_19``, ``d_20``, ``d_21``, ``d_22``, ``d_23``.

Outputs that retain their routing in safe state: ``fpga_24``, ``fpga_25``, ``fpga_26``, ``fpga_27``, ``fpga_28``, ``fpga_29``.

SlotOK follows normal-state permission; ReqOE remains high in normal and safe states.
Before first qualification, all declared data outputs, SlotOK and ReqOE are inhibited; qualification clears startup inhibition.
After the first qualified heartbeat, loss or malformed timing latches ``system_error``.
All declared data outputs, SlotOK and ReqOE are then zero, including the routes listed above as active in safe state.
Restored heartbeat and runtime reset cannot clear the fault.
See :doc:`/xo2-library` for power-on initialization, supply-domain and physical output-enable limitations.
Pilot is not required.
See the release description for protocol timing, ungated-output behavior and validation limits.

Validation
----------

The cocotb test checks every assigned route against the expected mapping with zero/one and walking-bit patterns, static safe requests, heartbeat qualification, loss and fault persistence after heartbeat recovery, plus all card-enable combinations where used.
It drives the unbound OSCH output; simulation timing is accelerated.
Diamond is the supported firmware backend; the manifest does not enable FOSS.
