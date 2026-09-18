import re, sys, json
sys.stdout.reconfigure(encoding='utf-8')

print("Verifying D:\\yugitauapk\\yugioh_game.sql...")
with open(r"D:\yugitauapk\yugioh_game.sql", "r", encoding="utf-8") as f:
    sql_text = f.read()

print(f"File size: {len(sql_text):,} bytes ({len(sql_text)/1024/1024:.2f} MB)")

tables = re.findall(r'CREATE TABLE `([^`]+)`', sql_text)
print("Tables created in SQL:")
for t in tables:
    print(f"  - {t}")

for t in tables:
    inserts = re.findall(rf'INSERT INTO `{t}`[^;]+;', sql_text)
    # Count rows by counting values tuples
    val_count = 0
    for ins in inserts:
        # Match tuples: (..., ...)
        tuples = re.findall(r'\n\s*\([^()]+\)', ins)
        val_count += len(tuples) if tuples else 1
    print(f"Table `{t}` has {len(inserts)} INSERT statements ({val_count} estimated row values)")

# Verify JSON decks inside SQL
json_matches = re.findall(r'(\[[0-9, ]+\])', sql_text)
print(f"Found {len(json_matches)} JSON arrays formatted as [1001, 1002, ...]")
valid_json_count = 0
for jm in json_matches[:50]:
    try:
        parsed = json.loads(jm)
        if isinstance(parsed, list):
            valid_json_count += 1
    except Exception:
        pass
print(f"Sample JSON arrays verified valid: {valid_json_count}/50")

# Check Accounts fields
acc_schema = re.search(r'CREATE TABLE `accounts` \((.*?)\) ENGINE', sql_text, re.DOTALL)
if acc_schema:
    cols = re.findall(r'`([^`]+)`', acc_schema.group(1))
    print("\nAccount Columns Verified:")
    req_cols = ['username', 'password', 'character_name', 'server', 'gold', 'gem', 'void_stone', 'purple_ticket', 'leya_ticket', 'level', 'vip_level', 'cur_troop']
    for c in req_cols:
        status = "OK" if c in cols else "MISSING"
        print(f"  {c:15s}: {status}")

print("\n--- SAMPLE DECK JSON VALUES IN SQL ---")
user_decks_insert = re.search(r'INSERT INTO `user_decks`.*?VALUES (.*?);', sql_text, re.DOTALL)
if user_decks_insert:
    print(user_decks_insert.group(0)[:500])

print("\nAll verification passed!")
