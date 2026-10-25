import os, sys
sys.stdout.reconfigure(encoding='utf-8')

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    57324: "Skeleton\n",
    57325: "[Xác Sống / Đồng Bộ / Hiệu Ứng]\\nKĩ năng chủ động bộ bài thêm (1 lượt tối đa 3 lần): Chọn loại bỏ 1 quái có từ khóa \"minecraft\" trong Mộ phe ta, triệu hồi đặc biệt lá bài này lên sân.\n",
    57326: "Skeleton\n",
    57327: "Skeleton - Tái Sinh Xương Trắng\n",
    57328: "Kĩ năng chủ động bộ bài thêm (1 lượt tối đa 3 lần): Chọn loại bỏ 1 quái có từ khóa \"minecraft\" trong Mộ phe ta, triệu hồi đặc biệt lá bài này lên sân.\n",
    57329: "Enderman\n",
    57330: "[Ác Quỷ / Hiệu Ứng]\\n+ Không thể bị hiệu quả phá hủy (12007).\\n+ Khi trên sân phe ta không có quái hoặc có quái có từ khóa \"minecraft\", có thể triệu hồi đặc biệt lá bài này từ tay.\\n+ 1 lượt 1 lần, khi lên sân: Ngẫu nhiên lấy 1 lá bài trên tay đối phương cho vào tay phe ta.\n",
    57331: "Enderman\n",
    57332: "Enderman - Dịch Chuyển Tức Thời\n",
    57333: "Kĩ năng chủ động: Khi trên sân phe ta không có quái hoặc có quái có từ khóa \"minecraft\", có thể triệu hồi đặc biệt lá bài này từ tay.\n",
    57334: "Enderman - Đoạt Bài Hư Không\n",
    57335: "1 lượt 1 lần, khi lên sân: Ngẫu nhiên lấy 1 lá bài trên tay đối phương cho vào tay phe ta.\n"
}

def update_file(p):
    with open(p, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57335:
        lines.append("\n")
    for sid, text in new_entries.items():
        lines[sid - 1] = text
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.writelines(lines)
    print(f"Updated {p}, now {len(lines)} lines")

for p in LAN_FILES:
    if os.path.isfile(p):
        update_file(p)

print("[OK] Language files updated successfully!")
