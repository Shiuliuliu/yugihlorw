import sys
sys.stdout.reconfigure(encoding='utf-8')
import urllib.request
import json

test_packs = [
    (10201, 1, 'Char Pack 1 (Blue-Eyes)'),
    (12101, 1, 'Char Pack 20 (Amazoness)'),
    (101010, 1, 'Liya Pack 1'),
    (120010, 1, 'Liya Pack 20'),
    (121010, 1, 'Extra Pack 1 (X-Saber)'),
    (143010, 1, 'Extra Pack 23 (Mecha Phantom Beast)'),
    (174010, 1, 'Extra Pack 54 (Fairy Tail)'),
    (181010, 1, 'Expansion Pack 1 (Monsters I)'),
    (195010, 1, 'Expansion Pack 15 (Spells V)'),
    (210010, 1, 'Expansion Pack 30 (Traps X)')
]

print("=== RUNNING LIVE HTTP PURCHASE TESTS ===")
for pkg, cnt, name in test_packs:
    payload = json.dumps({
        'account_id': 10001000,
        'pkg_num': pkg,
        'count': cnt,
        'cost_type': 'gold'
    }).encode('utf-8')
    req = urllib.request.Request('http://127.0.0.1:8080/api/buy_package', data=payload, headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req) as resp:
        d = json.loads(resp.read().decode('utf-8'))
        code = d.get('code')
        cards = d.get('cards', [])
        sample_card = cards[0]['name'] if cards else 'None'
        print(f"[{code}] {name} (ID {pkg}): drawn {len(cards)} cards -> '{sample_card}'")
        assert code == 200, f"Purchase failed for {name}"
        assert len(cards) == cnt * 3, f"Card count mismatch for {name}"

print("\n=== ALL LIVE HTTP TESTS SUCCEEDED! ===")
