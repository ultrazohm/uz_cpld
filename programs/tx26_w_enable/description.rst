Forwards FPGA channels 0–25 only when pins 26, 27, 28, 29 are ``0, 0, 1, 1`` and ``reqsafestate`` is low.
Otherwise the 26 data outputs are forced low and ``slotok`` is deasserted.
``reqoe`` stays high.

Adapter outputs 26–29 are declared but undriven.
Their unknown values are visible in the waveform; they are not valid data outputs.
The test checks 54 data patterns, all 16 enable codes and safe-state transitions ``0 → 1 → 0``, for a total of 2592 ns at 1 ns per check.
