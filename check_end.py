# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\orig_lan.txt", "rb") as f:
    orig_lines = f.read().split(b"\n")

with open(r"D:\yugitauapk\extend_lan.txt", "rb") as f:
    ext_lines = f.read().split(b"\n")

print(f"orig lines: {len(orig_lines)}, ext lines: {len(ext_lines)}")
for i in range(len(orig_lines)-10, len(orig_lines)):
    print(f"ORIG L{i+1}: {orig_lines[i][:60].decode('utf-8', 'ignore')}")

for i in range(len(orig_lines)-5, len(orig_lines)+10):
    if i < len(ext_lines):
        print(f"EXT  L{i+1}: {ext_lines[i][:60].decode('utf-8', 'ignore')}")