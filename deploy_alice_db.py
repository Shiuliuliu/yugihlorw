import pymysql
import sys
sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4'
)
cur = conn.cursor()

sql = """
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

cur.execute(sql, (
    12336,
    'Sucs vat Alice',
    'Phù Thủy',
    'Quang',
    'Không có',
    3,
    300,
    100,
    'GR',
    0,
    3,
    'sucvatalice',
    '[Phù Thủy / Thường / Điều Chỉnh]',
    ''
))
conn.commit()
print("[OK] Inserted/Updated card 12336 into card_monsters")

cur.execute("SELECT * FROM card_monsters WHERE id = 12336")
row = cur.fetchone()
print(f"Verified row: {row}")

conn.close()
