import pymysql, json, sys

sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
with conn.cursor(pymysql.cursors.DictCursor) as cur:
    cur.execute("SELECT * FROM card_traps WHERE id IN (30598, 30599, 30600, 30601)")
    rows = cur.fetchall()
    for r in rows:
        print(r)

    print("\n--- Check Shop items for these traps ---")
    cur.execute("SELECT * FROM shop_cards WHERE card_id IN (30598, 30599, 30600, 30601)")
    print("shop_cards:", cur.fetchall())

    cur.execute("SHOW TABLES LIKE '%shop%'")
    print("shop tables:", cur.fetchall())

conn.close()
