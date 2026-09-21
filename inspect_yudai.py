import pymysql, re

with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern for entry with _value = 11201
pattern = re.compile(r'\[(\d+)\]=\{(.*?)\n  \},', re.DOTALL)
entries = {}
for m in pattern.finditer(content):
    eid = int(m.group(1))
    body = m.group(2)
    m_val = re.search(r'\["_value"\]=(\d+)', body)
    if m_val:
        entries[int(m_val.group(1))] = (eid, body)

if 11201 in entries:
    eid, body = entries[11201]
    pids = [int(x) for x in re.findall(r'\[\d+\]=\{\[1\]=(\d+),\}', body)]
    print(f"Total cards in entry {eid} (_value=11201): {len(pids)}")
    conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
    with conn.cursor() as c:
        format_strings = ','.join(['%s'] * len(pids))
        c.execute(f'''
            SELECT id, name, quality FROM (
                SELECT id, name, quality FROM card_monsters
                UNION ALL SELECT id, name, quality FROM card_spells
                UNION ALL SELECT id, name, quality FROM card_traps
                UNION ALL SELECT id, name, quality FROM card_extra
            ) AS t WHERE id IN ({format_strings})
        ''', tuple(pids))
        cards = c.fetchall()
        print(f"Found {len(cards)} cards in DB")
        for c in cards[:35]:
            name = c['name'].encode('ascii', 'replace').decode('ascii')
            print(f"  {c['id']}: {name} ({c['quality']})")
