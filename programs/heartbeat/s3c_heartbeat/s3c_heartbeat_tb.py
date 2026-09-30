"""Exercise the unchanged heartbeat top level using its internal clock/reset logic."""
import cocotb
from cocotb.clock import Clock
from cocotb.handle import Force
from cocotb.triggers import Timer


async def check_heartbeat(dut):
    """Check 21-clock edge spacing while the accelerated 10 ns clock runs."""
    previous = int(dut.digs3c_shared_carrierready.value)
    edges = []
    for cycle in range(100):
        await Timer(10, unit="ns")
        current = int(dut.digs3c_shared_carrierready.value)
        if current != previous:
            edges.append(cycle)
        previous = current
    assert len(edges) >= 4, "CarrierReady must keep toggling"
    assert all(b - a == 21 for a, b in zip(edges, edges[1:]))


@cocotb.test()
async def startup_soft_stop_and_supply_failure(dut):
    dut.syssw_pwr_nc.value = 1
    dut.fpio_externalstop.value = 1
    dut.fp_usrsw1.value = 1
    dut.fp_usrsw2.value = 1
    dut.fp_usrsw3.value = 1
    dut.pg_vin.value = 1
    dut.ppn_vin.value = 0
    dut.pg_module.value = 1
    dut.digs3c_slotd_reqoe.value = 0b11111
    dut.flexmios52_pcie.value = 1
    # The vendor OSCH is unbound in GHDL; drive its local output, retaining
    # the archived clock distribution, startup reset, tickgen and debounce.
    cocotb.start_soon(Clock(dut.s3c_clkrst.local_clk, 10, unit="ns").start())
    await Timer(100, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    assert int(dut.digs3c_slotd_slotoe.value) == 0
    assert int(dut.flexmios53_gpio_powerdown.value) == 0
    assert int(dut.sd_sel.value) == 0
    assert int(dut.fpio_flexmio52.value) == 1
    assert int(dut.digs3c_shared_carrierready.value) == 0
    dut.ppn_vin.value = 1
    await Timer(100, unit="ns")
    assert int(dut.carrier_pwron.value) == 0
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    assert int(dut.digs3c_slotd_slotoe.value) == 0

    # Accelerate the existing millisecond timebase for behavioral coverage.
    # Each 10 ns clock now represents one timer tick, not real board timing.
    dut.tick1ms.value = Force(1)
    dut.syssw_pwr_nc.value = 0
    await Timer(200, unit="ns")
    assert int(dut.carrier_pwron.value) == 1
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    dut.syssw_pwr_nc.value = 1
    await Timer(11000, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 0
    assert int(dut.digs3c_slotd_slotoe.value) == 0b11111
    await check_heartbeat(dut)

    # Module-power gating must suppress the heartbeat without requesting stop.
    dut.pg_module.value = 0
    await Timer(200, unit="ns")
    for _ in range(50):
        await Timer(10, unit="ns")
        assert int(dut.digs3c_shared_carrierready.value) == 0
    assert int(dut.digs3c_shared_reqsafestate.value) == 0
    dut.pg_module.value = 1
    await Timer(200, unit="ns")
    await check_heartbeat(dut)

    dut.fp_usrsw3.value = 0
    await Timer(200, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    await check_heartbeat(dut)  # Static safe-state request is independent.
    dut.fp_usrsw1.value = 0
    await Timer(200, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 1, "Stop must win over enable"
    dut.fp_usrsw3.value = 1
    await Timer(100, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 0

    dut.pg_vin.value = 0
    await Timer(200, unit="ns")
    assert int(dut.digs3c_shared_reqsafestate.value) == 1
    assert int(dut.flexmios53_gpio_powerdown.value) == 1
    assert int(dut.fp_usrled.value) == 0b0110
    assert int(dut.carrier_pwron.value) == 1, "Hard error must allow shutdown time"
    await Timer(45000, unit="ns")
    assert int(dut.carrier_pwron.value) == 1
    await Timer(10000, unit="ns")
    assert int(dut.carrier_pwron.value) == 0
    assert int(dut.digs3c_slotd_slotoe.value) == 0
    assert int(dut.digs3c_shared_carrierready.value) == 0
