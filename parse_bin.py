import struct, sys
sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f:
    raw = f.read()

num_cols = struct.unpack('<H', raw[0:2])[0]
ptr = 2
cols = []
for i in range(num_cols):
    namelen = raw[ptr]
    ptr += 1
    colname = raw[ptr:ptr+namelen].decode('ascii')
    ptr += namelen
    typelen = raw[ptr]
    ptr += 1
    coltype = raw[ptr:ptr+typelen].decode('ascii')
    ptr += typelen
    cols.append((colname, coltype))

print(f'Header ends at ptr={ptr}. Columns: {len(cols)}')
for c in cols:
    print(' ', c)

# Let's see what follows the header:
# In many binary table formats:
# Is there a row count?
# Let's inspect next 32 bytes:
print('Next 32 bytes:', list(raw[ptr:ptr+32]))
print('Hex:', raw[ptr:ptr+32].hex())
