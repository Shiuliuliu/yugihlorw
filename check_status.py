import pymysql

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
with conn.cursor() as cur:
    cur.execute("SELECT id, username, last_login FROM accounts ORDER BY last_login DESC LIMIT 15")
    rows = cur.fetchall()
    print("Recent accounts:")
    for r in rows:
        print(r)

    # Check user_cards for these 4 traps
    cur.execute("SELECT account_id, card_id, count FROM user_cards WHERE card_id IN (30598, 30599, 30600, 30601) LIMIT 20")
    print("\nSample user_cards for 30598..30601:")
    for r in cur.fetchall():
        print(r)

conn.close()
