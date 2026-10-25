import pymysql, sys
sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4'
)
cur = conn.cursor()

desc_40746 = (
    '[Chiến Binh - Hiệu Quả - Link]\n'
    '2 quái trở lên, trong đó gồm 1 quái có từ khóa "Kiếm phá hủy".\n'
    '(1) Mỗi lượt chỉ 1 lần. Khi bài này nằm trong bộ bài thêm; trên sân phe ta không có quái hoặc trên sân phe ta chỉ có quái có từ khóa “Kiếm sĩ diệt rồng”; đồng thời đối thủ Triệu Hồi Đặc Biệt quái tộc "rồng" sẽ có thể dùng. Hi sinh bản thân bài này; khi bài này nằm trong mộ; loại bỏ bài của đối thủ bị đưa vào mộ từ trên sân.\n'
    '(2) 1 lượt 1 lần, Khi lá bài này được triệu hồi lên sân, ngẫu nhiên loại bỏ tối đa 2 quái tộc "rồng" trong bộ bài thêm đối thủ.\n'
    '(3) Kẻ Diệt Rồng: Tăng ATK/DEF theo số lượng quái tộc Rồng trên sân và mộ đối thủ x1000.\n'
    '(4) Lá Chắn Năng Lượng: Khi được Triệu Hồi Đặc Biệt, nhận Khiên Quái, Phép, Bẫy.\n'
    '(5) 1 lượt 1 lần, khi lá bài này trên sân, đối phương triệu hồi/triệu hồi đặc biệt quái tộc "rồng" sẽ kích hoạt, đưa quái đó vào mộ (Xuyên qua tường chắn quái), sau đó lượt này đối phương không thể triệu hồi/triệu hồi đặc biệt quái tộc "rồng".\n'
    '(6) Khi quái đối thủ rời sân trong lượt đối thủ: đối thủ không thể triệu hồi thông thường hoặc Triệu Hồi Đặc Biệt quái tộc "rồng" ở lượt này. Tất cả Quái Vật tộc "rồng" của đối thủ không thể tấn công . đưa tất cả quái tộc "rồng" trên tay đối phương vào mộ.'
)

sql = """
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

cur.execute(sql, (
    40746,
    'Kỵ sĩ diệt rồng',
    'Link',
    'Chiến Binh',
    'Địa',
    'Kiếm phá hủy',
    0,
    2900,
    0,
    'UR',
    '["2 quái trở lên, trong đó gồm 1 quái có từ khóa \\"Kiếm phá hủy\\""]',
    '[1, 2, 7, 8]',
    'ksdr',
    desc_40746,
    ''
))
print("[OK] Inserted/Updated card 40746 in card_extra")

# Grant card 40746 to test account 6
grant_sql = """
INSERT INTO user_cards (account_id, card_id, count)
VALUES (6, 40746, 3)
ON DUPLICATE KEY UPDATE count = 3
"""
cur.execute(grant_sql)
print("[OK] Granted 3 copies of card 40746 to account 6")

conn.commit()

# Verify
cur.execute("SELECT id, name, summon_type, keyword, quality, atk, def FROM card_extra WHERE id = 40746")
print("Verified card 40746 in DB:", cur.fetchone())

conn.close()
print("[OK] DB operations completed successfully!")
