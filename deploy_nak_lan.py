import os

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

desc_40745 = (
    '[Chiến Binh - Hiệu Quả - Link]\\n'
    '1 quái GR có từ khóa "liqi".\\n'
    '(1) Khi vào sân: Nhận được rào chắn Quái vật, Phép thuật, Bẫy.\\n'
    '(2) Khi có mặt: Tăng công bằng số lượng bài trên tay x1000.\\n'
    '(3) Khi tấn công: Rút 1 lá bài.\\n'
    '(4) Khi có mặt: Khóa tất cả quái thú trên sân phe ta ngoại trừ bản thân.\\n'
    '(5) Lá bài này có thể tấn công hai lần trong mỗi lượt chiến đấu.\n'
)

new_entries = {
    57303: 'Nak - Thứ nguyên vệ thần\n',
    57304: desc_40745,
    57305: 'Nak - Thứ nguyên vệ thần\n',
    57306: 'Thứ Nguyên Chuyển Hóa\n',
    57307: 'Khi có mặt; tăng công bằng số lượng bài trên tay x[1]\n'
}

def update_file(p):
    with open(p, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57307:
        lines.append('\n')
    for sid, text in new_entries.items():
        lines[sid - 1] = text
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.writelines(lines)
    print(f"Updated {p}, now {len(lines)} lines")

for p in LAN_FILES:
    if os.path.isfile(p):
        update_file(p)

print("[OK] Language files updated successfully!")
