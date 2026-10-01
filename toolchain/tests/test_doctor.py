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

from toolchain import commands, doctor
from toolchain.buildsystem.model import BuildError


class DoctorTests(unittest.TestCase):
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
                patch.dict(os.environ, {'FOSS_ROOT': tmp, 'DIAMOND_ROOT': tmp}, clear=True), \
                patch.object(doctor, 'package', side_effect=lambda name, module=None: doctor.Finding(name, 'MISSING', 'not installed')), \
                patch.object(doctor, 'locate', return_value=None), \
                patch.object(doctor, 'diamond_executable', side_effect=BuildError('no vendor tools')), \
                patch.object(doctor.subprocess, 'run') as run, redirect_stdout(io.StringIO()) as output:
            self.assertEqual(doctor.report(Path(tmp)), 0)
        text = output.getvalue()
        for name in ('Python:', 'Virtual environment:', 'Diamond build CLI', 'GHDL', 'OpenOCD', 'Docker client', 'Catalog'):
            self.assertIn(name, text)
        self.assertIn('MISSING', text)
        self.assertIn('INVALID', text)
        run.assert_not_called()

    def test_doctor_stays_local_regardless_of_backend_unless_container_is_explicit(self):
        for backend in ('diamond', 'foss'):
            with self.subTest(backend=backend):
                call, = commands.plan('doctor', {'backend': backend}, environ={})
                self.assertIn('toolchain.doctor', call.argv)
                self.assertNotIn('docker', call.argv)
                call, = commands.plan('doctor', {'backend': backend, 'runner': 'container'}, environ={})
                self.assertEqual(call.argv[:2], ('docker', 'run'))

    def test_clean_python_without_third_party_packages_can_run_doctor(self):
        with tempfile.TemporaryDirectory() as tmp:
            result = subprocess.run([sys.executable, '-S', '-m', 'toolchain.doctor', '--root', tmp],
                                    cwd=commands.ROOT, env={**os.environ, 'PATH': '', 'DIAMOND_ROOT': tmp,
                                                          'FOSS_ROOT': tmp, 'CPLD_OPENFPGALOADER': tmp + '/missing',
                                                          'CPLD_OPENOCD': tmp + '/missing'},
                                    text=True, capture_output=True, timeout=20)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('Environment report', result.stdout)
            self.assertIn('MISSING', result.stdout)
