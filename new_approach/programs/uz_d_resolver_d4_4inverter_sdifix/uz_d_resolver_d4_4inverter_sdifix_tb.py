"""Verify D4 routing with physical swaps 00/01, 09/10, and 18/19."""
import cocotb
from cocotb.triggers import Timer

# (CPLD input, CPLD output), including all three physical wire swaps.
ROUTES = [
    ("fpga_01", "d_01"),
    ("d_00", "fpga_08"),
    ("fpga_03", "d_02"),
    ("fpga_07", "d_03"),
    ("fpga_02", "d_04"),
    ("fpga_04", "d_05"),
    ("fpga_06", "d_06"),
    ("fpga_05", "d_07"),
    ("fpga_00", "d_08"),
    ("fpga_10", "d_10"),
    ("d_09", "fpga_17"),
    ("fpga_12", "d_11"),
    ("fpga_16", "d_12"),
    ("fpga_11", "d_13"),
    ("fpga_13", "d_14"),
    ("fpga_15", "d_15"),
    ("fpga_14", "d_16"),
    ("fpga_09", "d_17"),
    ("fpga_19", "d_19"),
    ("d_18", "fpga_26"),
    ("fpga_21", "d_20"),
    ("fpga_25", "d_21"),
    ("fpga_20", "d_22"),
    ("fpga_22", "d_23"),
    ("fpga_24", "d_24"),
    ("fpga_23", "d_25"),
    ("fpga_18", "d_26"),
    ("fpga_27", "d_27"),
    ("fpga_28", "d_28"),
    ("fpga_29", "d_29"),
]


@cocotb.test()
async def test_routing_with_wire_swap(dut):
    for name in ("pilot_in", "carrierrdy", "i2c_scl", "i2c_sda"):
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
