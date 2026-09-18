# -*- coding: utf-8 -*-
import sys, re
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = [line.rstrip("\r\n") for line in f]

print("Total lines:", len(lines))

# Search for hilarious find-and-replace bugs:
bugs = [
    r"eMa Phápil",
    r"Ma Phápy mắn",
    r"boong", # deck in French/bad translation of deck
    r"tường chắn",
    r"tam quốc",
    r"mắt xanh",
    r"Thanh Nhãn",
    r"quyết đấu",
    r"đấu tay đôi",
]

for b in bugs:
    matches = [(idx+1, l) for idx, l in enumerate(lines) if re.search(b, l, re.IGNORECASE)]
    print(f"=== Pattern '{b}': {len(matches)} matches ===")
    for m in matches[:5]:
        print(f"  L{m[0]}: {m[1][:100]}")