import os, sys
sys.stdout.reconfigure(encoding='utf-8')

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    58351: 'Nạp quân huy\n',
    58352: '[Bài Phép / Thường / UR]\nTừ khóa: "liqi"\nChọn tối đa 2 quái thú có từ khóa "liqi" tay phe ta, đưa chúng vào mộ, sau đó phe ta rút bài bằng số quái đã chọn + 1.\n',
    58353: 'Nạp quân huy\n',
    58354: 'Chọn tối đa 2 quái thú có từ khóa "liqi" tay phe ta, đưa chúng vào mộ, sau đó phe ta rút bài bằng số quái đã chọn + 1.\n',
    58355: 'Elsu - Mafia\n',
    58356: '[Chiến Binh / Hiệu Ứng / UR]\nThuộc tính: Quang | 4 Sao\nTừ khóa: "liqi"\nATK: 1800 | DEF: 200\n',
    58357: 'Elsu - Mafia\n',
    58358: 'Ẩn Thân Bắn Tỉa\n',
    58359: 'Khi trở thành mục tiêu tấn công, đưa lá bài này về lại tay sau đó phá hủy quái đối phương (xuyên qua 12002).\n',
    58360: 'Định Mệnh Mafia\n',
    58361: 'Bắt đầu lượt đối thủ (sau khi đối phương rút bài): 1 lượt 1 lần, tung 1 đồng xu, mặt ngửa: phe địch bỏ 1 lá bài quái thú trên tay vào mộ. Mặt úp: phe ta bỏ 1 lá bài ngẫu nhiên trên tay vào mộ.\n',
    58362: 'Hu hu các người bắt nạt ta\n',
    58363: '[Bài Phép / Thường / UR]\nTừ khóa: "liqi"\nTriệu hồi đặc biệt 1 12336 từ mộ lên sân, tất cả 12336 trên sân phe ta nhận 5000 atk.\n',
    58364: 'Hu hu các người bắt nạt ta\n',
    58365: 'Triệu hồi đặc biệt 1 12336 từ mộ lên sân, tất cả 12336 trên sân phe ta nhận 5000 atk.\n'
}

for p in LAN_FILES:
    if os.path.isfile(p):
        with open(p, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        print(f"Current lines in {p}: {len(lines)}")
        while len(lines) < 58365:
            lines.append('\n')
        for sid, text in new_entries.items():
            lines[sid - 1] = text
        with open(p, 'w', encoding='utf-8', newline='\n') as f:
            f.writelines(lines)
        print(f"Updated {p}, now {len(lines)} lines")

print("[OK] Language files updated successfully!")
