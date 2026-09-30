"""Behavioral checks for branch D-slot ports against frozen upstream route metadata."""
from itertools import product
import json

from cocotb.triggers import Timer


async def exercise_program(dut, provenance_path):
    upstream = json.loads(provenance_path.read_text())
    routes, enable = upstream['routes'], upstream['enable']
    values = {pin: enable.get(pin, 0) for pin, direction in upstream['ports'].items()
              if direction == 'in'}
    for pin, value in values.items():
        getattr(dut, pin).value = value
    dut.reqsafestate.value = 0
    dut.carrierrdy.value = 0
    dut.pilot_in.value = 0
    dut.i2c_scl.value = 0
    dut.i2c_sda.value = 0
    # The imported internal oscillator is unbound in GHDL. A manual clock
    # also lets the test prove that safe assertion does not require an edge.
    dut.clk.value = 0
    heartbeat_running, heartbeat_level, phase, period = False, 0, 0, 21

    async def tick(count=1):
        nonlocal heartbeat_level, phase
        for _ in range(count):
            dut.clk.value = 0
            if heartbeat_running:
                phase += 1
                if phase >= period:
                    phase = 0
                    heartbeat_level ^= 1
                    dut.carrierrdy.value = heartbeat_level
            await Timer(5, unit='ns')
            dut.clk.value = 1
            await Timer(5, unit='ns')

    async def check(normal):
        await Timer(1, unit='ns')
        assert int(dut.slotok.value) == int(normal), 'SlotOK'
        assert int(dut.reqoe.value) == 1, 'ReqOE must remain high in safe state'
        for pin, route in routes.items():
            source = route['source']
            value = heartbeat_level if source == 'carrierrdy' else values[source]
            expected = value if normal or not route['gated'] else 0
            assert int(getattr(dut, pin).value) == expected, (pin, route, normal, expected)

    async def patterns(normal):
        # Drive all data inputs with zero/one and walking-one/walking-zero patterns.
        # Enable pins remain at the permitted pattern until their own test below.
        for background in (0, 1):
            for pin in values:
                values[pin] = enable.get(pin, background)
                getattr(dut, pin).value = values[pin]
            await check(normal)
            for pin in values:
                if pin in enable:
                    continue
                values[pin] = 1 - background
                getattr(dut, pin).value = values[pin]
                await check(normal)
                values[pin] = background
                getattr(dut, pin).value = background
            await check(normal)

    await tick(220)
    await patterns(False)  # A static CarrierReady cannot qualify.
    heartbeat_running = True
    await tick(21 * 14)
    await check(False)
    await tick(21 * 4)
    await patterns(True)

    dut.reqsafestate.value = 1
    await patterns(False)  # No clock edge: every gated route must already be low.
    await tick(21 * 20)  # Keep qualification while the static request is asserted.
    await check(False)
    dut.reqsafestate.value = 0
    await check(False)
    await tick()
    await check(False)
    await tick()
    await check(True)  # No fresh qualification is required.

    # An assertion entirely between clock edges must close and hold the gate.
    dut.reqsafestate.value = 1
    await check(False)
    dut.reqsafestate.value = 0
    await Timer(1000, unit='ns')
    await check(False)
    await tick()
    await check(False)
    await tick()
    await check(True)

    # These branch programs intentionally do not require pilot.
    dut.pilot_in.value = 1
    await tick(2)
    await check(True)
    dut.pilot_in.value = 0
    await tick(2)
    await check(True)

    for bits in product((0, 1), repeat=len(enable)):
        for pin, bit in zip(enable, bits):
            values[pin] = bit
            getattr(dut, pin).value = bit
        await tick(2)
        await check(all(values[pin] == bit for pin, bit in enable.items()))
    for pin, bit in enable.items():
        values[pin] = bit
        getattr(dut, pin).value = bit
    await tick(2)
    await check(True)

    heartbeat_running = False
    await tick(212)
    await patterns(False)
    heartbeat_running = True
    phase = 0
    await tick(21 * 14)
    await check(False)
    await tick(21 * 4)
    await check(True)

    # The stricter shared receiver must reject a pulse train with short intervals.
    period = 9
    phase = 0
    await tick(9 * 20)
    await patterns(False)
    period = 21
    phase = 0
    await tick(21 * 18)
    await check(True)

    # Observe raw diagnostic routes on both heartbeat levels, also in safe state.
    for safe_request in (0, 1):
        dut.reqsafestate.value = safe_request
        await tick(2)
        for _ in range(45):
            await tick()
            await check(not safe_request)
