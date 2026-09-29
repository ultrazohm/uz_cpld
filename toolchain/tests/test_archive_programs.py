"""Keep the migrated D-slot source files identical to their archive inputs."""

from pathlib import Path
import unittest
import hashlib
import json

from toolchain.buildsystem.model import catalog, load_build


ROOT = Path(__file__).resolve().parents[2]
ARCHIVE = ROOT / 'archive/MACHXO2/D_Slot_CPLD_LCMXO2-2000HC-4TG100C/uz_d_slots'
MIGRATED = {
    'optical_14tx_4rx': 'optical_14tx_4rx',
    'template_dslots': 'template_dslots',
    'tx16_14rx': 'tx16_14rx',
    'tx20_10rx': 'tx20_10rx',
    'uz_d_3ph_inverter': 'uz_d_3ph_inverter',
    'uz_d_abs_encoder': 'uz_d_abs_encoder',
    'uz_d_resolver_d1_to_d4': 'uz_d_resolver_d1_to_d4',
    'uz_d_resolver_d4_4inverter': 'uz_d_resolver_d4_4inverter',
    'uz_d_resolver_d5': 'uz_d_resolver_d5',
    'uz_d_resolver_d5_4inverter': 'uz_d_resolver_d5_4inverter',
    'uz_d_temperature_ltc2983': 'uz_d_temperature_ltc2983',
    'uz_d_voltage_003_5v_tx30': 'uz_d_voltage_003_5V_tx30',
    'uz_d_voltage_013_tx30': 'uz_d_voltage_013_tx30',
}


class ArchiveProgramTests(unittest.TestCase):
    def test_every_archived_router_has_a_program(self):
        archived = {path.parent.parent.name for path in ARCHIVE.glob('*/source/*.vhdl')}
        represented = set(MIGRATED.values()) | {'tx30', 'rx30', 'tx26_w_enable'}
        self.assertEqual(archived, represented)

    def test_migrated_program_inputs_match_archive(self):
        names = catalog(ROOT, 'original')
        for program, archive_name in MIGRATED.items():
            with self.subTest(program=program):
                self.assertIn(program, names)
                source_dir = ARCHIVE / archive_name / 'source'
                archived_sources = list(source_dir.glob('*.vhdl'))
                self.assertEqual(len(archived_sources), 1)
                build = load_build(ROOT, program, release_cycle='original')
                self.assertEqual(len(build.sources), 1)
                self.assertEqual(build.sources[0].path.read_bytes(), archived_sources[0].read_bytes())
                self.assertEqual(build.constraint.read_bytes(), (source_dir / 'uz_d_slots.lpf').read_bytes())


class Rev6SnapshotTests(unittest.TestCase):
    def test_snapshot_matches_pinned_source_hashes(self):
        directory = ROOT / 'programs/original/s3c_rev6_beta'
        expected = {
            's3c_rev6_beta_lib.vhdl': '8b66d6a3494d63a28c4ea1ec24c99de33e0638fba5b20af9f0b1be865a8a2e1c',
            's3c_rev6_beta_fsm.vhdl': '68d69897da4edb35eca7a3f9ee557275bc3ea6b75e7cfd000f169af06c157788',
            's3c_rev6_beta.vhdl': '463f0117e4bf565e5cd865d75932e736eaab02cd19a2889092878c8e6d42af51',
            's3c_rev6_beta_constraints.lpf': 'd66988fecf955c54f8ee84be5a6a64f0608722a1c2ef892de9b82441acab1ec6',
        }
        provenance = json.loads((directory / 'upstream.json').read_text())
        self.assertEqual(provenance['commit'], '2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae')
        self.assertEqual(provenance['original_sha256'], expected)
        for path, digest in expected.items():
            with self.subTest(path=path):
                data = (directory / path).read_bytes()
                self.assertEqual(hashlib.sha256(data).hexdigest(), provenance['sha256'][path])
                if path == 's3c_rev6_beta.vhdl':
                    commented = b"-- tristate_signals <= (others => 'Z');"
                    self.assertEqual(data.count(commented), 1)
                    data = data.replace(commented, commented[3:])
                self.assertEqual(hashlib.sha256(data).hexdigest(), digest)

    def test_manifest_uses_all_original_inputs(self):
        build = load_build(ROOT, 's3c_rev6_beta', release_cycle='original')
        self.assertEqual(build.top, 'S3C')
        self.assertEqual(build.standard, '2008')
        self.assertEqual([source.path.name for source in build.sources],
                         ['s3c_rev6_beta_lib.vhdl', 's3c_rev6_beta_fsm.vhdl', 's3c_rev6_beta.vhdl'])
        self.assertEqual(build.constraint.name, 's3c_rev6_beta_constraints.lpf')
        self.assertIsNone(build.netlist_skip_reason)
        foss = load_build(ROOT, 's3c_rev6_beta', backend='foss', release_cycle='original')
        self.assertEqual(foss.sources, build.sources)
        self.assertEqual(foss.constraint.name, 's3c_rev6_beta_foss_constraints.lpf')

    def test_foss_constraints_preserve_physical_vector_pins(self):
        from toolchain.buildsystem.backends.foss import constraints
        build = load_build(ROOT, 's3c_rev6_beta', backend='foss', release_cycle='original')
        lpf, settings, _ = constraints(build.constraint.read_text())
        self.assertNotIn('JTAG_PORT', settings)
        self.assertEqual([settings[f'BANK_{bank}'] for bank in range(6)],
                         ['3.3', '1.8', '1.8', '1.8', '3.3', '3.3'])
        for port, pin in (('DIGS3C_SlotD_ReqOE[0]', '92'), ('DIGS3C_SlotD_ReqOE[4]', '82'),
                          ('DIGS3C_SlotD_SlotOE[0]', '20'), ('DIGS3C_SlotD_SlotOE[4]', '14'),
                          ('FP_UsrLED[0]', '95'), ('FP_UsrLED[3]', '98'),
                          ('FlexLIO[2]', '75'), ('FlexLIO[3]', '76')):
            self.assertIn(f'LOCATE COMP "{port}" SITE "{pin}"', lpf)
        for port in ('FlexMio61ExternalStop', 'SD_SEL'):
            self.assertIn(f'IOBUF PORT "{port}" IO_TYPE=LVCMOS33 OPENDRAIN=ON PULLMODE=NONE DRIVE=12 SLEWRATE=SLOW', lpf)

    def test_procedure_fsm_does_not_publish_an_empty_transition_graph(self):
        from toolchain.analysis.state_diagram import extract_state_machines
        from toolchain.buildsystem.ghdl import read_vhdl
        source = ROOT / 'programs/original/s3c_rev6_beta/s3c_rev6_beta_fsm.vhdl'
        self.assertEqual(extract_state_machines(read_vhdl(source)), [])
