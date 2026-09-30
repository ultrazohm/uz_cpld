Source and scope
----------------

``uz_d_resolver_d5`` is ported from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` to ``s3c.s3c_logic(heartbeat)``.
It targets the LCMXO2-2000HC-4TG100C and pairs with ``s3c_heartbeat``.
The original entity name ``SignalRouter``, port directions, routing expressions,
card-enable decode, oscillator and shared branch LPF are preserved.
``upstream.json`` records source paths, hashes, reversible source patches and
routing expectations. This is a handwritten import, not a CSV-generated project.

Routing and safe state
----------------------

Outputs forced low in safe state: none.

Outputs that retain their routing in safe state: ``d_00``, ``d_01``, ``d_02``, ``d_03``, ``d_04``, ``d_05``, ``d_06``, ``d_07``, ``fpga_14``, ``d_09``, ``d_10``, ``d_11``, ``d_12``, ``d_13``, ``d_14``, ``d_15``, ``d_16``, ``fpga_23``.

The upstream declares these outputs without assignments: ``d_18``, ``d_19``, ``d_20``, ``d_21``, ``d_22``, ``d_23``, ``d_24``, ``d_25``, ``d_27``, ``d_28``, ``d_29``, ``fpga_00``, ``fpga_01``, ``fpga_02``, ``fpga_03``, ``fpga_04``, ``fpga_05``, ``fpga_24``, ``fpga_25``, ``fpga_26``, ``fpga_27``, ``fpga_28``, ``fpga_29``. They remain undriven in RTL; no electrical safe value is inferred.

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
