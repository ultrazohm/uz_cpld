"""Protect the heartbeat import's source fidelity and release scope."""
import hashlib
import json
from pathlib import Path
import unittest

from toolchain.buildsystem.model import catalog, load_build

ROOT = Path(__file__).resolve().parents[2]


class HeartbeatSnapshotTests(unittest.TestCase):
    def test_pinned_sources_and_only_documented_library_edits(self):
        directory = ROOT / 'programs/heartbeat/s3c_heartbeat'
        provenance = json.loads((directory / 'upstream.json').read_text())
        expected = {
            's3c_heartbeat.vhdl': '073c92b851df2404edeef1becb052f0443095b521bb9e324c374b6411353f119',
            's3c_heartbeat_fsm.vhdl': '2a238cbe24626a12f795a1656cc263dbe7b6e59597cc5b86fe3184e3a52e30f6',
            's3c_heartbeat_constraints.lpf': '9c85cca0e13bb292b6b44633ea4a63b2f7557ef497ba0393547a36b3af50d9ab',
            's3c_heartbeat_lib.vhdl': '04cb964582a104355f958aa68bb434074f6ebb830e3fcbbefbb69939d9173cbd',
        }
        self.assertEqual(provenance['commit'], 'bcfc7ee37d79eb2068b7d0dab166f0fa2e8833f7')
        self.assertEqual(provenance['dependencies']['s3c_heartbeat_lib.vhdl']['commit'],
                         '74c74460171527ff17ce074ae38ac34e14e3baec')
        self.assertEqual(provenance['original_sha256'], expected)
        self.assertEqual(set(provenance['modifications']), {'s3c_heartbeat_lib.vhdl'})
        for name, digest in expected.items():
            with self.subTest(source=name):
                data = (directory / name).read_bytes()
                self.assertEqual(hashlib.sha256(data).hexdigest(), provenance['sha256'][name])
                if name == 's3c_heartbeat_lib.vhdl':
                    for original, current in (
                        (b'USE sXc_hbgen_pkg.ALL;', b'USE work.sXc_hbgen_pkg.ALL;'),
                        (b'IN STD_LOGIC_VECTOR(CASCADE-1 DOWNTO 0);',
                         b"IN STD_LOGIC_VECTOR(CASCADE-1 DOWNTO 0) := (others => '0');"),
                    ):
                        self.assertEqual(data.count(current), 1)
                        data = data.replace(current, original)
                self.assertEqual(hashlib.sha256(data).hexdigest(), digest)

    def test_release_contains_only_s3c_and_compiles_its_pinned_dependency(self):
        self.assertEqual(list(catalog(ROOT, 'heartbeat')), ['s3c_heartbeat'])
        build = load_build(ROOT, 's3c_heartbeat', release_cycle='heartbeat')
        self.assertEqual(build.top, 'S3C')
        self.assertEqual(build.target, 'uz_s3c_xo2')
        self.assertEqual([source.path.name for source in build.sources],
                         ['s3c_heartbeat_lib.vhdl', 's3c_heartbeat_fsm.vhdl', 's3c_heartbeat.vhdl'])
        self.assertEqual(build.constraint.name, 's3c_heartbeat_constraints.lpf')
