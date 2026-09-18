# -*- coding: utf-8 -*-
import sys, re, struct, os

sys.stdout.reconfigure(encoding='utf-8')

FIB = [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 584, 4181, 6765, 
    10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 
    2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 
    165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903
]

def encrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r5 = (-shift) & 7
        r7 = (b << shift) & 0xFF
        b = (b >> r5) & 0xFF
        b = (b | r7) & 0xFF
        b ^= mod_key
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

print("1. Reading extend_lan.txt...")
with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = f.readlines()

print(f"Total lines: {len(lines)}")

# 1. Chủng Tộc (Monster Races) - lines 1902-1928
RACES = {
    1902: "Không có",
    1903: "Pháp Sư",             # Spellcaster
    1904: "Rồng",                # Dragon
    1905: "Máy Móc",             # Machine
    1906: "Ác Ma",               # Fiend
    1907: "Thú",                 # Beast
    1908: "Chiến Sĩ",            # Warrior
    1909: "Nham Thạch",          # Rock
    1910: "Thủy Tộc",            # Aqua
    1911: "Hải Long",            # Sea Serpent
    1912: "Bò Sát",              # Reptile
    1913: "Thú Chiến Sĩ",        # Beast-Warrior
    1914: "Khủng Long",          # Dinosaur
    1915: "Điểu Thú",            # Winged Beast
    1916: "Thiên Thần",          # Fairy
    1917: "Côn Trùng",           # Insect
    1918: "Ngư Tộc",             # Fish
    1919: "Zombie",              # Zombie
    1920: "Thực Vật",            # Plant
    1921: "Hỏa Tộc",             # Pyro
    1922: "Huyễn Thần Thú",      # Divine-Beast
    1923: "Lôi Tộc",             # Thunder
    1924: "Sáng Tạo Thần",       # Creator-God
    1925: "Tâm Linh",            # Psychic
    1926: "Cyberse",             # Cyberse
    1927: "Huyễn Long",          # Wyrm
    1928: "Ảo Tưởng Tộc",        # Illusion
}

