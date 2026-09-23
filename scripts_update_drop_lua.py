import sys
sys.stdout.reconfigure(encoding='utf-8')
import json
import re

with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    summary = json.load(f)

pack_defs = {}

# 1. Char packs
for p in summary['char_packs']:
    num = p['num']
    val = p['value'] # e.g. 10201
    name = p['name']
    cards = p['cards']
    sid = (14202 + (num - 1) * 6) if num <= 12 else (56684 + (num - 13))
    pack_defs[val] = {'type': 1002, 'cost': 500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num}
    pack_defs[val + 9] = {'type': 1002, 'cost': 4500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num}
    pack_defs[val + 49] = {'type': 1002, 'cost': 22500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num}

# 2. Liya packs
for p in summary['liya_packs']:
    num = p['num']
    val = p['value'] # e.g. 101010
    cards = p['cards']
    sid = 15224 + (num - 1) * 6
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num}

# 3. Extra packs
for p in summary['extra_packs']:
    num = p['num']
    val = p['value'] # e.g. 121010
    cards = p['cards']
    sid = (15344 + (num - 1) * 6) if num <= 16 else (56692 + (num - 17))
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num}

print(f"Total target pack variants: {len(pack_defs)}")

with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

top_entries = []
for idx, l in enumerate(lines):
    m = re.match(r'^\s*\[(\d+)\]=\{\["_descSid"\]=', l)
    if m:
        top_entries.append((int(m.group(1)), idx))

print(f"Parsed {len(top_entries)} top-level entries from drop.lua")

# Map of entry text
entry_chunks = {}
for i in range(len(top_entries)):
    did, start_line = top_entries[i]
    if i + 1 < len(top_entries):
        end_line = top_entries[i+1][1]
    else:
        end_line = len(lines) - 1 # exclude closing '}'
    entry_chunks[did] = "".join(lines[start_line:end_line])

def build_pid_str(card_list):
    res = ['\n  ["_pid"]={']
    for idx, cid in enumerate(card_list, 1):
        res.append(f'\n  [{idx}]={{\n  [1]={cid},\n}},')
    res.append('},\n')
    return "".join(res)

val_to_did = {}
for did, text in entry_chunks.items():
    vm = re.search(r'\["_value"\]=(\d+),', text)
    if vm:
        val = int(vm.group(1))
        val_to_did[val] = did

updated_count = 0
added_count = 0
max_did = max(entry_chunks.keys())

for val, pinfo in pack_defs.items():
    pid_str = build_pid_str(pinfo['cards'])
    if val in val_to_did:
        did = val_to_did[val]
        content = entry_chunks[did]
        # Replace _pid
        content = re.sub(r'\n  \["_pid"\]=\{.*?\},', pid_str, content, flags=re.DOTALL)
        content = re.sub(r'\["_nameSid"\]=\d+,', f'["_nameSid"]={pinfo["nameSid"]},', content)
        content = re.sub(r'\["_descSid"\]=\d+,', f'["_descSid"]={pinfo["nameSid"]},', content)
        content = re.sub(r'\["_param"\]=\{\[1\]=1,\[2\]=\d+,', f'["_param"]={{[1]=1,[2]={pinfo["cost"]},', content)
        entry_chunks[did] = content
        updated_count += 1
    else:
        max_did += 1
        did = max_did
        new_content = (
            f'  [{did}]={{\n'
            f'  ["_descSid"]={pinfo["nameSid"]},["_id"]={did},["_isHide"]=0,["_nameSid"]={pinfo["nameSid"]},["_param"]={{[1]=1,[2]={pinfo["cost"]},[3]=0,[4]=0,[5]=0,}},'
            f'{pid_str}'
            f'  ["_showRes"]={{[1]=0,}},\n'
            f'  ["_type"]={pinfo["type"]},["_value"]={val},}},\n'
        )
        entry_chunks[did] = new_content
        val_to_did[val] = did
        added_count += 1

print(f"Updated {updated_count} existing entries, Added {added_count} new entries. Total entries: {len(entry_chunks)}")

out_text = ["return {\n"]
for did in sorted(entry_chunks.keys()):
    out_text.append(entry_chunks[did])
    if not entry_chunks[did].endswith('\n'):
        out_text.append('\n')
out_text.append("}\n")

with open('web/data/drop.lua', 'w', encoding='utf-8') as f:
    f.writelines(out_text)

print("Successfully wrote web/data/drop.lua!")
