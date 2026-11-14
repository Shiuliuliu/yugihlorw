import re

files = {
    'monster': r'D:\yugitauapk\web\data\monster.lua',
    'rare': r'D:\yugitauapk\web\data\rare.lua',
    'magic': r'D:\yugitauapk\web\data\magic.lua',
    'trap': r'D:\yugitauapk\web\data\trap.lua'
}

with open(r'D:\yugitauapk\web\src\h5_patch.lua', 'r', encoding='utf-8') as f:
    h5 = f.read()

overrides = dict(re.findall(r'\[(\d+)\]\s*=\s*"([^"]+)"', h5))

cards = []

for ctype, path in files.items():
    with open(path, 'r', encoding='utf-8') as f:
        text = f.read()
    for m in re.finditer(r'\[(\d+)\]=\{(.*?)\}', text):
        cid = int(m.group(1))
        body = m.group(2)
        kw = re.search(r'\["_keyword"\]=(\d+)', body)
        py = re.search(r'\["_py"\]="([^"]+)"', body)
        name_sid = re.search(r'\["_nameSid"\]=(\d+)', body)
        quality = re.search(r'\["_quality"\]=(\d+)', body)
        
        name = ''
        if name_sid:
            name = overrides.get(name_sid.group(1), '')
        
        kw_val = int(kw.group(1)) if kw else 0
        py_val = py.group(1) if py else ''
        q_val = int(quality.group(1)) if quality else 1
        
        cards.append({
            'id': cid,
            'type': ctype,
            'kw': kw_val,
            'py': py_val,
            'name': name,
            'quality': q_val
        })

print("=== LABRYNTH CARDS ===")
lab = [c for c in cards if c['kw'] == 308 or 'labrynth' in c['py'].lower() or 'labrynth' in c['name'].lower()]
for c in sorted(lab, key=lambda x: x['id']):
    print(f"{c['id']}: [{c['type']}] (Q{c['quality']}) {c['name']} (py: {c['py']})")

print("\n=== LIQI CARDS ===")
liq = [c for c in cards if c['kw'] == 303 or 'liqi' in c['py'].lower() or any(k in c['name'].lower() for k in ['dolia', 'heino', 'violet', 'elsu', 'hayate', 'quân huy', 'vệ thần', 'airi', 'tel'])]
for c in sorted(liq, key=lambda x: x['id']):
    print(f"{c['id']}: [{c['type']}] (Q{c['quality']}) {c['name']} (py: {c['py']})")
