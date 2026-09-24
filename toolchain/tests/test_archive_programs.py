"""Keep the migrated D-slot source files identical to their archive inputs."""

from pathlib import Path
import unittest

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
        names = catalog(ROOT)
        for program, archive_name in MIGRATED.items():
            with self.subTest(program=program):
                self.assertIn(program, names)
                source_dir = ARCHIVE / archive_name / 'source'
                archived_sources = list(source_dir.glob('*.vhdl'))
                self.assertEqual(len(archived_sources), 1)
                build = load_build(ROOT, program)
                self.assertEqual(len(build.sources), 1)
                self.assertEqual(build.sources[0].path.read_bytes(), archived_sources[0].read_bytes())
                self.assertEqual(build.constraint.read_bytes(), (source_dir / 'uz_d_slots.lpf').read_bytes())
