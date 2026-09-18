# -*- coding: utf-8 -*-
import sys, os, glob
sys.stdout.reconfigure(encoding='utf-8')

target = "Lỗi kết nối".encode("utf-8")
target2 = "kiểm tra cập nhật".encode("utf-8")

for root, dirs, files in os.walk(r"D:\yugitauapk\extracted\1.0.7"):
    for f in files:
        p = os.path.join(root, f)
        try:
            with open(p, "rb") as fp:
                c = fp.read()
                if target in c:
                    print(f"Found 'Lỗi kết nối' in: {p}")
                if target2 in c:
                    print(f"Found 'kiểm tra cập nhật' in: {p}")
        except Exception:
            pass