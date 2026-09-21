import pymysql

pids = [10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11245, 11246, 11247, 11248, 11249, 11250, 11251, 11416, 11417, 11461, 11463, 11555, 12008, 12042, 12078, 12173, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40167, 40168, 40169, 40263, 40272, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40336, 40534, 40606, 40658, 40696, 40697, 40170, 40646, 40558, 40607, 20511, 20486]

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
with conn.cursor() as c:
    fmt = ','.join(['%s'] * len(pids))
    c.execute(f'''
        SELECT id, name, quality FROM (
            SELECT id, name, quality FROM card_monsters
            UNION ALL SELECT id, name, quality FROM card_spells
            UNION ALL SELECT id, name, quality FROM card_traps
            UNION ALL SELECT id, name, quality FROM card_extra
        ) AS t WHERE id IN ({fmt})
    ''', tuple(pids))
    cards = {r['id']: r for r in c.fetchall()}

print(f'Found {len(cards)}/{len(pids)} cards in DB')
with open('yudai_cards.txt', 'w', encoding='utf-8') as out:
    out.write(f"Found {len(cards)}/{len(pids)} cards in DB\n")
    for pid in pids:
        if pid in cards:
            c = cards[pid]
            out.write(f"  {pid}: {c['name']} [{c['quality']}]\n")
        else:
            out.write(f"  {pid}: NOT IN DB\n")
print("Done writing yudai_cards.txt")
