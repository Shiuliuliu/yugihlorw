import sys
from build_mysql_db import raw_traps, get_text

sys.stdout.reconfigure(encoding='utf-8')

for opt in [1, 2, 4, 8]:
    print(f"\n--- TRAP OPTION {opt} ---")
    samples = [t for t in raw_traps if t.get('_option') == opt][:5]
    for t in samples:
        cid = t['_id']
        name = get_text(t['_nameSid'])
        desc = get_text(t['_descSid'])[:60]
        print(f"  ID {cid}: {name} | {desc}")
