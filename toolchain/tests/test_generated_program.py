"""Repository integration for independently generated VHDL programs."""
from pathlib import Path
import shutil
import tempfile
import unittest

from toolchain.buildsystem import workflow
from toolchain.buildsystem.model import BuildError, load_build

ROOT = Path(__file__).resolve().parents[2]


class GeneratedProgramTests(unittest.TestCase):
    def test_clone_regenerates_names_and_checks_sources(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for folder in ('programs', 'toolchain', 'cpld_vhdl_generator'):
                shutil.copytree(ROOT / folder, root / folder,
                                ignore=shutil.ignore_patterns('build', '__pycache__'))
            new = workflow.scaffold(root, 'stateful_clone', 'tx30_stateful')
            build = load_build(root, 'stateful_clone')
            self.assertEqual(build.top, 'stateful_clone')
            self.assertFalse((new / 'tx30_stateful.vhdl').exists())
            self.assertFalse((new / 'generated').exists())
            self.assertEqual([s.path for s in build.sources],
                             [root / 'cpld_vhdl_generator/hdl/s3c_logic.vhdl',
                              root / 'cpld_vhdl_generator/hdl/level_signals.vhdl', new / 'stateful_clone.vhdl'])
            self.assertFalse((new / 's3c_logic.vhdl').exists())
            self.assertEqual([s.library for s in build.sources], ['s3c', 's3c', 'work'])
            shared = build.sources[1].path
            original = shared.read_text()
            shared.write_text(original + '\n-- changed shared logic\n')
            with self.assertRaisesRegex(BuildError, 'inputs changed'):
                load_build(root, 'stateful_clone')
            shared.write_text(original)
            routing = new / 'routing.csv'
            self.assertEqual(routing.read_bytes(), (ROOT / 'programs/tx30_stateful/routing.csv').read_bytes())
            routing.write_text(routing.read_text().replace('d_00,fpga_00,0', 'd_00,fpga_00,1'))
            with self.assertRaisesRegex(BuildError, 'Stale'):
                load_build(root, 'stateful_clone')
