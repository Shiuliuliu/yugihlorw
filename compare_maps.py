import json, re

with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    drop_content = f.read()

with open('char_cards_map.json', 'r', encoding='utf-8') as f:
    char_map = json.load(f)

with open('liya_cards_map.json', 'r', encoding='utf-8') as f:
    liya_map = json.load(f)

drop_packs = {}
cur_v = None
cur_t = None
cur_pids = []
in_pid = False

with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    for line in f:
        line_s = line.strip()
        if line.startswith('  [') and '={' in line:
            cur_v = None
            cur_t = None
            cur_pids = []
            in_pid = False
        
        if '["_type"]=' in line_s:
            m = re.search(r'\["_type"\]=(\d+)', line_s)
            if m: cur_t = int(m.group(1))
        if '["_value"]=' in line_s:
            m = re.search(r'\["_value"\]=(\d+)', line_s)
            if m: cur_v = int(m.group(1))
        if '["_pid"]=' in line_s:
            in_pid = True
        elif in_pid:
            m = re.search(r'\[\d+\]=\{\[1\]=(\d+),\}', line_s)
            if m:
                cur_pids.append(int(m.group(1)))
            elif line_s.endswith('},') and not line_s.startswith('['):
                in_pid = False

        if cur_v and cur_t in (1001, 1002) and line_s.endswith('},'):
            drop_packs[cur_v] = cur_pids[:]

print(f"Total packs in drop.lua: {len(drop_packs)}")

if 11201 in drop_packs:
    drop_11201 = drop_packs[11201]
    char_11201 = char_map.get('11201', [])
    print(f"Yudai 11201 in drop.lua: {len(drop_11201)} cards")
    print(f"Yudai 11201 in char_cards_map: {len(char_11201)} cards")
    diff = set(drop_11201) ^ set(char_11201)
    print(f"Difference for 11201: {len(diff)} cards")

# Check all character packs
char_packs = [10201, 10301, 10401, 10501, 10601, 10701, 10801, 10901, 11001, 11101, 11201, 11301]
print("\n--- Character Packs Check ---")
for cp in char_packs:
    in_drop = len(drop_packs.get(cp, []))
    in_map = len(char_map.get(str(cp), []))
    print(f"Pack {cp}: drop.lua={in_drop}, map={in_map}")

# Check Liya packs
print("\n--- Sample Liya Packs Check ---")
for lp in [101001, 102001, 103001, 104001, 105001, 112001, 120001, 131001, 132001]:
    in_drop = len(drop_packs.get(lp, []))
    liya_idx = (lp - 100000) // 1000
    in_map = len(liya_map.get(str(liya_idx), []))
    in_map_full = len(liya_map.get(str(lp), []))
    print(f"Liya {lp} (idx {liya_idx}): drop.lua={in_drop}, map_idx={in_map}, map_full={in_map_full}")
