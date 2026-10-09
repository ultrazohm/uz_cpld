This cycle contains the handwritten ``s3c_heartbeat`` controller and 29 handwritten D-slot programs.
All manifests select Diamond, Synplify and VHDL-2008.
D-slots use the shared ``s3c.s3c_logic(heartbeat)`` receiver.

.. rubric:: Protocol

CarrierReady carries heartbeat and ReqSafeState is a separate active-high static request.
Receivers require 16 qualifying edges, inclusive 10--52-clock intervals and a 208-clock no-edge timeout at nominal 2.08 MHz.
Before qualification all declared data outputs, SlotOK and ReqOE are zero; qualification clears startup inhibition.
After qualification a malformed interval or timeout latches system_error until power-on initialization or reconfiguration.
Runtime reset and restored heartbeat do not clear a latched fault.
Static safe-state assertion is clock-independent; release takes two rising edges while heartbeat monitoring continues.
See :doc:`/xo2-library` for clock, reset and supply-domain limits.

.. rubric:: Routing

The 16 voltage variants select TX/RX for groups 00--07, 08--15, 16--23 and 24--29.
TX is FPGA to adapter and gated low in safe state; RX is adapter to FPGA and remains active in safe state.
All routes are zero in system_error.
The inverter, encoder, resolver and RX-only programs keep their assigned routes active in safe state.
``uz_d_temperature_ltc2983`` keeps channels 00--18 active and gates outputs 19--29.
``optical_14tx_4rx`` implements 26 TX and four RX routes.
``tx30_hearbeattesting`` exposes raw CarrierReady on outputs 00 and 01 in normal/safe state and is a diagnostic program.
Program descriptions list individual gated, ungated, high-impedance and enable-controlled pins.

Pilot is unused and ReqOE is high in normal and safe states.
Low SlotOK alone does not mean that every route is disabled; S3C SlotOK inputs do not cause the implemented hard-error decisions.
ReqOE zero disables external buffers and does not guarantee physical pins are driven low.
LPFs request ``TRACEID "0000000000"`` and ``SLAVE_SPI_PORT=ENABLE``; review vendor diagnostics and board pulls for these settings.
Managed builds allocate USERCODE independently.

.. rubric:: Validation

D-slot tests exercise routes, safe-state requests, system-error persistence and enable combinations where used.
Shared-library tests cover interval boundaries and runtime-reset behavior.
The S3C test accelerates its oscillator/tick stimulus; neither RTL simulation nor firmware export establishes fitted startup or board timing.

::

   uz_cpld sim --release-cycle heartbeat
   uz_cpld build_all --release-cycle heartbeat
   uz_cpld docs --release-cycle heartbeat
