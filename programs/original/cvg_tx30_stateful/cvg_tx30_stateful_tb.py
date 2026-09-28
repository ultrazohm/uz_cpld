"""Check startup, all transmit routes, and S3C soft-stop behavior."""
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def routes_and_s3c_stop(dut):
    # OSCH is a hardware primitive; drive its internal net in RTL simulation.
    dut.s3c_clk.value = 0
    dut.reqsafestate.value = 1
    dut.carrierrdy.value = 0
    dut.pilot_in.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0
    values = [0] * 30
    for i in range(30):
        getattr(dut, f'fpga_{i:02d}').value = 0

    async def tick(count=1):
        for _ in range(count):
            dut.s3c_clk.value = 0
            await Timer(5, unit='ns')
            dut.s3c_clk.value = 1
            await Timer(5, unit='ns')

    async def check(normal):
        await Timer(1, unit='ns')
        assert int(dut.slotok.value) == normal
        assert int(dut.reqoe.value) == 1
        for i, bit in enumerate(values):
            assert int(getattr(dut, f'd_{i:02d}').value) == (bit if normal else 0)

    await tick(12)
    await check(False)
    dut.reqsafestate.value = 0
    await tick(5)
    for i in range(30):
        values[i] = 1
        getattr(dut, f'fpga_{i:02d}').value = 1
        await check(True)
        values[i] = 0
        getattr(dut, f'fpga_{i:02d}').value = 0
    for i in range(30):
        values[i] = 1
        getattr(dut, f'fpga_{i:02d}').value = 1
    await check(True)
    dut.reqsafestate.value = 1
    await tick(3)
    await check(False)
    # The legacy profile intentionally ignores CarrierReady and pilot_in.
    dut.carrierrdy.value = 1
    dut.pilot_in.value = 1
    await tick(5)
    await check(False)
    dut.reqsafestate.value = 0
    await tick(3)
    await check(True)