# 2. Archetypes & Keywords (Từ Khóa) - lines 1930-2186
ARCHETYPES = {
    1930: "Không có",
    1931: "Phù Thủy Áo Đen",
    1932: "Rồng Trắng Mắt Xanh",
    1933: "Archfiend (Ác Ma)",
    1934: "Chiến Binh Nam Châm",
    1935: "Kuriboh",
    1936: "Amazoness",
    1937: "Skull Servant (Hài Cốt)",
    1938: "Chân Hồng Nhãn (Mắt Đỏ)",
    1939: "Chiến Binh Tinh Linh",
    1940: "Hieratic (Thánh Khắc)",
    1941: "Darklord (Đọa Thiên Sứ)",
    1942: "Guardian (Người Bảo Hộ)",
    1943: "Noble Knight (Hiệp Sĩ)",
    1944: "Elemental HERO",
    1945: "Harpie",
    1946: "Ojama",
    1947: "Phong Ấn (Exodia)",
    1948: "Photon",
    1949: "Vampire",
    1950: "Dark World (Thế Giới Bóng Tối)",
    1951: "Buster Blader (Phá Hoại Kiếm Sĩ)",
    1952: "Bonding (Hóa Hợp Cảm Ứng)",
    1953: "Evolzar (Tiến Hóa Long)",
    1954: "Evolsaur (Tiến Hóa Côn Trùng)",
    1955: "Arcana Force (Bí Nghi Chi Lực)",
    1956: "Ice Barrier (Kết Giới Băng)",
    1957: "Ghostrick",
    1958: "Nimble (Nhanh Nhẹn)",
    1959: "Worm (Trùng Tộc)",
    1960: "Atlantean (Hải Hoàng)",
    1961: "Frog (Ếch)",
    1962: "Aroma (Hương Thơm)",
    1963: "Kiếm Sĩ",
    1964: "Ma Đạo Chiến Sĩ",
    1965: "Monarch (Đế Vương)",
    1966: "Jinzo (Nhân Tạo Nhân)",
    1967: "Cyberdark (Hắc Ám Điện Tử)",
    1968: "Chronomaly (Di Sản Tiên Sử)",
    1969: "Mắt Xanh",
    1970: "Chiến Binh Hỗn Độn",
    1971: "Rồng Đen Mắt Đỏ",
    1972: "Cyber Dragon (Rồng Điện Tử)",
    1973: "Toon",
    1974: "Gaia Kỵ Sĩ",
    1975: "Tuner (Hiệu Chỉnh)",
    1976: "Ancient Gear (Cổ Đại Cơ Khí)",
    1977: "Kuriboh",
    1978: "Fire King (Viêm Vương)",
    1979: "Viêm Vương Thú",
    1980: "LV",
    1981: "Possessed (Bằng Y)",
    1982: "World Legacy (Tinh Di Vật)",
    1983: "Jurrac",
    1984: "B.E.S. (Cự Đại Chiến Hạm)",
    1985: "Naturia (Tự Nhiên)",
    1986: "Magician Girl (Ma Đạo Nữ Hài)",
    1987: "Neos",
    1988: "Fairy Tale (Đồng Thoại)",
    1989: "Gravekeeper's (Thủ Mộ)",
    1990: "Fortune Lady (Vận Mệnh Nữ Lang)",
    1991: "Noble Arms (Thánh Kiếm)",
    1992: "Djinn (Nghi Thức Ma Nhân)",
    1993: "Inzektor (Giáp Trùng Trang Bị)",
    1994: "Steelswarm (Xâm Lược Ma)",
    1995: "Gusto",
    1996: "Six Samurai (Lục Vũ Chúng)",
    1997: "Shien (Tử Viêm)",
    1998: "Neo-Spacian",
    1999: "Tân Vũ (Neos)",
    2000: "Scrap (Phế Liệu)",
    2001: "Stardust (Tinh Trần)",
    2002: "Iron Chain (Thiết Liên)",
    2003: "Reptilianne (Bò Sát Lệ Nhân)",
    2004: "Ninja",
    2005: "T.G. (Công Nghệ)",
    2006: "Armed Dragon (Vũ Trang Long)",
    2007: "Felgrand (Cự Long)",
    2008: "Mythical Beast (Ma Đạo Thú)",
    2009: "X-Saber (X-Kiếm Sĩ)",
    2010: "Infernity (Vĩnh Cửu Hỏa)",
    2011: "Karakuri (Cơ Xảo)",
    2012: "Resonator (Cộng Hưởng Giả)",
    2013: "Red Dragon Archfiend (Hồng Liên Ma)",
    2014: "Windwitch (Tấn Phong)",
    2015: "Morphtronic (Biến Hình Đấu Sĩ)",
    2016: "Roid (Cơ Nhân)",
    2017: "Kuriboh",
    2018: "Ghostrick",
    2019: "The Agent (Đại Lý Nhân)",
    2020: "Penguin (Chim Cánh Cụt)",
    2021: "Cyber Angel (Điện Tử Thiên Sứ)",
    2022: "Machina (Cơ Giáp)",
    2023: "Volcanic (Hỏa Sơn)",
    2024: "Blaze Accelerator (Hỏa Diễm Pháo)",
    2025: "Spellbook (Ma Đạo Thư)",
    2026: "Malefic (Tội Ác)",
    2027: "Bảo Ngọc",
    2028: "Crystal Beast (Bảo Ngọc Thú)",
    2029: "Ultimate Crystal (Cực Trí Bảo Ngọc)",
    2030: "Batteryman (Điện Trì Nhân)",
    2031: "PSY-Frame (PSY Khung Xương)",
    2032: "Sphinx (Nhân Diện Sư)",
    2033: "Destiny HERO (Anh Hùng Định Mệnh)",
    2034: "HERO (Anh Hùng)",
    2035: "Vision HERO (Huyễn Ảnh Anh Hùng)",
    2036: "Scrap (Phế Thiết)",
    2037: "Gizmek (Cơ Xảo)",
    2038: "Thunder Dragon (Lôi Long)",
    2039: "Mist Valley (Thung Lũng Kasumi)",
    2040: "Herald (Tuyên Cáo Giả)",
    2041: "No.",
    2042: "Utopia (Hy Vọng Hoàng Hope)",
    2043: "Heroic (Hào Kiệt)",
    2044: "CNo.",
    2045: "Gagaga (Tôi Tôi Tôi)",
    2046: "Gogogo (Ầm Ầm)",
    2047: "Dung Hợp (Fusion)",
    2048: "Blackwing (Hắc Vũ)",
    2049: "Evolzar (Tiến Hóa Đế)",
    2050: "Harpie Lady Sisters",
    2051: "Ninjitsu (Nhẫn Pháp)",
    2052: "Laval (Dung Nham)",
    2053: "Bujin (Vũ Thần)",
    2054: "Djinn (Ma Nhân)",
    2055: "D/D (Dị Thứ Nguyên)",
    2056: "Chaos (Hỗn Độn)",
    2057: "Cyber (Điện Tử)",
    2058: "Invoked (Triệu Hoán Thú)",
    2059: "Gimmick Puppet (Cơ Xảo Khôi Lỗi)",
    2060: "Puppet (Khôi Lỗi)",
    2061: "Rank-Up-Magic (Nâng Cấp Phép Thuật)",
    2062: "Fur Hire (Không Nha Đoàn)",
    2063: "Infernoid (Ngục Hỏa Cơ)",
    2064: "Nekroz (Ảnh Linh Y)",
    2065: "Evil HERO (Tà Ác Anh Hùng)",
    2066: "Chrysalis (Cái Kén)",
    2067: "Shiranui (Bất Tri Hỏa)",
    2068: "Mayakashi (Ma Yêu)",
    2069: "Zombie (Bất Tử)",
    2070: "Alien (Ngoại Tinh Quái Thú)",
    2071: "Cloudian (Vân Ma Vật)",
    2072: "Lightsworn (Quang Đạo)",
    2073: "Bamboo Sword (Trúc Kiếm)",
    2074: "The Agent (Đại Lý Giả)",
    2075: "Silent Swordsman (Trầm Mặc Kiếm Sĩ)",
    2076: "Raidraptor (Cấp Tập Mãnh Cầm)",
    2077: "Galaxy (Ngân Hà)",
    2078: "Galaxy-Eyes (Mắt Ngân Hà)",
    2079: "Change (Biến Thân)",
    2080: "Masked HERO (Mặt Nạ Anh Hùng)",
    2081: "Mecha Phantom Beast (Huyễn Thú Cơ)",
    2082: "Excalibur (Thánh Kiếm)",
    2083: "Subterror (Địa Để)",
    2084: "Rokket (Đạn Hoàn)",
    2085: "Artifact (Thần Khí)",
    2086: "Dark Fusion (Hắc Ám Dung Hợp)",
    2087: "Endymion",
    2088: "DD",
    2089: "DDD",
    2090: "Dark Contract (Khế Ước Thư)",
    2091: "Rose (Hoa Hồng)",
    2092: "Shadow Six Samurai (Bóng Tối Lục Vũ)",
    2093: "Battlin' Boxer (Đốt Cháy Quyền Thủ)",
    2094: "Metaphys (Huyễn Hoàng)",
    2095: "Gladiator Beast (Đấu Sĩ Quái Thú)",
    2096: "Plunder Patroll (Hải Tặc)",
    2097: "Marincess (Hải Tinh Nữ)",
    2098: "Evolution Pill (Tiến Hóa Dược)",
    2099: "Chemicritter (Hóa Hợp Thú)",
    2100: "Codebreaker (Phá Mã Giả)",
    2101: "Fire Fist (Viêm Tinh)",
    2102: "Code Talker (Mã Ngữ Giả)",
    2103: "Salamangreat (Hỏa Thú Luân Hồi)",
    2104: "Gottoms",
    2105: "Flower Cardian (Hoa Trát Vệ)",
    2106: "Genex (Thứ Thế Hệ)",
    2107: "Fabled (Ma Thần)",
    2108: "Gandora",
    2109: "Nordic (Cực Tinh)",
    2110: "Aesir (Cực Thần)",
    2111: "Magical (Ma Pháp)",
    2112: "Lyrilusc (Thơ Ca Điểu)",
    2113: "Dododo (Tức Giận)",
    2114: "Onomat (Hài Âm)",
    2115: "Mắt Xanh",
    2116: "Ally of Justice (Chính Nghĩa Minh Hữu)",
    2117: "Madolche (Điềm Điểm Ma Âu)",
    2118: "Superheavy Samurai (Siêu Trọng Vũ Giả)",
    2119: "Superheavy Samurai Soul (Siêu Trọng Trang Hồn)",
    2120: "Barbaros",
    2121: "World Chalice (Tinh Di Vật)",
    2122: "Train (Đoàn Tàu Liệt Xa)",
    2123: "Perseus",
    2124: "Windwitch (Phong Linh Nữ Vu)",
    2125: "Shaddoll (Ảnh Y)",
    2126: "ZW - Zexal Weapon (Dị Nhiệt Đồng Tâm Vũ Khí)",
    2127: "CNo.39",
    2128: "Thánh Địa Bầu Trời (Sanctuary in the Sky)",
    2129: "Vendread (Phục Thù Thi Tộc)",
    2130: "Crystron (Thủy Tinh Xảo Cơ)",
    2131: "Gravekeeper's Priestess (Thủ Mộ Linh Mục)",
    2132: "Heraldic Beast (Huy Chương Thú)",
    2133: "Warrior (Chiến Sĩ)",
    2134: "Buster Blader (Phá Hoại Kiếm)",
    2135: "Time Thief (Thời Gian Đạo Tặc)",
    2136: "Cipher (Quang Ba)",
    2137: "Gem-Knight (Bảo Thạch Kỵ Sĩ)",
    2138: "Xtra HERO (Dị Thường Anh Hùng)",
    2139: "Rikka (Lục Hoa)",
    2140: "Skull (Bộ Xương)",
    2141: "Generaider (Sáng Hóa Vương)",
    2142: "The Phantom Knights (Huyễn Ảnh Kỵ Sĩ Đoàn)",
    2143: "Venom (Độc Xà)",
    2144: "Void (Luyện Ngục)",
    2145: "Rokket / Bullet (Đạn Hoàn)",
    2146: "Borrel (Nòng Súng Barrel)",
    2147: "Dogmatika (Giáo Đạo)",
    2148: "Reactor (Phản Ứng Pháo)",
    2149: "Mermail (Thủy Tinh Lân)",
    2150: "Abyss (Thâm Uyên)",
    2151: "Rose Dragon (Hồng Ngọc Long)",
    2152: "Fossil (Hóa Thạch)",
    2153: "Speedroid (Xúc Xắc)",
    2154: "Spright (Tinh Linh Lôi Quang)",
    2155: "Magistus (Đại Hiền Giả)",
    2156: "Ritual Beast (Linh Thú)",
    2157: "Ritual Beast Tamer (Linh Thú Sứ)",
    2158: "Spiritual Beast (Linh Thú Quái)",
    2159: "Yang Zing (Long Tinh)",
    2160: "Marincess (Hải Tinh Thiếu Nữ)",
    2161: "Morpho (Huyễn Điệp)",
    2162: "Star Seraph (Quang Thiên Sứ)",
    2163: "Gunkan (Quân Quan)",
    2164: "XYZ",
    2165: "Stardust Dragon (Tinh Trần Long)",
    2166: "Psychic (Tâm Linh)",
    2167: "Cipher Dragon (Quang Ba Long)",
    2168: "Assault Mode (Chế Độ Thiểm Cấp)",
    2169: "Tam Quốc (Ancient Warriors)",
    2170: "Mê Đắm (Allure)",
    2171: "Possessed (Bằng Y)",
    2172: "Lunalight (Nguyệt Quang)",
    2173: "Hiến Tế (Tribute)",
    2174: "Drytron (Long Huy Kiều)",
    2175: "Drytron (Long Nhất Kiều)",
    2176: "Stealth Kragen (Ẩn Hình Thủy Mẫu)",
    2177: "XYZ Dragon Cannon (XYZ Long Pháo)",
    2178: "Swordsoul (Tương Kiếm)",
    2179: "Onomat (Hài Âm)",
    2180: "Ác Ma (Archfiend)",
    2181: "Dual Sky (Song Thiên)",
    2182: "Scareclaw (Bù Nhìn Ma Quái)",
    2183: "ZS - Zexal Server (Dị Nhiệt Đồng Tâm Tòng Giả)",
    2184: "Dinomorphia (Khủng Long Cơ Xảo)",
    2185: "Prank-Kids (Đồ Chơi Khăm)",
    2186: "Icejade (Băng Ngọc)"
}

