import struct, sys, json
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extend_lan.txt', 'r', encoding='utf-8', errors='ignore') as f:
    lan = [l.rstrip('\r\n') for l in f]

def get_text(sid):
    if sid == 0: return ''
    idx = sid - 1
    if 0 <= idx < len(lan): return lan[idx]
    return f'<SID {sid}>'

with open(r'D:\yugitauapk\extracted_bins\troop.bin', 'rb') as f:
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
    if ptr >= len(raw): return None, ptr
    if t == 'H' or t == 'D': return struct.unpack('<H', raw[ptr:ptr+2])[0], ptr + 2
    elif t == 'I': return struct.unpack('<I', raw[ptr:ptr+4])[0], ptr + 4
    elif t == '[H':
        cnt = raw[ptr]; ptr += 1
        arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(cnt)]
        return arr, ptr + cnt*2
    else: raise ValueError(t)

troops = []
while ptr < len(raw):
    row = {}
    err = False
    p_row = ptr
    try:
        for cname, ctype in cols:
            val, ptr = parse_val(ctype, ptr)
            row[cname] = val
    except Exception as e:
        print(f'Failed at row {len(troops)}, offset {p_row}: {e}')
        break
    troops.append(row)


print(f'Successfully parsed {len(troops)} decks in troop.bin!')
for t in troops[:5]:
    name = get_text(t['_nameSid'])
    deck = []
    for cid, cnt in zip(t['_infoId'], t['_num']):
        deck.extend([cid] * cnt)
    print(f"Deck ID: {t['_id']} | Name: {name} | Cards count: {len(deck)} | Cards: {deck[:10]}...")
