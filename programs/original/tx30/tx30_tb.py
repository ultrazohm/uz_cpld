"""Test 30 FPGA-to-adapter routes and the safe-state request."""
import cocotb
from cocotb.triggers import Timer


async def check_forwarding(dut):
    await Timer(1, unit="ns")
    assert dut.d_00.value == dut.fpga_00.value
    assert dut.d_01.value == dut.fpga_01.value
    assert dut.d_02.value == dut.fpga_02.value
    assert dut.d_03.value == dut.fpga_03.value
    assert dut.d_04.value == dut.fpga_04.value
    assert dut.d_05.value == dut.fpga_05.value
    assert dut.d_06.value == dut.fpga_06.value
    assert dut.d_07.value == dut.fpga_07.value
    assert dut.d_08.value == dut.fpga_08.value
    assert dut.d_09.value == dut.fpga_09.value
    assert dut.d_10.value == dut.fpga_10.value
    assert dut.d_11.value == dut.fpga_11.value
    assert dut.d_12.value == dut.fpga_12.value
    assert dut.d_13.value == dut.fpga_13.value
    assert dut.d_14.value == dut.fpga_14.value
    assert dut.d_15.value == dut.fpga_15.value
    assert dut.d_16.value == dut.fpga_16.value
    assert dut.d_17.value == dut.fpga_17.value
    assert dut.d_18.value == dut.fpga_18.value
    assert dut.d_19.value == dut.fpga_19.value
    assert dut.d_20.value == dut.fpga_20.value
    assert dut.d_21.value == dut.fpga_21.value
    assert dut.d_22.value == dut.fpga_22.value
    assert dut.d_23.value == dut.fpga_23.value
    assert dut.d_24.value == dut.fpga_24.value
    assert dut.d_25.value == dut.fpga_25.value
    assert dut.d_26.value == dut.fpga_26.value
    assert dut.d_27.value == dut.fpga_27.value
    assert dut.d_28.value == dut.fpga_28.value
    assert dut.d_29.value == dut.fpga_29.value
    assert dut.slotok.value == 1
    assert dut.reqoe.value == 1


async def check_safe_state(dut):
    await Timer(1, unit="ns")
    assert dut.d_00.value == 0
    assert dut.d_01.value == 0
    assert dut.d_02.value == 0
    assert dut.d_03.value == 0
    assert dut.d_04.value == 0
    assert dut.d_05.value == 0
    assert dut.d_06.value == 0
    assert dut.d_07.value == 0
    assert dut.d_08.value == 0
    assert dut.d_09.value == 0
    assert dut.d_10.value == 0
    assert dut.d_11.value == 0
    assert dut.d_12.value == 0
    assert dut.d_13.value == 0
    assert dut.d_14.value == 0
    assert dut.d_15.value == 0
    assert dut.d_16.value == 0
    assert dut.d_17.value == 0
    assert dut.d_18.value == 0
    assert dut.d_19.value == 0
    assert dut.d_20.value == 0
    assert dut.d_21.value == 0
    assert dut.d_22.value == 0
    assert dut.d_23.value == 0
    assert dut.d_24.value == 0
    assert dut.d_25.value == 0
    assert dut.d_26.value == 0
    assert dut.d_27.value == 0
    assert dut.d_28.value == 0
    assert dut.d_29.value == 0
    assert dut.slotok.value == 0
    assert dut.reqoe.value == 1


