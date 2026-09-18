import subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

sql_query = """
USE yugioh_game;
SELECT '=== ACCOUNTS TABLE ===' AS Section;
SELECT id, username, character_name, server, gold, gem, void_stone, purple_ticket, leya_ticket, vip_level FROM accounts;

SELECT '=== SAMPLE USER DECKS (JSON FORMAT) ===' AS Section;
SELECT id, account_id, deck_slot, deck_name, cards, extra_cards, is_active FROM user_decks LIMIT 3;

SELECT '=== SAMPLE MONSTER CARDS ===' AS Section;
SELECT id, name, category, attribute, keyword, stars, atk, def, quality FROM card_monsters WHERE id IN (10001, 10004, 10006, 10048, 10055, 10056);

SELECT '=== SAMPLE SPELL CARDS ===' AS Section;
SELECT id, name, type, quality FROM card_spells WHERE id IN (20001, 20005, 20006, 20007, 20030, 20051);

SELECT '=== SAMPLE TRAP CARDS ===' AS Section;
SELECT id, name, type, quality FROM card_traps WHERE id IN (30001, 30002, 30006, 30018, 30025);

SELECT '=== SAMPLE EXTRA DECK CARDS (Fusion, Synchro, Xyz, Link) ===' AS Section;
SELECT id, name, summon_type, category, stars, atk, def, quality FROM card_extra WHERE id IN (40001, 40006, 40039, 40148, 40301);
"""

cmd = [r"C:\xampp\mysql\bin\mysql.exe", "-u", "root", "--default-character-set=utf8mb4", "-e", sql_query]
res = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8')
print(res.stdout)
if res.stderr:
    print("Errors:", res.stderr)
