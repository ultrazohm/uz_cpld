"""Validate the imported routes in normal/safe state against pinned upstream metadata."""
from pathlib import Path
import cocotb
from cpld_toolchain.toolchain.simulation.heartbeat_dslot import exercise_program


@cocotb.test()
async def routing_and_heartbeat(dut):
    await exercise_program(dut, Path(__file__).with_name("upstream.json"))
