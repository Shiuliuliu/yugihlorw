import zipfile, struct

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

with zipfile.ZipFile(r"D:\yugitauapk\QuyetChienChiThanh_base_sign_1.apk") as z:
    data = z.read("assets/res/lan.lcres")

cur_key = struct.unpack('<I', data[4:8])[0]
delta_key = struct.unpack('<I', data[8:12])[0]
off = 44

is_comp = data[off]
flag2 = data[off+1]
uncomp_len = struct.unpack('<I', data[off+2:off+6])[0]
fn_len = data[off+6]
off += 7
enc_fn = data[off:off+fn_len]
off += fn_len

dec_fn = decrypt_data(enc_fn, cur_key)
cur_key = (cur_key + delta_key) & 0xFFFFFFFF

data_len = struct.unpack('<I', data[off:off+4])[0]
off += 4
enc_data = data[off:off+data_len]

dec_file = decrypt_data(enc_data, cur_key)

with open(r"D:\yugitauapk\orig_lan.txt", "wb") as f:
    f.write(dec_file)

lines = dec_file.split(b'\n')
print(f"Original Chinese lan unpacked: {len(dec_file)} bytes, {len(lines)} lines")