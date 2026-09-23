import sys
sys.stdout.reconfigure(encoding='utf-8')
import json
import re

# 1. Load summary
with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    summary = json.load(f)

# 2. Load extend_lan.txt
with open('extend_lan.txt', 'r', encoding='utf-8') as f:
    lan_lines = [l.rstrip('\r\n') for l in f]

print(f"Initial lan lines: {len(lan_lines)}")

# Map of existing Character packs in drop.lua:
# val=10201: nameSid=14202 (pack 1) -> 14202, 14204, 14206
# val=10301: nameSid=14208 (pack 2) -> 14208, 14210, 14212
# val=10401: nameSid=14214 (pack 3) -> 14214, 14216, 14218
# etc.
char_name_sids = {}
for i in range(1, 13):
    sid = 14202 + (i - 1) * 6
    char_name_sids[i] = sid

# Liya packs 1..20:
# val=101010: nameSid=15224 (pack 1) -> base sid 15224, x1 is 15222, x50 is 15226
liya_name_sids = {}
for i in range(1, 21):
    sid = 15224 + (i - 1) * 6
    liya_name_sids[i] = sid

# Extra packs 1..16:
# val=121010: nameSid=15344 (pack 1)
extra_name_sids = {}
for i in range(1, 17):
    sid = 15344 + (i - 1) * 6
    extra_name_sids[i] = sid

# Apply names to existing lines in lan_lines
for p in summary['char_packs']:
    num = p['num']
    name = p['name']
    if num in char_name_sids:
        base_sid = char_name_sids[num]
        lan_lines[base_sid - 1] = name
        lan_lines[base_sid + 1] = name # 14204
        lan_lines[base_sid + 3] = name # 14206
    else:
        # Need new sid
        lan_lines.append(name)
        new_sid = len(lan_lines)
        char_name_sids[num] = new_sid

for p in summary['liya_packs']:
    num = p['num']
    name = p['name']
    if num in liya_name_sids:
        base_sid = liya_name_sids[num]
        lan_lines[base_sid - 1] = name # 15224 (x10)
        lan_lines[base_sid - 3] = name # 15222 (x1)
        lan_lines[base_sid - 1 + 2] = name # 15226 (x50)
    else:
        lan_lines.append(name)
        new_sid = len(lan_lines)
        liya_name_sids[num] = new_sid

for p in summary['extra_packs']:
    num = p['num']
    name = p['name']
    if num in extra_name_sids:
        base_sid = extra_name_sids[num]
        lan_lines[base_sid - 1] = name # 15344
        lan_lines[base_sid - 3] = name # 15342
        lan_lines[base_sid + 1] = name # 15346
    else:
        lan_lines.append(name)
        new_sid = len(lan_lines)
        extra_name_sids[num] = new_sid

print(f"Final lan lines: {len(lan_lines)}")

# Save updated lan files
with open('extend_lan.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lan_lines) + '\n')

with open('web/res/lan.lcres/extend.lan', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lan_lines) + '\n')

print("Updated extend_lan.txt and web/res/lan.lcres/extend.lan")

# 3. Now let's inspect and update web/data/drop.lua
# We will read drop.lua, parse existing entries, update them, and add missing entries.
with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    drop_content = f.read()

# Find max drop id
max_drop_id = max(int(m) for m in re.findall(r'\[(\d+)\]=\{', drop_content))
print(f"Max existing drop id: {max_drop_id}")

# Build map of pack entries to add/update
# For each pack, we have 3 variants: (1, 10, 50)
# Char packs:
# num 1..20: baseVal = 10100 + num * 100
# variants: (baseVal + 1, 1, 500), (baseVal + 10, 10, 4500), (baseVal + 50, 50, 22500)
# type = 1002
#
# Liya packs:
# num 1..20: prefix = 100000 + num * 1000
# variants: (prefix + 1, 1, 600), (prefix + 10, 10, 6000), (prefix + 50, 50, 28500)
# type = 1001
#
# Extra packs:
# num 1..20: prefix = 120000 + num * 1000
# variants: (prefix + 1, 1, 600), (prefix + 10, 10, 6000), (prefix + 50, 50, 28500)
# type = 1001

all_target_packs = []
for p in summary['char_packs']:
    num = p['num']
    base_val = 10100 + num * 100
    sid = char_name_sids[num]
    cards = p['cards']
    all_target_packs.append({
        'group': 'char',
        'num': num,
        'val_1': base_val + 1,
        'val_10': base_val + 10,
        'val_50': base_val + 50,
        'type': 1002,
        'nameSid': sid,
        'cards': cards,
        'costs': (500, 4500, 22500)
    })

for p in summary['liya_packs']:
    num = p['num']
    prefix = 100000 + num * 1000
    sid = liya_name_sids[num]
    cards = p['cards']
    all_target_packs.append({
        'group': 'liya',
        'num': num,
        'val_1': prefix + 1,
        'val_10': prefix + 10,
        'val_50': prefix + 50,
        'type': 1001,
        'nameSid': sid,
        'cards': cards,
        'costs': (600, 6000, 28500)
    })

for p in summary['extra_packs']:
    num = p['num']
    prefix = 120000 + num * 1000
    sid = extra_name_sids[num]
    cards = p['cards']
    all_target_packs.append({
        'group': 'extra',
        'num': num,
        'val_1': prefix + 1,
        'val_10': prefix + 10,
        'val_50': prefix + 50,
        'type': 1001,
        'nameSid': sid,
        'cards': cards,
        'costs': (600, 6000, 28500)
    })

print(f"Total packs to sync in drop.lua: {len(all_target_packs)} ({len(all_target_packs) * 3} drop entries)")
