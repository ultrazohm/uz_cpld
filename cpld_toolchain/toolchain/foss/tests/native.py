"""Smoke the actual parser/CLI with no USB access; called by flasher_build."""
from pathlib import Path
import subprocess
import sys
import tempfile


def check(binary):
    def invoke(args, success=False, error=None):
        p = subprocess.run([str(binary), *args], capture_output=True, text=True, timeout=10)
        assert (p.returncode == 0) == success, (args, p.returncode, p.stdout, p.stderr)
        assert p.returncode in (0, 1), ('native crash', p.returncode, p.stderr)
        assert 'JTAG init' not in p.stdout + p.stderr, 'unexpected USB access'
        if error:
            assert error in p.stdout + p.stderr
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        jed = root / 'firmware.jed'
        valid = b'\x02*\nQF8*\nL0 00000000*\nUH89ABCDEF*\nC0000*\n\x030000\n'
        jed.write_bytes(valid)
        invoke(['--check-file', '--usercode', '89ABCDEF', str(jed)], True)
        invoke(['--check-file', '--usercode', '00000000', str(jed)])
        for malformed in (b'', b'\x02', valid.replace(b'00000000*', b'000*'),
                          valid.replace(b'QF8', b'QF'), valid.replace(b'UH89ABCDEF', b'UH'),
                          valid.replace(b'QF8*', b'QF8*\nE0*'), valid.replace(b'\x03', b'')):
            jed.write_bytes(malformed)
            invoke(['--check-file', str(jed)])
        bit = root / 'firmware.bit'
        prefix = b'\xff\x00Part: LCMXO2-2000HC\x00\xff\xff\xff\xbd\xb3'
        for malformed in (b'', b'x'*32, b'\xff\x00', prefix,
                          prefix+b'\xe2\x00\x00', prefix+b'\xb8\x00', prefix+b'\x82\x00\x00\x00'):
            bit.write_bytes(malformed)
            invoke(['--check-file', str(bit)])
        # Exact paths only: missing firmware.jed must not open fallback firmware.
        jed.unlink()
        jed.with_suffix('').write_bytes(valid)
        invoke(['--check-file', str(jed)])
    for extra in (['firmware.bit'], ['--write-flash'], ['--write-sram'], ['--reset'],
                  ['--bulk-erase'], ['--detect'], ['--spi'], ['--usercode', '00000000'],
                  ['--index-chain', '0'], ['--check-file']):
        invoke(['--read-identity', *extra], error='conflicts')
    invoke(['--Version'], True)


if __name__ == '__main__':
    check(Path(sys.argv[1]))
