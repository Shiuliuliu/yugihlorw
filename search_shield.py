# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = [line.rstrip("\r\n") for line in f]

for idx, l in enumerate(lines):
    if re.search(r"tường|chắn quái|chắn phép|miễn quái|miễn phép|kháng quái|kháng phép", l, re.I):
        print(f"L{idx+1}: {l[:100]}")