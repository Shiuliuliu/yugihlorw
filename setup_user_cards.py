import pymysql, sys

sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(
    host='localhost',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True
)

create_table_sql = """
CREATE TABLE IF NOT EXISTS `user_cards` (
  `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Mã bản ghi',
  `account_id` INT NOT NULL COMMENT 'ID tài khoản sở hữu',
  `card_id` INT NOT NULL COMMENT 'Mã ID thẻ bài',
  `count` INT NOT NULL DEFAULT 1 COMMENT 'Số lượng sở hữu (1-3)',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Thời gian nhận',
  KEY `idx_acc` (`account_id`),
  KEY `idx_card` (`card_id`),
  UNIQUE KEY `uk_acc_card` (`account_id`, `card_id`),
  CONSTRAINT `fk_user_cards_acc` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Kho thẻ bài sở hữu của người chơi';
"""

with conn.cursor() as cursor:
    cursor.execute(create_table_sql)
    print("Table `user_cards` created successfully!")
    
    # Check if user_cards already has data
    cursor.execute("SELECT COUNT(*) FROM `user_cards`")
    cnt = cursor.fetchone()[0]
    if cnt == 0:
        print("Seeding starter cards for accounts...")
        # Admin gets a rich collection: top monsters, spells, traps, extra
        cursor.execute("SELECT id FROM card_monsters WHERE quality IN ('UR', 'SR') LIMIT 150")
        monsters = [r[0] for r in cursor.fetchall()]
        
        cursor.execute("SELECT id FROM card_spells WHERE quality IN ('UR', 'SR') LIMIT 60")
        spells = [r[0] for r in cursor.fetchall()]
        
        cursor.execute("SELECT id FROM card_traps WHERE quality IN ('UR', 'SR') LIMIT 40")
        traps = [r[0] for r in cursor.fetchall()]
        
        cursor.execute("SELECT id FROM card_extra LIMIT 50")
        extra = [r[0] for r in cursor.fetchall()]
        
        admin_cards = monsters + spells + traps + extra
        insert_rows = []
        for cid in admin_cards:
            insert_rows.append((1, cid, 3)) # admin gets 3 copies
            
        # Kaiba: Blue-Eyes themed
        cursor.execute("SELECT id FROM card_monsters WHERE keyword = 'Mắt Xanh' OR id IN (10001, 10002, 10008, 10009, 10010, 10011)")
        kaiba_monsters = [r[0] for r in cursor.fetchall()]
        cursor.execute("SELECT id FROM card_spells WHERE id IN (20005, 20030, 20051, 20001, 20007)")
        kaiba_spells = [r[0] for r in cursor.fetchall()]
        cursor.execute("SELECT id FROM card_traps WHERE id IN (30001, 30002, 30004, 30006, 30012)")
        kaiba_traps = [r[0] for r in cursor.fetchall()]
        cursor.execute("SELECT id FROM card_extra WHERE id IN (40001, 40011, 40012, 40148, 40301)")
        kaiba_extra = [r[0] for r in cursor.fetchall()]
        for cid in set(kaiba_monsters + kaiba_spells + kaiba_traps + kaiba_extra):
            insert_rows.append((2, cid, 3))
            
        # Joey: Red-Eyes themed
        cursor.execute("SELECT id FROM card_monsters WHERE keyword = 'Mắt Đỏ' OR id IN (10003, 10007, 10016, 10018, 10020, 10040, 10055, 10056)")
        joey_monsters = [r[0] for r in cursor.fetchall()]
        for cid in set(joey_monsters + kaiba_spells + kaiba_traps):
            insert_rows.append((3, cid, 3))
            
        # Player 1: Starter collection
        cursor.execute("SELECT id FROM card_monsters WHERE quality = 'R' LIMIT 30")
        p1_monsters = [r[0] for r in cursor.fetchall()]
        cursor.execute("SELECT id FROM card_spells WHERE quality = 'R' LIMIT 15")
        p1_spells = [r[0] for r in cursor.fetchall()]
        cursor.execute("SELECT id FROM card_traps WHERE quality = 'R' LIMIT 10")
        p1_traps = [r[0] for r in cursor.fetchall()]
        for cid in set(p1_monsters + p1_spells + p1_traps + [10001, 20005, 30001]):
            insert_rows.append((4, cid, 2))
            
        cursor.executemany("INSERT IGNORE INTO `user_cards` (`account_id`, `card_id`, `count`) VALUES (%s, %s, %s)", insert_rows)
        print(f"Seeded {len(insert_rows)} card entries into `user_cards`!")
    else:
        print(f"`user_cards` already contains {cnt} cards.")
        
conn.close()