# 3. Subtypes 1 (lines 2198-2212)
SUBTYPES_1 = {
    2198: "Thông Thường",        # Normal Monster
    2199: "Hiệu Ứng",            # Effect Monster
    2200: "Dung Hợp",            # Fusion Monster
    2201: "Linh Hồn",            # Spirit Monster
    2202: "Nghi Thức",           # Ritual Monster
    2203: "Toon",                # Toon Monster
    2204: "Nhị Trọng",           # Gemini Monster
    2205: "Tuner",               # Tuner Monster
    2206: "Liên Minh",           # Union Monster
    2207: "Đồng Điệu",           # Synchro Monster
    2208: "Siêu Lượng (XYZ)",    # Xyz Monster
    2209: "Lật",                 # Flip Monster
    2210: "Dao Động",            # Pendulum Monster
    2211: "Liên Kết",            # Link Monster
    2212: "Non-Tuner",           # Non-Tuner
}

# 4. Material Prompts (lines 2213-2220)
MATERIAL_PROMPTS = {
    2213: "Vui lòng chọn phương thức Triệu Hồi",
    2214: "Vui lòng chọn mục tiêu Dung Hợp",
    2215: "Vui lòng chọn %d nguyên liệu Dung Hợp",
    2216: "Vui lòng chọn mục tiêu Trang Bị",
    2217: "Vui lòng chọn nguyên liệu Đồng Điệu (mục tiêu: %d sao)",
    2218: "Vui lòng chọn %d nguyên liệu Siêu Lượng %d sao",
    2219: "Vui lòng chọn %d nguyên liệu Siêu Lượng (XYZ)",
    2220: "Vui lòng chọn tối đa %d nguyên liệu Liên Kết (%s)",
}

