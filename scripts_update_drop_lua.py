import sys
sys.stdout.reconfigure(encoding='utf-8')
import re
import json

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
    pack_defs[val] = {'type': 1002, 'cost': 500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}
    pack_defs[val + 9] = {'type': 1002, 'cost': 4500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}
    pack_defs[val + 49] = {'type': 1002, 'cost': 22500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}

# 2. Liya packs
for p in summary['liya_packs']:
    num = p['num']
    val = p['value'] # e.g. 101010
    cards = p['cards']
    sid = 15224 + (num - 1) * 6
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}

# 3. Extra packs
for p in summary['extra_packs']:
    num = p['num']
    val = p['value'] # e.g. 121010
    cards = p['cards']
    sid = (15344 + (num - 1) * 6) if num <= 16 else (56692 + (num - 17))
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}

with open('web/data/drop.lua.orig', 'r', encoding='utf-8') as f:
    orig_content = f.read()

pattern = re.compile(r'\n  \[(\d+)\]=\{(.*?)\n  \[\"_type\"\]=(\d+),\[\"_value\"\]=(\d+),\},', re.DOTALL)
orig_entries = {}
for m in pattern.finditer(orig_content):
    did = int(m.group(1))
    body = m.group(2)
    t = int(m.group(3))
    val = int(m.group(4))
    # Capture the exact chunk text
    orig_entries[did] = {
        'did': did,
        'val': val,
        'type': t,
        'raw': m.group(0)
    }

val_to_did = {e['val']: did for did, e in orig_entries.items()}

def generate_entry_lua(did, val, pinfo):
    lines = []
    lines.append(f'  [{did}]={{\n')
    lines.append(f'  ["_descSid"]={pinfo["nameSid"]},["_id"]={did},["_isHide"]=0,["_nameSid"]={pinfo["nameSid"]},["_param"]={{[1]=1,[2]={pinfo["cost"]},[3]=0,[4]=0,[5]=0,}},\n')
    lines.append('  ["_pid"]={\n')
    for idx, cid in enumerate(pinfo['cards'], 1):
        lines.append(f'  [{idx}]={{\n  [1]={cid},\n}},\n')
    lines.append('  },\n')
    lines.append('  ["_showRes"]={[1]=0,},\n')
    lines.append(f'  ["_type"]={pinfo["type"]},["_value"]={val},}},\n')
    return "".join(lines)

final_entries = {}
# 1. First, populate all original entries as-is
for did, e in orig_entries.items():
    final_entries[did] = e['raw']

# 2. For pack_defs: if exists in orig, replace cleanly. If not, allocate new did
max_did = max(orig_entries.keys())
added = 0
updated = 0

for val, pinfo in pack_defs.items():
    if val in val_to_did:
        did = val_to_did[val]
        final_entries[did] = "\n" + generate_entry_lua(did, val, pinfo)
        updated += 1
    else:
        max_did += 1
        did = max_did
        final_entries[did] = "\n" + generate_entry_lua(did, val, pinfo)
        val_to_did[val] = did
        added += 1

print(f"Updated {updated} pack entries, Added {added} new pack entries. Total entries: {len(final_entries)}")

# Construct output
out_lines = ["return {\n"]
for did in sorted(final_entries.keys()):
    entry_str = final_entries[did].strip('\n')
    out_lines.append("  " + entry_str.strip() + "\n")
out_lines.append("}\n")

with open('web/data/drop.lua', 'w', encoding='utf-8') as f:
    f.writelines(out_lines)

print("Generated web/data/drop.lua successfully!")
