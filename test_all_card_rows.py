import struct, sys
sys.stdout.reconfigure(encoding='utf-8')
from check_all_bins_seq import bins, get_text

def parse_val(raw, t, ptr):
    if ptr >= len(raw): return None, ptr
    if t == 'B': return raw[ptr], ptr + 1
    elif t == 'b': return struct.unpack('b', raw[ptr:ptr+1])[0], ptr + 1
    elif t == 'H' or t == 'D': return struct.unpack('<H', raw[ptr:ptr+2])[0], ptr + 2
    elif t == 'I': return struct.unpack('<I', raw[ptr:ptr+4])[0], ptr + 4
    elif t == 'S':
        slen = struct.unpack('<H', raw[ptr:ptr+2])[0]; ptr += 2
        s = raw[ptr:ptr+slen].decode('utf-8', errors='ignore'); return s, ptr + slen
    elif t == '[H':
        cnt = raw[ptr]; ptr += 1
        arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(cnt)]
        return arr, ptr + cnt*2
    elif t == '[I':
        cnt = raw[ptr]; ptr += 1
        arr = [struct.unpack('<I', raw[ptr+i*4:ptr+i*4+4])[0] for i in range(cnt)]
        return arr, ptr + cnt*4
    elif t == '[[H':
        outer_cnt = raw[ptr]; ptr += 1
        outer_arr = []
        for _ in range(outer_cnt):
            inner_cnt = raw[ptr]; ptr += 1
            inner_arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(inner_cnt)]
            ptr += inner_cnt*2
            outer_arr.append(inner_arr)
        return outer_arr, ptr
    else: raise ValueError(t)

for name in ['monster.bin', 'magic.bin', 'trap.bin', 'rare.bin']:
    raw = bins[name]
    num_cols = struct.unpack('<H', raw[0:2])[0]
    ptr = 2
    cols = []
    for i in range(num_cols):
        namelen = raw[ptr]; ptr += 1
        colname = raw[ptr:ptr+namelen].decode('ascii'); ptr += namelen
        typelen = raw[ptr]; ptr += 1
        coltype = raw[ptr:ptr+typelen].decode('ascii'); ptr += typelen
        cols.append((colname, coltype))
    
    rows = []
    while ptr < len(raw):
        row = {}
        err = False
        for cname, ctype in cols:
            val, ptr = parse_val(raw, ctype, ptr)
            if val is None: err = True; break
            row[cname] = val
        if err: break
        rows.append(row)
    print(f"=== {name} ===")
    print(f"Parsed {len(rows)} cards! Remaining bytes: {len(raw)-ptr}")
    if rows:
        print(f"  First: ID={rows[0]['_id']} Name={get_text(rows[0]['_nameSid'])}")
        print(f"  Last : ID={rows[-1]['_id']} Name={get_text(rows[-1]['_nameSid'])}")
