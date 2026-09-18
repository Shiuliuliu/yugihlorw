# -*- coding: utf-8 -*-
import re, sys

with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    text = f.read()

changes = []

def record_sub(pattern, repl, s, flags=0, desc=""):
    global changes
    count = len(re.findall(pattern, s, flags=flags))
    if count > 0:
        changes.append((desc or pattern, count))
    return re.sub(pattern, repl, s, flags=flags)

new_text = text

# 1. Clean up dumb find-and-replace bugs from previous patch:
new_text = record_sub(r"eMa Phápil", "Hòm Thư", new_text, desc="eMa Phápil -> Hòm Thư")
new_text = record_sub(r"Ma Phápy mắn", "May mắn", new_text, desc="Ma Phápy mắn -> May mắn")
new_text = record_sub(r"Ma Phápy Mắn", "May Mắn", new_text, desc="Ma Phápy Mắn -> May Mắn")
new_text = record_sub(r"ma phápy mắn", "may mắn", new_text, desc="ma phápy mắn -> may mắn")
new_text = record_sub(r"Trại Ma TaMa Pháp", "Trại Tà Ma", new_text, desc="Trại Ma TaMa Pháp -> Trại Tà Ma")
new_text = record_sub(r"huyền thoại boong", "Huyền thoại Bộ Bài", new_text, flags=re.I, desc="huyền thoại boong -> Huyền thoại Bộ Bài")
new_text = record_sub(r"\bboong\b", "bộ bài", new_text, desc="boong -> bộ bài")
new_text = record_sub(r"\bBoong\b", "Bộ Bài", new_text, desc="Boong -> Bộ Bài")
new_text = record_sub(r"trò chơi giết", "Đấu Trường Sinh Tử", new_text, flags=re.I, desc="trò chơi giết -> Đấu Trường Sinh Tử")

# 2. Archetypes & Keywords:
new_text = record_sub(r"AMa Phápzon", "Amazoness", new_text, desc="AMa Phápzon -> Amazoness")
new_text = record_sub(r"\bmắt xanh lam\b", "Mắt Xanh", new_text, flags=re.I, desc="mắt xanh lam -> Mắt Xanh")
new_text = record_sub(r"<mắt xanh>", "<Mắt Xanh>", new_text, flags=re.I, desc="<mắt xanh> -> <Mắt Xanh>")
new_text = record_sub(r"<Mắt xanh>", "<Mắt Xanh>", new_text, desc="<Mắt xanh> -> <Mắt Xanh>")
new_text = record_sub(r"rồng trắng mắt xanh", "Rồng Trắng Mắt Xanh", new_text, flags=re.I, desc="rồng trắng mắt xanh -> Rồng Trắng Mắt Xanh")
new_text = record_sub(r"<Blue Eyes White Dragon>", "<Rồng Trắng Mắt Xanh>", new_text, desc="<Blue Eyes White Dragon> -> <Rồng Trắng Mắt Xanh>")
new_text = record_sub(r"<Phù Thủy bóng tối>", "<Phù Thủy Áo Đen>", new_text, desc="<Phù Thủy bóng tối> -> <Phù Thủy Áo Đen>")
new_text = record_sub(r"<Phù Thủy Bóng Tối>", "<Phù Thủy Áo Đen>", new_text, desc="<Phù Thủy Bóng Tối> -> <Phù Thủy Áo Đen>")
new_text = record_sub(r"<Salamon Reincarnation>", "<Hỏa Thú Luân Hồi (Salamangreat)>", new_text, desc="<Salamon Reincarnation> -> <Hỏa Thú Luân Hồi>")
new_text = record_sub(r"<Black Feather>", "<Lông Vũ Đen (Blackwing)>", new_text, desc="<Black Feather> -> <Lông Vũ Đen>")

