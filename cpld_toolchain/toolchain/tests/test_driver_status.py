import io
import json
import subprocess
import sys
import unittest
from contextlib import redirect_stdout
from unittest.mock import patch

from cpld_toolchain import driver_status as drivers


def device(service='WinUSB', code=0, interface='01', serial='probe'):
    return dict(PNPDeviceID=rf'USB\VID_0403&PID_6011&MI_{interface}\{serial}',
                Service=service, ConfigManagerErrorCode=code)


class DriverStatusTests(unittest.TestCase):
    def inspect(self, devices):
        result = subprocess.CompletedProcess([], 0, json.dumps(devices), '')
        with patch.object(drivers.subprocess, 'run', return_value=result):
            return drivers.inspect_windows()

    def test_multiple_probes_and_interface_filter(self):
        rows = self.inspect([device(), device('FTDIBUS', serial='second'),
                             device(interface='00'), device(interface='02'), device(interface='03')])
        self.assertEqual([r[0] for r in rows], ['CONFIGURED', 'INCOMPATIBLE'])
        self.assertIn('second', rows[1][1])

    def test_device_error_overrides_driver_binding(self):
        for service in ('WinUSB', 'FTDIBUS', None):
            self.assertEqual(self.inspect([device(service, 28)])[0][0], 'DEVICE ERROR')
        self.assertEqual(self.inspect([device(code=None)])[0][0], 'UNKNOWN')
        self.assertEqual(self.inspect([device('libusbK')])[0][0], 'CHECK DRIVER')
        self.assertEqual(self.inspect([]), [])

    def test_failed_queries_never_report_absence(self):
        for failure in (OSError('missing PowerShell'), ValueError('invalid JSON'),
                        subprocess.TimeoutExpired('powershell', 15)):
            with self.subTest(failure=failure), patch.object(drivers.sys, 'platform', 'win32'), \
                    patch.object(drivers, 'inspect_windows', side_effect=failure), \
                    redirect_stdout(io.StringIO()) as output:
                drivers.report()
                self.assertIn('UNKNOWN', output.getvalue())
                self.assertNotIn('ABSENT:', output.getvalue())

    def test_invalid_response_is_rejected(self):
        for response in ({}, [None], [{}]):
            with self.assertRaises(ValueError):
                self.inspect(response)
        with patch.object(drivers.subprocess, 'run', return_value=subprocess.CompletedProcess([], 1, '', 'denied')):
            with self.assertRaisesRegex(ValueError, 'denied'):
                drivers.inspect_windows()

    def test_incompatible_driver_guidance_and_no_usb_claim(self):
        with patch.object(drivers.sys, 'platform', 'win32'), \
                patch.object(drivers, 'inspect_windows', return_value=[('INCOMPATIBLE', 'FTDIBUS')]), \
                redirect_stdout(io.StringIO()) as output:
            drivers.report()
        self.assertIn('Interface 1 only', output.getvalue())
        self.assertIn('were not tested', output.getvalue())

    def test_non_windows_does_not_query(self):
        with patch.object(drivers.sys, 'platform', 'linux'), patch.object(drivers, 'inspect_windows') as query:
            drivers.report()
        query.assert_not_called()

    @unittest.skipUnless(sys.platform == 'win32', 'Requires native Windows PnP')
    def test_native_windows_query_without_hardware(self):
        self.assertIsInstance(drivers.inspect_windows(), list)
