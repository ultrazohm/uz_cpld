"""Check archived routing, safe-state behavior, and status outputs."""
import cocotb
from cocotb.triggers import Timer

INPUTS = ['d_20', 'd_21', 'd_22', 'd_23', 'd_24', 'd_25', 'd_26', 'd_27', 'd_28', 'd_29', 'fpga_00', 'fpga_01', 'fpga_02', 'fpga_03', 'fpga_04', 'fpga_05', 'fpga_06', 'fpga_07', 'fpga_08', 'fpga_09', 'fpga_10', 'fpga_11', 'fpga_12', 'fpga_13', 'fpga_14', 'fpga_15', 'fpga_16', 'fpga_17', 'fpga_18', 'fpga_19']
ROUTES = {
    'd_00': ('fpga_00', True),
    'd_01': ('fpga_01', True),
    'd_02': ('fpga_02', True),
    'd_03': ('fpga_03', True),
    'd_04': ('fpga_04', True),
    'd_05': ('fpga_05', True),
    'd_06': ('fpga_06', True),
    'd_07': ('fpga_07', True),
    'd_08': ('fpga_08', True),
    'd_09': ('fpga_09', True),
    'd_10': ('fpga_10', True),
    'd_11': ('fpga_11', True),
    'd_12': ('fpga_12', True),
    'd_13': ('fpga_13', True),
    'd_14': ('fpga_14', True),
    'd_15': ('fpga_15', True),
    'd_16': ('fpga_16', True),
    'd_17': ('fpga_17', True),
    'd_18': ('fpga_18', True),
    'd_19': ('fpga_19', True),
    'fpga_20': ('d_20', False),
    'fpga_21': ('d_21', False),
    'fpga_22': ('d_22', False),
    'fpga_23': ('d_23', False),
    'fpga_24': ('d_24', False),
    'fpga_25': ('d_25', False),
    'fpga_26': ('d_26', False),
    'fpga_27': ('d_27', False),
    'fpga_28': ('d_28', False),
    'fpga_29': ('d_29', False),
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
