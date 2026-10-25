import os, sys
sys.stdout.reconfigure(encoding='utf-8')

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    57336: "Wither\n",
    57337: "[Xác Sống / Link 3 / Hiệu Ứng]\\n2 quái thú có từ khóa \"minecraft\" trở lên\\n+ Không thể bị hiệu quả phá hủy (12007).\\n+ Khi lá bài này trên sân, ngoại trừ quái tộc \"Xác Sống\", tất cả quái trên sân 2 bên bị giảm 1 nửa ATK (xuyên qua tường chắn quái).\n",
    57338: "Wither\n",
    57339: "Wither - Héo Rũ Tử Khí\n",
    57340: "Khi lá bài này trên sân, ngoại trừ quái tộc \"Xác Sống\", tất cả quái trên sân 2 bên bị giảm 1 nửa ATK (xuyên qua tường chắn quái).\n"
}

def update_file(p):
    with open(p, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57340:
        lines.append("\n")
    for sid, text in new_entries.items():
        lines[sid - 1] = text
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.writelines(lines)
    print(f"Updated {p}, now {len(lines)} lines")

for p in LAN_FILES:
    if os.path.isfile(p):
        update_file(p)

print("[OK] Language files for Wither updated successfully!")
