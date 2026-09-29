"""Check archived routing, safe-state behavior, and status outputs."""
import cocotb
from cocotb.triggers import Timer

INPUTS = ['d_01', 'd_17', 'd_26', 'fpga_06', 'fpga_07', 'fpga_08', 'fpga_09', 'fpga_10', 'fpga_11', 'fpga_12', 'fpga_13', 'fpga_15', 'fpga_16', 'fpga_17', 'fpga_18', 'fpga_19', 'fpga_20', 'fpga_21', 'fpga_22']
ROUTES = {
    'd_00': ('fpga_07', False),
    'fpga_14': ('d_01', False),
    'd_02': ('fpga_09', False),
    'd_03': ('fpga_13', False),
    'd_04': ('fpga_08', False),
    'd_05': ('fpga_10', False),
    'd_06': ('fpga_12', False),
    'd_07': ('fpga_11', False),
    'd_08': ('fpga_06', False),
    'd_09': ('fpga_15', False),
    'd_10': ('fpga_16', False),
    'd_11': ('fpga_17', False),
    'd_12': ('fpga_18', False),
    'd_13': ('fpga_19', False),
    'd_14': ('fpga_20', False),
    'd_15': ('fpga_21', False),
    'd_16': ('fpga_22', False),
    'fpga_23': ('d_17', False),
}
ENABLE_PINS = False

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
