Source and scope
----------------

``tx20_10rx`` is ported from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` to ``s3c.s3c_logic(heartbeat)``.
It targets the LCMXO2-2000HC-4TG100C and pairs with ``s3c_heartbeat``.
The original entity name ``SignalRouter``, port directions, normal/safe routing,
card-enable decode, oscillator and shared branch LPF are preserved.
``upstream.json`` records source paths, hashes, reversible source patches and
routing expectations. This is a handwritten import, not a CSV-generated project.

Routing and safe state
----------------------

Outputs forced low in safe state: ``d_00``, ``d_01``, ``d_02``, ``d_03``, ``d_04``, ``d_05``, ``d_06``, ``d_07``, ``d_08``, ``d_09``, ``d_10``, ``d_11``, ``d_12``, ``d_13``, ``d_14``, ``d_15``, ``d_16``, ``d_17``, ``d_18``, ``d_19``.

Outputs that retain their routing in safe state: ``fpga_20``, ``fpga_21``, ``fpga_22``, ``fpga_23``, ``fpga_24``, ``fpga_25``, ``fpga_26``, ``fpga_27``, ``fpga_28``, ``fpga_29``.

SlotOK follows normal-state permission; ReqOE remains high in normal and safe states.
After the first qualified heartbeat, loss or malformed timing latches
``system_error``. All declared data outputs, SlotOK and ReqOE are then zero,
including the routes listed above as active in safe state. Restored heartbeat
and runtime reset cannot clear the fault. See :doc:`/xo2-library` for power-on
initialization, supply-domain and physical output-enable limitations.
Pilot is not required, matching the branch. See the release description for
protocol differences, ungated-output implications and unresolved hardware checks.

Validation
----------

The cocotb test checks every assigned route against the upstream mapping with
zero/one and walking-bit patterns, static safe requests, heartbeat qualification,
loss and fault persistence after heartbeat recovery, plus all card-enable combinations where used.
It drives the unbound OSCH output; simulation timing is accelerated.
Formerly undriven ports are checked for Z in normal/safe and zero in system_error.
Diamond is the supported firmware backend; no FOSS support is claimed by this port.
