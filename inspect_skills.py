import sys
import re

sys.stdout.reconfigure(encoding='utf-8')

with open('web/data/skill.lua', 'r', encoding='utf-8') as f:
    skill_text = f.read()

with open('extend_lan.txt', 'r', encoding='utf-8') as f:
    lan_lines = [l.rstrip('\r\n') for l in f.readlines()]

def get_lan(sid):
    if 1 <= sid <= len(lan_lines):
        return lan_lines[sid - 1]
    return f"UNKNOWN_{sid}"

def inspect_skill(sk_id):
    target = f'  [{sk_id}]={{'
    pos = skill_text.find(target)
    if pos == -1:
        target = f'[{sk_id}]={{'
        pos = skill_text.find(target)
    if pos == -1:
        print(f"=== Skill {sk_id} NOT FOUND ===")
        return
    # Find next skill by matching \n  [\d+]={
    m_next = re.search(r'\n  \[\d+\]=\{', skill_text[pos + len(target):])
    if m_next:
        block = skill_text[pos:pos + len(target) + m_next.start()]
    else:
        block = skill_text[pos:pos+1000]
    
    name_sid_m = re.search(r'\["_nameSid"\]=(\d+)', block)
    desc_sid_m = re.search(r'\["_descSid"\]=(\d+)', block)
    name = get_lan(int(name_sid_m.group(1))) if name_sid_m else ""
    desc = get_lan(int(desc_sid_m.group(1))) if desc_sid_m else ""
    print(f"=== Skill {sk_id}: {name} (nameSid: {name_sid_m.group(1) if name_sid_m else 0}) ===")
    print(f"Desc: {desc}")
    print(f"Block:\n{block.strip()}\n")

skills_to_check = [
    # 40708 (Rồng bạo chúa mắt xanh)
    14435, 1163, 1008, 3533, 2948, 14436,
    # 40722 (Rồng bạc mắt trắng)
    14588, 14589, 14590,
    # 40454 (Mắt xanh - Rồng bạo liệt)
    13850, 9800, 3114, 3501, 6578, 1141, 9627,
    # 12293 (Rồng chiến ngân hà)
    14538, 14536, 14537,
    # 12314 (Lệ quỷ)
    14633, 14634, 14635, 14636,
    # 12315 (Kỳ baby)
    14639, 14640
]

for s in skills_to_check:
    inspect_skill(s)
