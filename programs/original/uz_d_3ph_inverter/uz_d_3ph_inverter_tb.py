"""Check archived routing, safe-state behavior, and status outputs."""
import cocotb
from cocotb.triggers import Timer

INPUTS = ['d_06', 'd_07', 'd_08', 'd_09', 'd_10', 'd_11', 'd_12', 'd_13', 'd_15', 'd_16', 'd_17', 'd_18', 'd_19', 'd_20', 'd_21', 'd_22', 'd_23', 'd_24', 'd_25', 'd_26', 'd_27', 'd_28', 'd_29', 'fpga_00', 'fpga_01', 'fpga_02', 'fpga_03', 'fpga_04', 'fpga_05', 'fpga_14']
ROUTES = {
    'd_00': ('fpga_00', False),
    'd_01': ('fpga_01', False),
    'd_02': ('fpga_02', False),
    'd_03': ('fpga_03', False),
    'd_04': ('fpga_04', False),
    'd_05': ('fpga_05', False),
    'd_14': ('fpga_14', False),
    'fpga_06': ('d_06', False),
    'fpga_07': ('d_07', False),
    'fpga_08': ('d_08', False),
    'fpga_09': ('d_09', False),
    'fpga_10': ('d_10', False),
    'fpga_11': ('d_11', False),
    'fpga_12': ('d_12', False),
    'fpga_13': ('d_13', False),
    'fpga_15': ('d_15', False),
    'fpga_16': ('d_16', False),
    'fpga_17': ('d_17', False),
    'fpga_18': ('d_18', False),
    'fpga_19': ('d_19', False),
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
