import re
import sys

sys.stdout.reconfigure(encoding='utf-8')

skill_txt = open(r'D:\yugitauapk\web\data\skill.lua', encoding='utf-8').read()
lines = open(r'D:\yugitauapk\extend_lan.txt', encoding='utf-8', errors='ignore').readlines()

def get_str(sid):
    if 1 <= sid <= len(lines):
        return lines[sid-1].strip()
    return f'ID_{sid}'

def extract_table(txt, sid):
    pattern = f'[{sid}]='
    start = txt.find(pattern)
    if start == -1:
        return None
    open_brace = txt.find('{', start)
    depth = 0
    i = open_brace
    while i < len(txt):
        if txt[i] == '{':
            depth += 1
        elif txt[i] == '}':
            depth -= 1
            if depth == 0:
                return txt[start:i+1]
        i += 1
    return None

for sid in [9504, 9505, 6201, 7142]:
    snippet = extract_table(skill_txt, sid)
    print(f"\n--- Skill {sid} ---")
    print(snippet)
    if snippet:
        for m in re.finditer(r'\["_(\w+Sid)"\]=(\d+)', snippet):
            s_val = int(m.group(2))
            print(f"   {m.group(1)}={s_val} -> {get_str(s_val)}")
