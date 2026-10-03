import sys, pymysql, json
sys.stdout.reconfigure(encoding='utf-8')

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
with conn.cursor() as cur:
    cur.execute("SELECT id, name, type, keyword, quality, description FROM card_spells WHERE type = 'Môi Trường' LIMIT 5")
    rows = cur.fetchall()
    for r in rows:
        print(r)

    cur.execute("SELECT * FROM card_spells WHERE id >= 21100")
    print("\nRecent cards in card_spells:")
    for r in cur.fetchall():
        print(r)
