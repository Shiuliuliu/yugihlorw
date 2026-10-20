import os

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    57291: 'Diệt Rồng Tập Sự - Hàng Long\n',
    57292: 'Kĩ năng chủ động bộ bài thêm: Chọn 1 quái tộc "rồng" trên sân đối phương đưa vào mộ, sau đó triệu hồi đặc biệt bài này lên sân phe ta (xuyên qua tường chắn quái).\n',
    57293: 'Diệt Rồng Tập Sự - Tầm Kiếm\n',
    57294: 'Kĩ năng chủ động (1 lượt 1 lần): Chọn lấy tối đa 2 quái thú có từ khóa "Kiếm hủy diệt" từ bộ bài lên tay.\n',
    57295: 'Diệt Rồng Tập Sự - Truyền Thừa\n',
    57296: 'Kĩ năng chủ động (1 lượt 1 lần): Hy sinh bản thân, chọn triệu hồi đặc biệt 1 quái có từ khóa "Kiếm sĩ diệt rồng" trong bộ bài phe ta.\n',
    57297: 'Kiếm sĩ diệt rồng tập sự\n',
    57298: '[Chiến Binh - Hiệu Quả - Link]\\n1 quái có từ khóa "Kiếm hủy diệt" hoặc "Kiếm sĩ diệt rồng".\\n(Lá bài này luôn có từ khóa "Kiếm hủy diệt" và "Kiếm sĩ diệt rồng".)\\n(1) Kĩ năng chủ động bộ bài thêm: Chọn 1 quái tộc "rồng" trên sân đối phương đưa vào mộ, sau đó triệu hồi đặc biệt bài này lên sân phe ta (xuyên qua tường chắn quái).\\n(2) Kĩ năng chủ động (1 lượt 1 lần): Chọn lấy tối đa 2 quái thú có từ khóa "Kiếm hủy diệt" từ bộ bài lên tay.\\n(3) Kĩ năng chủ động (1 lượt 1 lần): Hy sinh bản thân, chọn triệu hồi đặc biệt 1 quái có từ khóa "Kiếm sĩ diệt rồng" trong bộ bài phe ta.\n',
    57299: 'Kiếm sĩ diệt rồng tập sự\n'
}

def update_file(p):
    with open(p, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57299:
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
