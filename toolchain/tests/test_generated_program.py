"""Repository integration for independently generated VHDL programs."""
from pathlib import Path
import json
import shutil
import subprocess
import sys
import tempfile
import unittest

from cpld_vhdl_generator import GeneratorError, check, generate
from toolchain.buildsystem import workflow
from toolchain.buildsystem.model import BuildError, catalog, load_build

ROOT = Path(__file__).resolve().parents[2]


class GeneratedProgramTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for folder in ('programs', 'toolchain', 'cpld_vhdl_generator'):
            shutil.copytree(ROOT / folder, self.root / folder,
                            ignore=shutil.ignore_patterns('build', '__pycache__'))
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        shutil.copy2(ROOT / 'Makefile', self.root / 'Makefile')

    def test_generator_template_then_generate_project(self):
        for arguments in (['new', 'name=adapter', 'template=generator'],
                          ['generate', 'program=cvg_adapter']):
            if arguments[0] == 'generate':
                directory = self.root / 'programs/original/cvg_adapter'
                self.assertEqual({path.name for path in directory.iterdir()},
                                 {'generator.toml', 'routing.csv', 'description.rst'})
                self.assertNotIn('cvg_adapter', catalog(self.root))
                (directory / 'routing.csv').write_text(
                    'output,normal_state,safe_state\nd_00,fpga_00,0\nfpga_01,d_01,Z\nd_29,1,0\n')
            result = subprocess.run(['make', *arguments], cwd=self.root, capture_output=True,
                                    text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(catalog(self.root).count('cvg_adapter'), 1)
        build = load_build(self.root, 'cvg_adapter')
        self.assertEqual(build.top, 'cvg_adapter')
        self.assertEqual([source.library for source in build.sources], ['s3c', 's3c', 'work'])
        config = check(directory / 'generator.toml', directory)
        receipt = json.loads((directory / 'generator-output.json').read_text())
        self.assertEqual(set(receipt['files']), {'cvg_adapter.vhdl', 'cvg_adapter.toml',
                                               'cvg_adapter_tb.py', 'cvg_adapter_constraints.lpf'})
        self.assertEqual(config.target, 'uz_dslot_xo2')
        self.assertEqual(build.constraint.read_text(),
                         (ROOT / 'programs/original/cvg_tx30_stateful/cvg_tx30_stateful_constraints.lpf').read_text())
        workflow.generate_program(self.root, 'cvg_adapter')
        self.assertEqual(catalog(self.root).count('cvg_adapter'), 1)
        (directory / 'routing.csv').write_text('output,normal_state,safe_state\nfpga_00,d_00,1\n')
        workflow.generate_program(self.root, 'cvg_adapter')
        top = (directory / 'cvg_adapter.vhdl').read_text()
        self.assertIn('fpga_00 : out std_logic', top)
        self.assertIn('d_00 : in std_logic', top)
        self.assertIn("'fpga_00': ('d_00', '1')", build.testbench.read_text())
        check(directory / 'generator.toml', directory)

    def test_invalid_routing_does_not_register_or_publish_project(self):
        directory = workflow.scaffold(self.root, 'cvg_adapter', 'generator')
        (directory / 'routing.csv').write_text('output,normal_state,safe_state\nd_00,typo,0\n')
        with self.assertRaises(GeneratorError):
            workflow.generate_program(self.root, 'cvg_adapter')
        self.assertNotIn('cvg_adapter', catalog(self.root))
        self.assertFalse((directory / 'cvg_adapter.toml').exists())
        self.assertFalse((directory / 'cvg_adapter.vhdl').exists())
        with self.assertRaisesRegex(BuildError, 'already exists'):
            workflow.scaffold(self.root, 'cvg_adapter', 'generator')

    def test_generated_project_protects_testbench_manifest_and_constraints(self):
        directory = workflow.scaffold(self.root, 'cvg_adapter', 'generator')
        workflow.generate_program(self.root, 'cvg_adapter')
        for name in ('cvg_adapter_tb.py', 'cvg_adapter.toml', 'cvg_adapter_constraints.lpf'):
            with self.subTest(name=name):
                path = directory / name
                original = path.read_text()
                path.write_text(original + '\n# manual change\n')
                with self.assertRaisesRegex(GeneratorError, 'Stale'):
                    check(directory / 'generator.toml', directory)
                with self.assertRaisesRegex(GeneratorError, 'edited or unowned'):
                    workflow.generate_program(self.root, 'cvg_adapter')
                self.assertEqual(path.read_text(), original + '\n# manual change\n')
                path.write_text(original)

    def test_clone_of_generated_project_preserves_file_ownership(self):
        source = workflow.scaffold(self.root, 'cvg_adapter', 'generator')
        workflow.generate_program(self.root, 'cvg_adapter')
        clone = workflow.scaffold(self.root, 'cvg_adapter_clone', 'cvg_adapter')
        check(source / 'generator.toml', source)
        check(clone / 'generator.toml', clone)
        load_build(self.root, 'cvg_adapter_clone')
        for suffix in ('.vhdl', '.toml', '_tb.py', '_constraints.lpf'):
            self.assertFalse((clone / ('cvg_adapter' + suffix)).exists())
            self.assertTrue((clone / ('cvg_adapter_clone' + suffix)).is_file())
        (clone / 'routing.csv').write_text('output,normal_state,safe_state\nd_10,fpga_15,1\n')
        workflow.generate_program(self.root, 'cvg_adapter_clone')
        check(source / 'generator.toml', source)
        self.assertNotEqual((clone / 'routing.csv').read_bytes(), (source / 'routing.csv').read_bytes())

    def test_generator_template_rejects_unsupported_target_and_reserved_name(self):
        for name, target in (('cvg_adapter', 'uz_s3c_xo2'), ('std_logic', None), ('generator', None)):
            with self.subTest(name=name, target=target), self.assertRaises((BuildError, GeneratorError)):
                workflow.scaffold(self.root, name, 'generator', target=target)
            self.assertFalse((self.root / 'programs/original' / name).exists())

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
    def test_generated_testbench_simulates_changed_routes_and_controls(self):
        directory = workflow.scaffold(self.root, 'cvg_adapter', 'generator')
        (directory / 'routing.csv').write_text('''output,normal_state,safe_state
d_00,fpga_00,0
d_01,fpga_00,fpga_00
fpga_02,d_02,Z
d_03,1,0
d_04,0,1
d_05,fpga_29,1
''')
        config_path = directory / 'generator.toml'
        original = config_path.read_text()
        (directory / 'contract.toml').write_text('''id = "test_contract"
compatible_s3c = ["test_s3c"]
implementation = "level_signals"
request_mode = "active_low"
carrier_ready = "active_low"
slotok = [0, 1]
reqoe = [1, 0]
''')
        routing = (directory / 'routing.csv').read_text()
        variants = [(original, routing),
                    (original.replace('pilot_policy = "unused"', 'pilot_policy = "required"')
                    .replace('contract = "s3c_power_on_debounce_v1"', 'contract = "contract.toml"') +
                    'enable = {fpga_29 = 1, d_29 = 0}\n', routing),
                    (original, 'output,normal_state,safe_state\n'),
                    (original, 'output,normal_state,safe_state\n' +
                     ''.join(f'{bank}_{i:02d},1,0\n' for bank in ('fpga', 'd') for i in range(30)))]
        for index, (config, routing) in enumerate(variants):
            with self.subTest(variant=index):
                config_path.write_text(config)
                (directory / 'routing.csv').write_text(routing)
                workflow.generate_program(self.root, 'cvg_adapter')
                result = subprocess.run([sys.executable, '-m', 'pytest',
                                         'toolchain/simulation/test_simulation.py', '--program', 'cvg_adapter', '-q'],
                                        cwd=self.root, capture_output=True, text=True, timeout=30)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_clone_rejects_shared_generator_without_modifying_original(self):
        source = self.root / 'programs/original/cvg_tx30_stateful'
        shared = self.root / 'shared'
        shared.mkdir()
        config = shared / 'generator.toml'
        config.write_text((source / 'generator.toml').read_text().replace(
            '../../../cpld_vhdl_generator/hdl', '../cpld_vhdl_generator/hdl'))
        shutil.copy2(source / 'routing.csv', shared / 'routing.csv')
        manifest = source / 'cvg_tx30_stateful.toml'
        manifest.write_text(manifest.read_text().replace('generator = "generator.toml"',
                                                       'generator = "../../../shared/generator.toml"'))
        generate(config, source)
        build = load_build(self.root, 'cvg_tx30_stateful')
        paths = [*build.inputs, self.root / 'programs/original/catalog.toml']
        before = {path: path.read_bytes() for path in paths}
        with self.assertRaisesRegex(BuildError, 'program-local inputs'):
            workflow.scaffold(self.root, 'cvg_stateful_clone', 'cvg_tx30_stateful')
        self.assertEqual(before, {path: path.read_bytes() for path in paths})
        self.assertFalse((self.root / 'programs/original/cvg_stateful_clone').exists())
        load_build(self.root, 'cvg_tx30_stateful')

    def test_clone_normalizes_generator_path_that_mentions_template(self):
        source = self.root / 'programs/original/cvg_tx30_stateful'
        manifest = source / 'cvg_tx30_stateful.toml'
        manifest.write_text(manifest.read_text().replace('generator = "generator.toml"',
                                                       'generator = "../cvg_tx30_stateful/generator.toml"'))
        config = source / 'generator.toml'
        original = config.read_bytes()
        new = workflow.scaffold(self.root, 'cvg_stateful_clone', 'cvg_tx30_stateful')
        self.assertEqual(config.read_bytes(), original)
        self.assertTrue((new / 'cvg_stateful_clone.vhdl').is_file())
        load_build(self.root, 'cvg_tx30_stateful')
        load_build(self.root, 'cvg_stateful_clone')

    def test_clone_regenerates_names_and_checks_sources(self):
        root = self.root
        new = workflow.scaffold(root, 'cvg_stateful_clone', 'cvg_tx30_stateful')
        build = load_build(root, 'cvg_stateful_clone')
        self.assertEqual(build.top, 'cvg_stateful_clone')
        self.assertFalse((new / 'cvg_tx30_stateful.vhdl').exists())
        self.assertFalse((new / 'generated').exists())
        self.assertEqual([s.path for s in build.sources],
                         [root / 'cpld_vhdl_generator/hdl/s3c_logic.vhdl',
                          root / 'cpld_vhdl_generator/hdl/level_signals.vhdl', new / 'cvg_stateful_clone.vhdl'])
        self.assertFalse((new / 's3c_logic.vhdl').exists())
        self.assertEqual([s.library for s in build.sources], ['s3c', 's3c', 'work'])
        shared = build.sources[1].path
        original = shared.read_text()
        shared.write_text(original + '\n-- changed shared logic\n')
        with self.assertRaisesRegex(BuildError, 'inputs changed'):
            load_build(root, 'cvg_stateful_clone')
        shared.write_text(original)
        routing = new / 'routing.csv'
        self.assertEqual(routing.read_bytes(), (ROOT / 'programs/original/cvg_tx30_stateful/routing.csv').read_bytes())
        routing.write_text(routing.read_text().replace('d_00,fpga_00,0', 'd_00,fpga_00,1'))
        with self.assertRaisesRegex(BuildError, 'Stale'):
            load_build(root, 'cvg_stateful_clone')
