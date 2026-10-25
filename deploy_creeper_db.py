import pymysql
import sys

sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True
)
cur = conn.cursor(pymysql.cursors.DictCursor)

# 1. Insert/Update card_monsters
sql_mon = """
INSERT INTO card_monsters (id, name, category, attribute, keyword, stars, atk, def, quality, cost, max_count, pinyin, description, guide)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE
    name=VALUES(name),
    category=VALUES(category),
    attribute=VALUES(attribute),
    keyword=VALUES(keyword),
    stars=VALUES(stars),
    atk=VALUES(atk),
    def=VALUES(def),
    quality=VALUES(quality),
    cost=VALUES(cost),
    max_count=VALUES(max_count),
    pinyin=VALUES(pinyin),
    description=VALUES(description),
    guide=VALUES(guide)
"""

cur.execute(sql_mon, (
    12337,
    'Creeper',
    'Xác Sống',
    'Ám',
    'minecraft',
    3,
    1200,
    1000,
    'SR',
    0,
    3,
    'creeper',
    '[Xác Sống - Hiệu Ứng]\nKhi lá bài này trên sân, đối phương triệu hồi quái sẽ kích hoạt: phá hủy bản thân và lá bài đối phương vừa triệu hồi. Trong lượt này, ô quái thú đối phương vừa bị phá hủy sẽ không thể đặt quái.',
    ''
))
print("[OK] Inserted/Updated card 12337 (Creeper) in card_monsters")

# 2. Grant x3 to Shiuliuliu accounts
shiuliuliu_accounts = [6, 640, 1454, 10002550]
for acc in shiuliuliu_accounts:
    cur.execute("SELECT id, count FROM user_cards WHERE account_id = %s AND card_id = 12337", (acc,))
    row = cur.fetchone()
    if row:
        cur.execute("UPDATE user_cards SET count = 3 WHERE id = %s", (row['id'],))
    else:
        cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, 12337, 3)", (acc,))
print(f"[OK] Granted 3x Creeper (12337) to accounts: {shiuliuliu_accounts}")

# 3. Verification
cur.execute("SELECT id, name, category, attribute, keyword, stars, quality, atk, def FROM card_monsters WHERE id = 12337")
print("card_monsters row:", cur.fetchone())

cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id = 12337")
print("user_cards rows:", cur.fetchall())

conn.close()
