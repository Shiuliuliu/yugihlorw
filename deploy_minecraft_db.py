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

# 1. Insert/Update card_extra: Skeleton (40747)
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
    40747,
    'Skeleton',
    'Synchro',
    'Xác Sống',
    'Thổ',
    'minecraft',
    4,
    1600,
    0,
    'SR',
    '[5008, 6008]',
    None,
    'skeleton',
    '[Xác Sống / Đồng Bộ / Hiệu Ứng]\nKĩ năng chủ động bộ bài thêm (1 lượt tối đa 3 lần): Chọn loại bỏ 1 quái có từ khóa "minecraft" trong Mộ phe ta, triệu hồi đặc biệt lá bài này lên sân.',
    ''
))
print("[OK] Inserted/Updated card 40747 (Skeleton) in card_extra")

# 2. Insert/Update card_monsters: Enderman (12338)
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
    12338,
    'Enderman',
    'Ác Quỷ',
    'Ám',
    'minecraft',
    6,
    2000,
    1000,
    'SR',
    0,
    3,
    'enderman',
    '[Ác Quỷ / Hiệu Ứng]\n+ Không thể bị hiệu quả phá hủy (12007).\n+ Khi trên sân phe ta không có quái hoặc có quái có từ khóa "minecraft", có thể triệu hồi đặc biệt lá bài này từ tay.\n+ 1 lượt 1 lần, khi lên sân: Ngẫu nhiên lấy 1 lá bài trên tay đối phương cho vào tay phe ta.',
    ''
))
print("[OK] Inserted/Updated card 12338 (Enderman) in card_monsters")

# 3. Grant x3 to Shiuliuliu accounts
shiuliuliu_accounts = [6, 640, 1454, 10002550]
for card_id in [40747, 12338]:
    for acc in shiuliuliu_accounts:
        cur.execute("SELECT id, count FROM user_cards WHERE account_id = %s AND card_id = %s", (acc, card_id))
        row = cur.fetchone()
        if row:
            cur.execute("UPDATE user_cards SET count = 3 WHERE id = %s", (row['id'],))
        else:
            cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, 3)", (acc, card_id))
    print(f"[OK] Granted 3x card {card_id} to accounts: {shiuliuliu_accounts}")

# 4. Verify
cur.execute("SELECT id, name, summon_type, category, attribute, keyword, stars, atk, def FROM card_extra WHERE id = 40747")
print("card_extra row:", cur.fetchone())

cur.execute("SELECT id, name, category, attribute, keyword, stars, quality, atk, def FROM card_monsters WHERE id = 12338")
print("card_monsters row:", cur.fetchone())

cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id IN (40747, 12338)")
print("user_cards rows:", cur.fetchall())

conn.close()
