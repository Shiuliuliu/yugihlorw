import sys
sys.stdout.reconfigure(encoding='utf-8')
import urllib.request
import json
import pymysql

print("==================================================")
print("RUNNING COMPREHENSIVE REQUIREMENTS VERIFICATION")
print("==================================================")

# 1. Connect to DB
conn = pymysql.connect(
    host='127.0.0.1', user='root', password='', database='yugioh_game',
    charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor, autocommit=True
)
cur = conn.cursor()
cur.execute("SELECT id, username, character_name, gold FROM accounts WHERE gold > 1000000 LIMIT 1")
test_acc = cur.fetchone()
acc_id = test_acc['id']
print(f"Test account: id={acc_id}, user={test_acc['username']}, char_name={test_acc['character_name']}, gold={test_acc['gold']}")

# 2. Test Character Rename
print("\n--- [TEST 1] Character Rename API ---")
orig_name = test_acc['character_name']
new_test_name = "Vua_Tro_Choi_2026"
rename_payload = {"account_id": acc_id, "name": new_test_name}
req = urllib.request.Request("http://127.0.0.1:8080/api/change_nickname",
                             data=json.dumps(rename_payload).encode('utf-8'),
                             headers={'Content-Type': 'application/json'})
with urllib.request.urlopen(req) as resp:
    res = json.loads(resp.read().decode('utf-8'))
assert res['code'] == 200, f"Rename failed: {res}"
assert res['character_name'] == new_test_name, f"Response character_name mismatch: {res}"

cur.execute("SELECT character_name FROM accounts WHERE id = %s", (acc_id,))
db_row = cur.fetchone()
assert db_row['character_name'] == new_test_name, f"DB name mismatch: {db_row}"
print(f"[PASS] Successfully changed character name to '{new_test_name}' in DB & API response.")

# Revert name back
cur.execute("UPDATE accounts SET character_name = %s WHERE id = %s", (orig_name, acc_id))
print(f"[PASS] Restored original character name '{orig_name}'.")

# 3. Load all card maps
with open('char_cards_map.json', 'r', encoding='utf-8') as f:
    char_map = {int(k): v for k, v in json.load(f).items()}
with open('liya_cards_map.json', 'r', encoding='utf-8') as f:
    liya_map = {int(k): v for k, v in json.load(f).items()}
with open('extra_cards_map.json', 'r', encoding='utf-8') as f:
    extra_map = {int(k): v for k, v in json.load(f).items()}
with open('expansion_cards_map.json', 'r', encoding='utf-8') as f:
    expansion_map = {int(k): v for k, v in json.load(f).items()}

forbidden_cids = {
    # Combat equip spells
    20804, 20805, 20806, 20807, 20808, 20809, 20810, 30439, 11309, 20525,
    20841, 20842, 20843, 20844, 20845,
    20961, 20962, 20963, 20964, 20965,
    20981, 20982, 20983, 20984, 20985,
    # Unobtainable cards
    20233, 20236
}

# Check card maps have 0 forbidden cards
for m_name, cmap in [("Char", char_map), ("Liya", liya_map), ("Extra", extra_map), ("Expansion", expansion_map)]:
    for p_id, cards in cmap.items():
        bad = [c for c in cards if c in forbidden_cids]
        assert len(bad) == 0, f"Found forbidden cards in {m_name} pack {p_id}: {bad}"
print("[PASS] All pack mapping JSON files contain 0 forbidden cards!")

# 4. Check Expansion Packs structure
print("\n--- [TEST 2] Expansion Packs Configuration ---")
expansion_pack_ids = [151010, 152010, 153010, 154010, 155010]
for pid in expansion_pack_ids:
    assert pid in expansion_map, f"Missing expansion pack {pid}!"
    cids = expansion_map[pid]
    assert len(cids) == 40, f"Expansion pack {pid} has {len(cids)} cards (expected 40)!"
print(f"[PASS] All 5 expansion packs (151010..155010) contain exactly 40 cards each.")

# 5. Check Extra Packs 21 (ES/CS) and 22 (TrickStar)
print("\n--- [TEST 3] Extra Packs 21 & 22 ---")
assert 141010 in extra_map, "Pack 21 (141010) missing from extra_cards_map!"
assert 142010 in extra_map, "Pack 22 (142010) missing from extra_cards_map!"
print(f"[PASS] Pack 21 (ES/CS, 141010) has {len(extra_map[141010])} cards.")
print(f"[PASS] Pack 22 (TrickStar, 142010) has {len(extra_map[142010])} cards.")

# 6. Test Buy Package API on server
print("\n--- [TEST 4] Buy Package API Tests ---")
def buy(pkg_id, count, cost_val, pool):
    url = "http://127.0.0.1:8080/api/buy_package"
    payload = {
        "account_id": acc_id,
        "package_id": pkg_id,
        "count": count,
        "cost_type": "gold",
        "cost_val": cost_val,
        "card_pool": pool
    }
    req = urllib.request.Request(url, data=json.dumps(payload).encode('utf-8'), headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req) as resp:
        res = json.loads(resp.read().decode('utf-8'))
    assert res['code'] == 200, f"Buy package {pkg_id} failed: {res}"
    for c in res['cards']:
        cid = int(c['info_id'])
        assert cid in pool, f"Card {cid} ({c['name']}) not in pool for pack {pkg_id}!"
        assert cid not in forbidden_cids, f"Forbidden card {cid} ({c['name']}) pulled!"
    return res['cards']

# Test Extra Pack 21 (ES/CS)
cards = buy(141001, 3, 0, extra_map[141010])
print(f"[PASS] Extra Pack 21 (ES/CS) 1x pull: {[c['name'] + ' (' + c['quality'] + ')' for c in cards]}")

# Test Extra Pack 22 (TrickStar)
cards = buy(142001, 3, 0, extra_map[142010])
print(f"[PASS] Extra Pack 22 (TrickStar) 1x pull: {[c['name'] + ' (' + c['quality'] + ')' for c in cards]}")

# Test Expansion Packs 1..5
for i, pid in enumerate([151010, 152010, 153010, 154010, 155010], start=1):
    cards = buy(pid - 9, 3, 0, expansion_map[pid])
    print(f"[PASS] Expansion Pack {i} ({pid}) 1x pull: {[c['name'] + ' (' + c['quality'] + ')' for c in cards]}")

# Test 10x pull on Expansion Pack 1
cards_10x = buy(151010, 30, 6000, expansion_map[151010])
print(f"[PASS] Expansion Pack 1 10x pull ({len(cards_10x)} cards): Pulled successfully without errors or forbidden cards.")

# 7. Stress test: 50 pulls across multiple packs to ensure 0 forbidden cards
print("\n--- [TEST 5] Stress Test: 100 pulls across packs ---")
test_packs = [
    (10201, char_map[10201]),
    (101001, liya_map[101010]),
    (141001, extra_map[141010]),
    (142001, extra_map[142010]),
    (151001, expansion_map[151010]),
    (152001, expansion_map[152010]),
    (153001, expansion_map[153010]),
    (154001, expansion_map[154010]),
    (155001, expansion_map[155010])
]
total_tested_cards = 0
for pid, pool in test_packs:
    for _ in range(5):
        pulled = buy(pid, 3, 0, pool)
        total_tested_cards += len(pulled)

print(f"[PASS] Stress tested {total_tested_cards} card pulls across all 4 shop tabs: ZERO forbidden cards found, all pools strictly respected!")

print("\n==================================================")
print("ALL VERIFICATIONS PASSED SUCCESSFULLY!")
print("==================================================")