# 5. Spell / Trap / Monster Subtypes 2 (lines 3430-3453)
SUBTYPES_2 = {
    3430: "Thông Thường",        # Normal Spell
    3431: "Trang Bị",            # Equip Spell
    3432: "Môi Trường",          # Field Spell
    3433: "Nghi Thức",           # Ritual Spell
    3434: "Vĩnh Cửu",            # Continuous Spell
    3435: "Tốc Công",            # Quick-Play Spell
    3436: "Thông Thường",        # Normal Trap
    3437: "Vĩnh Cửu",            # Continuous Trap
    3438: "Phản Đòn",            # Counter Trap
    3439: "Trang Bị",            # Equip Trap
    3440: "Thông Thường",        # Normal Monster
    3441: "Hiệu Ứng",            # Effect Monster
    3442: "Dung Hợp",            # Fusion Monster
    3443: "Linh Hồn",            # Spirit Monster
    3444: "Nghi Thức",           # Ritual Monster
    3445: "Toon",                # Toon Monster
    3446: "Nhị Trọng",           # Gemini Monster
    3447: "Tuner",               # Tuner Monster
    3448: "Liên Minh",           # Union Monster
    3449: "Đồng Điệu",           # Synchro Monster
    3450: "Siêu Lượng (XYZ)",    # Xyz Monster
    3451: "Lật",                 # Flip Monster
    3452: "Dao Động",            # Pendulum Monster
    3453: "Liên Kết",            # Link Monster
}

