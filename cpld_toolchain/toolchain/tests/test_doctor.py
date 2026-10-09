"""Environment diagnostics remain useful with missing tools and broken installs."""
from contextlib import redirect_stdout
from importlib import metadata
import io
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain.toolchain import commands, doctor
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class DoctorTests(unittest.TestCase):
    def test_vendor_version_metadata_is_read_without_startup(self):
        from cpld_toolchain.toolchain.diamond import installed_version
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            binary = root / 'bin/nt64/pnmainc.exe'
            (root / 'data').mkdir()
            config = root / 'data/ispsys.ini'
            config.write_text('[version]\nMajorVersion=3\nMinorVersion=13.0\nBuildNumber=56.2\n')
            self.assertEqual(installed_version(binary), '3.13.0.56.2')
            config.write_text('invalid')
            self.assertIsNone(installed_version(binary))

    def test_build_preflight_rejects_wrong_version_before_startup(self):
        from types import SimpleNamespace
        from cpld_toolchain.toolchain.buildsystem.backends import diamond
        with patch.object(diamond, 'launcher', return_value=Path('/vendor/pnmainc.exe')), \
                patch.object(diamond, 'installed_version', return_value='3.13.0.56.2'), \
                patch.object(diamond.subprocess, 'run') as run:
            with self.assertRaisesRegex(BuildError, 'installed 3.13.0.56.2'):
                diamond.preflight([SimpleNamespace(backend='diamond', expected_version='3.14.0.75.2')])
        run.assert_not_called()

    def test_build_preflight_checks_startup_once_and_reports_license_failure(self):
        from types import SimpleNamespace
        from cpld_toolchain.toolchain.buildsystem.backends import diamond
        builds = [SimpleNamespace(backend='diamond', expected_version='3.14.0.75.2')] * 29
        with patch.object(diamond, 'launcher', return_value=Path('/vendor/pnmainc.exe')), \
                patch.object(diamond, 'installed_version', return_value='3.14.0.75.2'), \
                patch.object(diamond.subprocess, 'run', return_value=subprocess.CompletedProcess([], 0, '', '')) as run:
            diamond.preflight(builds)
            run.assert_called_once()
            self.assertEqual(run.call_args.kwargs['timeout'], 30)
            run.return_value = subprocess.CompletedProcess([], 255, '', 'License checkout failed')
            with self.assertRaisesRegex(BuildError, 'License checkout failed'):
                diamond.preflight(builds)
            run.side_effect = subprocess.TimeoutExpired('diamond', 30)
            with self.assertRaisesRegex(BuildError, 'timed out'):
                diamond.preflight(builds)

    def test_foss_preflight_does_not_require_diamond(self):
        from types import SimpleNamespace
        from cpld_toolchain.toolchain.buildsystem.backends import diamond
        with patch.object(diamond, 'launcher') as launcher:
            diamond.preflight([SimpleNamespace(backend='foss')])
        launcher.assert_not_called()

    def test_missing_tool_is_a_finding_without_starting_a_process(self):
        with patch.object(doctor, 'locate', return_value=None), patch.object(doctor.subprocess, 'run') as run:
            result = doctor.probe('missing', 'nonexistent-tool', ['--version'])
        self.assertEqual(result.state, 'MISSING')
        run.assert_not_called()

    def test_versions_include_path_and_only_first_output_line(self):
        with patch.object(doctor, 'locate', return_value='found-tool'), \
                patch.object(doctor.subprocess, 'run', return_value=subprocess.CompletedProcess(
                    [], 0, 'tool version 1\nextra output\n', '')) as run:
            result = doctor.probe('tool', 'tool', ['--version'])
        self.assertEqual(result.state, 'OK')
        self.assertEqual(result.detail, 'found-tool; tool version 1')
        self.assertEqual(run.call_args.kwargs['timeout'], 5)
        self.assertEqual(run.call_args.args[0], ['found-tool', '--version'])

    def test_failure_and_timeout_do_not_abort_inventory(self):
        with patch.object(doctor, 'locate', return_value='broken-tool'):
            for error, expected in [(OSError('cannot load library'), 'FAILED'),
                                    (subprocess.TimeoutExpired('tool', 5), 'TIMEOUT')]:
                with self.subTest(error=error), patch.object(doctor.subprocess, 'run', side_effect=error):
                    self.assertEqual(doctor.probe('tool', 'tool', ['--version']).state, expected)
            with patch.object(doctor.subprocess, 'run', return_value=subprocess.CompletedProcess([], 3, '', 'broken')):
                self.assertEqual(doctor.probe('tool', 'tool', ['--version']).state, 'FAILED')

    def test_gui_and_vendor_inventory_does_not_launch_tools(self):
        with patch.object(doctor, 'locate', return_value='gui-tool'), patch.object(doctor.subprocess, 'run') as run:
            self.assertEqual(doctor.probe('GUI', 'gui-tool').state, 'FOUND')
        run.assert_not_called()

    def test_missing_packages_are_reported_for_the_current_interpreter(self):
        with patch.object(doctor.metadata, 'version', side_effect=metadata.PackageNotFoundError):
            self.assertEqual(doctor.package('absent').state, 'MISSING')

    def test_report_survives_missing_tools_packages_and_bad_catalog(self):
        with tempfile.TemporaryDirectory() as tmp, \
                patch.object(doctor.platform, 'system', return_value='Windows'), \
                patch.object(doctor.platform, 'machine', return_value='AMD64'), \
                patch.dict(os.environ, {'FOSS_ROOT': tmp, 'DIAMOND_ROOT': tmp}, clear=True), \
                patch.object(Path, 'home', side_effect=RuntimeError('Could not determine home directory.')), \
                patch.object(doctor, 'package', side_effect=lambda name, module=None: doctor.Finding(name, 'MISSING', 'not installed')), \
                patch.object(doctor, 'locate', return_value=None), \
                patch.object(doctor, 'diamond_executable', side_effect=BuildError('no vendor tools')), \
                patch.object(doctor.subprocess, 'run') as run, redirect_stdout(io.StringIO()) as output:
            self.assertEqual(doctor.report(Path(tmp)), 0)
        text = output.getvalue()
        for name in ('Python:', 'Virtual environment:', 'Diamond build CLI', 'GHDL', 'openFPGALoader', 'Docker client', 'Catalog'):
            self.assertIn(name, text)
        self.assertIn('MISSING', text)
        self.assertIn('INVALID', text)
        run.assert_not_called()

    def test_doctor_stays_local_regardless_of_backend(self):
        for backend in ('diamond', 'foss'):
            with self.subTest(backend=backend):
                call, = commands.plan('doctor', {'backend': backend})
                self.assertIn('cpld_toolchain.toolchain.doctor', call.argv)
                self.assertNotIn('docker', call.argv)

    def test_clean_python_without_third_party_packages_can_run_doctor(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = subprocess.run([sys.executable, '-S', '-m', 'cpld_toolchain.toolchain.doctor', '--root', tmp],
                                    cwd=commands.ROOT, env={**os.environ, 'PATH': '', 'DIAMOND_ROOT': tmp,
                                                          'FOSS_ROOT': tmp, 'CPLD_OPENFPGALOADER': tmp + '/missing'},
                                    text=True, capture_output=True, timeout=20)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('Environment report', result.stdout)
            self.assertIn('MISSING', result.stdout)
