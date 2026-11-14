import os
import re
import sys
import pymysql

sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True,
    cursorclass=pymysql.cursors.DictCursor
)

username = 'ttt2006'

with conn.cursor() as cur:
    cur.execute('SELECT id, username, character_name FROM accounts WHERE username = %s', (username,))
    acc = cur.fetchone()
    if not acc:
        print(f'ERROR: Account {username} not found!')
        sys.exit(1)
    
    account_id = acc['id']
    char_name = acc['character_name']
    print(f'Found account: {username} (ID: {account_id}, Tên nhân vật: {char_name})')

    all_card_ids = set()

    # 1. Database tables
    for tbl in ['card_monsters', 'card_spells', 'card_traps', 'card_extra']:
        cur.execute(f'SELECT id FROM {tbl}')
        for r in cur.fetchall():
            cid = int(r['id'])
            if 10000 <= cid < 50000:
                all_card_ids.add(cid)

# 2. Lua data tables
for fname in ['monster.lua', 'magic.lua', 'trap.lua', 'rare.lua']:
    fpath = os.path.join(r'D:\yugitauapk\web\data', fname)
    if os.path.exists(fpath):
        txt = open(fpath, encoding='utf-8', errors='ignore').read()
        for m in re.finditer(r'\[(\d+)\]\s*=\s*\{', txt):
            cid = int(m.group(1))
            if 10000 <= cid < 50000:
                all_card_ids.add(cid)

# 3. h5_patch.lua
patch_path = r'D:\yugitauapk\web\src\h5_patch.lua'
if os.path.exists(patch_path):
    txt = open(patch_path, encoding='utf-8', errors='ignore').read()
    for m in re.finditer(r'Data\._(?:monster|magic|trap|rare)Info\[(\d+)\]', txt):
        cid = int(m.group(1))
        if 10000 <= cid < 50000:
            all_card_ids.add(cid)

sorted_cids = sorted(all_card_ids)
print(f'Total unique card IDs collected across DB & Lua: {len(sorted_cids)}')

# Batch insert / update
batch_size = 500
records = [(account_id, cid, 3) for cid in sorted_cids]

with conn.cursor() as cur:
    for i in range(0, len(records), batch_size):
        batch = records[i:i+batch_size]
        cur.executemany('''
            INSERT INTO user_cards (account_id, card_id, count)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE count = VALUES(count)
        ''', batch)
    
    cur.execute('SELECT COUNT(*) as total_cards, SUM(count) as total_copies FROM user_cards WHERE account_id = %s', (account_id,))
    res = cur.fetchone()
    print(f"SUCCESS! User {username} now has {res['total_cards']} unique cards with {res['total_copies']} total copies (all x3).")

    # Breakdown by category
    cur.execute('''
        SELECT 
            SUM(CASE WHEN card_id >= 10000 AND card_id < 20000 THEN 1 ELSE 0 END) as monsters,
            SUM(CASE WHEN card_id >= 20000 AND card_id < 30000 THEN 1 ELSE 0 END) as spells,
            SUM(CASE WHEN card_id >= 30000 AND card_id < 40000 THEN 1 ELSE 0 END) as traps,
            SUM(CASE WHEN card_id >= 40000 AND card_id < 50000 THEN 1 ELSE 0 END) as extra
        FROM user_cards WHERE account_id = %s
    ''', (account_id,))
    bd = cur.fetchone()
    print(f"Breakdown: Quái thú: {bd['monsters']}, Phép: {bd['spells']}, Bẫy: {bd['traps']}, Extra Deck: {bd['extra']}")

conn.close()
