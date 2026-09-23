import sys
sys.stdout.reconfigure(encoding='utf-8')
import pymysql
import json
import re
from collections import defaultdict

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
cursor = conn.cursor(pymysql.cursors.DictCursor)

cursor.execute("""
    SELECT id, name, keyword, quality FROM (
        SELECT id, name, keyword, quality FROM card_monsters
        UNION ALL SELECT id, name, keyword, quality FROM card_spells
        UNION ALL SELECT id, name, keyword, quality FROM card_traps
        UNION ALL SELECT id, name, '' AS keyword, quality FROM card_extra
    ) AS all_cards
""")
all_cards_map = {r['id']: r for r in cursor.fetchall()}

with open('web/data/ancient_products.lua', 'r', encoding='utf-8') as f:
    anc_text = f.read()
ancient_cids = set(int(m.group(1)) for m in re.finditer(r'\[\"_cardId\"\]=(\d+)', anc_text))

with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    all_packs_summary = json.load(f)

pack_quality_map = {}

for tab_key in ['char_packs', 'liya_packs', 'extra_packs']:
    for p in all_packs_summary[tab_key]:
        pname = p['name']
        val = p['value']
        cids = p['cards']
        
        gr_list = []
        ur_anc_list = []
        normal_pool = []
        
        for cid in cids:
            c = all_cards_map.get(cid)
            if not c:
                continue
            q = (c.get('quality') or 'N').upper()
            if q == 'GR':
                gr_list.append(c)
            elif cid in ancient_cids:
                ur_anc_list.append(c)
            else:
                normal_pool.append(c)
                
        # If no ancient card in pack, pick the 1-2 most iconic/highest ID UR cards as Ancient UR
        if len(ur_anc_list) == 0 and len(normal_pool) > 0:
            ur_anc_list.append(normal_pool.pop(-1))
            if len(normal_pool) > 10:
                ur_anc_list.append(normal_pool.pop(-1))

        # Now distribute normal_pool across UR, SR, R, N
        # We want:
        # UR: ~15% (min 1)
        # SR: ~20% (min 1)
        # R:  ~35% (min 1)
        # N:  ~30% (min 1)
        total_norm = len(normal_pool)
        if total_norm == 0:
            # Fallback if pack is small
            ur_list = ur_anc_list[:]
            sr_list = ur_anc_list[:]
            r_list = ur_anc_list[:]
            n_list = ur_anc_list[:]
        else:
            n_cnt = max(1, round(total_norm * 0.35))
            r_cnt = max(1, round(total_norm * 0.35))
            sr_cnt = max(1, round(total_norm * 0.18))
            ur_cnt = total_norm - (n_cnt + r_cnt + sr_cnt)
            if ur_cnt < 1:
                ur_cnt = 1
                if n_cnt > 1: n_cnt -= 1
                elif r_cnt > 1: r_cnt -= 1
            
            # Slice normal_pool:
            # First cards (often basic spells/monsters) -> N
            # Next -> R
            # Next -> SR
            # Last (often boss/extra deck) -> UR
            n_list = normal_pool[:n_cnt]
            r_list = normal_pool[n_cnt:n_cnt + r_cnt]
            sr_list = normal_pool[n_cnt + r_cnt:n_cnt + r_cnt + sr_cnt]
            ur_list = normal_pool[n_cnt + r_cnt + sr_cnt:]
            
        pack_quality_map[val] = {
            'name': pname,
            'GR': [c['id'] for c in gr_list],
            'UR_ANCIENT': [c['id'] for c in ur_anc_list],
            'UR': [c['id'] for c in ur_list],
            'SR': [c['id'] for c in sr_list],
            'R': [c['id'] for c in r_list],
            'N': [c['id'] for c in n_list]
        }

print("Sample balanced pack distribution:")
for val in [10201, 10301, 10401, 10501, 101010, 121010]:
    p = pack_quality_map[val]
    print(f"  {p['name']} ({val}): GR:{len(p['GR'])}, UR_Ancient:{len(p['UR_ANCIENT'])}, UR:{len(p['UR'])}, SR:{len(p['SR'])}, R:{len(p['R'])}, N:{len(p['N'])}")

# Check if ANY pack has 0 cards in UR, SR, R, or N
empty_checks = []
for val, p in pack_quality_map.items():
    for q in ['UR_ANCIENT', 'UR', 'SR', 'R', 'N']:
        if len(p[q]) == 0:
            empty_checks.append((p['name'], val, q))

if empty_checks:
    print(f"WARNING: Found {len(empty_checks)} empty qualities: {empty_checks[:5]}")
else:
    print("ALL 60 PACKS HAVE CANDIDATES FOR UR_ANCIENT, UR, SR, R, and N! PERFECT!")

with open('pack_quality_distribution.json', 'w', encoding='utf-8') as f:
    json.dump(pack_quality_map, f, indent=2, ensure_ascii=False)
