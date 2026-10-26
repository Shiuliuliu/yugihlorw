import re
import pymysql
import sys

sys.stdout.reconfigure(encoding='utf-8')

DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': '',
    'database': 'yugioh_game',
    'charset': 'utf8mb4',
    'autocommit': True
}

def get_all_lua_card_ids(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    matches = re.findall(r'\[(\d+)\]\s*=\s*\{', content)
    return set(int(m) for m in matches)

conn = pymysql.connect(**DB_CONFIG, cursorclass=pymysql.cursors.DictCursor)
with conn.cursor() as cur:
    # 1. Insert 12316 to card_monsters
    cur.execute("""
        INSERT INTO card_monsters (id, name, category, attribute, keyword, stars, atk, def, quality, cost, max_count, pinyin, description, guide)
        VALUES (12316, 'Bát Hoang Huyền Hỏa Long', 'Rồng', 'Hỏa', 'Tru Tiên', 10, 4000, 4000, 'GR', 0, 3, 'bathoang', 'Rồng - hiệu quả - nghi lễ', '0')
        ON DUPLICATE KEY UPDATE name=VALUES(name), category=VALUES(category), attribute=VALUES(attribute), keyword=VALUES(keyword), stars=VALUES(stars), atk=VALUES(atk), def=VALUES(def), quality=VALUES(quality), max_count=VALUES(max_count)
    """)
    print("[1] Updated card_monsters for 12316")

    # 2. Insert 21136, 21137, 21138 to card_spells
    spells = [
        (21136, 'Đồng Vợ Đồng Chồng', 'Thông Thường', 'Tru Tiên', 'UR', 3, 'dvdc', 'Đồng vợ đồng chồng', '0'),
        (21137, 'Vào Sinh Cộng Tử', 'Thông Thường', 'Tru Tiên', 'UR', 3, 'vaosinh', 'Vào sinh cộng tử', '0'),
        (21138, 'Thần Khiển', 'Nghi Lễ', 'Tru Tiên', 'UR', 3, 'thankhien', 'Thần khiển', '0'),
    ]
    for sp in spells:
        cur.execute("""
            INSERT INTO card_spells (id, name, type, keyword, quality, max_count, pinyin, description, guide)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE name=VALUES(name), type=VALUES(type), keyword=VALUES(keyword), quality=VALUES(quality), max_count=VALUES(max_count)
        """, sp)
        print(f"[2] Updated card_spells for {sp[0]}: {sp[1]}")

    # 3. Collect all game card IDs
    monster_ids = get_all_lua_card_ids('web/data/monster.lua')
    magic_ids = get_all_lua_card_ids('web/data/magic.lua')
    trap_ids = get_all_lua_card_ids('web/data/trap.lua')
    all_game_cards = monster_ids | magic_ids | trap_ids
    print(f"[3] Total game cards in data files: {len(all_game_cards)}")

    # 4. Check accounts for shiuliuliu
    cur.execute("SELECT id, username FROM accounts WHERE username LIKE '%shiu%' OR id = 6")
    target_accs = cur.fetchall()
    print("[4] Target accounts:", target_accs)

    for acc in target_accs:
        acc_id = acc['id']
        username = acc['username']
        cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s", (acc_id,))
        owned = {r['card_id']: r['count'] for r in cur.fetchall()}

        missing = [cid for cid in sorted(all_game_cards) if cid not in owned or owned[cid] < 3]
        print(f"Account {acc_id} ({username}): missing or <3 count for {len(missing)} cards.")
        
        batch_inserts = []
        batch_updates = []
        for cid in missing:
            if cid in owned:
                batch_updates.append((3, acc_id, cid))
            else:
                batch_inserts.append((acc_id, cid, 3))

        if batch_inserts:
            cur.executemany("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s)", batch_inserts)
            print(f"  -> Inserted {len(batch_inserts)} new cards (x3).")
        if batch_updates:
            cur.executemany("UPDATE user_cards SET count = %s WHERE account_id = %s AND card_id = %s", batch_updates)
            print(f"  -> Updated {len(batch_updates)} cards to x3.")

        # Verify critical cards
        for test_cid in [12316, 21135, 21136, 21137, 21138]:
            cur.execute("SELECT count FROM user_cards WHERE account_id = %s AND card_id = %s", (acc_id, test_cid))
            r = cur.fetchone()
            print(f"  -> Card {test_cid}: count = {r['count'] if r else 0}")

conn.close()
print("DONE!")
