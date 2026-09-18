# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = [line.rstrip("\r\n") for line in f]

for i in range(10580, 10615):
    print(f"L{i+1}: {lines[i]}")