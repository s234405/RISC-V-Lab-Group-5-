import serial
import time
import sys
import os

def send(name = "LED"):
    port = "COM3"
    baud = 9200
    filename = "binaryFiles/"+ name + ".bin"
    ser = serial.Serial(port, baudrate=baud, timeout=1)
    print(f"Opened {port} at {baud} baud")
    time.sleep(0.1)

    with open(filename, "rb") as f:
        data = f.read()

    #Pad to multiple of 4 bytes
    pad = (4 - (len(data) % 4)) % 4
    if pad:
        data += b"\x00" * pad

    data += b"\x01\x01\x01\x01"

    size = len(data)
    print(f"Sending {size} bytes...")


    sent = 0
    for b in data:
        ser.write(bytes([b]))
        sent += 1
        #print(f"{b:02x}")
        #time.sleep(0.0005)


    print(f"Done! Sent {sent} bytes.")
    ser.close()

if __name__ == "__main__":
    send(sys.argv[1])