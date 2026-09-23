import sys
sys.stdout.reconfigure(encoding='utf-8')
import urllib.request
import json
import pymysql

# 1. Connect to DB to get a test account
conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
cursor = conn.cursor()
cursor.execute("SELECT id, username, gold FROM accounts WHERE gold > 1000000 LIMIT 1")
test_acc = cursor.fetchone()
acc_id = test_acc['id']
print(f"Using test account: id={acc_id} ({test_acc['username']}) with {test_acc['gold']} gold")

with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    summary = json.load(f)

# Load forbidden IDs
forbidden_cids = {20804, 20805, 20806, 20807, 20808, 20809, 20810, 30439, 11309}

def test_pack(pkg_id, expected_name, allowed_cids, cost_type='gold'):
    url = "http://127.0.0.1:8080/api/buy_package"
    payload = {
        "account_id": acc_id,
        "package_id": pkg_id,
        "count": 3, # 1 pack = 3 cards
        "cost_type": cost_type,
        "cost_val": 0,
        "card_pool": allowed_cids
    }
    req = urllib.request.Request(url, data=json.dumps(payload).encode('utf-8'), headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req) as resp:
        res = json.loads(resp.read().decode('utf-8'))
    
    assert res['code'] == 200, f"Failed buy_package: {res}"
    cards = res['cards']
    assert len(cards) == 3, f"Expected 3 cards, got {len(cards)}"
    
    for c in cards:
        cid = int(c['info_id'])
        assert cid in allowed_cids, f"ILLEGAL CARD! Card {cid} ({c['name']}) not in {expected_name} pool!"
        assert cid not in forbidden_cids, f"FORBIDDEN CARD {cid} ({c['name']}) found in pull!"
    
    return [c['name'] + f" [{c['quality']}]" for c in cards]

print("\n--- Testing Character Packs ---")
for p in summary['char_packs'][:3] + [summary['char_packs'][3]] + [summary['char_packs'][-1]]:
    val = p['value']
    names = test_pack(val, p['name'], p['cards'])
    print(f"Pack {p['num']} ({p['name']}) [id={val}]: Pulled {names}")

print("\n--- Testing Liya Packs ---")
for p in summary['liya_packs'][:3] + [summary['liya_packs'][-1]]:
    val = p['value'] # e.g. 101010 -> x1 is 101001
    prefix = (val // 1000) * 1000
    names = test_pack(prefix + 1, p['name'], p['cards'])
    print(f"Pack {p['num']} ({p['name']}) [id={prefix+1}]: Pulled {names}")

print("\n--- Testing Extra Packs ---")
for p in summary['extra_packs'][:3] + [summary['extra_packs'][-1]]:
    val = p['value'] # e.g. 121010 -> x1 is 121001
    prefix = (val // 1000) * 1000
    names = test_pack(prefix + 1, p['name'], p['cards'])
    print(f"Pack {p['num']} ({p['name']}) [id={prefix+1}]: Pulled {names}")

print("\n--- Testing 10x and 50x Packs ---")
# 10x pack (30 cards) for Red-Eyes (10310)
payload_10x = {
    "account_id": acc_id,
    "package_id": 10310,
    "count": 30,
    "cost_type": "gold",
    "cost_val": 4500,
    "card_pool": summary['char_packs'][1]['cards']
}
req = urllib.request.Request("http://127.0.0.1:8080/api/buy_package", data=json.dumps(payload_10x).encode('utf-8'), headers={'Content-Type': 'application/json'})
with urllib.request.urlopen(req) as resp:
    res = json.loads(resp.read().decode('utf-8'))
assert len(res['cards']) == 30
allowed = set(summary['char_packs'][1]['cards'])
for c in res['cards']:
    assert int(c['info_id']) in allowed

print(f"10x Red-Eyes pack: 30 cards pulled, 100% Red-Eyes archetype cards verified!")

# 50x pack (150 cards) for Extra pack 1 (Thunder Dragon: 121050)
payload_50x = {
    "account_id": acc_id,
    "package_id": 121050,
    "count": 150,
    "cost_type": "gold",
    "cost_val": 28500,
    "card_pool": summary['extra_packs'][0]['cards']
}
req = urllib.request.Request("http://127.0.0.1:8080/api/buy_package", data=json.dumps(payload_50x).encode('utf-8'), headers={'Content-Type': 'application/json'})
with urllib.request.urlopen(req) as resp:
    res = json.loads(resp.read().decode('utf-8'))
assert len(res['cards']) == 150
allowed = set(summary['extra_packs'][0]['cards'])
for c in res['cards']:
    assert int(c['info_id']) in allowed

print(f"50x Thunder Dragon pack: 150 cards pulled, 100% Thunder Dragon archetype cards verified!")
print("\nALL VERIFICATION TESTS PASSED SUCCESSFULLY!")
