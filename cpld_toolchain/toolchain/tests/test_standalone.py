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

    def test_identify_without_target_or_firmware_does_not_prompt_for_a_zip(self):
        with patch('cpld_toolchain.toolchain.commands.run', return_value=0) as run, \
                patch.object(standalone, 'included_firmware', return_value=self.root / 'missing.zip'):
            self.assertEqual(self.run_cli('identify'), 0)
        self.assertNotIn('target', run.call_args.args[1])
        self.assertNotIn('firmware', run.call_args.args[1])

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
        self.assertEqual(values['programmer_backend'], 'foss')
        self.assertEqual(execute.call_args.kwargs['workspace'], self.data / 'workspace')

    def test_backend_and_serial_options_reach_the_shared_programmer(self):
        with patch('cpld_toolchain.toolchain.commands.run', return_value=0) as execute:
            self.assertEqual(self.run_cli('scan', '--usb-serial', 'UZ123', '--probe-index', '0'), 0)
            self.assertEqual(execute.call_args.args[1]['programmer_backend'], 'foss')
            self.assertEqual(execute.call_args.args[1]['usb_serial'], 'UZ123')
            self.assertEqual(self.run_cli('scan', '--programmer-backend', 'diamond', '--probe-index', '1'), 0)
            self.assertEqual(execute.call_args.args[1]['programmer_backend'], 'diamond')

    def test_foss_bitstream_package_can_be_selected_and_inspected(self):
        self.fixture.manifest, self.fixture.payloads = self.fixture.package('foss')
        self.fixture.write_zip()
        self.assertEqual(self.run_cli('firmware_select', '--firmware', str(self.fixture.zip)), 0)
        self.assertEqual(self.run_cli('firmware_list'), 0)

    def test_doctor_verifies_foss_without_diamond_or_usb(self):
        from cpld_toolchain.toolchain.foss import flasher
        from cpld_toolchain import tools
        binary = self.root / 'openFPGALoader'
        binary.write_bytes(b'loader bytes')
        record = dict(pin=flasher.pin(), binary_sha256=flasher.digest(binary),
                      runtime_sha256={'runtime.so': flasher.digest(binary)})
        (self.root / 'runtime.so').write_bytes(binary.read_bytes())
        (self.root / flasher.RECEIPT).write_text(json.dumps(record))
        with patch('cpld_toolchain.driver_status.report') as driver_report, \
                patch.object(tools, 'loader_path', return_value=binary), \
                patch.object(flasher, 'version', return_value=record['pin']['capability']) as version, \
                patch.object(diamond, 'executable', side_effect=AssertionError('No Diamond')):
            self.assertEqual(self.run_cli('doctor'), 0)
            (self.root / 'runtime.so').write_bytes(b'changed')
            self.assertEqual(self.run_cli('doctor'), 1)
            self.assertEqual(version.call_count, 1)
            self.assertEqual(driver_report.call_count, 2)

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
            from cpld_toolchain.toolchain.foss import flasher
            application = self.root / platform
            application.mkdir()
            loader = application / '_internal/cpld_toolchain/bundled_tools/openFPGALoader'
            loader.mkdir(parents=True)
            binary = loader / ('openFPGALoader.exe' if platform == 'windows-x64' else 'openFPGALoader')
            binary.write_bytes(b'exact loader bytes')
            provenance = dict(pin=flasher.pin(), binary_sha256=flasher.digest(binary),
                              git_revision='a' * 40, runtime_sha256={}, linkage='static')
            (loader / flasher.RECEIPT).write_text(json.dumps(provenance))
            driver_provenance = None
            if platform == 'windows-x64':
                from cpld_toolchain import driver_setup
                helper = loader.parent / 'windows-drivers/uz-cpld-driver-helper.exe'
                helper.parent.mkdir()
                helper.write_bytes(b'exact helper bytes')
                driver_provenance = dict(schema_version=1, linkage='static', git_revision='a' * 40,
                    pin=json.loads(Path(driver_setup.__file__).with_name('windows_driver_pin.json').read_text()),
                    files={helper.name: flasher.digest(helper)})
                helper.with_name('driver-helper.json').write_text(json.dumps(driver_provenance))
            (application / 'application.json').write_text(json.dumps(dict(application_version='0.5.0',
                platform=platform, git_revision='a' * 40, openfpgaloader=provenance, windows_drivers=driver_provenance,
                default_programmer_backend='foss')))
            (application / 'uz_cpld').write_bytes(b'exact application bytes')
            (application / 'uz_cpld').chmod(0o755)
            from distribution.licensing import digest, native_file
            (application / 'licenses').mkdir()
            (application / 'LICENSE').write_text('fixture license')
            inventory = dict(schema_version=1, components={'fixture': dict(notices=['LICENSE'], sources=[])},
                             materials={'LICENSE': digest(application / 'LICENSE')},
                             files={p.relative_to(application).as_posix(): dict(components=['fixture'], sha256=digest(p))
                                    for p in application.rglob('*') if p.is_file() and native_file(p)})
            (application / 'licenses/inventory.json').write_text(json.dumps(inventory))
            pack(application, tools)
        source_application = application
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
        windows = self.root / 'windows-x64'
        receipt = windows / '_internal/cpld_toolchain/bundled_tools/openFPGALoader/usercode-support.json'
        info_path = windows / 'application.json'
        info = json.loads(info_path.read_text())
        provenance = json.loads(receipt.read_text())
        provenance['linkage'] = 'shared'
        info['openfpgaloader'] = provenance
        receipt.write_text(json.dumps(provenance))
        info_path.write_text(json.dumps(info))
        pack(windows, tools)
        with self.assertRaisesRegex(BuildError, 'statically linked'):
            assemble(tools, self.fixture.zip, self.root / 'dynamic-windows', 'a' * 40)
        provenance['linkage'] = 'static'
        receipt.write_text(json.dumps(provenance))
        info_path.write_text(json.dumps(info))
        pack(windows, tools)
        # The application metadata alone must not allow a replaced loader to be released.
        binary.write_bytes(b'changed loader')
        with self.assertRaisesRegex(RuntimeError, 'Missing or changed distribution material'):
            pack(source_application, tools)


if __name__ == '__main__':
    unittest.main()
