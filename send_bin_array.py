
import serial
import time

# === Config ===
port = "COM3"
baud = 9200
timeout_s = 1
byteorder = "little"  # change to "big" if your target expects big-endian words
append_terminator = True  # set False if your array already includes the 0x01*4 trailer

# === Your data as 32-bit words ===
# Example words you provided:
data_words_jump = [
    0x000012b7,  # 0x000: lui  x5, 0x1
    0x00828293,  # 0x004: addi x5, x5, 8
    0x000013b7,  # 0x008: lui  x7, 0x1
    0x00c38393,  # 0x00c: addi x7, x7, 12
    0x014000ef,  # 0x010: jal  x1, wait_ready1
    0x00028303,  # 0x014: lb   x6, 0(x5)
    0x01c000ef,  # 0x018: jal  x1, wait_ready2
    0x00628023,  # 0x01c: sb   x6, 0(x5)

    0xfe1ff06f,  # 0x020: jal  x0, _start (hang loop)

    0x0003ce03,  # 0x024: lbu  x28, 0(x7)
    0x002e7e13,  # 0x028: andi x28, x28, 2
    0xfe0e0ce3,  # 0x02c: beq  x28, x0, -8
    0x00008067,  # 0x030: jalr x0, x1, 0

    0x0003ce03,  # 0x034: lbu  x28, 0(x7)
    0x001e7e13,  # 0x038: andi x28, x28, 1
    0xfe0e0ce3,  # 0x03c: beq  x28, x0, -8
    0x00008067   # 0x040: jalr x0, x1, 0
]

data_words_call = [ #with call
    0x000012b7,  # 0x000: lui  x5, 0x1
    0x00828293,  # 0x004: addi x5, x5, 8
    0x000013b7,  # 0x008: lui  x7, 0x1
    0x00c38393,  # 0x00c: addi x7, x7, 12
    0x00000097,  # 0x010: auipc x1, 0
    0x01c080e7,  # 0x014: jalr  x1, x1, 28
    0x00028303,  # 0x018: lb    x6, 0(x5)
    0x00000097,  # 0x01c: auipc x1, 0
    0x020080e7,  # 0x020: jalr  x1, x1, 32
    0x00628023,  # 0x024: sb    x6, 0(x5)

    0xfd9ff06f,  # 0x028: jal   x0, -40     (hang loop)

    0x0003ce03,  # 0x02c: lbu   x28, 0(x7)
    0x002e7e13,  # 0x030: andi  x28, x28, 2
    0xfe0e0ce3,  # 0x034: beq   x28, x0, -8
    0x00008067,  # 0x038: jalr  x0, x1, 0

    0x0003ce03,  # 0x03c: lbu   x28, 0(x7)
    0x001e7e13,  # 0x040: andi  x28, x28, 1
    0xfe0e0ce3,  # 0x044: beq   x28, x0, -8
    0x00008067   # 0x048: jalr  x0, x1, 0
]


data_words = [
    0x00001137,
    0x07c000ef,
    0x00000013,
    0x00000013,
    0xff010113,
    0x00812623,
    0x01010413,
    0x00000013,
    0x000017b7,
    0x00c78793,
    0x0007a783,
    0x0027f793,
    0xfe0788e3,
    0x00000013,
    0x00000013,
    0x00c12403,
    0x01010113,
    0x00008067,
    0xff010113,
    0x00812623,
    0x01010413,
    0x00000013,
    0x000017b7,
    0x00c78793,
    0x0007a783,
    0x0017f793,
    0xfe0788e3,
    0x00000013,
    0x00000013,
    0x00c12403,
    0x01010113,
    0x00008067,
    0xfe010113,
    0x00112e23,
    0x00812c23,
    0x02010413,

    0x00000097,
    0xf80080e7,
    0x000017b7,
    0x00878793,
    0x0007a783,
    0xfef42623,
    0x000017b7,
    0x00478793,
    0xfec42703,
    0x00e7a023,
    0x00000097,
    0xf90080e7,
    0x000017b7,
    0x00878793,
    0xfec42703,
    0x00e7a023,
    0x00000097,
    0xfc0080e7,
]



# === Convert words to bytes ===
payload = bytearray()
for w in data_words:
    if not (0 <= w <= 0xFFFFFFFF):
        raise ValueError(f"Word out of 32-bit range: {w:#x}")
    payload += w.to_bytes(4, byteorder=byteorder, signed=False)

# No need to pad: words are 4-byte aligned by construction
# Append 0x01 0x01 0x01 0x01 like the original script did (optional)
if append_terminator:
    payload += b"\x01\x01\x01\x01"

# === Send over serial ===
with serial.Serial(port, baudrate=baud, timeout=timeout_s) as ser:
    print(f"Opened {port} at {baud} baud")
    time.sleep(0.1)

    size = len(payload)
    print(f"Sending {size} bytes...")
    sent = 0

    # Byte-by-byte with small pacing, mirroring your original
    for b in payload:
        ser.write(bytes([b]))
        sent += 1
        time.sleep(0.005)

    print(f"Done! Sent {sent} bytes.")
