"""Verify D5 routing with the physical d_00/d_01 wire swap."""
import cocotb
from cocotb.triggers import Timer

# (CPLD input, CPLD output). First two routes compensate the wire swap.
ROUTES = [
    ("fpga_07", "d_01"),
    ("d_00", "fpga_14"),
    ("fpga_09", "d_02"),
    ("fpga_13", "d_03"),
    ("fpga_08", "d_04"),
    ("fpga_10", "d_05"),
    ("fpga_12", "d_06"),
    ("fpga_11", "d_07"),
    ("fpga_06", "d_08"),
    ("fpga_15", "d_09"),
    ("fpga_16", "d_10"),
    ("fpga_17", "d_11"),
    ("fpga_18", "d_12"),
    ("fpga_19", "d_13"),
    ("fpga_20", "d_14"),
    ("fpga_21", "d_15"),
    ("fpga_22", "d_16"),
    ("d_17", "fpga_23"),
]


@cocotb.test()
async def test_routing_with_wire_swap(dut):
    for name in ("pilot_in", "carrierrdy", "i2c_scl", "i2c_sda", "d_26"):
        getattr(dut, name).value = 0
    all_high = (1 << len(ROUTES)) - 1
    patterns = [0, all_high]
    for bit in range(len(ROUTES)):
        patterns.extend((1 << bit, all_high ^ (1 << bit)))

    for pattern in patterns:
        for bit, (source, _) in enumerate(ROUTES):
            getattr(dut, source).value = (pattern >> bit) & 1
        for safe in (0, 1, 0):
            dut.reqsafestate.value = safe
            await Timer(1, unit="ns")
            for bit, (source, destination) in enumerate(ROUTES):
                assert int(getattr(dut, destination).value) == (pattern >> bit) & 1, (
                    f"{source} -> {destination}: pattern={pattern:#x}, safe={safe}"
                )
            assert int(dut.slotok.value) == 1 - safe
            assert int(dut.reqoe.value) == 1
