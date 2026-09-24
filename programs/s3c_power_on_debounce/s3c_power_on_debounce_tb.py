"""Check the archived S3C controller's initial safe-state behavior."""
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def startup_requests_safe_state(dut):
    dut.syssw_pwr_nc.value = 1
    dut.fpio_externalstop.value = 1
    dut.fp_usrsw1.value = 1
    dut.fp_usrsw2.value = 1
    dut.fp_usrsw3.value = 1
    dut.pg_vin.value = 1
    dut.ppn_vin.value = 1
    dut.digs3c_slotd_reqoe.value = 0b11111
    dut.flexmios52_pcie.value = 1
    dut.clk.value = 0

    await Timer(1, unit="ns")
    dut.clk.value = 1
    await Timer(1, unit="ns")

    assert int(dut.carrier_pwron.value) == 0
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    assert int(dut.digs3c_slotd_slotoe.value) == 0
    assert int(dut.sd_sel.value) == 0
    assert int(dut.fpio_flexmio52.value) == 1
    assert int(dut.flexmio61externalstop.value) == 1
