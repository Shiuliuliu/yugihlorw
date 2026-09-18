import struct, sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extend_lan.txt', 'r', encoding='utf-8', errors='ignore') as f:
    lan = [l.rstrip('\r\n') for l in f]

def get_text(sid):
    if sid == 0: return ''
    idx = sid - 1
    if 0 <= idx < len(lan):
        return lan[idx]
    return f'<SID {sid}>'

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f:
    raw = f.read()

num_cols = struct.unpack('<H', raw[0:2])[0]
ptr = 2
cols = []
for i in range(num_cols):
    namelen = raw[ptr]; ptr += 1
    colname = raw[ptr:ptr+namelen].decode('ascii'); ptr += namelen
    typelen = raw[ptr]; ptr += 1
    coltype = raw[ptr:ptr+typelen].decode('ascii'); ptr += typelen
    cols.append((colname, coltype))

def parse_val(t, ptr):
    if ptr >= len(raw):
        return None, ptr
    if t == 'B':
        return raw[ptr], ptr + 1
    elif t == 'b':
        return struct.unpack('b', raw[ptr:ptr+1])[0], ptr + 1
    elif t == 'H':
        return struct.unpack('<H', raw[ptr:ptr+2])[0], ptr + 2
    elif t == 'D':
        return struct.unpack('<H', raw[ptr:ptr+2])[0], ptr + 2
    elif t == 'I':
        return struct.unpack('<I', raw[ptr:ptr+4])[0], ptr + 4
    elif t == 'S':
        slen = struct.unpack('<H', raw[ptr:ptr+2])[0]
        ptr += 2
        s = raw[ptr:ptr+slen].decode('utf-8', errors='ignore')
        return s, ptr + slen
    elif t == '[H':
        cnt = raw[ptr]; ptr += 1
        arr = []
        for _ in range(cnt):
            arr.append(struct.unpack('<H', raw[ptr:ptr+2])[0])
            ptr += 2
        return arr, ptr
    elif t == '[I':
        cnt = raw[ptr]; ptr += 1
        arr = []
        for _ in range(cnt):
            arr.append(struct.unpack('<I', raw[ptr:ptr+4])[0])
            ptr += 4
        return arr, ptr
    else:
        raise ValueError(f'Unknown type {t}')

row_count = 0
while ptr < len(raw):
    p_start = ptr
    row = {}
    old_ptr = ptr
    err = False
    for cname, ctype in cols:
        val, ptr = parse_val(ctype, ptr)
        if val is None:
            err = True
            break
        row[cname] = val
    if err:
        print(f'Stopped at row {row_count}, ptr={old_ptr}/{len(raw)}, remaining bytes: {len(raw)-old_ptr}')
        print('Remaining hex:', raw[old_ptr:old_ptr+50].hex())
        break
    
    name = get_text(row['_nameSid'])
    print(f"Row {row_count}: len={ptr-p_start} ID={row['_id']} Name={name}")
    if row_count == 0:
        for k, v in row.items():
            print(f"   {k}: {v}")
            
    row_count += 1

print(f'Successfully parsed {row_count} monsters!')
