import pymysql

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4'
)
cur = conn.cursor()

# 1. Insert or update card 40743 in card_extra
desc_40743 = (
    '[Chiến Binh - Đồng Bộ - Hiệu Ứng]\n'
    '10058 + 1 quái điều chỉnh.\n'
    '(1) Quái đối phương bị giảm 200 ATK cho mỗi quái tộc Rồng trên sân và trong Mộ 2 bên.\n'
    '(2) Kĩ năng chủ động: 1 lượt 1 lần, bỏ 1 lá bài trên tay, triệu hồi đặc biệt 1 quái có từ khóa "Kiếm Phá Hủy" từ bộ bài lên sân.\n'
    '(3) Khi lá bài này bị phá hủy bởi chiến đấu hoặc hiệu quả, phá hủy tất cả quái tộc rồng trên sân đối phương (xuyên qua khiên bảo vệ).'
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
    40743,
    'Kiếm sĩ diệt rồng huyền thoại',
    'Đồng Bộ',
    'Chiến Binh',
    'Quang',
    'Kiếm Sĩ Diệt Rồng, Kiếm Phá Hủy',
    8,
    2800,
    2500,
    'UR',
    '["10058", "1 quái điều chỉnh"]',
    '[0]',
    'ksdrht',
    desc_40743,
    ''
))
print("Inserted/Updated card 40743 in card_extra")

# Also ensure 40742 in card_extra has correct keyword and materials
cur.execute("""
UPDATE card_extra SET keyword = 'Amazon, Harpie', materials = '["10084", "3006"]' WHERE id = 40742
""")
print("Verified card 40742 in card_extra")

# 2. Grant 3 copies of card 40743 to all accounts that have card 40742 or cards in user_cards
cur.execute("""
INSERT INTO user_cards (account_id, card_id, count)
SELECT DISTINCT account_id, 40743, 3 FROM user_cards WHERE card_id = 40742
ON DUPLICATE KEY UPDATE count = 3
""")
print(f"Granted 40743 to {cur.rowcount} accounts based on 40742")

conn.commit()
conn.close()
print("Database update completed!")
