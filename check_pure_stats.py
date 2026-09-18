import struct, sys, re
sys.stdout.reconfigure(encoding='utf-8')

FIB = [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 584, 4181, 6765, 
    10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 
    2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 
    165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903
]

def decrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r5 = (-shift) & 7
        b ^= mod_key
        r7 = (b >> shift) & 0xFF
        b = ((b << r5) | r7) & 0xFF
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

with open(r'D:\yugitauapk\extracted\1.0.7\res\lan.lcres', 'rb') as f:
    data = f.read()

cur_key = struct.unpack('<I', data[4:8])[0]
delta_key = struct.unpack('<I', data[8:12])[0]
off = 44
uncomp_len = struct.unpack('<I', data[off+2:off+6])[0]
fn_len = data[off+6]
off += 7 + fn_len
cur_key = (cur_key + delta_key) & 0xFFFFFFFF
data_len = struct.unpack('<I', data[off:off+4])[0]
off += 4
enc_data = data[off:off+data_len]
dec_file = decrypt_data(enc_data, cur_key)
text = dec_file.decode('utf-8', errors='ignore')
lines = text.split('\n')

print('--- CHECKING ALL REQUIREMENTS ---')
chn = [i for i, l in enumerate(lines) if 'chân hồng nhãn' in l.lower()]
print(f'Occurrences of Chân Hồng Nhãn: {len(chn)}')

brackets_in_meta = []
for i in range(1900, 2220):
    if '(' in lines[i] or ')' in lines[i]:
        brackets_in_meta.append((i, lines[i]))
print(f'Parentheses in card types/archetypes (lines 1900-2220): {len(brackets_in_meta)}')
for b in brackets_in_meta:
    print('  Line', b[0], ':', b[1])

noichungla = [i for i, l in enumerate(lines) if l.strip() == 'nói chung là']
print(f'Lines equal to "nói chung là": {len(noichungla)}')

print('Counts of official summon keywords in entire game text:')
for kw in ['Triệu Hồi Link', 'Triệu Hồi Synchro', 'Triệu Hồi Xyz', 'Triệu Hồi Dung Hợp', 'Quái Thú Link', 'Quái Thú Synchro', 'Quái Thú Xyz', 'Quái Thú Dung Hợp']:
    count = len(re.findall(re.escape(kw), text))
    print(f'  {kw}: {count}')

print('Sample key lines:')
print('  Line 1938 (Mắt Đỏ):', lines[1938])
print('  Line 1969 (Mắt Xanh):', lines[1969])
print('  Line 1971 (Rồng Đen Mắt Đỏ):', lines[1971])
print('  Line 2198 (Chủng tộc Thông Thường):', lines[2198])
print('  Line 2200 (Dung Hợp):', lines[2200])
print('  Line 2207 (Synchro):', lines[2207])
print('  Line 2208 (Xyz):', lines[2208])
print('  Line 2211 (Link):', lines[2211])
print('  Line 3596 (Modal button):', repr(lines[3596]))
