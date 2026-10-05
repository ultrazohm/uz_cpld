"""Temporarily release one Linux FTDI JTAG interface for Diamond."""
from contextlib import contextmanager, ExitStack
import ctypes as C
from ctypes.util import find_library
from dataclasses import dataclass
from cpld_toolchain.toolchain.locking import file_lock
import os
from pathlib import Path
import signal
import sys
import tempfile

from cpld_toolchain.toolchain.buildsystem.model import BuildError
from .helper import DEFAULT_DIAMOND_PORT


# UltraZohm wiring: Diamond FTUSB-1 uses FT4232 channel B (USB interface 1).
# Change these constants together with helper.DEFAULT_DIAMOND_PORT for other wiring.
FTDI_VENDOR_ID = '0403'
FTDI_PRODUCT_ID = '6011'
JTAG_INTERFACE = 1


@dataclass(frozen=True)
class Interface:
    path: Path
    bus: int
    address: int
    number: int
    serial: str

    @property
    def driver(self):
        driver = self.path / 'driver'
        return driver.resolve().name if driver.exists() else None


def diamond_interface(sysfs: Path = Path('/sys/bus/usb/devices'), serial=None):
    """Find the configured JTAG interface on one UltraZohm FT4232."""
    devices = [p for p in sysfs.iterdir() if (p / 'idVendor').is_file()
               and (p / 'idVendor').read_text().strip() == FTDI_VENDOR_ID
               and (p / 'idProduct').read_text().strip() == FTDI_PRODUCT_ID
               and (serial is None or ((p / 'serial').is_file() and (p / 'serial').read_text().strip() == serial))]
    if not devices:
        return None  # Let Diamond diagnose a missing or non-FTDI cable.
    if len(devices) != 1:
        raise BuildError('Automatic Diamond USB detachment requires one matching FT4232 device; '
                         'disconnect extra FT4232 devices before retrying. No driver was detached.')
    device = devices[0]
    matches = [p for p in sysfs.glob(device.name + ':*')
               if int((p / 'bInterfaceNumber').read_text().strip(), 16) == JTAG_INTERFACE]
    if len(matches) != 1:
        raise BuildError(f'Cannot find USB interface {JTAG_INTERFACE}; no driver was detached')
    serial = device / 'serial'
    return Interface(matches[0], int((device / 'busnum').read_text()),
                     int((device / 'devnum').read_text()), JTAG_INTERFACE,
                     serial.read_text().strip() if serial.exists() else '(no serial)')


class LibUSB:
    """Minimal libusb interface; use the existing USB node permissions."""
    def __init__(self, interface):
        name = find_library('usb-1.0')
        if not name:
            raise BuildError('Automatic FTDI detachment requires libusb-1.0')
        self.lib = C.CDLL(name)
        pointer = C.c_void_p
        signatures = {
            'init': ([C.POINTER(pointer)], C.c_int),
            'exit': ([pointer], None),
            'get_device_list': ([pointer, C.POINTER(C.POINTER(pointer))], C.c_ssize_t),
            'free_device_list': ([C.POINTER(pointer), C.c_int], None),
            'get_bus_number': ([pointer], C.c_uint8),
            'get_device_address': ([pointer], C.c_uint8),
            'open': ([pointer, C.POINTER(pointer)], C.c_int),
            'close': ([pointer], None),
            'kernel_driver_active': ([pointer, C.c_int], C.c_int),
            'detach_kernel_driver': ([pointer, C.c_int], C.c_int),
            'attach_kernel_driver': ([pointer, C.c_int], C.c_int),
            'error_name': ([C.c_int], C.c_char_p),
        }
        for operation, (args, result) in signatures.items():
            function = getattr(self.lib, 'libusb_' + operation)
            function.argtypes, function.restype = args, result
        self.context, self.handle = pointer(), pointer()
        self.number = interface.number
        self.check('init', C.byref(self.context))
        try:
            devices = C.POINTER(pointer)()
            count = self.check('get_device_list', self.context, C.byref(devices))
            try:
                for index in range(count):
                    device = devices[index]
                    if (self.lib.libusb_get_bus_number(device) == interface.bus
                            and self.lib.libusb_get_device_address(device) == interface.address):
                        self.check('open', device, C.byref(self.handle))
                        break
            finally:
                self.lib.libusb_free_device_list(devices, 1)
            if not self.handle:
                raise BuildError('Selected FTDI device disappeared before opening')
        except BaseException:
            self.close()
            raise

    def check(self, operation, *args):
        result = getattr(self.lib, 'libusb_' + operation)(*args)
        if result < 0:
            error = self.lib.libusb_error_name(result).decode()
            raise BuildError(f'libusb {operation}: {error}; check USB permissions and device connection')
        return result

    def active(self):
        return self.check('kernel_driver_active', self.handle, self.number) == 1

    def detach(self):
        self.check('detach_kernel_driver', self.handle, self.number)

    def attach(self):
        self.check('attach_kernel_driver', self.handle, self.number)

    def close(self):
        if self.handle:
            self.lib.libusb_close(self.handle)
            self.handle = C.c_void_p()
        self.lib.libusb_exit(self.context)


def _interrupt(signum, frame):
    raise KeyboardInterrupt(f'Received signal {signum}')


@contextmanager
def diamond_usb(port: int, *, serial=None):
    """Restore only the driver we detached, after the Diamond process has exited."""
    if not sys.platform.startswith('linux'):
        # Windows uses the vendor driver. Serialize access without Linux sysfs.
        lock_path = Path(tempfile.gettempdir()) / 'uz-cpld-diamond-usb.lock'
        with ExitStack() as stack:
            try:
                stack.enter_context(file_lock(lock_path))
            except BlockingIOError as exc:
                raise BuildError('Another programmer operation is using Diamond USB') from exc
            yield
        return
    interface = diamond_interface(serial=serial) if serial is not None else diamond_interface()
    if interface is None:
        yield
        return
    if port != DEFAULT_DIAMOND_PORT:
        raise BuildError(f'Automatic USB detachment is configured for FTUSB-{DEFAULT_DIAMOND_PORT}, '
                         f'interface {JTAG_INTERFACE}; update the port/interface constants for other wiring')
    lock_path = Path(tempfile.gettempdir()) / (
        f'uz-cpld-ftdi-{interface.bus}-{interface.address}-{interface.number}.lock')
    with ExitStack() as stack:
        try:
            stack.enter_context(file_lock(lock_path))
        except BlockingIOError as exc:
            raise BuildError('Another programmer operation is using this USB interface') from exc
        driver = interface.driver
        if driver not in (None, 'ftdi_sio'):
            raise BuildError(f'{interface.path.name} is owned by {driver}; refusing to detach it')
        old_term = signal.signal(signal.SIGTERM, _interrupt)
        usb, detached = None, False
        try:
            if driver == 'ftdi_sio':
                usb = LibUSB(interface)
                if usb.active():
                    usb.detach()
                    detached = True
                    print(f'Detached ftdi_sio: {interface.path.name} '
                          f'(serial {interface.serial}, channel {chr(65 + interface.number)})', flush=True)
            yield
        finally:
            try:
                if detached:
                    try:
                        usb.attach()
                    except BuildError as exc:
                        raise BuildError(f'Could not restore ftdi_sio on {interface.path.name}: {exc}. '
                                         'Reconnect the USB device to restore its driver.') from exc
                    print(f'Restored ftdi_sio: {interface.path.name}', flush=True)
            finally:
                if usb is not None:
                    usb.close()
                signal.signal(signal.SIGTERM, old_term)
