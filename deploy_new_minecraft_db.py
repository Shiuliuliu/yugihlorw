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

# 1. Insert/Update card_monsters: 12339 (Ender Dragon) & 12340 (Trung rong ender)
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
    12339,
    'Ender Dragon',
    'Rồng',
    'Ám',
    'minecraft',
    10,
    4500,
    4500,
    'GR',
    0,
    3,
    'enderdragon',
    '[Rồng / Hiệu Ứng]\n+ Nguyên tố tương tác (3043): Miễn nhiễm quái thú, phép và bẫy.\n+ Trong Mộ phe ta có từ 5 quái có từ khóa "minecraft" trở lên có thể triệu hồi đặc biệt lá bài này từ tay.\n+ Khi lá bài này bị phá hủy, phe ta tăng LP bằng tổng tấn công quái thú trên sân đối phương.',
    ''
))
print("[OK] Inserted/Updated card 12339 (Ender Dragon) in card_monsters")

cur.execute(sql_mon, (
    12340,
    'Trứng rồng ender',
    'Rồng',
    'Ám',
    'minecraft',
    1,
    0,
    0,
    'UR',
    0,
    3,
    'trungrongender',
    '[Rồng / Hiệu Ứng]\n+ Khiên chắn phá hủy (12006): Không thể bị tiêu diệt trong chiến đấu hoặc bởi hiệu ứng.\n+ Kĩ năng chủ động (1 lượt 1 lần): Đưa lá bài này vào Mộ, chọn triệu hồi đặc biệt 1 <Ender Dragon> từ trong Bộ bài, Bài trên tay hoặc Mộ bài lên sân. Sau đó trong lượt này phe ta chỉ có thể triệu hồi đặc biệt quái có từ khóa "minecraft".',
    ''
))
print("[OK] Inserted/Updated card 12340 (Trứng rồng ender) in card_monsters")

# 2. Insert/Update card_spells: 21148 (Command Block) & 21149 (Tao vang duoc phu phep)
sql_spell = """
INSERT INTO card_spells (id, name, type, keyword, quality, max_count, pinyin, description, guide)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE
    name=VALUES(name),
    type=VALUES(type),
    keyword=VALUES(keyword),
    quality=VALUES(quality),
    max_count=VALUES(max_count),
    pinyin=VALUES(pinyin),
    description=VALUES(description),
    guide=VALUES(guide)
"""

cur.execute(sql_spell, (
    21148,
    'Command Block',
    'Thông Thường',
    'minecraft',
    'UR',
    3,
    'commandblock',
    '[Phép Thường]\nLấy 1 lá bài có từ khóa "minecraft" từ Mộ hoặc Bộ bài lên tay.',
    ''
))
print("[OK] Inserted/Updated card 21148 (Command Block) in card_spells")

cur.execute(sql_spell, (
    21149,
    'Táo vàng được phù phép',
    'Thông Thường',
    'minecraft',
    'UR',
    3,
    'taovang',
    '[Phép Thường]\n+ Phe ta nhận 3000 LP, nếu LP phe ta thấp hơn 8000 sẽ cộng thêm LP để LP bằng 8000.\n+ Khi bài này trong Mộ, mỗi lượt tăng 400 LP cho phe ta (14797).\n+ Nguồn thanh tẩy (9232): Khi chịu sát thương hiệu ứng hoặc sát thương trực tiếp, đưa lá bài này từ tay vào Mộ để vô hiệu hóa và hồi LP tương ứng.',
    ''
))
print("[OK] Inserted/Updated card 21149 (Táo vàng được phù phép) in card_spells")

# 3. Insert/Update card_traps: 30596 (Totem)
sql_trap = """
INSERT INTO card_traps (id, name, type, keyword, quality, max_count, pinyin, description, guide)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE
    name=VALUES(name),
    type=VALUES(type),
    keyword=VALUES(keyword),
    quality=VALUES(quality),
    max_count=VALUES(max_count),
    pinyin=VALUES(pinyin),
    description=VALUES(description),
    guide=VALUES(guide)
"""

cur.execute(sql_trap, (
    30596,
    'Totem',
    'Thông Thường',
    'minecraft',
    'UR',
    3,
    'totem',
    '[Bẫy Thường]\n+ 1 lượt 1 lần, khi quái có từ khóa "minecraft" trên sân phe ta bị phá hủy sẽ kích hoạt, bỏ qua 1 lần bị phá hủy.\n+ 1 lượt 1 lần, khi lá bài này trên tay, quái thú đối phương tấn công trực tiếp và điểm tấn công của quái đối phương lớn hơn hoặc bằng điểm LP phe ta sẽ kích hoạt: Đưa lá bài này vào Mộ, phe ta nhận 1 tầng "Khiên Sinh Mệnh" trong lượt này và 1000 LP.',
    ''
))
print("[OK] Inserted/Updated card 30596 (Totem) in card_traps")

# 4. Grant x3 to Shiuliuliu accounts
shiuliuliu_accounts = [6, 640, 1454, 10002550]
new_card_ids = [12339, 12340, 21148, 21149, 30596]

for card_id in new_card_ids:
    for acc in shiuliuliu_accounts:
        cur.execute("SELECT id, count FROM user_cards WHERE account_id = %s AND card_id = %s", (acc, card_id))
        row = cur.fetchone()
        if row:
            cur.execute("UPDATE user_cards SET count = 3 WHERE id = %s", (row['id'],))
        else:
            cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, 3)", (acc, card_id))
    print(f"[OK] Granted 3x card {card_id} to accounts: {shiuliuliu_accounts}")

# 5. Verify
print("\n--- Verifying Card Records in DB ---")
cur.execute("SELECT id, name, category, attribute, keyword, stars, quality, atk, def FROM card_monsters WHERE id IN (12339, 12340)")
for r in cur.fetchall():
    print("Monster:", r)

cur.execute("SELECT id, name, type, keyword, quality FROM card_spells WHERE id IN (21148, 21149)")
for r in cur.fetchall():
    print("Spell:", r)

cur.execute("SELECT id, name, type, keyword, quality FROM card_traps WHERE id = 30596")
for r in cur.fetchall():
    print("Trap:", r)

cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id IN (12339, 12340, 21148, 21149, 30596)")
print("Granted user_cards rows count:", len(cur.fetchall()))

conn.close()
