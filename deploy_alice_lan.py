import os

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_entries = {
    57300: 'Sucs vat Alice\n',
    57301: '[Phù Thủy / Thường / Điều Chỉnh]\n',
    57302: 'Sucs vat Alice\n'
}

def update_file(p):
    with open(p, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57302:
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
