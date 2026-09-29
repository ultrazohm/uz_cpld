"""Identity allocation, ownership, revision reuse and collision regressions."""
from concurrent.futures import ProcessPoolExecutor
import json
from pathlib import Path
import shutil
import tempfile
import unittest

from toolchain.buildsystem import identity, workflow
from toolchain.buildsystem.model import BuildError, load_build, discover_programs, release_cycles

ROOT = Path(__file__).resolve().parents[2]


def allocate(arguments):
    root, index = arguments
    return identity.reserve_program(Path(root), f'new_{index}', 'original')


def allocate_revision(root):
    return identity.reserve_build(load_build(Path(root), 'tx30'))['usercode']


class IdentityTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        for directory in ('programs', 'toolchain', 'cpld_vhdl_generator', 'xo2_library'):
            shutil.copytree(ROOT / directory, self.root / directory,
                            ignore=shutil.ignore_patterns('build', '__pycache__'))
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')

    def test_all_current_programs_have_distinct_numbers(self):
        entries = identity.read_registry(self.root)['programs']
        names = {f'{cycle}/{name}' for cycle in release_cycles(self.root)
                 for name in discover_programs(self.root, cycle)}
        self.assertTrue(names <= entries.keys())
        self.assertEqual(len({entry['number'] for entry in entries.values()}), len(entries))

    def test_concurrent_allocations_are_unique_and_repeated_allocation_is_stable(self):
        with ProcessPoolExecutor(max_workers=4) as workers:
            numbers = list(workers.map(allocate, [(str(self.root), i) for i in range(12)]))
        self.assertEqual(len(set(numbers)), 12)
        for i, number in enumerate(numbers):
            self.assertEqual(identity.reserve_program(self.root, f'new_{i}', 'original'), number)

    def test_concurrent_same_build_reuses_one_revision(self):
        with ProcessPoolExecutor(max_workers=4) as workers:
            codes = list(workers.map(allocate_revision, [str(self.root)] * 8))
        self.assertEqual(len(set(codes)), 1)
        build = load_build(self.root, 'tx30')
        before = identity.reserve_build(build)
        identity.reserve_program(self.root, 'unrelated', 'original')
        self.assertEqual(before, identity.reserve_build(build))

    def test_clone_starter_generation_and_release_copy_get_distinct_numbers(self):
        from toolchain.buildsystem.releases import create
        workflow.scaffold(self.root, 'manual_clone', 'tx30')
        starter = workflow.scaffold(self.root, 'generated_clone', 'generator')
        before = identity.read_registry(self.root)['programs'][f'original/{starter.name}']['number']
        workflow.generate_program(self.root, starter.name)
        self.assertEqual(identity.read_registry(self.root)['programs'][f'original/{starter.name}']['number'], before)
        create(self.root, 'next', 'original')
        entries = identity.read_registry(self.root)['programs']
        self.assertNotEqual(entries['original/tx30']['number'], entries['original/manual_clone']['number'])
        self.assertNotEqual(entries['original/tx30']['number'], entries['next/tx30']['number'])
        self.assertNotEqual(before, entries[f'next/{starter.name}']['number'])

    def test_revisions_reuse_inputs_and_separate_source_and_backend_changes(self):
        build = load_build(self.root, 'tx30')
        first = identity.reserve_build(build)
        self.assertEqual(first, identity.reserve_build(build))
        source = build.sources[0].path
        original = source.read_bytes()
        source.write_bytes(original + b'\n-- changed implementation\n')
        second = identity.reserve_build(build)
        self.assertEqual(first['program_number'], second['program_number'])
        self.assertNotEqual(first['usercode'], second['usercode'])
        with self.assertRaisesRegex(BuildError, 'does not match'):
            identity.validate_identity(build, first)
        source.write_bytes(original)
        self.assertEqual(first, identity.reserve_build(build))
        third = identity.reserve_build(load_build(self.root, 'tx30', backend='foss'))
        self.assertNotIn(third['usercode'], (first['usercode'], second['usercode']))
        resolved = identity.resolve_usercode(self.root, int(first['usercode'], 16))
        self.assertEqual(resolved['program'], 'original/tx30')
        self.assertTrue(resolved['known_build'])
        self.assertIsNone(identity.resolve_usercode(self.root, 0))

    def test_shared_library_change_changes_generated_build_revision(self):
        build = load_build(self.root, 'cvg_tx30_stateful')
        first = identity.reserve_build(build)
        shared = build.sources[1].path
        shared.write_text(shared.read_text() + '\n-- shared library change\n')
        workflow.generate_program(self.root, build.name)
        second = identity.reserve_build(load_build(self.root, build.name))
        self.assertNotEqual(first['usercode'], second['usercode'])

    def test_constraint_injection_replaces_historical_usercode(self):
        build = load_build(self.root, 's3c_rev6_beta')
        code = identity.reserve_build(build)
        text = identity.constraint_text(build, code)
        self.assertEqual(text.count('USERCODE HEX'), 1)
        self.assertIn(f'USERCODE HEX "{code["usercode"]}";', text)
        self.assertNotIn('BADC0DED', text)
        self.assertIn('TRACEID', text)

    def test_duplicate_numbers_bad_counters_and_missing_registry_fail_closed(self):
        path = self.root / identity.REGISTRY
        original = path.read_text()
        data = json.loads(original)
        entries = list(data['programs'].values())
        entries[1]['number'] = entries[0]['number']
        path.write_text(json.dumps(data))
        with self.assertRaisesRegex(BuildError, 'duplicate'):
            identity.reserve_program(self.root, 'another', 'original')
        data = json.loads(original)
        data['next_program'] = 1
        path.write_text(json.dumps(data))
        with self.assertRaisesRegex(BuildError, 'counter'):
            identity.read_registry(self.root)
        path.unlink()
        with self.assertRaisesRegex(BuildError, 'Restore/merge'):
            identity.reserve_program(self.root, 'another', 'original')
        self.assertFalse(path.exists())

    def test_number_and_revision_exhaustion_do_not_wrap(self):
        path = self.root / identity.REGISTRY
        data = identity.read_registry(self.root)
        data['next_program'] = 65536
        path.write_text(json.dumps(data))
        with self.assertRaisesRegex(BuildError, 'space exhausted'):
            identity.reserve_program(self.root, 'overflow', 'original')
        data['programs']['original/tx30']['next_revision'] = 65536
        path.write_text(json.dumps(data))
        build = load_build(self.root, 'tx30')
        source = build.sources[0].path
        source.write_bytes(source.read_bytes() + b'\n-- new revision beyond the limit\n')
        with self.assertRaisesRegex(BuildError, 'space exhausted'):
            identity.reserve_build(build)

    def test_registry_symlinks_are_rejected(self):
        path = self.root / identity.REGISTRY
        saved = path.with_suffix('.saved')
        path.rename(saved)
        path.symlink_to(saved)
        with self.assertRaisesRegex(BuildError, 'symlink'):
            identity.reserve_program(self.root, 'another', 'original')
