import sys, re, json
sys.stdout.reconfigure(encoding='utf-8')

with open('web/data/drop.lua', encoding='utf-8') as f:
    text = f.read()

with open('web/res/lan.lcres/extend.lan', encoding='utf-8', errors='ignore') as f:
    lan = [line.strip() for line in f]

for block in text.split('},\n'):
    if '_value' in block and '_nameSid' in block:
        m_val = re.search(r'\["_value"\]\s*=\s*(\d+)', block)
        m_sid = re.search(r'\["_nameSid"\]\s*=\s*(\d+)', block)
        if m_val and m_sid:
            val = int(m_val.group(1))
            sid = int(m_sid.group(1))
            name = lan[sid] if sid < len(lan) else 'Unknown'
            print(f'{val} (sid {sid}): {name}')
