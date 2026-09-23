import sys
sys.stdout.reconfigure(encoding='utf-8')
import pymysql
import json

with open('pack_quality_distribution.json', 'r', encoding='utf-8') as f:
    pack_dist = json.load(f)

card_new_quality = {}
for val, p in pack_dist.items():
    for cid in p.get('N', []):
        card_new_quality[cid] = 'N'
    for cid in p.get('R', []):
        card_new_quality[cid] = 'R'
    for cid in p.get('SR', []):
        card_new_quality[cid] = 'SR'
    for cid in p.get('UR', []):
        card_new_quality[cid] = 'UR'
    for cid in p.get('UR_ANCIENT', []):
        card_new_quality[cid] = 'UR'
    for cid in p.get('GR', []):
        card_new_quality[cid] = 'GR'

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', autocommit=True)
cursor = conn.cursor()

updated = 0
for table in ['card_monsters', 'card_spells', 'card_traps', 'card_extra']:
    for cid, q in card_new_quality.items():
        res = cursor.execute(f"UPDATE {table} SET quality = %s WHERE id = %s;", (q, cid))
        if res > 0:
            updated += 1

print(f"Updated {updated} card records in database across tables.")