# 3. Duel terms:
new_text = record_sub(r"đấu tay đôi với Quái Thú", "Quyết Đấu Quái Thú", new_text, flags=re.I, desc="đấu tay đôi với Quái Thú -> Quyết Đấu Quái Thú")
new_text = record_sub(r"Cuộc đấu tay đôi của Quái Thú", "Đấu Trường Quái Thú", new_text, flags=re.I, desc="Cuộc đấu tay đôi của Quái Thú -> Đấu Trường Quái Thú")
new_text = record_sub(r"Học viện đấu tay đôi", "Học Viện Quyết Đấu", new_text, flags=re.I, desc="Học viện đấu tay đôi -> Học Viện Quyết Đấu")
new_text = record_sub(r"vương quốc đấu tay đôi", "Vương Quốc Quyết Đấu", new_text, flags=re.I, desc="vương quốc đấu tay đôi -> Vương Quốc Quyết Đấu")
new_text = record_sub(r"vua đấu tay đôi", "Vua Quyết Đấu", new_text, flags=re.I, desc="vua đấu tay đôi -> Vua Quyết Đấu")
new_text = record_sub(r"trò chơi vua đấu tay đôi", "Vua Trò Chơi Quyết Đấu", new_text, flags=re.I, desc="trò chơi vua đấu tay đôi -> Vua Trò Chơi Quyết Đấu")
new_text = record_sub(r"kết nối đấu tay đôi", "Đấu Quyết Đấu Kết Nối (Link Duel)", new_text, flags=re.I, desc="kết nối đấu tay đôi -> Đấu Quyết Đấu Kết Nối")

