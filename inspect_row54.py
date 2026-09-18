import struct, sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extend_lan.txt', 'r', encoding='utf-8', errors='ignore') as f:
    lan = [l.rstrip('\r\n') for l in f]

def get_text(sid):
    if sid == 0: return ''
    idx = sid - 1
    if 0 <= idx < len(lan): return lan[idx]
    return f'<SID {sid}>'

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f:
    raw = f.read()

from test_parser import cols, parse_val

ptr = 294
for r in range(55):
    p_start = ptr
    row = {}
    for cname, ctype in cols:
        val, ptr = parse_val(ctype, ptr)
        row[cname] = val
    if r == 54:
        print(f"Row 54 (ends at {ptr}):")
        for k, v in row.items():
            print(f"  {k}: {v}")

print(f"Bytes after Row 54 (ptr={ptr}):")
print(raw[ptr:ptr+80].hex())
print("As values if next card is 10056 (0x2748 -> 48 27):")
print(raw[ptr:ptr+10])
