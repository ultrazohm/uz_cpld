S3C power-on debounce (archived S3C_171224)
-------------------------------------------

This program ports the ``S3C_171224`` Diamond implementation's
``Power_on_debounce.vhd`` state machine. The source was normalized for GHDL:
unused nonstandard imports and an unused, multiply driven tristate signal were
removed. The testbench drives the internal clock to check startup while GHDL
leaves the MachXO2 ``OSCH`` instance unbound. The hardware implementation uses
``OSCH`` at 2.08 MHz.

The archived logic requests safe state and disables the five digital slot
outputs during startup, then handles ready, stop, error, and shutdown states.
The included simulation checks startup only. The archived source declares
``CarrierReady`` outputs without driving them and hardcodes ``warning`` low.
Its comments also report that ``ReqSafeState`` did not work while its 1.8 V
bank was unpowered. This is an extracted historical design, not a validated
operating safety controller.

Diamond uses the archived LPF. A prepared FOSS LPF omits ``JTAG_PORT=DISABLE`` because
Trellis has no corresponding setting, and corrects the ``IO_TYPE`` of the two
bank-2 outputs ``SD_SEL`` and ``FlexMio61ExternalStop`` from 3.3 V to 1.8 V.
The FOSS firmware backend is not enabled for this program: its mapped
sequential equivalence check remains unproven. These configuration differences
also require hardware review before deployment.
