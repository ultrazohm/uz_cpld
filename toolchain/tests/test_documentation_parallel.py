"""Check program discovery, concurrent asset scheduling and failure propagation."""
import os
from pathlib import Path
import tempfile
import time
import unittest
from unittest.mock import patch

from toolchain.analysis.documentation import generate
from toolchain.buildsystem.model import BuildError, discover_programs


def overlapping_worker(root, generated, name):
    name = name.split('/')[-1]
    (generated / f'{name}.started').write_text(str(os.getpid()))
    deadline = time.monotonic() + 15
    while len(list(generated.glob('*.started'))) != 2:
        if time.monotonic() > deadline:
            raise BuildError('Workers did not overlap')
        time.sleep(0.02)
    if name == 'alpha' and (root / 'fail').exists():
        raise BuildError('alpha: deliberate worker failure')
    (generated / 'programs' / f'program-original-{name}.rst').write_text(name)


class DocumentationSchedulingTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for name in ('zeta', 'alpha'):
            directory = self.root / 'programs/original' / name
            directory.mkdir(parents=True)
            (directory / f'{name}.toml').write_text('')
        (self.root / 'programs/releases.toml').write_text('current = "original"\n')
        (self.root / 'programs/original/catalog.toml').write_text('programs = []\n')
        starter = self.root / 'programs/original' / 'unfinished'
        starter.mkdir()
        (starter / 'generator.toml').write_text('')

    def test_discovery_includes_uncatalogued_and_skips_unfinished(self):
        self.assertEqual(discover_programs(self.root), ['alpha', 'zeta'])

    def test_workers_overlap_and_index_is_sorted(self):
        with patch('toolchain.analysis.documentation.generate_program', overlapping_worker):
            pages = generate(self.root, jobs=2)
        index = (pages / 'index.rst').read_text()
        self.assertLess(index.index('program-original-alpha'), index.index('program-original-zeta'))
        pids = {p.read_text() for p in pages.parent.glob('*.started')}
        self.assertEqual(len(pids), 2)
        self.assertNotIn(str(os.getpid()), pids)
        self.assertEqual(len(list(pages.glob('program-*.rst'))), 2)

    def test_failed_worker_does_not_publish_index(self):
        (self.root / 'fail').touch()
        with patch('toolchain.analysis.documentation.generate_program', overlapping_worker):
            with self.assertRaisesRegex(BuildError, 'deliberate worker failure'):
                generate(self.root, jobs=2)
        self.assertFalse((self.root / 'docs/_generated/programs/index.rst').exists())

    def test_invalid_worker_count_preserves_existing_assets(self):
        generated = self.root / 'docs/_generated'
        generated.mkdir(parents=True)
        sentinel = generated / 'sentinel'
        sentinel.touch()
        with self.assertRaisesRegex(BuildError, 'positive integer'):
            generate(self.root, jobs=0)
        self.assertTrue(sentinel.exists())

    def test_one_worker_runs_programs_in_order(self):
        with patch('toolchain.analysis.documentation.generate_program') as worker:
            generate(self.root, jobs=1)
        self.assertEqual([call.args[2] for call in worker.call_args_list], ['original/alpha', 'original/zeta'])

    def test_multiple_cycles_keep_duplicate_names_and_empty_cycles(self):
        cycle = self.root / 'programs/next'
        (cycle / 'alpha').mkdir(parents=True)
        (cycle / 'catalog.toml').write_text('programs = ["alpha"]\n')
        (cycle / 'alpha/alpha.toml').write_text('')
        (cycle / 'description.rst').write_text('Next cycle protocol and compatibility.\n')
        empty = self.root / 'programs/empty'
        empty.mkdir()
        (empty / 'catalog.toml').write_text('programs = []\n')
        (empty / 'description.rst').write_text('Planned cycle without firmware yet.\n')
        with patch('toolchain.analysis.documentation.generate_program') as worker:
            pages = generate(self.root, jobs=1)
        self.assertEqual([call.args[2] for call in worker.call_args_list],
                         ['next/alpha', 'original/alpha', 'original/zeta'])
        index = (pages / 'index.rst').read_text()
        self.assertIn('program-next-alpha', index)
        self.assertIn('program-original-alpha', index)
        self.assertIn('No complete program manifests', index)
        self.assertIn('.. include:: ../../../programs/empty/description.rst', index)
        self.assertIn('.. include:: ../../../programs/next/description.rst', index)
        self.assertLess(index.index('programs/next/description.rst'), index.index('program-next-alpha'))
        self.assertNotIn('programs/original/description.rst', index)
        with patch('toolchain.analysis.documentation.generate_program') as worker:
            pages = generate(self.root, jobs=1, release_cycle='next')
        self.assertEqual([call.args[2] for call in worker.call_args_list], ['next/alpha'])
        index = (pages / 'index.rst').read_text()
        self.assertNotIn('program-original-alpha', index)
        self.assertNotIn('programs/empty/description.rst', index)
        self.assertIn('programs/next/description.rst', index)

    def test_documentation_lock_prevents_cleanup_and_other_generators(self):
        from toolchain.buildsystem.workflow import clean_all, workspace_lock
        docs = self.root / 'docs'
        docs.mkdir()
        sentinel = docs / '_generated/sentinel'
        sentinel.parent.mkdir()
        sentinel.touch()
        with workspace_lock(docs, exclusive=True):
            with self.assertRaisesRegex(BuildError, 'already active'):
                generate(self.root, jobs=1)
        self.assertTrue(sentinel.is_file())

        def worker(root, generated, name):
            with self.assertRaisesRegex(BuildError, 'already active'):
                clean_all(root)
        with patch('toolchain.analysis.documentation.generate_program', worker):
            generate(self.root, jobs=1)
