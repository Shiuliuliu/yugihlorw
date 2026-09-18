import sys
from build_mysql_db import raw_traps, raw_spells, get_text

sys.stdout.reconfigure(encoding='utf-8')

print("=== TRAP TYPES ===")
for t_type in [11, 12, 13, 14]:
    print(f"\n--- TRAP TYPE {t_type} ---")
    samples = [t for t in raw_traps if t.get('_type') == t_type][:6]
    for s in samples:
        cid = s['_id']
        name = get_text(s['_nameSid'])
        desc = get_text(s['_descSid'])[:50]
        print(f"  ID {cid}: {name} | Desc: {desc}")

print("\n=== SPELL TYPES ===")
for s_type in [11, 12, 13, 14, 15, 16]:
    samples = [s for s in raw_spells if s.get('_type') == s_type][:4]
    if samples:
        print(f"\n--- SPELL TYPE {s_type} ---")
        for s in samples:
            cid = s['_id']
            name = get_text(s['_nameSid'])
            print(f"  ID {cid}: {name}")
