import sys
from build_mysql_db import raw_spells, get_text

sys.stdout.reconfigure(encoding='utf-8')

for opt in [2, 4, 8, 16, 66, 80, 98]:
    print(f"\n--- SPELL OPTION {opt} ---")
    samples = [s for s in raw_spells if s.get('_option') == opt][:4]
    for s in samples:
        cid = s['_id']
        name = get_text(s['_nameSid'])
        print(f"  ID {cid}: {name} (type={s.get('_type')})")
