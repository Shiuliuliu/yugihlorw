import struct, sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f: data = f.read()
from test_parser import cols, parse_val

ptr = 294
for r in range(53):
    for cname, ctype in cols:
        val, ptr = parse_val(ctype, ptr)

for r in [53, 54]:
    print(f"=== ROW {r} (starts at {ptr}) ===")
    for cname, ctype in cols:
        p_before = ptr
        val, ptr = parse_val(ctype, ptr)
        print(f"  {cname:15s} ({ctype:3s}): {val} | hex: {data[p_before:ptr].hex()}")
