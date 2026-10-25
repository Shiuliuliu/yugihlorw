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

# 1. Insert/Update card_extra: Wither (40748)
sql_extra = """
INSERT INTO card_extra (id, name, summon_type, category, attribute, keyword, stars, atk, def, quality, materials, link_arrows, pinyin, description, guide)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE
    name=VALUES(name),
    summon_type=VALUES(summon_type),
    category=VALUES(category),
    attribute=VALUES(attribute),
    keyword=VALUES(keyword),
    stars=VALUES(stars),
    atk=VALUES(atk),
    def=VALUES(def),
    quality=VALUES(quality),
    materials=VALUES(materials),
    link_arrows=VALUES(link_arrows),
    pinyin=VALUES(pinyin),
    description=VALUES(description),
    guide=VALUES(guide)
"""

cur.execute(sql_extra, (
    40748,
    'Wither',
    'Link',
    'Xác Sống',
    'Ám',
    'minecraft',
    0,
    3000,
    0,
    'UR',
    '[304, 304]',
    '[1, 2, 3]',
    'wither',
    '[Xác Sống / Link 3 / Hiệu Ứng]\n2 quái thú có từ khóa "minecraft" trở lên\n+ Không thể bị hiệu quả phá hủy (12007).\n+ Khi lá bài này trên sân, ngoại trừ quái tộc "Xác Sống", tất cả quái trên sân 2 bên bị giảm 1 nửa ATK (xuyên qua tường chắn quái).',
    ''
))
print("[OK] Inserted/Updated card 40748 (Wither) in card_extra")

# 2. Grant x3 to Shiuliuliu accounts
shiuliuliu_accounts = [6, 640, 1454, 10002550]
for acc in shiuliuliu_accounts:
    cur.execute("SELECT id, count FROM user_cards WHERE account_id = %s AND card_id = 40748", (acc,))
    row = cur.fetchone()
    if row:
        cur.execute("UPDATE user_cards SET count = 3 WHERE id = %s", (row['id'],))
    else:
        cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, 40748, 3)", (acc,))
print(f"[OK] Granted 3x Wither (40748) to accounts: {shiuliuliu_accounts}")

# 3. Verify
cur.execute("SELECT id, name, summon_type, category, attribute, keyword, stars, quality, atk, def, link_arrows FROM card_extra WHERE id = 40748")
print("card_extra row:", cur.fetchone())

cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id = 40748")
print("user_cards rows:", cur.fetchall())

conn.close()
