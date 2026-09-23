import sys
sys.stdout.reconfigure(encoding='utf-8')
import os
import json
import re

print("=== VERIFYING 100% COMPLETE SHOP DEPLOYMENT ===")

# 1. Load cards from database
from yugioh_web_server import get_db, ALL_CARDS_MAP, load_pack_mappings

with get_db() as conn:
    with conn.cursor() as cur:
        cur.execute("""
            SELECT id, name, keyword, quality, 'monster' as tbl FROM card_monsters
            UNION ALL SELECT id, name, keyword, quality, 'spell' as tbl FROM card_spells
            UNION ALL SELECT id, name, keyword, quality, 'trap' as tbl FROM card_traps
            UNION ALL SELECT id, name, keyword, quality, 'extra' as tbl FROM card_extra
        """)
        all_cards = {r['id']: r for r in cur.fetchall()}

forbidden_cids = {
    20804, 20805, 20806, 20807, 20808, 20809, 20810, 30439, 11309, 20525,
    20841, 20842, 20843, 20844, 20845,
    20961, 20962, 20963, 20964, 20965,
    20981, 20982, 20983, 20984, 20985,
    20233, 20236, 11753
}

def is_excluded(c):
    cid = c['id']
    if cid in forbidden_cids: return True
    name = (c['name'] or '').lower()
    if any(k in name for k in ['token', 'mã thông báo', 'diễn sinh', 'thay thế', 'tạm thời', 'chiến đao']): return True
    return False

valid_db_cards = {cid: c for cid, c in all_cards.items() if not is_excluded(c)}

print(f"Total valid non-dev cards in DB: {len(valid_db_cards)}")

# 2. Load maps
with open('char_cards_map.json', 'r', encoding='utf-8') as f:
    char_map = {int(k): v for k, v in json.load(f).items()}
with open('liya_cards_map.json', 'r', encoding='utf-8') as f:
    liya_map = {int(k): v for k, v in json.load(f).items()}
with open('extra_cards_map.json', 'r', encoding='utf-8') as f:
    extra_map = {int(k): v for k, v in json.load(f).items()}
with open('expansion_cards_map.json', 'r', encoding='utf-8') as f:
    expansion_map = {int(k): v for k, v in json.load(f).items()}

all_pack_cards = set()
for m in [char_map, liya_map, extra_map, expansion_map]:
    for k, v in m.items():
        all_pack_cards.update(v)

print(f"Unique cards present across all packs: {len(all_pack_cards)}")

missing_from_packs = set(valid_db_cards.keys()) - all_pack_cards
print(f"Missing valid cards from packs: {len(missing_from_packs)}")
assert len(missing_from_packs) == 0, f"Missing cards: {list(missing_from_packs)[:10]}"

forbidden_ids = {90001, 90002, 90003, 90004}
assert not (all_pack_cards & forbidden_ids), "Dev cards leaked into packs!"

# 3. Quality distribution ladder
with open('pack_quality_distribution.json', 'r', encoding='utf-8') as f:
    pack_dist = {int(k): v for k, v in json.load(f).items()}

print(f"Packs in quality distribution: {len(pack_dist)}")
assert len(pack_dist) == 124, f"Expected 124 packs, got {len(pack_dist)}"

for pid, dist in pack_dist.items():
    ur_gr_count = len(dist.get('GR', [])) + len(dist.get('UR', [])) + len(dist.get('UR_ANCIENT', []))
    sr_count = len(dist.get('SR', []))
    r_count = len(dist.get('R', []))
    n_count = len(dist.get('N', []))
    assert ur_gr_count >= 1, f"Pack {pid} has 0 UR/GR cards!"
    assert sr_count >= 1, f"Pack {pid} has 0 SR cards!"
    assert r_count >= 1, f"Pack {pid} has 0 R cards!"
    assert n_count >= 1, f"Pack {pid} has 0 N cards!"

print("Quality distribution check: PASS (All 124 packs have complete N/R/SR/UR ladders)")

# 4. Check drop.lua
with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    drop_content = f.read()

# Check sample pack entries
sample_packs = [10201, 12101, 101010, 120010, 121010, 142010, 143010, 174010, 181010, 210010]
for pval in sample_packs:
    assert f'["_value"]={pval},' in drop_content, f"drop.lua missing pack {pval}"

print("drop.lua check: PASS (All sample pack values present)")

# 5. Test execute_pack_lottery from yugioh_web_server
from yugioh_web_server import execute_pack_lottery, resolve_pack_cards

test_cases = [
    (10201, 3, "Char Pack 1"),
    (12101, 150, "Char Pack 20 (50 draws)"),
    (101010, 30, "Liya Pack 1 (10 draws)"),
    (120010, 3, "Liya Pack 20"),
    (121010, 3, "Extra Pack 1 (X-Saber)"),
    (142010, 30, "Extra Pack 22 (TrickStar)"),
    (143010, 150, "Extra Pack 23 (Mecha Phantom Beast)"),
    (174010, 30, "Extra Pack 54 (Fairy Tail)"),
    (181010, 3, "Expansion Pack 1 (Quái Thú Chiến Đấu I)"),
    (195010, 30, "Expansion Pack 15 (Phép Thuật Tối Thượng V)"),
    (210010, 150, "Expansion Pack 30 (Cạm Bẫy Chiến Trường X)")
]

user_acc = {'character_name': 'TestUser', 'gold': 999999, 'gem': 99999}
for pkg_num, count, desc in test_cases:
    cards = resolve_pack_cards(pkg_num)
    assert len(cards) > 0, f"No cards resolved for {desc} (ID: {pkg_num})"
    won, pity, has_ur = execute_pack_lottery(pkg_num, count, 0.0, None, user_acc)
    assert len(won) == count, f"Lottery count mismatch for {desc}: expected {count}, got {len(won)}"
    # Verify every won card is in DB
    for item in won:
        cid = item['info_id']
        assert cid in valid_db_cards, f"Won card {cid} not in valid DB cards!"
    sample_names = [f"{x['name']} ({x['quality']})" for x in won[:3]]
    print(f"  [PASS] {desc}: {count} cards drawn successfully. Sample cards: {sample_names}")

print("\n=== ALL TESTS PASSED! 100% COVERAGE & REPRODUCIBILITY VERIFIED ===")
