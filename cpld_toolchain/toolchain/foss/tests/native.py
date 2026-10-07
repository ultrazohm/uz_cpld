"""Smoke the actual parser/CLI with no USB access; called by flasher_build."""
from pathlib import Path
import subprocess
import sys
import tempfile

from fixtures import bitstream, jedec


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
        valid = jedec()
        jed.write_bytes(valid)
        invoke(['--check-file', '--usercode', '89ABCDEF', str(jed)], True)
        invoke(['--check-file', '--usercode', '00000000', str(jed)])
        for malformed in (b'', b'\x02', jedec(8), jedec(136), jedec(0), jedec(offset=128),
                          jedec(8, inline=True), jedec(136, inline=True),
                          valid.replace(b'QF128', b'QF'), valid.replace(b'UH89ABCDEF', b'UH'),
                          valid.replace(b'QF128*', b'QF128*\nE0*'), valid.replace(b'\x03', b'')):
            jed.write_bytes(malformed)
            invoke(['--check-file', str(jed)])
        jed.write_bytes(jedec(inline=True))
        invoke(['--check-file', str(jed)], True)
        bit = root / 'firmware.bit'
        prefix = b'\xff\x00Part: LCMXO2-2000HC\x00\xff\xff\xff\xbd\xb3'
        for malformed in (b'', b'x'*32, b'\xff\x00', prefix,
                          prefix+b'\xe2\x00\x00', prefix+b'\xb8\x00', prefix+b'\x82\x00\x00\x00'):
            bit.write_bytes(malformed)
            invoke(['--check-file', str(bit)])
        # Complete frame decoding, all compression prefix types and CRC modes.
        for idcode in (0x012B0043, 0x012B9043, 0x012BA043, 0x012BB043, 0x012BC043, 0x012BD043):
            for flags in (0xE0, 0x91):
                data, _ = bitstream(idcode, frame_flags=flags, ebr=True, done_crc=True)
                bit.write_bytes(data)
                invoke(['--check-file', '--expected-idcode', f'{idcode:08X}',
                        '--usercode', '89ABCDEF', str(bit)], True)
        data, positions = bitstream()
        bit.write_bytes(data)
        invoke(['--check-file', '--expected-idcode', '012BB043', str(bit)], True)
        invoke(['--check-file', '--expected-idcode', '012BC043', str(bit)], error='IDCODE')
        invoke(['--check-file', '--usercode', '00000000', str(bit)], error='USERCODE')
        # End-of-payload, USERCODE and DONE truncations must not be treated as padding.
        cuts = set(range(positions['frames'], positions['payload'] + 12))
        cuts.update(range(positions['payload_end'] - 5, positions['done_end']))
        cuts.update(range(positions['payload'], positions['payload_end'], 997))
        for cut in sorted(cuts):
            bit.write_bytes(data[:cut])
            invoke(['--check-file', str(bit)])
        # Fully received DONE with optional trailing dummy bytes is complete.
        bit.write_bytes(data[:positions['done_end']])
        invoke(['--check-file', str(bit)], True)
        for at in (positions['payload'] + 10, positions['payload_end'] - 1,
                   positions['usercode'] + 6, positions['frames'] + 3):
            corrupt = bytearray(data)
            corrupt[at] ^= 1
            bit.write_bytes(corrupt)
            invoke(['--check-file', str(bit)])
        for malformed in (data[:positions['dictionary']] + data[positions['frames']:],
                          data[:positions['done']] + data[positions['done_end']:],
                          data + b'\x00', bitstream(frame_flags=0x60)[0],
                          data[:positions['payload']] + b'\x00',
                          prefix+b'\xe2\x00\x00\x00\x01\x2b\xb0\x43\xb8\x00\x00\x00\x01'):
            bit.write_bytes(malformed)
            invoke(['--check-file', str(bit)])
        ebr_data, ebr_positions = bitstream(ebr=True)
        for cut in (ebr_positions['ebr_address'] + 6, ebr_positions['ebr_write'] + 4,
                    ebr_positions['ebr_write'] + 50, ebr_positions['control_end'] - 1):
            bit.write_bytes(ebr_data[:cut])
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
    for value in ('', '012BB04', '012BB0430', 'zzzzzzzz'):
        invoke(['--check-file', '--expected-idcode', value, 'firmware.bit'])
    invoke(['--expected-idcode', '012BB043', 'firmware.bit'])


if __name__ == '__main__':
    check(Path(sys.argv[1]))
