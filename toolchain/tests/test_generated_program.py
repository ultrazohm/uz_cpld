"""Repository integration for independently generated VHDL programs."""
from pathlib import Path
import shutil
import tempfile
import unittest

from cpld_vhdl_generator import generate
from toolchain.buildsystem import workflow
from toolchain.buildsystem.model import BuildError, load_build

ROOT = Path(__file__).resolve().parents[2]


class GeneratedProgramTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for folder in ('programs', 'toolchain', 'cpld_vhdl_generator'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('build', '__pycache__'))

    def test_clone_rejects_shared_generator_without_modifying_original(self):
        source = self.root / 'programs/tx30_stateful'
        shared = self.root / 'shared'
        shared.mkdir()
        config = shared / 'generator.toml'
        config.write_text((source / 'generator.toml').read_text().replace(
            '../../cpld_vhdl_generator/hdl', '../cpld_vhdl_generator/hdl'))
        shutil.copy2(source / 'routing.csv', shared / 'routing.csv')
        manifest = source / 'tx30_stateful.toml'
        manifest.write_text(manifest.read_text().replace('generator = "generator.toml"',
                                                       'generator = "../../shared/generator.toml"'))
        generate(config, source)
        build = load_build(self.root, 'tx30_stateful')
        paths = [*build.inputs, self.root / 'programs/catalog.toml']
        before = {path: path.read_bytes() for path in paths}
        with self.assertRaisesRegex(BuildError, 'program-local inputs'):
            workflow.scaffold(self.root, 'stateful_clone', 'tx30_stateful')
        self.assertEqual(before, {path: path.read_bytes() for path in paths})
        self.assertFalse((self.root / 'programs/stateful_clone').exists())
        load_build(self.root, 'tx30_stateful')

    def test_clone_normalizes_generator_path_that_mentions_template(self):
        source = self.root / 'programs/tx30_stateful'
        manifest = source / 'tx30_stateful.toml'
        manifest.write_text(manifest.read_text().replace('generator = "generator.toml"',
                                                       'generator = "../tx30_stateful/generator.toml"'))
        config = source / 'generator.toml'
        original = config.read_bytes()
        new = workflow.scaffold(self.root, 'stateful_clone', 'tx30_stateful')
        self.assertEqual(config.read_bytes(), original)
        self.assertTrue((new / 'stateful_clone.vhdl').is_file())
        load_build(self.root, 'tx30_stateful')
        load_build(self.root, 'stateful_clone')

    def test_clone_regenerates_names_and_checks_sources(self):
        root = self.root
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
