import re

with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern for entry
# [547]={["_descSid"]=... ["_type"]=1001,["_value"]=112001,},
pattern = re.compile(r'\[(\d+)\]=\{(.*?\[\"_type\"\]=(\d+).*?\[\"_value\"\]=(\d+).*?)\},', re.DOTALL)

type_1001 = []
type_1002 = []

for m in pattern.finditer(content):
    eid = int(m.group(1))
    body = m.group(2)
    t = int(m.group(3))
    v = int(m.group(4))
    if t == 1001:
        type_1001.append((eid, v, body))
    elif t == 1002:
        type_1002.append((eid, v, body))

print(f"Type 1001 count: {len(type_1001)}")
for eid, v, body in type_1001[:35]:
    # extract cards from _pid
    pids = re.findall(r'\[\d+\]=\{\[1\]=(\d+),\}', body)
    print(f"  1001: eid={eid}, _value={v}, card_count={len(pids)}, first5={pids[:5]}")

print(f"\nType 1002 count: {len(type_1002)}")
for eid, v, body in type_1002:
    pids = re.findall(r'\[\d+\]=\{\[1\]=(\d+),\}', body)
    print(f"  1002: eid={eid}, _value={v}, card_count={len(pids)}, first5={pids[:5]}")
