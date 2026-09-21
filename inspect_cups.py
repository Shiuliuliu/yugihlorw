import re
import sys

sys.stdout.reconfigure(encoding='utf-8')
props_txt = open(r'D:\yugitauapk\web\data\props.lua', encoding='utf-8').read()
lines = open(r'D:\yugitauapk\extend_lan.txt', encoding='utf-8', errors='ignore').readlines()

def get_str(sid):
    if 1 <= sid <= len(lines):
        return lines[sid-1].strip()
    return f'ID_{sid}'

print("=== Search Cup Props in props.lua ===")
for m in re.finditer(r'\[(\d+)\]=\{(.*?)\n  \},', props_txt, re.DOTALL):
    pid = int(m.group(1))
    body = m.group(2)
    m_sid = re.search(r'\["_nameSid"\]=(\d+)', body)
    if m_sid:
        sid = int(m_sid.group(1))
        ns = get_str(sid)
        if any(w in ns.lower() for w in ['cúp', 'cup', 'quán quân', 'á quân', 'hạng nhất', 'hạng nhì', 'hạng ba']):
            print(f"Prop {pid} (nameSid {sid}): {ns}")