# 4. Standardize Barrier / Tường Chắn mechanics:
# Complex barriers:
new_text = record_sub(r"Rào chắn Quái Thú - Phép thuật và Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", new_text, flags=re.I, desc="Rào chắn tổng hợp -> Tường chắn tổng hợp")
new_text = record_sub(r"Quái Thú - Phép Thuật - Rào chắn Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", new_text, flags=re.I, desc="Quái Thú - Phép - Rào chắn Bẫy -> Tường chắn tổng hợp")
new_text = record_sub(r"Trận chiến·Quái Thú·Phép Thuật·Bẫy rào chắn", "Tường chắn Toàn Diện (Chiến Đấu - Quái - Phép - Bẫy)", new_text, flags=re.I, desc="Rào chắn toàn diện")
new_text = record_sub(r"Quái Thú·Phép Thuật·Bẫy Rào chắn", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", new_text, flags=re.I, desc="Quái·Phép·Bẫy rào chắn")

# Single barriers:
new_text = record_sub(r"Rào Chắn Quái Thú", "Tường Chắn Quái Thú", new_text, desc="Rào Chắn Quái Thú -> Tường Chắn Quái Thú")
new_text = record_sub(r"rào chắn Quái Thú", "Tường chắn Quái Thú", new_text, desc="rào chắn Quái Thú -> Tường chắn Quái Thú")
new_text = record_sub(r"rào chắn quái thú", "Tường chắn Quái Thú", new_text, desc="rào chắn quái thú -> Tường chắn Quái Thú")
new_text = record_sub(r"Rào Chắn Cạm Bẫy", "Tường Chắn Cạm Bẫy", new_text, desc="Rào Chắn Cạm Bẫy -> Tường Chắn Cạm Bẫy")
new_text = record_sub(r"rào chắn Cạm Bẫy", "Tường chắn Cạm Bẫy", new_text, desc="rào chắn Cạm Bẫy -> Tường chắn Cạm Bẫy")
new_text = record_sub(r"rào chắn Bẫy", "Tường chắn Cạm Bẫy", new_text, desc="rào chắn Bẫy -> Tường chắn Cạm Bẫy")
new_text = record_sub(r"rào chắn Phép Thuật", "Tường chắn Phép Thuật", new_text, desc="rào chắn Phép Thuật -> Tường chắn Phép Thuật")
new_text = record_sub(r"Rào chắn Phép Thuật", "Tường Chắn Phép Thuật", new_text, desc="Rào chắn Phép Thuật -> Tường Chắn Phép Thuật")
new_text = record_sub(r"Rào chắn Phép thuật", "Tường Chắn Phép Thuật", new_text, desc="Rào chắn Phép thuật -> Tường Chắn Phép Thuật")
new_text = record_sub(r"rào chắn phép thuật", "Tường chắn Phép Thuật", new_text, desc="rào chắn phép thuật -> Tường chắn Phép Thuật")
new_text = record_sub(r"rào chắn chiến đấu", "Tường chắn Chiến Đấu", new_text, desc="rào chắn chiến đấu -> Tường chắn Chiến Đấu")
new_text = record_sub(r"khiên chiến đấu", "Tường chắn Chiến Đấu", new_text, desc="khiên chiến đấu -> Tường chắn Chiến Đấu")
new_text = record_sub(r"Hiệu ứng Phá hủy Rào chắn", "Tường chắn Phá Hủy", new_text, desc="Hiệu ứng Phá hủy Rào chắn -> Tường chắn Phá Hủy")
new_text = record_sub(r"Phá hủy Rào chắn", "Tường chắn Phá Hủy", new_text, desc="Phá hủy Rào chắn -> Tường chắn Phá Hủy")
new_text = record_sub(r"Phá hủy rào chắn", "Tường chắn Phá Hủy", new_text, desc="Phá hủy rào chắn -> Tường chắn Phá Hủy")
new_text = record_sub(r"Tiêu diệt Rào chắn", "Tường chắn Phá Hủy", new_text, desc="Tiêu diệt Rào chắn -> Tường chắn Phá Hủy")

# Barrier actions:
new_text = record_sub(r"bỏ qua <rào chắn", "bỏ qua <Tường chắn", new_text, desc="bỏ qua <rào chắn -> bỏ qua <Tường chắn")
new_text = record_sub(r"bỏ qua <Rào chắn", "bỏ qua <Tường chắn", new_text, desc="bỏ qua <Rào chắn -> bỏ qua <Tường chắn")
new_text = record_sub(r"\(xuyên thủng rào chắn\)", "(xuyên Tường chắn)", new_text, desc="xuyên thủng rào chắn -> xuyên Tường chắn")
new_text = record_sub(r"\(xuyên thủng\)", "(xuyên Tường chắn)", new_text, desc="xuyên thủng -> xuyên Tường chắn")

# 5. Yu-Gi-Oh mechanics:
new_text = record_sub(r"Mạng sống của người chơi của bạn", "Điểm gốc (LP)", new_text, desc="Mạng sống người chơi -> Điểm gốc (LP)")
new_text = record_sub(r"mạng sống của người chơi của bạn", "Điểm gốc (LP)", new_text, desc="mạng sống người chơi -> Điểm gốc (LP)")
new_text = record_sub(r"mạng sống của người chơi đối phương", "Điểm gốc (LP) của đối phương", new_text, desc="mạng sống đối phương -> Điểm gốc (LP) đối phương")
new_text = record_sub(r"lá bài bẫy Ma Pháp thuật", "lá bài Phép Thuật hoặc Cạm Bẫy", new_text, desc="lá bài bẫy Ma Pháp thuật -> Phép Thuật hoặc Cạm Bẫy")
new_text = record_sub(r"Ma Pháp thuật", "Phép Thuật", new_text, desc="Ma Pháp thuật -> Phép Thuật")

print("=== CHANGES REPORT ===")
total = 0
for desc, count in changes:
    print(f"  {desc}: {count} occurrences")
    total += count
print(f"TOTAL REPLACEMENTS: {total}")

with open(r"D:\yugitauapk\extend_lan_clean.txt", "w", encoding="utf-8") as f:
    f.write(new_text)
print("Saved to extend_lan_clean.txt")