"""Test 30 adapter-to-FPGA routes, which stay active during safe state."""
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_rx30(dut):
    dut.pilot_in.value = 0
    dut.carrierrdy.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0

    all_high = (1 << 30) - 1
    patterns = [0, all_high]
    for pin in range(30):
        patterns.append(1 << pin)             # One high input.
        patterns.append(all_high ^ (1 << pin))  # One low input.

    for data in patterns:
        for pin in range(30):
            getattr(dut, f"d_{pin:02}").value = (data >> pin) & 1

        # Receiving continues in safe state; only slotok changes.
        for safe in (0, 1, 0):
            dut.reqsafestate.value = safe
            await Timer(1, unit="ns")  # Let the combinational logic settle.

            for pin in range(30):
                expected = (data >> pin) & 1
                assert getattr(dut, f"fpga_{pin:02}").value == expected, (
                    f"fpga_{pin:02}: data={data:#x}, safe={safe}"
                )
            assert dut.slotok.value == 1 - safe
            assert dut.reqoe.value == 1