# 6. Deck tabs & stats
OTHER_DIRECT = {
    664: "EX-",                  # Tab 4: EX- + Quái Thú = EX-Quái Thú
    3235: "Quái Thú: %2d\nPhép & Bẫy: %2d",
    3237: "Quái Thú: %d - Phép & Bẫy: %d - Leya: %d",
}

# Apply direct line fixes
direct_maps = {}
direct_maps.update(RACES)
direct_maps.update(ARCHETYPES)
direct_maps.update(SUBTYPES_1)
direct_maps.update(MATERIAL_PROMPTS)
direct_maps.update(SUBTYPES_2)
direct_maps.update(OTHER_DIRECT)

print(f"Applying {len(direct_maps)} direct line replacements...")
for line_idx, val in direct_maps.items():
    if line_idx < len(lines):
        orig_val = lines[line_idx].strip()
        lines[line_idx] = val + "\n"

# Reconstruct text
text = "".join(lines)

# 7. Regex replacements across full text
changes = []
def record_sub(pattern, repl, s, flags=0, desc=""):
    global changes
    count = len(re.findall(pattern, s, flags=flags))
    if count > 0:
        changes.append((desc or pattern, count))
    return re.sub(pattern, repl, s, flags=flags)

# Clean up dumb translation bugs:
text = record_sub(r"eMa Phápil", "Hòm Thư", text, desc="eMa Phápil -> Hòm Thư")
text = record_sub(r"Ma Phápy mắn", "May mắn", text, desc="Ma Phápy mắn -> May mắn")
text = record_sub(r"Ma Phápy Mắn", "May Mắn", text, desc="Ma Phápy Mắn -> May Mắn")
text = record_sub(r"ma phápy mắn", "may mắn", text, desc="ma phápy mắn -> may mắn")
text = record_sub(r"Ma Phápy", "May", text, desc="Ma Phápy -> May")
text = record_sub(r"Trại Ma TaMa Pháp", "Trại Tà Ma", text, desc="Trại Ma TaMa Pháp -> Trại Tà Ma")
text = record_sub(r"huyền thoại boong", "Huyền Thoại Bộ Bài", text, flags=re.I, desc="huyền thoại boong -> Huyền Thoại Bộ Bài")
text = record_sub(r"\bboong\b", "bộ bài", text, desc="boong -> bộ bài")
text = record_sub(r"\bBoong\b", "Bộ Bài", text, desc="Boong -> Bộ Bài")
text = record_sub(r"trò chơi giết", "Đấu Trường Sinh Tử", text, flags=re.I, desc="trò chơi giết -> Đấu Trường Sinh Tử")

