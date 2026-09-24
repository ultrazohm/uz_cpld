"""Check archived routing, safe-state behavior, and status outputs."""
import cocotb
from cocotb.triggers import Timer

INPUTS = ['d_00', 'd_01', 'd_06', 'd_07', 'd_12', 'd_15', 'd_18', 'd_19', 'd_20', 'd_21', 'd_22', 'd_23', 'd_24', 'd_25', 'd_26', 'd_27', 'd_28', 'd_29', 'fpga_00', 'fpga_01', 'fpga_02', 'fpga_03', 'fpga_04', 'fpga_05', 'fpga_08', 'fpga_09', 'fpga_10', 'fpga_11', 'fpga_12', 'fpga_13', 'fpga_14', 'fpga_15', 'fpga_16', 'fpga_17', 'fpga_19', 'fpga_20', 'fpga_21', 'fpga_22', 'fpga_23', 'fpga_24', 'fpga_25', 'fpga_26', 'fpga_27', 'fpga_28', 'fpga_29']
ROUTES = {
    'd_05': ('fpga_11', False),
    'd_04': ('fpga_10', False),
    'd_14': ('fpga_20', False),
    'd_11': ('fpga_17', False),
    'd_10': ('fpga_16', False),
    'd_17': ('fpga_23', False),
    'd_09': ('fpga_15', False),
    'd_08': ('fpga_14', False),
    'd_16': ('fpga_22', False),
    'fpga_07': ('d_01', False),
    'fpga_06': ('d_00', False),
    'fpga_18': ('d_12', False),
    'd_03': ('fpga_08', False),
    'd_02': ('fpga_09', False),
    'd_13': ('fpga_12', False),
}
ENABLE_PINS = True

@cocotb.test()
async def test_archived_routes(dut):
    dut.pilot_in.value = 0
    dut.carrierrdy.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0
    values = {name: 0 for name in INPUTS}

    async def check(safe, enable_pattern=None):
        for name, value in values.items():
            getattr(dut, name).value = value
        if ENABLE_PINS:
            for index, bit in zip(range(26, 30), (0, 0, 1, 1) if enable_pattern is None else enable_pattern):
                pin = f'fpga_{index:02d}'
                values[pin] = bit
                getattr(dut, pin).value = bit
        dut.reqsafestate.value = safe
        await Timer(1, unit="ns")
        enabled = not ENABLE_PINS or tuple(values[f'fpga_{i:02d}'] for i in range(26, 30)) == (0, 0, 1, 1)
        forwarding = bool(enabled and not safe)
        assert int(dut.slotok.value) == forwarding
        assert int(dut.reqoe.value) == 1
        for destination, (source, gated) in ROUTES.items():
            expected = values[source] if not gated or forwarding else 0
            assert int(getattr(dut, destination).value) == expected, f'{destination} from {source}'

    await check(0)
    for source in sorted({source for source, _ in ROUTES.values()}):
        values[source] = 1
        await check(0)
        values[source] = 0
    for source in {source for source, _ in ROUTES.values()}:
        values[source] = 1
    await check(0)
    await check(1)
    if ENABLE_PINS:
        for pattern in ((0, 0, 0, 0), (1, 0, 1, 1), (0, 1, 1, 1),
                        (0, 0, 0, 1), (0, 0, 1, 0), (0, 0, 1, 1)):
            await check(0, pattern)
            await check(1, pattern)
