import sys
from build_mysql_db import raw_extra, get_text

sys.stdout.reconfigure(encoding='utf-8')

print("=== INSPECTING FIRST 30 EXTRA CARDS ===")
for i in range(30):
    e = raw_extra[i]
    cid = e["_id"]
    name = get_text(e["_nameSid"])
    jc = e.get("_joinComponent")
    sc = e.get("_syncComponent")
    lk = e.get("_link")
    lc = e.get("_linkCount")
    opt = e.get("_option")
    print(f"ID: {cid} | Name: {name} | opt: {opt}")
    print(f"   joinComponent: {jc}")
    print(f"   syncComponent: {sc}")
    print(f"   link: {lk}, linkCount: {lc}")

print("\n=== FINDING CARDS WITH DIFFERENT VALUES ===")
# Let's inspect some known cards:
# Fusion: Blue-Eyes Ultimate Dragon (40001)
# Synchro: Stardust Dragon, Red Dragon Archfiend
# Xyz: Utopia (Hope), etc.
# Link: Decode Talker, etc.
for e in raw_extra:
    cid = e["_id"]
    name = get_text(e["_nameSid"])
    sc = e.get("_syncComponent")
    jc = e.get("_joinComponent")
    lk = e.get("_link")
    lc = e.get("_linkCount")
    # Check if sc is not [[0]]
    if sc != [[0]] and sc != [0] and sc != []:
        print(f"[SC!=0] ID: {cid}, Name: {name}, sc={sc}")
    if lc and lc > 0:
        print(f"[LINK] ID: {cid}, Name: {name}, lc={lc}, lk={lk}")

