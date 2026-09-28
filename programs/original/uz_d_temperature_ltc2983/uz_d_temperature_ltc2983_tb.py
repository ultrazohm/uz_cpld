"""Check archived routing, safe-state behavior, and status outputs."""
import cocotb
from cocotb.triggers import Timer

INPUTS = ['d_02', 'd_04', 'd_08', 'd_10', 'd_14', 'd_16', 'fpga_00', 'fpga_01', 'fpga_03', 'fpga_05', 'fpga_06', 'fpga_07', 'fpga_09', 'fpga_11', 'fpga_12', 'fpga_13', 'fpga_15', 'fpga_17', 'fpga_18', 'fpga_19', 'fpga_20', 'fpga_21', 'fpga_22', 'fpga_23', 'fpga_24', 'fpga_25', 'fpga_26', 'fpga_27', 'fpga_28', 'fpga_29']
ROUTES = {
    'd_00': ('fpga_00', True),
    'd_01': ('fpga_01', True),
    'fpga_02': ('d_02', True),
    'd_03': ('fpga_03', True),
    'fpga_04': ('d_04', True),
    'd_05': ('fpga_05', True),
    'd_06': ('fpga_06', True),
    'd_07': ('fpga_07', True),
    'fpga_08': ('d_08', True),
    'd_09': ('fpga_09', True),
    'fpga_10': ('d_10', True),
    'd_11': ('fpga_11', True),
    'd_12': ('fpga_12', True),
    'd_13': ('fpga_13', True),
    'fpga_14': ('d_14', True),
    'd_15': ('fpga_15', True),
    'fpga_16': ('d_16', True),
    'd_17': ('fpga_17', True),
    'd_18': ('fpga_18', True),
    'd_19': ('fpga_19', True),
    'd_20': ('fpga_20', True),
    'd_21': ('fpga_21', True),
    'd_22': ('fpga_22', True),
    'd_23': ('fpga_23', True),
    'd_24': ('fpga_24', True),
    'd_25': ('fpga_25', True),
    'd_26': ('fpga_26', True),
    'd_27': ('fpga_27', True),
    'd_28': ('fpga_28', True),
    'd_29': ('fpga_29', True),
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
