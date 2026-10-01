"""Verify completeness and source fidelity of the heartbeat D-slot migration."""
import base64
import hashlib
from itertools import product
import json
from pathlib import Path
import re
import unittest

from toolchain.buildsystem.model import catalog, load_build

ROOT = Path(__file__).resolve().parents[2]
CYCLE = ROOT / 'programs/heartbeat'
CORE = {'optical_14tx_4rx', 'rx30', 'template_dslots', 'tx16_14rx', 'tx20_10rx',
        'tx26_w_enable', 'tx30', 'tx30_hearbeattesting', 'uz_d_3ph_inverter',
        'uz_d_abs_encoder', 'uz_d_resolver_d1_to_d4', 'uz_d_resolver_d5',
        'uz_d_temperature_ltc2983'}
EXPECTED = CORE | {f'voltage_8{a}_8{b}_8{c}_6{d}' for a, b, c, d in product(('rx', 'tx'), repeat=4)}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def routing(data):
    text = re.sub(r'--[^\n]*', '', data.decode('latin1'))
    return dict((pin.lower(), ' '.join(expression.lower().split()))
                for pin, expression in re.findall(r'\b((?:fpga|d)_\d\d)\s*<=\s*([^;]+);', text, re.I))


class HeartbeatDslotPortTests(unittest.TestCase):
    def test_every_branch_heartbeat_program_is_present_and_uses_shared_receiver(self):
        inventory = json.loads((CYCLE / 'dslot-ports.json').read_text())
        self.assertEqual(inventory['commit'], 'bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7')
        self.assertEqual({entry['name'] for entry in inventory['programs']}, EXPECTED)
        self.assertTrue(EXPECTED | {'s3c_heartbeat'} <= set(catalog(ROOT, 'heartbeat')))
        for name in sorted(EXPECTED):
            with self.subTest(name=name):
                build = load_build(ROOT, name, release_cycle='heartbeat')
                self.assertEqual(build.target, 'uz_dslot_xo2')
                self.assertEqual(build.top, 'SignalRouter')
                self.assertEqual([(source.path, source.library) for source in build.sources], [
                    (ROOT / 'xo2_library/s3c/s3c_logic.vhdl', 's3c'),
                    (ROOT / 'xo2_library/s3c/heartbeat.vhdl', 's3c'),
                    (CYCLE / name / f'{name}.vhdl', 'work'),
                ])
                source = build.sources[-1].path.read_text(encoding='latin1')
                self.assertIn('entity s3c.s3c_logic(heartbeat)', source)
                self.assertNotIn('ENTITY work.dslot_heartbeat_receiver', source)

    def test_only_recorded_controller_edits_and_original_constraints(self):
        for name in sorted(EXPECTED):
            with self.subTest(name=name):
                directory = CYCLE / name
                provenance = json.loads((directory / 'upstream.json').read_text())
                self.assertEqual(provenance['commit'], 'bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7')
                current = (directory / f'{name}.vhdl').read_bytes()
                self.assertEqual(digest(current), provenance['ported_sha256']['source'])
                lines = current.splitlines(keepends=True)
                for patch in reversed(provenance['source_patches']):
                    start = patch['ported_start']
                    old = base64.b64decode(patch['original']).splitlines(keepends=True)
                    new = base64.b64decode(patch['ported']).splitlines(keepends=True)
                    self.assertEqual(lines[start:start + len(new)], new)
                    lines[start:start + len(new)] = old
                original = b''.join(lines)
                self.assertEqual(digest(original), provenance['original_sha256']['source'])
                expected_error_routes = {
                    pin: "'0' when system_error = '1' else " + expression
                    for pin, expression in routing(original).items()
                }
                expected_error_routes.update({pin: "'0' when system_error = '1' else 'z'"
                                              for pin in provenance['undriven_outputs']})
                self.assertEqual(routing(current), expected_error_routes)
                expected = {pin: route['source'] + (' and enable_forwarding' if route['gated'] else '')
                            for pin, route in provenance['routes'].items()}
                self.assertEqual(routing(original), expected)
                constraints = (directory / f'{name}_constraints.lpf').read_bytes()
                self.assertEqual(digest(constraints), provenance['original_sha256']['constraints'])
                self.assertEqual(digest(constraints), provenance['ported_sha256']['constraints'])
                # Preserve every port direction; formerly undriven outputs now
                # drive Z normally and zero on a latched heartbeat fault.
                expression = rb'\b((?:fpga|d)_\d\d)\s*:\s*(in|out)\s+STD_LOGIC\b'
                self.assertEqual(re.findall(expression, original, re.I), re.findall(expression, current, re.I))
                decode = rb"user_enable_forwarding\s*<=\s*'1'\s+when[^;]+;"
                self.assertEqual(re.findall(decode, original, re.I), re.findall(decode, current, re.I))

    def test_voltage_groups_and_special_safe_state_routes(self):
        for a, b, c, d in product(('rx', 'tx'), repeat=4):
            name = f'voltage_8{a}_8{b}_8{c}_6{d}'
            routes = json.loads((CYCLE / name / 'upstream.json').read_text())['routes']
            expected = {}
            for indices, direction in zip((range(8), range(8, 16), range(16, 24), range(24, 30)), (a, b, c, d)):
                for i in indices:
                    out, src = (f'd_{i:02d}', f'fpga_{i:02d}') if direction == 'tx' else (f'fpga_{i:02d}', f'd_{i:02d}')
                    expected[out] = {'source': src, 'gated': direction == 'tx'}
            self.assertEqual(routes, expected)
        for name in ('uz_d_3ph_inverter', 'uz_d_abs_encoder', 'uz_d_resolver_d1_to_d4', 'uz_d_resolver_d5', 'rx30'):
            routes = json.loads((CYCLE / name / 'upstream.json').read_text())['routes']
            self.assertFalse(any(route['gated'] for route in routes.values()))
        routes = json.loads((CYCLE / 'uz_d_temperature_ltc2983/upstream.json').read_text())['routes']
        self.assertEqual({pin for pin, route in routes.items() if route['gated']}, {f'd_{i:02d}' for i in range(19, 30)})
        routes = json.loads((CYCLE / 'tx30_hearbeattesting/upstream.json').read_text())['routes']
        for pin in ('d_00', 'd_01'):
            self.assertEqual(routes[pin], {'source': 'carrierrdy', 'gated': False})
