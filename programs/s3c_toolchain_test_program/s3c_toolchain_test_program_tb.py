"""Check the fixed S3C safe-state outputs."""
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def safe_state_outputs(dut):
    await Timer(1, unit="ns")
    assert int(dut.carrier_pwron.value) == 0
    assert int(dut.anl_s3c_carrierready.value) == 0
    assert int(dut.digs3c_shared_carrierready.value) == 0
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    assert int(dut.digs3c_slotd1_slotoe.value) == 0
    assert int(dut.digs3c_slotd2_slotoe.value) == 0
    assert int(dut.digs3c_slotd3_slotoe.value) == 0
    assert int(dut.digs3c_slotd4_slotoe.value) == 0
    assert int(dut.digs3c_slotd5_slotoe.value) == 0
