"""Test 26 transmit routes with the four-bit enable code and safe state."""
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_tx26_w_enable(dut):
    dut.pilot_in.value = 0
    dut.carrierrdy.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0

    all_high = (1 << 26) - 1
    patterns = [0, all_high]
    for pin in range(26):
        patterns.append(1 << pin)             # One high input.
        patterns.append(all_high ^ (1 << pin))  # One low input.

    for data in patterns:
        for pin in range(26):
            getattr(dut, f"fpga_{pin:02}").value = (data >> pin) & 1

        for enable in range(16):
            dut.fpga_26.value = enable & 1
            dut.fpga_27.value = (enable >> 1) & 1
            dut.fpga_28.value = (enable >> 2) & 1
            dut.fpga_29.value = (enable >> 3) & 1

            for safe in (0, 1, 0):
                dut.reqsafestate.value = safe
                await Timer(1, unit="ns")  # Let the combinational logic settle.

                # Pins 26, 27, 28, 29 must be 0, 0, 1, 1.
                forwarding = (enable == 0b1100) and (safe == 0)
                for pin in range(26):
                    input_bit = (data >> pin) & 1
                    expected = input_bit & forwarding
                    assert getattr(dut, f"d_{pin:02}").value == expected, (
                        f"d_{pin:02}: data={data:#x}, enable={enable:04b}, safe={safe}"
                    )
                assert dut.slotok.value == forwarding
                assert dut.reqoe.value == 1

    # d_26 through d_29 are undriven in this design and are not data outputs.