# Materials
text = record_sub(r"vật liệu tổng hợp", "nguyên liệu Dung Hợp", text, desc="vật liệu tổng hợp -> nguyên liệu Dung Hợp")
text = record_sub(r"tài liệu đồng bộ", "nguyên liệu Đồng Điệu", text, desc="tài liệu đồng bộ -> nguyên liệu Đồng Điệu")
text = record_sub(r"vật liệu thừa", "nguyên liệu Siêu Lượng", text, desc="vật liệu thừa -> nguyên liệu Siêu Lượng")
text = record_sub(r"vật liệu kết nối", "nguyên liệu Liên Kết", text, desc="vật liệu kết nối -> nguyên liệu Liên Kết")
text = record_sub(r"Quái Thú con lắc", "Quái Thú Dao Động", text, desc="Quái Thú con lắc -> Quái Thú Dao Động")
text = record_sub(r"từ chối sự tương đồng", "Phân Tách Đồng Điệu (De-Synchro)", text, desc="từ chối sự tương đồng -> De-Synchro")

# Archetypes & Keywords:
text = record_sub(r"AMa Phápzon", "Amazoness", text, desc="AMa Phápzon -> Amazoness")
text = record_sub(r"\bmắt xanh lam\b", "Mắt Xanh", text, flags=re.I, desc="mắt xanh lam -> Mắt Xanh")
text = record_sub(r"<mắt xanh>", "<Mắt Xanh>", text, flags=re.I, desc="<mắt xanh> -> <Mắt Xanh>")
text = record_sub(r"<Mắt xanh>", "<Mắt Xanh>", text, desc="<Mắt xanh> -> <Mắt Xanh>")
text = record_sub(r"rồng trắng mắt xanh", "Rồng Trắng Mắt Xanh", text, flags=re.I, desc="rồng trắng mắt xanh -> Rồng Trắng Mắt Xanh")
text = record_sub(r"<Blue Eyes White Dragon>", "<Rồng Trắng Mắt Xanh>", text, desc="<Blue Eyes White Dragon> -> <Rồng Trắng Mắt Xanh>")
text = record_sub(r"<Phù Thủy bóng tối>", "<Phù Thủy Áo Đen>", text, desc="<Phù Thủy bóng tối> -> <Phù Thủy Áo Đen>")
text = record_sub(r"<Phù Thủy Bóng Tối>", "<Phù Thủy Áo Đen>", text, desc="<Phù Thủy Bóng Tối> -> <Phù Thủy Áo Đen>")
text = record_sub(r"<Salamon Reincarnation>", "<Hỏa Thú Luân Hồi (Salamangreat)>", text, desc="<Salamon Reincarnation> -> <Hỏa Thú Luân Hồi>")
text = record_sub(r"<Black Feather>", "<Lông Vũ Đen (Blackwing)>", text, desc="<Black Feather> -> <Lông Vũ Đen>")

