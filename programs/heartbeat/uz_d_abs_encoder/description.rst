Source and scope
----------------

``uz_d_abs_encoder`` is ported from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` to ``s3c.s3c_logic(heartbeat)``.
It targets the LCMXO2-2000HC-4TG100C and pairs with ``s3c_heartbeat``.
The original entity name ``SignalRouter``, port directions, normal/safe routing,
card-enable decode, oscillator and shared branch LPF are preserved.
``upstream.json`` records source paths, hashes, reversible source patches and
routing expectations. This is a handwritten import, not a CSV-generated project.

Routing and safe state
----------------------

Outputs forced low in safe state: none.

Outputs that retain their routing in safe state: ``d_05``, ``d_04``, ``d_14``, ``d_11``, ``d_10``, ``d_17``, ``d_09``, ``d_08``, ``d_16``, ``fpga_07``, ``fpga_06``, ``fpga_18``, ``d_03``, ``d_02``, ``d_13``.

The card-enable pattern requires ``fpga_26=0``, ``fpga_27=0``, ``fpga_28=1`` and ``fpga_29=1``. Its state/status effects are synchronized by the shared controller.

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
