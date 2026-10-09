"""Standalone configuration, package selection and external process boundaries."""
from contextlib import redirect_stdout, redirect_stderr
import io
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain import external, settings, standalone
from cpld_toolchain.programmer_helper import diamond as programmer
from cpld_toolchain.programmer_helper.tests import test_release as release_fixtures
from cpld_toolchain.toolchain import diamond
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class StandaloneTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='standalone CLI ')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name).resolve()
        self.config = self.root / 'config'
        self.data = self.root / 'data'
        self.env = patch.dict(os.environ, UZ_CPLD_CONFIG_DIR=str(self.config), UZ_CPLD_DATA_DIR=str(self.data))
        self.env.start()
        self.addCleanup(self.env.stop)
        # Use the release format fixture already exercised by managed programming.
        self.fixture = release_fixtures.ReleaseTests()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)

    def run_cli(self, *args):
        with redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
            return standalone.main(list(args))

    def test_user_directories_use_explicit_bases_without_a_home(self):
        for platform, kind, variable in (
            ('win32', 'config', 'LOCALAPPDATA'), ('win32', 'data', 'LOCALAPPDATA'),
            ('linux', 'config', 'XDG_CONFIG_HOME'), ('linux', 'data', 'XDG_DATA_HOME'),
        ):
            with self.subTest(platform=platform, kind=kind), \
                    patch.object(sys, 'platform', platform), \
                    patch.dict(os.environ, {variable: str(self.root)}, clear=True), \
                    patch.object(Path, 'home', side_effect=RuntimeError('No home')):
                self.assertEqual(settings.user_directory(kind), self.root / 'uz_cpld')
                os.environ[variable] = ''
                with self.assertRaisesRegex(BuildError, f'UZ_CPLD_{kind.upper()}_DIR'):
                    settings.user_directory(kind)

    def test_user_directories_fall_back_to_home(self):
        for platform, kind, suffix in (
            ('win32', 'config', 'AppData/Local'), ('win32', 'data', 'AppData/Local'),
            ('linux', 'config', '.config'), ('linux', 'data', '.local/share'),
        ):
            with self.subTest(platform=platform, kind=kind), \
                    patch.object(sys, 'platform', platform), \
                    patch.dict(os.environ, {}, clear=True), \
                    patch.object(Path, 'home', return_value=self.root):
                self.assertEqual(settings.user_directory(kind), self.root / suffix / 'uz_cpld')

    def test_persistent_programmer_and_authoritative_override(self):
        binary = Path(sys.executable).resolve()
        self.assertEqual(self.run_cli(f'programmer_path={binary}'), 0)
        self.assertEqual(settings.read()['programmer_path'], str(binary))
        with patch.dict(os.environ, CPLD_PGRCMD=''):
            self.assertEqual(diamond.executable('programmer'), binary)
        with patch.dict(os.environ, CPLD_PGRCMD=str(self.root / 'missing')):
            with self.assertRaises(BuildError):
                diamond.executable('programmer')
        original = settings.config_path().read_bytes()
        self.assertEqual(self.run_cli(f'programmer_path={self.root / "missing"}'), 2)
        self.assertEqual(settings.config_path().read_bytes(), original)
        self.assertEqual(self.run_cli('programmer_path=auto'), 0)
        self.assertEqual(settings.read(), {})

    def test_repository_entry_point_accepts_the_same_setting(self):
        from cpld_toolchain.__main__ import main
        with redirect_stdout(io.StringIO()):
            self.assertEqual(main(['programmer_path=' + sys.executable]), 0)
        self.assertEqual(settings.read()['programmer_path'], str(Path(sys.executable).resolve()))

    def test_download_defaults_and_partial_overrides_never_consult_git(self):
        for flags, repository, branch in (
            ([], standalone.DEFAULT_REPOSITORY, 'master'),
            (['--branch', 'topic'], standalone.DEFAULT_REPOSITORY, 'topic'),
            (['--git-url', 'https://github.com/owner/repo'], 'https://github.com/owner/repo', 'master'),
        ):
            with patch.object(standalone.firmware_download, 'download', return_value=self.fixture.zip) as download:
                self.assertEqual(self.run_cli('firmware_download', *flags), 0)
            self.assertEqual(download.call_args.kwargs['git_url'], repository)
            self.assertEqual(download.call_args.kwargs['branch'], branch)
        self.assertFalse((self.data / 'workspace/firmware.json').exists())

    def test_selected_firmware_is_persistent_and_changed_files_are_rejected(self):
        self.assertEqual(self.run_cli('firmware_select', '--firmware', str(self.fixture.zip)), 0)
        root = self.data / 'workspace'
        selected = standalone.selected_firmware(root)
        self.assertTrue(selected.is_relative_to(root))
        self.assertEqual(selected.read_bytes(), self.fixture.zip.read_bytes())
        self.fixture.zip.unlink()
        self.assertEqual(self.run_cli('firmware_list'), 0)
        selected.write_bytes(b'corrupt')
        with patch('cpld_toolchain.toolchain.commands.run') as execute:
            self.assertEqual(self.run_cli('program', '--target', 's3c'), 2)
        execute.assert_not_called()

    def test_included_firmware_is_discoverable_but_not_selected_implicitly(self):
        with patch.object(standalone, 'included_firmware', return_value=self.fixture.zip):
            self.assertEqual(self.run_cli('firmware_list'), 0)
            with patch('cpld_toolchain.toolchain.commands.run') as execute:
                self.assertEqual(self.run_cli('program', '--target', 's3c'), 2)
            execute.assert_not_called()
            self.assertEqual(self.run_cli('firmware_select', '--included'), 0)
            self.assertEqual(self.run_cli('firmware_list'), 0)

    def test_program_dispatches_immediately_without_confirmation(self):
        with patch('cpld_toolchain.toolchain.commands.run', return_value=0) as execute, \
                patch('builtins.input', side_effect=AssertionError('No confirmation')):
            self.assertEqual(self.run_cli('program', '--target', 's3c', '--firmware', str(self.fixture.zip),
                                         '--release', 'published', '--s3c-program', 'controller'), 0)
        action, values = execute.call_args.args
        self.assertEqual(action, 'program')
        self.assertEqual(values['source'], 'zip')
        self.assertEqual(values['dry_run'], '0')
        self.assertEqual(values['release_cycle'], 'published')
        self.assertEqual(execute.call_args.kwargs['workspace'], self.data / 'workspace')

    def test_linux_wrapper_is_a_resource_not_a_workspace_file(self):
        with patch.object(sys, 'platform', 'linux'):
            command = programmer.command(self.root, 'file.xcf', 'log.txt')
        self.assertTrue(Path(command[1]).is_file())
        self.assertFalse(Path(command[1]).is_relative_to(self.root))

    def test_frozen_external_environment_drops_bundled_library_paths(self):
        bundle = self.root / 'bundle'
        with patch.object(sys, 'frozen', True, create=True), \
                patch.object(sys, '_MEIPASS', str(bundle), create=True), \
                patch.object(sys, 'platform', 'linux'), \
                patch.dict(os.environ, LD_LIBRARY_PATH=str(bundle), LD_LIBRARY_PATH_ORIG='/vendor/lib',
                           PATH=os.pathsep.join((str(bundle), str(bundle / 'bin'), '/usr/bin'))):
            env = external.environment()
            self.assertEqual(env['LD_LIBRARY_PATH'], '/vendor/lib')
            self.assertEqual(env['PATH'], '/usr/bin')
            self.assertEqual(os.environ['LD_LIBRARY_PATH'], str(bundle))

    def test_release_contains_same_tool_and_firmware_in_both_variants(self):
        from distribution.archive import assemble, pack, unpack
        tools = self.root / 'tools'
        for platform in ('windows-x64', 'ubuntu-24.04-x64'):
            application = self.root / platform
            application.mkdir()
            (application / 'application.json').write_text(json.dumps(dict(application_version='0.5.0',
                platform=platform, git_revision='a' * 40)))
            (application / 'uz_cpld').write_bytes(b'exact application bytes')
            (application / 'uz_cpld').chmod(0o755)
            pack(application, tools)
        output = self.root / 'release'
        assemble(tools, self.fixture.zip, output, 'a' * 40)
        self.assertEqual(len(list(output.iterdir())), 6)
        for source in tools.iterdir():
            self.assertEqual(source.read_bytes(), (output / source.name).read_bytes())
        for archive in output.glob('*-with-firmware.*'):
            destination = self.root / archive.name.split('.')[0]
            application = unpack(archive, destination)
            self.assertEqual((application / 'uz_cpld').read_bytes(), b'exact application bytes')
            self.assertEqual((application / 'firmware/uz-cpld-firmware.zip').read_bytes(), self.fixture.zip.read_bytes())
        with self.assertRaises(BuildError):
            assemble(tools, self.fixture.zip, self.root / 'wrong', 'b' * 40)


if __name__ == '__main__':
    unittest.main()