# Duel terms:
text = record_sub(r"đấu tay đôi với Quái Thú", "Quyết Đấu Quái Thú", text, flags=re.I, desc="đấu tay đôi với Quái Thú -> Quyết Đấu Quái Thú")
text = record_sub(r"Cuộc đấu tay đôi của Quái Thú", "Đấu Trường Quái Thú", text, flags=re.I, desc="Cuộc đấu tay đôi của Quái Thú -> Đấu Trường Quái Thú")
text = record_sub(r"Học viện đấu tay đôi", "Học Viện Quyết Đấu", text, flags=re.I, desc="Học viện đấu tay đôi -> Học Viện Quyết Đấu")
text = record_sub(r"vương quốc đấu tay đôi", "Vương Quốc Quyết Đấu", text, flags=re.I, desc="vương quốc đấu tay đôi -> Vương Quốc Quyết Đấu")
text = record_sub(r"vua đấu tay đôi", "Vua Quyết Đấu", text, flags=re.I, desc="vua đấu tay đôi -> Vua Quyết Đấu")
text = record_sub(r"trò chơi vua đấu tay đôi", "Vua Trò Chơi Quyết Đấu", text, flags=re.I, desc="trò chơi vua đấu tay đôi -> Vua Trò Chơi Quyết Đấu")
text = record_sub(r"kết nối đấu tay đôi", "Quyết Đấu Kết Nối (Link Duel)", text, flags=re.I, desc="kết nối đấu tay đôi -> Quyết Đấu Kết Nối")

