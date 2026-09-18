# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = [line.rstrip("\r\n") for line in f]

terms = ["Lỗi kết nối", "mắt xanh", "Thanh Nhãn", "tam quốc", "tường chắn", "quái thú", "ma pháp", "cạm bẫy", "nghĩa địa", "rồng trắng"]
for t in terms:
    matches = [(idx+1, l) for idx, l in enumerate(lines) if t.lower() in l.lower()]
    print(f"=== Matches for '{t}': {len(matches)} ===")
    for m in matches[:5]:
        print(f"  L{m[0]}: {m[1][:120]}")