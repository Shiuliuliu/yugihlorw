import pymysql

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4'
)
cur = conn.cursor()

# 1. Insert or update card 40744 in card_extra
desc_40744 = (
    '[Chiến Binh - Hiệu Quả - Link]\n'
    '1 quái có từ khóa "Kiếm hủy diệt" hoặc "Kiếm sĩ diệt rồng".\n'
    '(Lá bài này luôn có từ khóa "Kiếm hủy diệt" và "Kiếm sĩ diệt rồng".)\n'
    '(1) Kĩ năng chủ động bộ bài thêm: Chọn 1 quái tộc "rồng" trên sân đối phương đưa vào mộ, sau đó triệu hồi đặc biệt bài này lên sân phe ta (xuyên qua tường chắn quái).\n'
    '(2) Kĩ năng chủ động (1 lượt 1 lần): Chọn lấy tối đa 2 quái thú có từ khóa "Kiếm hủy diệt" từ bộ bài lên tay.\n'
    '(3) Kĩ năng chủ động (1 lượt 1 lần): Hy sinh bản thân, chọn triệu hồi đặc biệt 1 quái có từ khóa "Kiếm sĩ diệt rồng" trong bộ bài phe ta.'
)

sql_insert = """
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

cur.execute(sql_insert, (
    40744,
    'Kiếm sĩ diệt rồng tập sự',
    'Link',
    'Chiến Binh',
    'Địa',
    'Kiếm Sĩ Diệt Rồng, Kiếm Hủy Diệt',
    0,
    1800,
    0,
    'UR',
    '["1 quái có từ khóa \\"Kiếm hủy diệt\\" hoặc \\"Kiếm sĩ diệt rồng\\""]',
    '[1]',
    'ksdrts',
    desc_40744,
    ''
))
print("[OK] Inserted/Updated card 40744 in card_extra")

# 2. Grant x3 copies of 40744 ONLY to "Shiuliuliu" (account_id = 6)
# First verify account 6
cur.execute("SELECT id, username, character_name FROM accounts WHERE id = 6")
acc = cur.fetchone()
print(f"Target account: {acc}")

# Insert or update 3 copies for account 6
cur.execute("""
INSERT INTO user_cards (account_id, card_id, count)
VALUES (6, 40744, 3)
ON DUPLICATE KEY UPDATE count = 3
""")
print(f"[OK] Granted 3 copies of card 40744 to account id {acc[0]} ({acc[1]})")

# Ensure no other account has 40744 ("chỉ thêm x3 lá này cho 'Shiuliuliu'")
cur.execute("DELETE FROM user_cards WHERE card_id = 40744 AND account_id != 6")
if cur.rowcount > 0:
    print(f"Removed 40744 from {cur.rowcount} unauthorized accounts")

conn.commit()

# Verify user_cards for 40744
cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id = 40744")
rows = cur.fetchall()
print(f"Verification - Accounts with card 40744: {rows}")

conn.close()
print("[OK] Database deployment completed!")
