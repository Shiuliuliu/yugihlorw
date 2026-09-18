import struct, os, sys
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

with open(r'D:\yugitauapk\extracted\1.0.7\res\data.lcres', 'rb') as f:
    data = f.read()

cur_key = struct.unpack('<I', data[4:8])[0]
delta_key = struct.unpack('<I', data[8:12])[0]

out_dir = r'D:\yugitauapk\extracted_bins'
os.makedirs(out_dir, exist_ok=True)

off = 44
count = 0
while off < len(data):
    if off + 7 > len(data): break
    uncomp_len = struct.unpack('<I', data[off+2:off+6])[0]
    fn_len = data[off+6]
    off += 7
    enc_fn = data[off:off+fn_len]
    off += fn_len
    dec_fn = decrypt_data(enc_fn, cur_key)
    cur_key = (cur_key + delta_key) & 0xFFFFFFFF
    data_len = struct.unpack('<I', data[off:off+4])[0]
    off += 4
    enc_file = data[off:off+data_len]
    dec_file = decrypt_data(enc_file, cur_key)
    cur_key = (cur_key + delta_key) & 0xFFFFFFFF
    off += data_len
    fname = dec_fn.decode('utf-8', errors='ignore')
    target = os.path.join(out_dir, fname)
    with open(target, 'wb') as f:
        f.write(dec_file)
    count += 1

print(f'Extracted {count} bin files into {out_dir}')
