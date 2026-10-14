"""Driver commands must select exactly one interface and never mutate on errors."""
from contextlib import nullcontext, redirect_stdout
import hashlib
import io
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain import driver_setup, standalone
from cpld_toolchain.toolchain import commands
from cpld_toolchain.toolchain.buildsystem.model import BuildError

ID = r'USB\VID_0403&PID_6011&MI_01\TEST'
OTHER = r'USB\VID_0403&PID_6011&MI_01\OTHER'


def device(service='FTDIBUS', identifier=ID):
    return dict(device_id=identifier, service=service, description='FT4232 B')


def result(code=0, stdout=''):
    return subprocess.CompletedProcess([], code, stdout, '')


class DriverSetupTests(unittest.TestCase):
    def test_selection_requires_unique_connected_instance(self):
        self.assertEqual(driver_setup.select([device()]), device())
        self.assertEqual(driver_setup.select([device(), device(identifier=OTHER)], ID.lower()), device())
        for rows, selected in (([], None), ([device()], OTHER), ([device(), device(identifier=OTHER)], None)):
            with self.assertRaises(BuildError):
                driver_setup.select(rows, selected)

    def test_commands_share_repository_and_standalone_contract(self):
        for action in driver_setup.ACTIONS:
            parsed = standalone.parser().parse_args([action, '--device-id', ID])
            self.assertEqual(parsed.device_id, ID)
            call, = commands.plan(action, {'device_id': ID})
            self.assertEqual(call.module, 'cpld_toolchain.driver_setup')
            self.assertEqual(call.arguments, (action, '--device-id', ID))
            with patch.object(driver_setup, 'setup', return_value=0) as setup, redirect_stdout(io.StringIO()):
                self.assertEqual(commands.run(action, {'device_id': ID}), 0)
                setup.assert_called_once_with(action, device_id=ID)

    def test_dry_run_does_not_discover_or_elevate(self):
        for action in driver_setup.ACTIONS:
            with patch.object(driver_setup, 'setup', side_effect=AssertionError('no mutation')), redirect_stdout(io.StringIO()):
                self.assertEqual(standalone.main([action, '--dry-run', '1']), 0)

    def test_non_windows_fails_before_tool_discovery(self):
        with patch.object(driver_setup.sys, 'platform', 'linux'), patch.object(driver_setup, 'helper_path') as helper:
            with self.assertRaisesRegex(BuildError, 'native Windows only'):
                driver_setup.setup('setup_foss_drivers')
        helper.assert_not_called()

    def run_setup(self, action, lists, installation=0):
        return self._setup_context(action, lists, installation)

    def _setup_context(self, action, lists, installation):
        with patch.object(driver_setup.sys, 'platform', 'win32'), \
                patch.object(driver_setup, 'helper_path', return_value=Path('helper.exe')), \
                patch('cpld_toolchain.programmer_helper.usb.diamond_usb', return_value=nullcontext()), \
                patch.object(driver_setup, 'devices', side_effect=lists), \
                patch.object(driver_setup, 'invoke', side_effect=[result(stdout=driver_setup.CAPABILITY + '; WinUSB'), result(installation)]) as invoke, \
                redirect_stdout(io.StringIO()):
            code = driver_setup.setup(action)
            return code, invoke.call_args_list

    def test_switch_and_verify_both_directions(self):
        for action, before, after, flag in [('setup_foss_drivers', 'FTDIBUS', 'WinUSB', '--foss'),
                                           ('setup_diamond_driver', 'WinUSB', 'FTDIBUS', '--diamond')]:
            code, calls = self.run_setup(action, [[device(before)], [device(after)]])
            self.assertEqual(code, 0)
            self.assertEqual(calls[1].args[1:], (flag, ID))
            self.assertFalse(calls[1].kwargs['capture'])

    def test_already_bound_never_elevates(self):
        code, calls = self.run_setup('setup_foss_drivers', [[device('WinUSB')]])
        self.assertEqual(code, 0)
        self.assertEqual(len(calls), 1)

    def test_install_failure_and_stale_binding_are_not_success(self):
        with self.assertRaisesRegex(BuildError, 'did not complete'):
            self.run_setup('setup_foss_drivers', [[device()]], installation=1)
        with self.assertRaisesRegex(BuildError, 'expected binding'):
            self.run_setup('setup_foss_drivers', [[device()], [device()]])
        code, calls = self.run_setup('setup_foss_drivers', [[device()]], installation=3010)
        self.assertEqual(code, 0)

    def test_receipt_rejects_modified_helper_and_wrong_pin(self):
        with tempfile.TemporaryDirectory() as temporary:
            binary = Path(temporary) / 'uz-cpld-driver-helper.exe'
            binary.write_bytes(b'helper')
            receipt = binary.with_name('driver-helper.json')
            record = dict(schema_version=1, linkage='static',
                          pin=json.loads(Path(driver_setup.__file__).with_name('windows_driver_pin.json').read_text()),
                          files={binary.name: hashlib.sha256(binary.read_bytes()).hexdigest()})
            receipt.write_text(json.dumps(record))
            self.assertEqual(driver_setup.verify(binary), record)
            binary.write_bytes(b'modified')
            with self.assertRaisesRegex(ValueError, 'checksum'):
                driver_setup.verify(binary)
            record['pin'] = {}
            receipt.write_text(json.dumps(record))
            with self.assertRaisesRegex(ValueError, 'provenance'):
                driver_setup.verify(binary)

    def test_interruption_waits_for_elevated_installation(self):
        with patch.object(driver_setup.subprocess, 'Popen') as popen, redirect_stdout(io.StringIO()):
            process = popen.return_value.__enter__.return_value
            process.wait.side_effect = [KeyboardInterrupt(), 0]
            self.assertEqual(driver_setup.invoke(Path('helper.exe'), '--foss', ID, capture=False).returncode, 0)
            self.assertEqual(process.wait.call_count, 2)
            process.kill.assert_not_called()

    def test_bad_enumeration_is_not_treated_as_no_device(self):
        with patch.object(driver_setup, 'invoke', return_value=result(1)):
            with self.assertRaisesRegex(BuildError, 'Cannot enumerate'):
                driver_setup.devices(Path('helper.exe'))
        for payload in ('{}', '[{}]', 'garbage'):
            with patch.object(driver_setup, 'invoke', return_value=result(stdout=payload)):
                with self.assertRaises(ValueError):
                    driver_setup.devices(Path('helper.exe'))
