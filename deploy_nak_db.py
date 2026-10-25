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

# 1. Update 12336 keyword in card_monsters
cur.execute("UPDATE card_monsters SET keyword = 'liqi' WHERE id = 12336")
print(f"[OK] Updated 12336 in card_monsters: affected rows = {cur.rowcount}")

# 2. Update 40731 keyword in card_extra
cur.execute("UPDATE card_extra SET keyword = 'liqi' WHERE id = 40731")
print(f"[OK] Updated 40731 in card_extra: affected rows = {cur.rowcount}")

# 3. Insert/Update 40745 in card_extra
desc_40745 = (
    '[Chiến Binh - Hiệu Quả - Link]\n'
    '1 quái GR có từ khóa "liqi".\n'
    '(1) Khi vào sân: Nhận được rào chắn Quái vật, Phép thuật, Bẫy.\n'
    '(2) Khi có mặt: Tăng công bằng số lượng bài trên tay x1000.\n'
    '(3) Khi tấn công: Rút 1 lá bài.\n'
    '(4) Khi có mặt: Khóa tất cả quái thú trên sân phe ta ngoại trừ bản thân.\n'
    '(5) Lá bài này có thể tấn công hai lần trong mỗi lượt chiến đấu.'
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
    40745,
    'Nak - Thứ nguyên vệ thần',
    'Link',
    'Chiến Binh',
    'Quang',
    'liqi',
    0,
    0,
    0,
    'UR',
    '["1 quái GR có từ khóa \\"liqi\\""]',
    '[1]',
    'nak',
    desc_40745,
    ''
))
print("[OK] Inserted/Updated card 40745 in card_extra")

conn.commit()

# Verification
cur.execute("SELECT id, name, keyword FROM card_monsters WHERE id = 12336")
print("Verified 12336:", cur.fetchone())
cur.execute("SELECT id, name, keyword FROM card_extra WHERE id = 40731")
print("Verified 40731:", cur.fetchone())
cur.execute("SELECT id, name, summon_type, keyword, quality, atk, def FROM card_extra WHERE id = 40745")
print("Verified 40745:", cur.fetchone())

conn.close()
print("[OK] Database deployment completed successfully!")
