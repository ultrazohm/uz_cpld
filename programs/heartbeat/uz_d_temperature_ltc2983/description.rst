Source and scope
----------------

``uz_d_temperature_ltc2983`` is ported from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` to ``s3c.s3c_logic(heartbeat)``.
It targets the LCMXO2-2000HC-4TG100C and pairs with ``s3c_heartbeat``.
The original entity name ``SignalRouter``, port directions, routing expressions,
card-enable decode, oscillator and shared branch LPF are preserved.
``upstream.json`` records source paths, hashes, reversible source patches and
routing expectations. This is a handwritten import, not a CSV-generated project.

Routing and safe state
----------------------

Outputs forced low in safe state: ``d_19``, ``d_20``, ``d_21``, ``d_22``, ``d_23``, ``d_24``, ``d_25``, ``d_26``, ``d_27``, ``d_28``, ``d_29``.

Outputs that retain their routing in safe state: ``d_00``, ``d_01``, ``fpga_02``, ``d_03``, ``fpga_04``, ``d_05``, ``d_06``, ``d_07``, ``fpga_08``, ``d_09``, ``fpga_10``, ``d_11``, ``d_12``, ``d_13``, ``fpga_14``, ``d_15``, ``fpga_16``, ``d_17``, ``d_18``.

SlotOK follows normal-state permission; ReqOE remains high in both states.
Pilot is not required, matching the branch. See the release description for
protocol differences, ungated-output implications and unresolved hardware checks.

Validation
----------

The cocotb test checks every assigned route against the upstream mapping with
zero/one and walking-bit patterns, static safe requests, heartbeat qualification,
loss, malformed pulses and recovery, plus all card-enable combinations where used.
It drives the unbound OSCH output; simulation timing is accelerated.
Undriven RTL outputs are not assigned assumed hardware levels.
Diamond is the supported firmware backend; no FOSS support is claimed by this port.
