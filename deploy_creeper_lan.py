import os, sys
sys.stdout.reconfigure(encoding='utf-8')

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    57319: 'Creeper\n',
    57320: '[Xác Sống - Hiệu Ứng]\\nKhi lá bài này trên sân, đối phương triệu hồi quái sẽ kích hoạt: phá hủy bản thân và lá bài đối phương vừa triệu hồi. Trong lượt này, ô quái thú đối phương vừa bị phá hủy sẽ không thể đặt quái.\n',
    57321: 'Creeper\n',
    57322: 'Creeper - Tự Bộc\n',
    57323: 'Khi lá bài này trên sân, đối phương triệu hồi quái sẽ kích hoạt: phá hủy bản thân và lá bài đối phương vừa triệu hồi. Trong lượt này, ô quái thú đối phương vừa bị phá hủy sẽ không thể đặt quái.\n'
}

def update_file(p):
    with open(p, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57323:
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
