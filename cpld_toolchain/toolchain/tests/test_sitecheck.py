"""Publishing checks exercise actual local files and project-relative links."""
from pathlib import Path
import tempfile
import unittest

from cpld_toolchain.toolchain.analysis.sitecheck import check, clean


class SiteCheckTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        (self.root / '.nojekyll').touch()
        (self.root / 'index.html').write_text('<a href="program/index.html">Program</a>')
        (self.root / 'program').mkdir()
        (self.root / 'program/index.html').write_text('<iframe src="../wave.html"></iframe>')
        (self.root / 'wave.html').write_text('<html></html>')

    def test_project_relative_site(self):
        self.assertEqual(check(self.root), 3)

    def test_missing_waveform(self):
        (self.root / 'wave.html').unlink()
        with self.assertRaisesRegex(ValueError, 'missing asset'):
            check(self.root)

    def test_root_absolute_asset(self):
        (self.root / 'index.html').write_text('<img src="/wave.html">')
        with self.assertRaisesRegex(ValueError, 'escapes project site'):
            check(self.root)

    def test_missing_pages_marker(self):
        (self.root / '.nojekyll').unlink()
        with self.assertRaisesRegex(ValueError, 'Missing .nojekyll'):
            check(self.root)

    def test_clean_refuses_symlink(self):
        link = self.root / 'output'
        link.symlink_to(self.root / 'program', target_is_directory=True)
        with self.assertRaisesRegex(ValueError, 'symlinked output'):
            clean(link)
        self.assertTrue((self.root / 'program/index.html').exists())

    def test_clean_removes_stale_pages(self):
        clean(self.root / 'program')
        self.assertFalse((self.root / 'program').exists())
