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

target_cards = [
    # 4 Traps
    30598, 30599, 30600, 30601,
    # Labrynth batch 1 & 2
    12371, 12372, 12373, 12374, 12375, 12376, 12377, 12378, 12379, 12380, 12381,
    # Labrynth batch 3
    30602, 30603, 30604, 30605, 21172, 21173
]

with conn.cursor() as cur:
    cur.execute("SELECT id FROM accounts")
    acc_ids = [r[0] for r in cur.fetchall()]
    print(f"Total accounts in DB: {len(acc_ids)}")

    for cid in target_cards:
        # Check how many accounts lack this card
        cur.execute("SELECT count(*) FROM accounts WHERE id NOT IN (SELECT account_id FROM user_cards WHERE card_id = %s)", (cid,))
        missing_count = cur.fetchone()[0]
        if missing_count > 0:
            print(f"Card {cid} is missing in {missing_count} accounts. Granting x3...")
            cur.execute("""
                INSERT INTO user_cards (account_id, card_id, count)
                SELECT id, %s, 3 FROM accounts
                ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
            """, (cid,))
        else:
            print(f"Card {cid} already owned by all accounts.")

    # Explicit check for user accounts
    for uname in ['thaung1232004', 'thang1232004', 'thuy1232004', 'admin', 'ttt2006', 'shiuliuliu']:
        cur.execute("SELECT id FROM accounts WHERE username = %s", (uname,))
        row = cur.fetchone()
        if row:
            uid = row[0]
            cur.execute("SELECT count(*) FROM user_cards WHERE account_id = %s AND card_id IN %s", (uid, tuple(target_cards)))
            cnt = cur.fetchone()[0]
            print(f"Account {uname} (ID {uid}) owns {cnt}/{len(target_cards)} target cards.")

conn.close()
print("Card grant check and update complete!")
