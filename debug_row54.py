import struct, sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f:
    raw = f.read()

from test_parser import cols, parse_val

ptr = 294
for r in range(54):
    for cname, ctype in cols:
        val, ptr = parse_val(ctype, ptr)

print(f"Row 54 starts at ptr={ptr}:")
for cname, ctype in cols:
    p_before = ptr
    val, ptr = parse_val(ctype, ptr)
    print(f"  {cname:15s} ({ctype:3s}) @ {p_before:5d}: {val} (bytes: {raw[p_before:ptr].hex()})")
