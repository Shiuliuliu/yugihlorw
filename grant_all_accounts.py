import pymysql
import sys

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Granting 4 Trap cards (30598..30601) & 11 Labrynth cards (12371..12381) to ALL accounts in database...")

conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True
)

cards_to_grant = [30598, 30599, 30600, 30601] + list(range(12371, 12382))

with conn.cursor() as cur:
    cur.execute("SELECT id FROM accounts")
    acc_ids = [r[0] for r in cur.fetchall()]
    total_accs = len(acc_ids)
    print(f"Total accounts found: {total_accs}")

    batch_size = 500
    for i in range(0, total_accs, batch_size):
        batch = acc_ids[i:i + batch_size]
        records = []
        for acc_id in batch:
            for cid in cards_to_grant:
                records.append((acc_id, cid, 3))
        
        cur.executemany("""
            INSERT INTO user_cards (account_id, card_id, count)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
        """, records)
        print(f"Processed {min(i + batch_size, total_accs)} / {total_accs} accounts...")

    # Verify
    cur.execute("SELECT COUNT(DISTINCT account_id) FROM user_cards WHERE card_id = 30598")
    count_30598 = cur.fetchone()[0]
    print(f"[OK] Total accounts with Dimensional Barrier (30598): {count_30598} / {total_accs}")

conn.close()
print("[*] Finished granting cards successfully!")
