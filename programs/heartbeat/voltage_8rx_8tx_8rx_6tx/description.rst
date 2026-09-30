Source and scope
----------------

``voltage_8rx_8tx_8rx_6tx`` is ported from ``feature/add_dig3v35v_configs_heartbeat`` at
``bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7`` to ``s3c.s3c_logic(heartbeat)``.
It targets the LCMXO2-2000HC-4TG100C and pairs with ``s3c_heartbeat``.
The original entity name ``SignalRouter``, port directions, routing expressions,
card-enable decode, oscillator and shared branch LPF are preserved.
``upstream.json`` records source paths, hashes, reversible source patches and
routing expectations. This is a handwritten import, not a CSV-generated project.

Routing and safe state
----------------------

Outputs forced low in safe state: ``d_08``, ``d_09``, ``d_10``, ``d_11``, ``d_12``, ``d_13``, ``d_14``, ``d_15``, ``d_24``, ``d_25``, ``d_26``, ``d_27``, ``d_28``, ``d_29``.

Outputs that retain their routing in safe state: ``fpga_00``, ``fpga_01``, ``fpga_02``, ``fpga_03``, ``fpga_04``, ``fpga_05``, ``fpga_06``, ``fpga_07``, ``fpga_16``, ``fpga_17``, ``fpga_18``, ``fpga_19``, ``fpga_20``, ``fpga_21``, ``fpga_22``, ``fpga_23``.

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
