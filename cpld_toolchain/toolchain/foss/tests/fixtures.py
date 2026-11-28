"""Small complete MachXO2 streams for native parser regression tests.

The wire format follows Project Trellis 3afe7b5 Bitstream.cpp. Fixtures include
all four compression prefixes and valid CRCs; no USB device is needed.
"""
import struct


def jedec(bits=128, *, offset=0, inline=False):
    row = b'0' * bits
    if inline:
        row = b' '.join(row[i:i+8] for i in range(0, bits, 8))
    return (b'\x02*\nQF' + str(bits).encode() + b'*\nL' + str(offset).encode()
            + (b' ' if inline else b'\n') + row
            + b'*\nUH89ABCDEF*\nC0000*\n\x030000\n')


def bitstream(idcode=0x012BB043, *, frame_flags=0xE0, ebr=False, done_crc=False):
    dimensions = ((186, 64), (215, 112), (333, 136), (420, 160), (623, 200), (770, 256))
    count, width = dimensions[(idcode >> 12) & 7]
    out = bytearray(b'\xff\x00Part: MachXO2 regression fixture\x00\xff\xff\xff\xbd\xb3\xff\xff')
    crc = 0
    offsets = {}

    def crc_byte(value):
        nonlocal crc
        for bit in range(7, -1, -1):
            crc = (crc << 1) | ((value >> bit) & 1)
            if crc & 0x10000:
                crc ^= 0x18005

    def write(data):
        out.extend(data)
        for value in data:
            crc_byte(value)

    def checksum():
        nonlocal crc
        crc_byte(0)
        crc_byte(0)
        out.extend(struct.pack('>H', crc))
        crc = 0

    def command(name, data):
        offsets[name] = len(out)
        write(data)

    command('reset', b'\x3b\x00\x00\x00')
    crc = 0
    command('id', b'\xe2\x00\x00\x00' + struct.pack('>I', idcode))
    command('control', b'\x22\x00\x00\x00\x40\x00\x00\x00')
    command('address', b'\x46\x00\x00\x00')
    command('dictionary', b'\x02\x00\x00\x00' + bytes(range(8)))
    command('frames', bytes([0xb8, frame_flags]) + struct.pack('>H', count))
    prefixes = ('0', '100101', '101001', '1101011010')
    bits = ''.join(prefixes[i % 4] for i in range(width))
    bits += '0' * (-len(bits) % 8)
    frame = bytes(int(bits[i:i+8], 2) for i in range(0, len(bits), 8))
    offsets['payload'] = len(out)
    for i in range(count):
        write(frame)
        if frame_flags & 0x80 and (not frame_flags & 0x40 or i + 1 == count):
            checksum()
        write(b'\xff' * (frame_flags & 15))
    offsets['payload_end'] = len(out)
    command('usercode', b'\xc2\x80\x00\x00\x89\xab\xcd\xef')
    checksum()
    if ebr:
        command('ebr_address', b'\xf6\x00\x00\x00\x00\x00\x00\x00')
        command('ebr_write', b'\xb2\xd0\x00\x80')
        write(bytes(128 * 9))
        checksum()
    command('control_end', b'\x22\x00\x00\x00\x40\x00\x00\x00')
    command('done', bytes([0x5e, 0x80 if done_crc else 0, 0, 0]))
    if done_crc:
        checksum()
    offsets['done_end'] = len(out)
    out.extend(b'\xff' * 4)
    return bytes(out), offsets
