# -*- coding: utf-8 -*-
import pymysql

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True
)

with conn.cursor() as cur:
    sql_extra = """
    INSERT INTO card_extra (id, name, summon_type, category, attribute, keyword, stars, atk, def, quality, materials, link_arrows, pinyin, description, guide)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ON DUPLICATE KEY UPDATE
        name=VALUES(name), summon_type=VALUES(summon_type), category=VALUES(category), attribute=VALUES(attribute),
        keyword=VALUES(keyword), stars=VALUES(stars), atk=VALUES(atk), def=VALUES(def), quality=VALUES(quality),
        materials=VALUES(materials), link_arrows=VALUES(link_arrows), pinyin=VALUES(pinyin), description=VALUES(description), guide=VALUES(guide)
    """
    cur.execute(sql_extra, (
        40782, "Heino x Dolia", "Dung Hợp", "Phù Thủy", "Quang", "liqi", 8, 2800, 2600, "UR",
        "[12388, 12387]", "[]", "heinoxdolia",
        '[Phù Thủy / Dung Hợp / Hiệu Ứng / UR]\nThuộc tính: Quang | 8 Sao\nTừ khóa: "liqi"\nATK: 2800 | DEF: 2600', ''
    ))
    print("[OK] card_extra updated with 40782.")

    # Grant cards (12387, 12388, 40782)
    cur.execute("SELECT id FROM accounts")
    acc_ids = [r[0] for r in cur.fetchall()]
    batch_size = 500
    for i in range(0, len(acc_ids), batch_size):
        batch = acc_ids[i:i + batch_size]
        records = []
        for aid in batch:
            records.append((aid, 12387, 3))
            records.append((aid, 12388, 3))
            records.append((aid, 40782, 3))
        cur.executemany("""
            INSERT INTO user_cards (account_id, card_id, count)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
        """, records)
    print(f"[OK] Granted 3x cards (12387, 12388, 40782) to {len(acc_ids)} accounts in user_cards.")

conn.close()
