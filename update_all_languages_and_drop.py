import sys
import re
import json

sys.stdout.reconfigure(encoding='utf-8')

print("==================================================")
print("UPDATING LAN AND DROP.LUA FOR ALL 124 PACKS")
print("==================================================")

# 1. Load summary
with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    summary = json.load(f)

# 2. Load extend_lan.txt
with open('extend_lan.txt', 'r', encoding='utf-8') as f:
    lan_lines = [l.rstrip('\r\n') for l in f]

print(f"Initial lan lines: {len(lan_lines)}")

# Existing SIDs for Char packs 1..12: 14202 + (i-1)*6
char_name_sids = {}
for i in range(1, 13):
    sid = 14202 + (i - 1) * 6
    char_name_sids[i] = sid

# Char packs 13..20: 56684 + (i-13)
for i in range(13, 21):
    sid = 56684 + (i - 13)
    char_name_sids[i] = sid

# Liya packs 1..20: 15224 + (i-1)*6
liya_name_sids = {}
for i in range(1, 21):
    sid = 15224 + (i - 1) * 6
    liya_name_sids[i] = sid

# Extra packs 1..16: 15344 + (i-1)*6
extra_name_sids = {}
for i in range(1, 17):
    sid = 15344 + (i - 1) * 6
    extra_name_sids[i] = sid

# Extra packs 17..20: 56692..56695
for i in range(17, 21):
    extra_name_sids[i] = 56692 + (i - 17)

extra_name_sids[21] = 56696 # ES/CS
extra_name_sids[22] = 56697 # TrickStar

# For Extra packs 23..54: assign new SIDs if not already existing
for p in summary['extra_packs']:
    num = p['num']
    name = p['name']
    if num not in extra_name_sids:
        lan_lines.append(name)
        sid = len(lan_lines)
        extra_name_sids[num] = sid
    p['nameSid'] = extra_name_sids[num]

# For Expansion packs 1..30: assign new SIDs
expansion_name_sids = {}
for p in summary['expansion_packs']:
    num = p['num']
    name = p['name']
    lan_lines.append(name)
    sid = len(lan_lines)
    expansion_name_sids[num] = sid
    p['nameSid'] = sid

for p in summary['char_packs']:
    p['nameSid'] = char_name_sids[p['num']]

for p in summary['liya_packs']:
    p['nameSid'] = liya_name_sids[p['num']]

print(f"Final lan lines after adding pack titles: {len(lan_lines)}")

# Save updated extend_lan.txt and extend.lan
with open('extend_lan.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lan_lines) + '\n')

with open('web/res/lan.lcres/extend.lan', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lan_lines) + '\n')

print("Updated extend_lan.txt and web/res/lan.lcres/extend.lan")

# Re-save all_60_packs_summary.json with nameSid included
with open('all_60_packs_summary.json', 'w', encoding='utf-8') as f:
    json.dump(summary, f, indent=2, ensure_ascii=False)

# 3. Build pack_defs for drop.lua
pack_defs = {}

# 1. Char packs (20 packs)
for p in summary['char_packs']:
    num = p['num']
    val = p['value'] # e.g. 10201
    name = p['name']
    cards = p['cards']
    sid = p['nameSid']
    pack_defs[val] = {'type': 1002, 'cost': 500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}
    pack_defs[val + 9] = {'type': 1002, 'cost': 4500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}
    pack_defs[val + 49] = {'type': 1002, 'cost': 22500, 'nameSid': sid, 'cards': cards, 'group': 'char', 'num': num, 'name': name}

# 2. Liya packs (20 packs)
for p in summary['liya_packs']:
    num = p['num']
    val = p['value'] # e.g. 101010
    name = p['name']
    cards = p['cards']
    sid = p['nameSid']
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'liya', 'num': num, 'name': name}

# 3. Extra packs (54 packs: 121010..174010)
for p in summary['extra_packs']:
    num = p['num']
    val = p['value']
    name = p['name']
    cards = p['cards']
    sid = p['nameSid']
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'extra', 'num': num, 'name': name}

# 4. Expansion packs (30 packs: 181010..210010)
for p in summary['expansion_packs']:
    num = p['num']
    val = p['value']
    name = p['name']
    cards = p['cards']
    sid = p['nameSid']
    prefix = (val // 1000) * 1000
    pack_defs[prefix + 1] = {'type': 1001, 'cost': 600, 'nameSid': sid, 'cards': cards, 'group': 'expansion', 'num': num, 'name': name}
    pack_defs[prefix + 10] = {'type': 1001, 'cost': 6000, 'nameSid': sid, 'cards': cards, 'group': 'expansion', 'num': num, 'name': name}
    pack_defs[prefix + 50] = {'type': 1001, 'cost': 28500, 'nameSid': sid, 'cards': cards, 'group': 'expansion', 'num': num, 'name': name}

print(f"Total pack variations to register in drop.lua: {len(pack_defs)} ({len(pack_defs)//3} packs)")

# 4. Read web/data/drop.lua to preserve all non-pack drop entries
with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    drop_content = f.read()

pattern = re.compile(r'\n  \[(\d+)\]=\{(.*?)\n  \[\"_type\"\]=(\d+),\[\"_value\"\]=(\d+),\},', re.DOTALL)
orig_entries = {}
non_pack_entries = {}
val_to_did = {}

for m in pattern.finditer(drop_content):
    did = int(m.group(1))
    body = m.group(2)
    t = int(m.group(3))
    val = int(m.group(4))
    entry_dict = {
        'did': did,
        'val': val,
        'type': t,
        'raw': m.group(0)
    }
    orig_entries[did] = entry_dict
    if val in pack_defs:
        val_to_did[val] = did
    else:
        # Non-pack entry (stage drop, chest, etc.)
        non_pack_entries[did] = entry_dict

print(f"Preserved {len(non_pack_entries)} non-pack drop entries (stages/chests).")

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
# Put non-pack entries
for did, e in non_pack_entries.items():
    final_entries[did] = e['raw']

# Allocate DIDs for packs
max_did = max(list(orig_entries.keys()) + [1300])

for val, pinfo in pack_defs.items():
    if val in val_to_did:
        did = val_to_did[val]
    else:
        max_did += 1
        did = max_did
        val_to_did[val] = did
    final_entries[did] = "\n" + generate_entry_lua(did, val, pinfo)

print(f"Total entries in final drop.lua: {len(final_entries)}")

out_lines = ["return {\n"]
for did in sorted(final_entries.keys()):
    entry_str = final_entries[did].strip('\n')
    out_lines.append("  " + entry_str.strip() + "\n")
out_lines.append("}\n")

with open('web/data/drop.lua', 'w', encoding='utf-8') as f:
    f.writelines(out_lines)

print("Generated web/data/drop.lua successfully!")
