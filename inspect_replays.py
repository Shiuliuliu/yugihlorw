import pymysql
import json
import sys

sys.stdout.reconfigure(encoding='utf-8')
conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game')
cur = conn.cursor(pymysql.cursors.DictCursor)
cur.execute('SELECT id, replay_id, account_id, opponent_name, replay_data FROM match_replays ORDER BY id DESC LIMIT 5')
for r in cur.fetchall():
    rid = r['replay_id']
    opp = r['opponent_name']
    acc = r['account_id']
    print(f"\n=== Replay {rid}: Account {acc} vs {opp} ===")
    try:
        data = json.loads(r['replay_data'])
        p = data.get('player', {})
        o = data.get('opponent', {})
        print("  root keys:", list(data.keys()))
        print("  player keys:", list(p.keys()))
        print("  player _usedCards sample:", (p.get('_usedCards') or [])[:20])
        print("  opponent _usedCards sample:", (o.get('_usedCards') or [])[:20])
        print("  isAttacker in data:", data.get('isAttacker'), "_isAttacker in data:", data.get('_isAttacker'))
        print("  isAttacker in player:", p.get('isAttacker'), p.get('_isAttacker'))
        print("  isAttacker in opponent:", o.get('isAttacker'), o.get('_isAttacker'))
    except Exception as e:
        print("  Error parsing json:", e)