# Barrier mechanics:
text = record_sub(r"Rào chắn Quái Thú - Phép thuật và Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", text, flags=re.I, desc="Rào chắn tổng hợp -> Tường chắn tổng hợp")
text = record_sub(r"Quái Thú - Phép Thuật - Rào chắn Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", text, flags=re.I, desc="Quái Thú - Phép - Rào chắn Bẫy -> Tường chắn tổng hợp")
text = record_sub(r"Trận chiến·Quái Thú·Phép Thuật·Bẫy rào chắn", "Tường chắn Toàn Diện (Chiến Đấu - Quái - Phép - Bẫy)", text, flags=re.I, desc="Rào chắn toàn diện")
text = record_sub(r"Quái Thú·Phép Thuật·Bẫy Rào chắn", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", text, flags=re.I, desc="Quái·Phép·Bẫy rào chắn")

text = record_sub(r"Rào Chắn Quái Thú", "Tường Chắn Quái Thú", text, desc="Rào Chắn Quái Thú -> Tường Chắn Quái Thú")
text = record_sub(r"rào chắn Quái Thú", "Tường chắn Quái Thú", text, desc="rào chắn Quái Thú -> Tường chắn Quái Thú")
text = record_sub(r"rào chắn quái thú", "Tường chắn Quái Thú", text, desc="rào chắn quái thú -> Tường chắn Quái Thú")
text = record_sub(r"Rào Chắn Cạm Bẫy", "Tường Chắn Cạm Bẫy", text, desc="Rào Chắn Cạm Bẫy -> Tường Chắn Cạm Bẫy")
text = record_sub(r"rào chắn Cạm Bẫy", "Tường chắn Cạm Bẫy", text, desc="rào chắn Cạm Bẫy -> Tường chắn Cạm Bẫy")
text = record_sub(r"rào chắn Bẫy", "Tường chắn Cạm Bẫy", text, desc="rào chắn Bẫy -> Tường chắn Cạm Bẫy")
text = record_sub(r"rào chắn Phép Thuật", "Tường chắn Phép Thuật", text, desc="rào chắn Phép Thuật -> Tường chắn Phép Thuật")
text = record_sub(r"Rào chắn Phép Thuật", "Tường Chắn Phép Thuật", text, desc="Rào chắn Phép Thuật -> Tường Chắn Phép Thuật")
text = record_sub(r"Rào chắn Phép thuật", "Tường Chắn Phép Thuật", text, desc="Rào chắn Phép thuật -> Tường Chắn Phép Thuật")
text = record_sub(r"rào chắn phép thuật", "Tường chắn Phép Thuật", text, desc="rào chắn phép thuật -> Tường chắn Phép Thuật")
text = record_sub(r"rào chắn chiến đấu", "Tường chắn Chiến Đấu", text, desc="rào chắn chiến đấu -> Tường chắn Chiến Đấu")
text = record_sub(r"khiên chiến đấu", "Tường chắn Chiến Đấu", text, desc="khiên chiến đấu -> Tường chắn Chiến Đấu")
text = record_sub(r"Hiệu ứng Phá hủy Rào chắn", "Tường chắn Phá Hủy", text, desc="Hiệu ứng Phá hủy Rào chắn -> Tường chắn Phá Hủy")
text = record_sub(r"Phá hủy Rào chắn", "Tường chắn Phá Hủy", text, desc="Phá hủy Rào chắn -> Tường chắn Phá Hủy")
text = record_sub(r"Phá hủy rào chắn", "Tường chắn Phá Hủy", text, desc="Phá hủy rào chắn -> Tường chắn Phá Hủy")
text = record_sub(r"Tiêu diệt Rào chắn", "Tường chắn Phá Hủy", text, desc="Tiêu diệt Rào chắn -> Tường chắn Phá Hủy")

text = record_sub(r"bỏ qua <rào chắn", "bỏ qua <Tường chắn", text, desc="bỏ qua <rào chắn -> bỏ qua <Tường chắn")
text = record_sub(r"bỏ qua <Rào chắn", "bỏ qua <Tường chắn", text, desc="bỏ qua <Rào chắn -> bỏ qua <Tường chắn")
text = record_sub(r"\(xuyên thủng rào chắn\)", "(xuyên Tường chắn)", text, desc="xuyên thủng rào chắn -> xuyên Tường chắn")
text = record_sub(r"\(xuyên thủng\)", "(xuyên Tường chắn)", text, desc="xuyên thủng -> xuyên Tường chắn")

# Yu-Gi-Oh mechanics:
text = record_sub(r"Mạng sống của người chơi của bạn", "Điểm gốc (LP)", text, desc="Mạng sống người chơi -> Điểm gốc (LP)")
text = record_sub(r"mạng sống của người chơi của bạn", "Điểm gốc (LP)", text, desc="mạng sống người chơi -> Điểm gốc (LP)")
text = record_sub(r"mạng sống của người chơi đối phương", "Điểm gốc (LP) của đối phương", text, desc="mạng sống đối phương -> Điểm gốc (LP) đối phương")
text = record_sub(r"Bẫy Ma Pháp thuật", "Phép & Bẫy", text, desc="Bẫy Ma Pháp thuật -> Phép & Bẫy")
text = record_sub(r"bẫy Ma Pháp thuật", "Phép & Bẫy", text, desc="bẫy Ma Pháp thuật -> Phép & Bẫy")
text = record_sub(r"lá bài bẫy Ma Pháp thuật", "lá bài Phép Thuật hoặc Cạm Bẫy", text, desc="lá bài bẫy Ma Pháp thuật -> Phép Thuật hoặc Cạm Bẫy")
text = record_sub(r"Ma Pháp thuật hoặc Cạm Bẫy", "Phép Thuật hoặc Cạm Bẫy", text, desc="Ma Pháp thuật hoặc Cạm Bẫy -> Phép Thuật hoặc Cạm Bẫy")
text = record_sub(r"Ma Pháp thuật", "Phép Thuật", text, desc="Ma Pháp thuật -> Phép Thuật")

print(f"Applied {len(changes)} regex rules, total replacements: {sum(c[1] for c in changes)}")
for desc, count in changes:
    print(f"   * {desc}: {count}")

encoded_file = text.encode('utf-8')

# Re-encrypt lan.lcres
orig_path = r"D:\yugitauapk\extracted\1.0.7\res\lan.lcres"
with open(orig_path, "rb") as f:
    orig = f.read()

cur_key = struct.unpack('<I', orig[4:8])[0]
delta_key = struct.unpack('<I', orig[8:12])[0]
orig_md5 = orig[12:44]

enc_fn = encrypt_data(b'extend.lan', cur_key)
k2 = (cur_key + delta_key) & 0xFFFFFFFF
enc_data = encrypt_data(encoded_file, k2)

rebuilt = bytearray()
rebuilt.extend(b'LCR\x01')
rebuilt.extend(struct.pack('<II', cur_key, delta_key))
rebuilt.extend(orig_md5)
rebuilt.append(0)
rebuilt.append(1)
rebuilt.extend(struct.pack('<I', len(encoded_file)))
rebuilt.append(len(b'extend.lan'))
rebuilt.extend(enc_fn)
rebuilt.extend(struct.pack('<I', len(enc_data)))
rebuilt.extend(enc_data)

target_res = r"D:\yugitauapk\extracted\1.0.7\res\lan.lcres"
with open(target_res, "wb") as f:
    f.write(rebuilt)
print(f"Encrypted new lan.lcres ({len(rebuilt)} bytes) successfully!")
