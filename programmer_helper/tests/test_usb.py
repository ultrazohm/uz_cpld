"""Check targeted detachment, restoration, and Diamond process cleanup."""
from contextlib import nullcontext
import json
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import Mock, patch

from programmer_helper import program, usb
from toolchain.buildsystem.model import BuildError


ROOT = Path(__file__).resolve().parents[2]


class USBTests(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.root = Path(directory.name)
        self.sysfs = self.root / 'devices'
        self.sysfs.mkdir()
        self.device('3-1')
        self.interface = usb.diamond_interface(self.sysfs)
        self.mock_usb = Mock()
        self.mock_usb.active.return_value = True
        for p in [patch.object(usb, 'diamond_interface', return_value=self.interface),
                  patch.object(usb, 'LibUSB', return_value=self.mock_usb),
                  patch.object(usb.tempfile, 'gettempdir', return_value=str(self.root))]:
            p.start()
            self.addCleanup(p.stop)

    def device(self, name, pid='6011'):
        device = self.sysfs / name
        device.mkdir()
        for key, value in dict(idVendor='0403', idProduct=pid, serial='testserial',
                               busnum='3', devnum='17').items():
            (device / key).write_text(value)
        driver = self.root / 'ftdi_sio'
        driver.mkdir(exist_ok=True)
        for number in range(4):
            interface = self.sysfs / f'{name}:1.{number}'
            interface.mkdir()
            (interface / 'bInterfaceNumber').write_text(f'{number:02x}')
            (interface / 'driver').symlink_to(driver, target_is_directory=True)

    def test_detaches_and_restores_only_selected_interface(self):
        self.assertEqual(self.interface.number, 1)
        with usb.diamond_usb(1):
            self.mock_usb.detach.assert_called_once_with()
            self.mock_usb.attach.assert_not_called()
        self.mock_usb.attach.assert_called_once_with()
        self.mock_usb.close.assert_called_once_with()

    def test_restores_after_failure_and_keyboard_interrupt(self):
        for error in [BuildError('scan failed'), KeyboardInterrupt()]:
            self.mock_usb.reset_mock()
            with self.subTest(error=type(error)), self.assertRaises(type(error)):
                with usb.diamond_usb(1):
                    raise error
            self.mock_usb.attach.assert_called_once_with()
            self.mock_usb.close.assert_called_once_with()

    def test_does_not_attach_a_driver_that_was_already_absent(self):
        (self.interface.path / 'driver').unlink()
        with usb.diamond_usb(1):
            pass
        usb.LibUSB.assert_not_called()

    def test_detach_failure_does_not_attempt_reattach(self):
        self.mock_usb.detach.side_effect = BuildError('access denied')
        with self.assertRaisesRegex(BuildError, 'access denied'):
            with usb.diamond_usb(1):
                self.fail('Diamond must not run after a failed detach')
        self.mock_usb.attach.assert_not_called()
        self.mock_usb.close.assert_called_once_with()

    def test_restore_failure_is_reported_and_handle_closed(self):
        self.mock_usb.attach.side_effect = BuildError('disconnected')
        with self.assertRaisesRegex(BuildError, 'Could not restore'):
            with usb.diamond_usb(1):
                pass
        self.mock_usb.close.assert_called_once_with()

    def test_second_operation_cannot_use_detached_interface(self):
        with usb.diamond_usb(1):
            with self.assertRaisesRegex(BuildError, 'Another programmer operation'):
                with usb.diamond_usb(1):
                    self.fail('Concurrent access must be rejected')

    def test_different_port_is_rejected_before_detachment(self):
        with self.assertRaisesRegex(BuildError, 'configured for FTUSB-1'):
            with usb.diamond_usb(0):
                self.fail('Mismatched port must be rejected')
        usb.LibUSB.assert_not_called()

    def test_diamond_wrapper_uses_actual_xcf_port_and_cleans_up(self):
        xcf = self.root / 'scan.xcf'
        program.diamond_scan_xcf(ROOT, 's3c', xcf)
        with patch.object(program, 'run_command', side_effect=BuildError('scan failed')):
            with self.assertRaisesRegex(BuildError, 'scan failed'):
                program.run_diamond(('fake-diamond',), self.root / 'scan.log', xcf)
        self.mock_usb.detach.assert_called_once_with()
        self.mock_usb.attach.assert_called_once_with()

    def test_interrupted_child_exits_before_driver_is_restored(self):
        xcf = self.root / 'scan.xcf'
        program.diamond_scan_xcf(ROOT, 's3c', xcf)
        child = Mock()
        def interrupted_output():
            raise KeyboardInterrupt()
            yield
        child.stdout = Mock()
        child.stdout.__iter__ = Mock(side_effect=interrupted_output)
        order = Mock()
        order.attach_mock(child, 'child')
        order.attach_mock(self.mock_usb, 'usb')
        with patch.object(program.subprocess, 'Popen', return_value=child):
            with self.assertRaises(KeyboardInterrupt):
                program.run_diamond(('fake-diamond',), self.root / 'scan.log', xcf)
        names = [call[0] for call in order.mock_calls]
        self.assertLess(names.index('child.terminate'), names.index('child.wait'))
        self.assertLess(names.index('child.wait'), names.index('usb.attach'))

    def test_programming_also_uses_detach_wrapper_without_real_flash_write(self):
        xcf = self.root / 'program.xcf'
        program.diamond_scan_xcf(ROOT, 'dslots', xcf)
        build = SimpleNamespace(directory=self.root / 'build', name='tx30', backend='diamond')
        step = program.Step('dslots', build, xcf, program.digest(xcf),
                            ('fake-diamond', str(xcf), '<run-log>'))
        with patch.object(program, 'locked', return_value=nullcontext()), \
                patch.object(program, 'verified_firmware'), \
                patch.object(program, 'run_command', return_value='success') as run:
            result = program.execute(self.root, 'original', 'dslots', 'diamond', self.root,
                                     [('slot1', 0, build)], [step], None, None)
        run.assert_called_once()
        self.mock_usb.detach.assert_called_once_with()
        self.mock_usb.attach.assert_called_once_with()
        self.assertEqual(json.loads((result / 'result.json').read_text())['status'], 'success')


class DiscoveryTests(unittest.TestCase):
    def test_multiple_matching_devices_are_ambiguous(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in ('3-1', '3-2'):
                device = root / name
                device.mkdir()
                (device / 'idVendor').write_text('0403')
                (device / 'idProduct').write_text('6011')
            with self.assertRaisesRegex(BuildError, 'one matching FT4232'):
                usb.diamond_interface(root)

    def test_absent_device_defers_to_diamond(self):
        with tempfile.TemporaryDirectory() as directory:
            self.assertIsNone(usb.diamond_interface(Path(directory)))


if __name__ == '__main__':
    unittest.main()
