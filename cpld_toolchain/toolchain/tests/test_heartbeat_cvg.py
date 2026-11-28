"""Check the generated release against its handwritten heartbeat sources."""
import hashlib
import json
from pathlib import Path
import re
import unittest

from cpld_toolchain.cpld_vhdl_generator import check
from cpld_toolchain.toolchain.buildsystem.model import catalog, load_build
from cpld_toolchain.toolchain.tests.test_heartbeat_dslot_ports import EXPECTED, routing

ROOT = Path(__file__).resolve().parents[3]
CYCLE = ROOT / 'programs/heartbeat_cvg'


class HeartbeatCvgTests(unittest.TestCase):
    def test_complete_catalog_and_recorded_cleanup(self):
        names = EXPECTED - {'tx30_hearbeattesting'}
        self.assertEqual(set(catalog(ROOT, 'heartbeat_cvg')),
                         {'cvg_' + name for name in names} | {'s3c_heartbeat'})
        migration = json.loads((CYCLE / 'migration.json').read_text())
        self.assertEqual({item['source'] for item in migration['programs']}, names)
        self.assertEqual(set(migration['omitted_programs']), {'tx30_hearbeattesting'})
        for item in migration['programs']:
            name = item['source']
            with self.subTest(program=name):
                source = ROOT / 'programs/heartbeat' / name / (name + '.vhdl')
                self.assertEqual(hashlib.sha256(source.read_bytes()).hexdigest(), item['source_sha256'])
                text = re.sub(r'--[^\n]*', '', source.read_text())
                # Compare normal/safe routes after removing the mandatory
                # system-error override verified by the handwritten-port tests.
                provenance = json.loads(source.with_name('upstream.json').read_text())
                prefix = "'0' when system_error = '1' else "
                old_routes = {}
                for pin, expression in routing(source.read_bytes()).items():
                    self.assertTrue(expression.startswith(prefix))
                    if pin not in provenance['undriven_outputs']:
                        old_routes[pin] = expression[len(prefix):]
                directory = CYCLE / item['generated']
                config = check(directory / 'generator.toml', directory)
                expected = {}
                for pin, expression in old_routes.items():
                    parts = expression.split(' and ')
                    self.assertIn(len(parts), (1, 2))
                    if len(parts) == 2:
                        self.assertEqual(parts[1], 'enable_forwarding')
                    expected[pin] = (parts[0], '0' if len(parts) == 2 else parts[0])
                self.assertEqual({p.name: p.actions for p in config.pins if p.direction == 'out'}, expected)
                old_ports = dict(re.findall(r'\b((?:fpga|d)_\d\d)\s*:\s*(in|out)\s+STD_LOGIC', text, re.I))
                undriven = {pin for pin, direction in old_ports.items() if direction == 'out' and pin not in expected}
                self.assertEqual(set(item['undriven_outputs_changed_to_inputs']), undriven)
                for pin in config.pins:
                    self.assertEqual(pin.direction, 'in' if pin.name in undriven else old_ports[pin.name])
                condition, = re.findall(r'user_enable_forwarding\s*<=\s*([^;]+);', text, re.I)
                enable = {p: int(v) for p, v in re.findall(r"((?:fpga|d)_\d\d)\s*=\s*'([01])'", condition)}
                self.assertEqual(config.enable, enable)
                self.assertEqual(config.pilot_policy, 'unused')
                self.assertIn('REQUIRE_PILOT => false', text)
                self.assertEqual(config.contract['id'], 's3c_heartbeat_v1')
                build = load_build(ROOT, item['generated'], release_cycle='heartbeat_cvg')
                self.assertEqual((build.standard, build.synthesis), ('2008', 'synplify'))
                self.assertEqual(build.sources[1].path, ROOT / 'xo2_library/s3c/heartbeat.vhdl')
                # Generator board constraints differ only in its existing TraceID default.
                def constraints(path):
                    return re.sub(r'TRACEID\s+"[^"]+"\s*;', '', path.read_text()).split()
                self.assertEqual(constraints(build.constraint), constraints(source.with_name(name + '_constraints.lpf')))

    def test_s3c_matches_heartbeat_release(self):
        source = ROOT / 'programs/heartbeat/s3c_heartbeat'
        destination = CYCLE / 's3c_heartbeat'
        original = load_build(ROOT, 's3c_heartbeat', release_cycle='heartbeat')
        copied = load_build(ROOT, 's3c_heartbeat', release_cycle='heartbeat_cvg')
        files = [path.path.name for path in original.sources] + [
            original.constraint.name, original.testbench.name, 's3c_heartbeat.toml', 'upstream.json']
        record, = json.loads((CYCLE / 'migration.json').read_text())['copied_programs']
        self.assertEqual(record['source'], 'heartbeat/s3c_heartbeat')
        self.assertEqual(record['destination'], 'heartbeat_cvg/s3c_heartbeat')
        self.assertEqual(set(record['files_sha256']), set(files))
        for name in files:
            with self.subTest(file=name):
                self.assertEqual((source / name).read_bytes(), (destination / name).read_bytes())
                self.assertEqual(hashlib.sha256((destination / name).read_bytes()).hexdigest(),
                                 record['files_sha256'][name])
        self.assertEqual((original.top, original.standard, original.synthesis),
                         (copied.top, copied.standard, copied.synthesis))
        self.assertFalse((destination / 'generator.toml').exists())
