import struct

with open(r'D:\yugitauapk\extracted_bins\monster.bin', 'rb') as f: data = f.read()

# Row 54 starts at 4046
p = 4046
print('Row 54 starts with ID:', int.from_bytes(data[p:p+2], 'little')) # 10055

# Let's see: next card could be 10056, or 10057... or what?
# What is the next monster card in Yu-Gi-Oh / this game?
# In extend_lan.txt:
# 22275: người đàn ông mặt chim
# 22279: sa giông
# 22283: Kiếm sĩ hủy diệt
# 22287: Rồng hủy diệt Gandora
# 22291: Chiến binh báo đen

# Let's search where in data (after 4046) are the string IDs for these names!
# 22275 -> 0x5703 -> in 1-based: 22276 -> 0x5704 (04 57)
# 22279 -> in 1-based: 22280 -> 0x5708 (08 57)
# 22283 -> in 1-based: 22284 -> 0x570c (0c 57)
# 22287 -> in 1-based: 22288 -> 0x5710 (10 57)
# 22291 -> in 1-based: 22292 -> 0x5714 (14 57)

for target_sid in [22276, 22280, 22284, 22288, 22292]:
    b = struct.pack('<H', target_sid)
    idx = data.find(b, 4046)
    print(f'SID {target_sid} (hex {b.hex()}) found at: {idx}')