@cocotb.test()
async def test_tx30(dut):
    dut.pilot_in.value = 0
    dut.carrierrdy.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0
    dut.reqsafestate.value = 0

    # Check all outputs low.
    dut.fpga_00.value = 0
    dut.fpga_01.value = 0
    dut.fpga_02.value = 0
    dut.fpga_03.value = 0
    dut.fpga_04.value = 0
    dut.fpga_05.value = 0
    dut.fpga_06.value = 0
    dut.fpga_07.value = 0
    dut.fpga_08.value = 0
    dut.fpga_09.value = 0
    dut.fpga_10.value = 0
    dut.fpga_11.value = 0
    dut.fpga_12.value = 0
    dut.fpga_13.value = 0
    dut.fpga_14.value = 0
    dut.fpga_15.value = 0
    dut.fpga_16.value = 0
    dut.fpga_17.value = 0
    dut.fpga_18.value = 0
    dut.fpga_19.value = 0
    dut.fpga_20.value = 0
    dut.fpga_21.value = 0
    dut.fpga_22.value = 0
    dut.fpga_23.value = 0
    dut.fpga_24.value = 0
    dut.fpga_25.value = 0
    dut.fpga_26.value = 0
    dut.fpga_27.value = 0
    dut.fpga_28.value = 0
    dut.fpga_29.value = 0
    await check_forwarding(dut)

    # Raise each input separately and check every output.
    dut.fpga_00.value = 1
    await check_forwarding(dut)
    dut.fpga_00.value = 0
    dut.fpga_01.value = 1
    await check_forwarding(dut)
    dut.fpga_01.value = 0
    dut.fpga_02.value = 1
    await check_forwarding(dut)
    dut.fpga_02.value = 0
    dut.fpga_03.value = 1
    await check_forwarding(dut)
    dut.fpga_03.value = 0
    dut.fpga_04.value = 1
    await check_forwarding(dut)
    dut.fpga_04.value = 0
    dut.fpga_05.value = 1
    await check_forwarding(dut)
    dut.fpga_05.value = 0
    dut.fpga_06.value = 1
    await check_forwarding(dut)
    dut.fpga_06.value = 0
    dut.fpga_07.value = 1
    await check_forwarding(dut)
    dut.fpga_07.value = 0
    dut.fpga_08.value = 1
    await check_forwarding(dut)
    dut.fpga_08.value = 0
    dut.fpga_09.value = 1
    await check_forwarding(dut)
    dut.fpga_09.value = 0
    dut.fpga_10.value = 1
    await check_forwarding(dut)
    dut.fpga_10.value = 0
    dut.fpga_11.value = 1
    await check_forwarding(dut)
    dut.fpga_11.value = 0
    dut.fpga_12.value = 1
    await check_forwarding(dut)
    dut.fpga_12.value = 0
    dut.fpga_13.value = 1
    await check_forwarding(dut)
    dut.fpga_13.value = 0
    dut.fpga_14.value = 1
    await check_forwarding(dut)
    dut.fpga_14.value = 0
    dut.fpga_15.value = 1
    await check_forwarding(dut)
    dut.fpga_15.value = 0
    dut.fpga_16.value = 1
    await check_forwarding(dut)
    dut.fpga_16.value = 0
    dut.fpga_17.value = 1
    await check_forwarding(dut)
    dut.fpga_17.value = 0
    dut.fpga_18.value = 1
    await check_forwarding(dut)
    dut.fpga_18.value = 0
    dut.fpga_19.value = 1
    await check_forwarding(dut)
    dut.fpga_19.value = 0
    dut.fpga_20.value = 1
    await check_forwarding(dut)
    dut.fpga_20.value = 0
    dut.fpga_21.value = 1
    await check_forwarding(dut)
    dut.fpga_21.value = 0
    dut.fpga_22.value = 1
    await check_forwarding(dut)
    dut.fpga_22.value = 0
    dut.fpga_23.value = 1
    await check_forwarding(dut)
    dut.fpga_23.value = 0
    dut.fpga_24.value = 1
    await check_forwarding(dut)
    dut.fpga_24.value = 0
    dut.fpga_25.value = 1
    await check_forwarding(dut)
    dut.fpga_25.value = 0
    dut.fpga_26.value = 1
    await check_forwarding(dut)
    dut.fpga_26.value = 0
    dut.fpga_27.value = 1
    await check_forwarding(dut)
    dut.fpga_27.value = 0
    dut.fpga_28.value = 1
    await check_forwarding(dut)
    dut.fpga_28.value = 0
    dut.fpga_29.value = 1
    await check_forwarding(dut)
    dut.fpga_29.value = 0

    # Check all outputs high.
    dut.fpga_00.value = 1
    dut.fpga_01.value = 1
    dut.fpga_02.value = 1
    dut.fpga_03.value = 1
    dut.fpga_04.value = 1
    dut.fpga_05.value = 1
    dut.fpga_06.value = 1
    dut.fpga_07.value = 1
    dut.fpga_08.value = 1
    dut.fpga_09.value = 1
    dut.fpga_10.value = 1
    dut.fpga_11.value = 1
    dut.fpga_12.value = 1
    dut.fpga_13.value = 1
    dut.fpga_14.value = 1
    dut.fpga_15.value = 1
    dut.fpga_16.value = 1
    dut.fpga_17.value = 1
    dut.fpga_18.value = 1
    dut.fpga_19.value = 1
    dut.fpga_20.value = 1
    dut.fpga_21.value = 1
    dut.fpga_22.value = 1
    dut.fpga_23.value = 1
    dut.fpga_24.value = 1
    dut.fpga_25.value = 1
    dut.fpga_26.value = 1
    dut.fpga_27.value = 1
    dut.fpga_28.value = 1
    dut.fpga_29.value = 1
    await check_forwarding(dut)

    # Lower each input separately and check every output.
    dut.fpga_00.value = 0
    await check_forwarding(dut)
    dut.fpga_00.value = 1
    dut.fpga_01.value = 0
    await check_forwarding(dut)
    dut.fpga_01.value = 1
    dut.fpga_02.value = 0
    await check_forwarding(dut)
    dut.fpga_02.value = 1
    dut.fpga_03.value = 0
    await check_forwarding(dut)
    dut.fpga_03.value = 1
    dut.fpga_04.value = 0
    await check_forwarding(dut)
    dut.fpga_04.value = 1
    dut.fpga_05.value = 0
    await check_forwarding(dut)
    dut.fpga_05.value = 1
    dut.fpga_06.value = 0
    await check_forwarding(dut)
    dut.fpga_06.value = 1
    dut.fpga_07.value = 0
    await check_forwarding(dut)
    dut.fpga_07.value = 1
    dut.fpga_08.value = 0
    await check_forwarding(dut)
    dut.fpga_08.value = 1
    dut.fpga_09.value = 0
    await check_forwarding(dut)
    dut.fpga_09.value = 1
    dut.fpga_10.value = 0
    await check_forwarding(dut)
    dut.fpga_10.value = 1
    dut.fpga_11.value = 0
    await check_forwarding(dut)
    dut.fpga_11.value = 1
    dut.fpga_12.value = 0
    await check_forwarding(dut)
    dut.fpga_12.value = 1
    dut.fpga_13.value = 0
    await check_forwarding(dut)
    dut.fpga_13.value = 1
    dut.fpga_14.value = 0
    await check_forwarding(dut)
    dut.fpga_14.value = 1
    dut.fpga_15.value = 0
    await check_forwarding(dut)
    dut.fpga_15.value = 1
    dut.fpga_16.value = 0
    await check_forwarding(dut)
    dut.fpga_16.value = 1
    dut.fpga_17.value = 0
    await check_forwarding(dut)
    dut.fpga_17.value = 1
    dut.fpga_18.value = 0
    await check_forwarding(dut)
    dut.fpga_18.value = 1
    dut.fpga_19.value = 0
    await check_forwarding(dut)
    dut.fpga_19.value = 1
    dut.fpga_20.value = 0
    await check_forwarding(dut)
    dut.fpga_20.value = 1
    dut.fpga_21.value = 0
    await check_forwarding(dut)
    dut.fpga_21.value = 1
    dut.fpga_22.value = 0
    await check_forwarding(dut)
    dut.fpga_22.value = 1
    dut.fpga_23.value = 0
    await check_forwarding(dut)
    dut.fpga_23.value = 1
    dut.fpga_24.value = 0
    await check_forwarding(dut)
    dut.fpga_24.value = 1
    dut.fpga_25.value = 0
    await check_forwarding(dut)
    dut.fpga_25.value = 1
    dut.fpga_26.value = 0
    await check_forwarding(dut)
    dut.fpga_26.value = 1
    dut.fpga_27.value = 0
    await check_forwarding(dut)
    dut.fpga_27.value = 1
    dut.fpga_28.value = 0
    await check_forwarding(dut)
    dut.fpga_28.value = 1
    dut.fpga_29.value = 0
    await check_forwarding(dut)
    dut.fpga_29.value = 1

    # A safe-state request forces every output low; clearing it restores forwarding.
    dut.reqsafestate.value = 1
    await check_safe_state(dut)
    dut.reqsafestate.value = 0
    await check_forwarding(dut)
