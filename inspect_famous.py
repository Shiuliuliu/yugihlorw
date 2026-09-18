import sys
from build_mysql_db import raw_spells, raw_traps, get_text

sys.stdout.reconfigure(encoding='utf-8')

print("=== FAMOUS SPELLS ===")
famous_spells = [
    (20005, "Dung Hợp (Polymerization)"),
    (20030, "Hồi Sinh Tử Giả (Monster Reborn)"),
    (20023, "Toon World"),
    (20051, "Hũ Lòng Tham (Pot of Greed)"),
    (20001, "Sách Phép Thuật (Equip)"),
    (20008, "Thanh Kiếm Ánh Sáng (Swords of Revealing Light)"),
    (20028, "Cơn Bão Cuồng Phong (Heavy Storm)"),
    (20042, "Lốc Xoáy Huyền Bí (Mystical Space Typhoon)"),
]

for fid, fname in famous_spells:
    sp = [s for s in raw_spells if s['_id'] == fid]
    if sp:
        s = sp[0]
        print(f"ID {s['_id']}: {get_text(s['_nameSid'])} ({fname}) -> _type={s.get('_type')}, _opt={s.get('_option')} ({bin(s.get('_option',0))})")

print("\n=== FAMOUS TRAPS ===")
famous_traps = [
    (30001, "Mirror Force (Thánh Khiên Phản Chiếu)"),
    (30002, "Trap Hole (Lỗ Thủng)"),
    (30003, "Shadow Spell / Six Star (Lời Nguyền Sao Sáu Cánh)"),
    (30004, "Magic Jammer (Mảng Can Thiệp Phép)"),
    (30009, "Seven Tools (Bảy Công Cụ)"),
    (30012, "Negate Attack (Vô Hiệu Hóa Tấn Công)"),
    (30018, "Dragon Capture Jar (Nồi Ấn Rồng)"),
    (30031, "Eternal Soul (Linh Hồn Vĩnh Cửu)"),
    (30038, "Divine Wrath / Punishment (Sự Trừng Phạt Thần Thánh)"),
]

for fid, fname in famous_traps:
    tr = [t for t in raw_traps if t['_id'] == fid]
    if tr:
        t = tr[0]
        print(f"ID {t['_id']}: {get_text(t['_nameSid'])} ({fname}) -> _type={t.get('_type')}, _opt={t.get('_option')} ({bin(t.get('_option',0))})")
