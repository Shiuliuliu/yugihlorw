import struct, sys
sys.stdout.reconfigure(encoding='utf-8')
from test_proper_decrypt import bins, get_text, parse_val

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
            if ctype == '[[H':
                outer_cnt = raw[ptr]; ptr += 1
                outer_arr = []
                for _ in range(outer_cnt):
                    inner_cnt = raw[ptr]; ptr += 1
                    inner_arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(inner_cnt)]
                    ptr += inner_cnt*2
                    outer_arr.append(inner_arr)
                row[cname] = outer_arr
                continue
            val, ptr = parse_val(ctype, ptr)
            if val is None: err = True; break
            row[cname] = val
        if err: break
        rows.append(row)
    print(f"{name:11s}: Parsed {len(rows)} cards! Remaining bytes: {len(raw)-ptr}")
    if rows:
        first = rows[0]
        last = rows[-1]
        print(f"   First -> ID: {first['_id']} | Name: {get_text(first['_nameSid'])}")
        print(f"   Last  -> ID: {last['_id']} | Name: {get_text(last['_nameSid'])}")
