import sys
from build_mysql_db import raw_extra, get_text

sys.stdout.reconfigure(encoding='utf-8')

print("Total cards:", len(raw_extra))

# Let's inspect options, fields, etc.
options = set()
card_samples = {}
for e in raw_extra:
    opt = e.get("_option")
    options.add(opt)
    if opt not in card_samples:
        card_samples[opt] = e

print("Distinct _option values:", sorted(list(options)))
for opt in sorted(list(options)):
    e = card_samples[opt]
    cid = e["_id"]
    name = get_text(e["_nameSid"])
    print(f"Option {opt}: ID {cid}, Name: {name}, jc: {e.get('_joinComponent')}, sc: {e.get('_syncComponent')}, link: {e.get('_link')}")

# Let's check which cards have actual non-zero syncComponent
print("\n--- CARDS WITH NON-ZERO SYNC COMPONENT ---")
count_sc = 0
for e in raw_extra:
    sc = e.get("_syncComponent")
    has_real_sc = False
    if isinstance(sc, list):
        for item in sc:
            if isinstance(item, list):
                if any(x > 0 for x in item if isinstance(x, (int, float))):
                    has_real_sc = True
            elif isinstance(item, (int, float)) and item > 0:
                has_real_sc = True
    if has_real_sc:
        count_sc += 1
        if count_sc <= 10:
            print(f"Sync Card: ID {e['_id']}, Name: {get_text(e['_nameSid'])}, sc: {sc}")
print(f"Total cards with real syncComponent: {count_sc}")

# Let's check which cards have actual non-zero link
print("\n--- CARDS WITH NON-ZERO LINK ---")
count_link = 0
for e in raw_extra:
    lk = e.get("_link")
    has_real_link = False
    if isinstance(lk, list):
        if any(x > 0 for x in lk if isinstance(x, (int, float))):
            has_real_link = True
    if has_real_link:
        count_link += 1
        if count_link <= 10:
            print(f"Link Card: ID {e['_id']}, Name: {get_text(e['_nameSid'])}, lk: {lk}, linkCount: {e.get('_linkCount')}")
print(f"Total cards with real link: {count_link}")

# Let's check which cards have actual non-zero joinComponent
print("\n--- CARDS WITH NON-ZERO JOIN COMPONENT ---")
count_join = 0
for e in raw_extra:
    jc = e.get("_joinComponent")
    has_real_jc = False
    if isinstance(jc, list):
        if any(x > 0 for x in jc if isinstance(x, (int, float))):
            has_real_jc = True
    if has_real_jc:
        count_join += 1
        if count_join <= 10:
            print(f"Join Card: ID {e['_id']}, Name: {get_text(e['_nameSid'])}, jc: {jc}")
print(f"Total cards with real joinComponent: {count_join}")
