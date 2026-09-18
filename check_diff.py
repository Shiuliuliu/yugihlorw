# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\orig_lan.txt", "rb") as f:
    orig_raw = f.read()

with open(r"D:\yugitauapk\extend_lan.txt", "rb") as f:
    ext_raw = f.read()

print("orig_raw size:", len(orig_raw), "CRLF count:", orig_raw.count(b"\r\n"), "LF count:", orig_raw.count(b"\n"))
print("ext_raw size:", len(ext_raw), "CRLF count:", ext_raw.count(b"\r\n"), "LF count:", ext_raw.count(b"\n"))

orig_lines = orig_raw.split(b"\n")
ext_lines = ext_raw.split(b"\n")

for i in range(15):
    print(f"L{i+1} ORIG: {orig_lines[i].decode('utf-8', 'ignore')}")
    print(f"L{i+1} EXT : {ext_lines[i].decode('utf-8', 'ignore')}")