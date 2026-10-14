Purpose
-------

``s3c_heartbeat`` is the S3C power controller for heartbeat D-slot firmware.
It targets ``LCMXO2-4000HC-4TG144C`` with top entity ``S3C``.
The top-level VHDL instantiates its program-local clock/debounce library and FSM.
See :doc:`/s3c` for signaling and controller compatibility.

Behavior
--------

Digital CarrierReady (pin 94) carries approximately 49.5 kHz heartbeat: one transition every 21 nominal 2.08 MHz clocks.
FSM enable, debounced power-panic ``ppn6v`` and debounced module power-good ``pg_som`` gate the sender; disabling it holds the physical output low.
ReqSafeState (pin 93) remains an independent static active-high request.
Soft stop can assert it while heartbeat continues.
Physical D-slot output enables are masked by ``forceoutputdisable``.
Power-good loss is debounced before heartbeat is gated; heartbeat enable can create a one-clock startup pulse.

Build and validation
--------------------

::

   uz_cpld check --program s3c_heartbeat --release-cycle heartbeat_cvg
   uz_cpld sim --program s3c_heartbeat --release-cycle heartbeat_cvg
   uz_cpld build --program s3c_heartbeat --release-cycle heartbeat_cvg

The manifest selects Diamond, Synplify and VHDL-2008.
The FSM requests ``safe,gray`` encoding; verify the mapped startup/reset behavior when changing synthesis settings.
The program retains two drivers of its unused ``tristate_signals`` vector, preventing GHDL synthesis; RTL schematics are explicitly skipped and FOSS firmware is unsupported.
GHDL simulation supports the source and tests startup, heartbeat edge spacing, module-power suppression/recovery, soft stop, STOP/ENABLE priority and delayed shutdown after supply failure.
The test drives the oscillator and accelerates millisecond ticks; it does not verify fitted startup or board timing.
Firmware export and USERCODE readback do not establish hardware qualification.
