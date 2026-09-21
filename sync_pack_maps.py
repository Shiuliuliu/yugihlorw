import json, os, re
from parse_drop import parse_drop_lua

def sync_maps():
    print("[*] Parsing web/data/drop.lua...")
    drop_char_packs, drop_liya_packs = parse_drop_lua()
    print(f"    Loaded {len(drop_char_packs)} char pack entries, {len(drop_liya_packs)} liya pack entries from drop.lua")

    # 1. Sync char_cards_map.json
    char_map_path = 'char_cards_map.json'
    with open(char_map_path, 'r', encoding='utf-8') as f:
        char_map = json.load(f)

    # If drop.lua has 11201 (Yudai), ensure it's in char_map
    if 11201 in drop_char_packs:
        char_map['11201'] = drop_char_packs[11201]
        char_map['11210'] = drop_char_packs[11201]
        char_map['11250'] = drop_char_packs[11201]
        char_map['15'] = drop_char_packs[11201]
        char_map['12'] = drop_char_packs[11201]

    # For other character packs in drop.lua:
    # 10201 -> Kaiba (2), 10301 -> Yugi (3), etc.
    for v, pids in drop_char_packs.items():
        char_map[str(v)] = pids
        # Calculate character index: (v - 10000) // 100
        cid = (v - 10000) // 100
        # If user customized cid (e.g. "2" in char_map), prefer user's custom cid or drop.lua
        if str(cid) in char_map and char_map[str(cid)]:
            # Sync user's custom cards to the full package ID
            char_map[str(v)] = char_map[str(cid)]
        else:
            char_map[str(cid)] = pids

    # Also map all base cids to full package IDs
    for cid_str, pids in list(char_map.items()):
        if cid_str.isdigit() and int(cid_str) < 100:
            cid = int(cid_str)
            base_pkg = 10000 + cid * 100
            for suffix in (1, 10, 50):
                pkg_id = str(base_pkg + suffix)
                if pkg_id not in char_map:
                    char_map[pkg_id] = pids

    with open(char_map_path, 'w', encoding='utf-8') as f:
        json.dump(char_map, f, indent=2, ensure_ascii=False)
    print(f"[OK] Saved char_cards_map.json with {len(char_map)} keys.")

    # 2. Sync liya_cards_map.json
    liya_map_path = 'liya_cards_map.json'
    with open(liya_map_path, 'r', encoding='utf-8') as f:
        liya_map = json.load(f)

    # For Liya packs: index 1..35
    for v, pids in drop_liya_packs.items():
        if v >= 101001:
            l_idx = (v - 100000) // 1000
            l_idx_str = str(l_idx)
            # If user customized this liya pack index, keep user's customized list
            if l_idx_str in liya_map and liya_map[l_idx_str]:
                cards = liya_map[l_idx_str]
            else:
                cards = pids
                liya_map[l_idx_str] = cards
            # Map full package ID (e.g. 101001, 101010, 101050)
            liya_map[str(v)] = cards

    # Also map all 1..35 to full package IDs
    for idx_str, pids in list(liya_map.items()):
        if idx_str.isdigit() and int(idx_str) <= 50:
            idx = int(idx_str)
            base_pkg = 100000 + idx * 1000
            for suffix in (1, 10, 50):
                pkg_id = str(base_pkg + suffix)
                if pkg_id not in liya_map:
                    liya_map[pkg_id] = pids

    with open(liya_map_path, 'w', encoding='utf-8') as f:
        json.dump(liya_map, f, indent=2, ensure_ascii=False)
    print(f"[OK] Saved liya_cards_map.json with {len(liya_map)} keys.")

if __name__ == '__main__':
    sync_maps()
