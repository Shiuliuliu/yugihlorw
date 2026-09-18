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

print("Reading extend_lan.txt...")
with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lines = [l.rstrip('\r\n') for l in f]

TOTAL_LINES = len(lines)
assert TOTAL_LINES == 56673, f"Unexpected line count {TOTAL_LINES}"

# 1. Chủng Tộc (Monster Races) - Thuần Việt, không ngoặc
RACES = {
    1902: "Không có",
    1903: "Pháp Sư",
    1904: "Rồng",
    1905: "Máy Móc",
    1906: "Ác Ma",
    1907: "Thú",
    1908: "Chiến Sĩ",
    1909: "Nham Thạch",
    1910: "Thủy Tộc",
    1911: "Hải Long",
    1912: "Bò Sát",
    1913: "Chiến Sĩ Thú",
    1914: "Khủng Long",
    1915: "Chim Thú",
    1916: "Thiên Thần",
    1917: "Côn Trùng",
    1918: "Cá",
    1919: "Zombie",
    1920: "Thực Vật",
    1921: "Hỏa Tộc",
    1922: "Thần Thú",
    1923: "Sấm Sét",
    1924: "Thần Sáng Tạo",
    1925: "Tâm Linh",
    1926: "Cyberse",
    1927: "Rồng Ảo",
    1928: "Ảo Tưởng",
    1929: "Từ Khóa",
}

# 2. Archetypes & Keywords (Từ Khóa) - Thuần Việt, không ngoặc, chuẩn Yu-Gi-Oh
ARCHETYPES = {
    1930: "Không có",
    1931: "Phù Thủy Áo Đen",
    1932: "Rồng Trắng Mắt Xanh",
    1933: "Ác Ma",
    1934: "Chiến Binh Nam Châm",
    1935: "Kuriboh",
    1936: "Amazoness",
    1937: "Hài Cốt",
    1938: "Mắt Đỏ",
    1939: "Chiến Binh Tinh Linh",
    1940: "Hieratic",
    1941: "Thiên Thần Sa Ngã",
    1942: "Người Bảo Hộ",
    1943: "Hiệp Sĩ",
    1944: "Anh Hùng Nguyên Tố",
    1945: "Harpie",
    1946: "Ojama",
    1947: "Phong Ấn Exodia",
    1948: "Photon",
    1949: "Vampire",
    1950: "Thế Giới Bóng Tối",
    1951: "Kiếm Sĩ Diệt Rồng",
    1952: "Liên Kết Hóa Học",
    1953: "Rồng Tiến Hóa",
    1954: "Côn Trùng Tiến Hóa",
    1955: "Sức Mạnh Thần Bí",
    1956: "Kết Giới Băng",
    1957: "Ghostrick",
    1958: "Nhanh Nhẹn",
    1959: "Trùng Tộc",
    1960: "Hải Hoàng",
    1961: "Ếch",
    1962: "Hương Thơm",
    1963: "Kiếm Sĩ",
    1964: "Chiến Binh Ma Thuật",
    1965: "Đế Vương",
    1966: "Người Nhân Tạo Jinzo",
    1967: "Điện Tử Bóng Tối",
    1968: "Di Sản Tiền Sử",
    1969: "Mắt Xanh",
    1970: "Chiến Binh Hỗn Độn",
    1971: "Rồng Đen Mắt Đỏ",
    1972: "Rồng Điện Tử",
    1973: "Toon",
    1974: "Kỵ Sĩ Gaia",
    1975: "Tuner",
    1976: "Cơ Khí Cổ Đại",
    1977: "Kuriboh",
    1978: "Vua Lửa",
    1979: "Thú Vua Lửa",
    1980: "LV",
    1981: "Linh Hồn Nhập",
    1982: "Di Sản Tinh Tú",
    1983: "Jurrac",
    1984: "Chiến Hạm Khổng Lồ",
    1985: "Tự Nhiên",
    1986: "Nữ Phù Thủy",
    1987: "Neos",
    1988: "Công Chúa Cổ Tích",
    1989: "Thủ Mộ",
    1990: "Cô Gái Vận Mệnh",
    1991: "Thánh Kiếm",
    1992: "Ác Quỷ Nghi Thức",
    1993: "Bọ Cánh Cứng Inzektor",
    1994: "Quỷ Xâm Lược",
    1995: "Gusto",
    1996: "Lục Vũ Chúng",
    1997: "Lửa Tím Shien",
    1998: "Tân Không Gian",
    1999: "Tân Không Gian Neos",
    2000: "Phế Liệu",
    2001: "Bụi Sao",
    2002: "Xích Sắt",
    2003: "Bò Sát",
    2004: "Ninja",
    2005: "Công Nghệ TG",
    2006: "Rồng Vũ Trang",
    2007: "Rồng Khổng Lồ Felgrand",
    2008: "Ma Thú",
    2009: "Kiếm Sĩ X",
    2010: "Lửa Vĩnh Cửu Infernity",
    2011: "Cơ Xảo Karakuri",
    2012: "Cộng Hưởng Resonator",
    2013: "Rồng Lửa Đỏ",
    2014: "Gió Lốc Windwitch",
    2015: "Biến Hình Morphtronic",
    2016: "Người Máy Roid",
    2017: "Kuriboh",
    2018: "Ghostrick",
    2019: "Đại Lý The Agent",
    2020: "Chim Cánh Cụt",
    2021: "Thiên Thần Điện Tử",
    2022: "Cơ Giáp Machina",
    2023: "Núi Lửa Volcanic",
    2024: "Pháo Lửa",
    2025: "Sách Phép",
    2026: "Tội Ác Malefic",
    2027: "Bảo Ngọc",
    2028: "Thú Bảo Ngọc",
    2029: "Bảo Ngọc Tối Thượng",
    2030: "Người Pin Batteryman",
    2031: "Khung Xương PSY",
    2032: "Nhân Sư Sphinx",
    2033: "Anh Hùng Định Mệnh",
    2034: "Anh Hùng",
    2035: "Anh Hùng Ảo Ảnh",
    2036: "Phế Liệu Sắt",
    2037: "Cơ Xảo Gizmek",
    2038: "Rồng Sấm Sét",
    2039: "Thung Lũng Sương Mù",
    2040: "Tuyên Cáo Herald",
    2041: "No.",
    2042: "Hi Vọng Hoàng Utopia",
    2043: "Hào Kiệt Heroic",
    2044: "CNo.",
    2045: "Gagaga",
    2046: "Gogogo",
    2047: "Dung Hợp",
    2048: "Lông Đen Blackwing",
    2049: "Vua Tiến Hóa Evolzar",
    2050: "Ba Chị Em Harpie",
    2051: "Nhẫn Pháp Ninjitsu",
    2052: "Dung Nham Laval",
    2053: "Chiến Thần Bujin",
    2054: "Ma Nhân Djinn",
    2055: "Dị Thứ Nguyên DD",
    2056: "Hỗn Độn Chaos",
    2057: "Điện Tử Cyber",
    2058: "Triệu Hồi Thú Invoked",
    2059: "Rối Cơ Khí Gimmick",
    2060: "Con Rối Puppet",
    2061: "Nâng Cấp Phép Thuật",
    2062: "Không Nha Đoàn",
    2063: "Ngục Hỏa Infernoid",
    2064: "Áo Giáp Bóng Đêm Nekroz",
    2065: "Anh Hùng Tà Ác",
    2066: "Cái Kén",
    2067: "Bất Tri Hỏa Shiranui",
    2068: "Ma Yêu Mayakashi",
    2069: "Zombie",
    2070: "Người Ngoài Hành Tinh",
    2071: "Quái Thú Mây Cloudian",
    2072: "Quang Đạo Lightsworn",
    2073: "Kiếm Tre",
    2074: "Đại Lý",
    2075: "Kiếm Sĩ Trầm Lặng",
    2076: "Chim Săn Mồi Raidraptor",
    2077: "Ngân Hà Galaxy",
    2078: "Mắt Ngân Hà",
    2079: "Biến Thân",
    2080: "Anh Hùng Mặt Nạ",
    2081: "Huyễn Thú Cơ",
    2082: "Thánh Kiếm Excalibur",
    2083: "Địa Đáy Subterror",
    2084: "Đạn Pháo Rokket",
    2085: "Cổ Vật Artifact",
    2086: "Dung Hợp Bóng Tối",
    2087: "Endymion",
    2088: "DD",
    2089: "DDD",
    2090: "Khế Ước Tối",
    2091: "Hoa Hồng",
    2092: "Lục Vũ Bóng Tối",
    2093: "Quyền Thủ Lửa",
    2094: "Huyễn Hoàng Metaphys",
    2095: "Đấu Sĩ Quái Thú",
    2096: "Hải Tặc Plunder",
    2097: "Công Chúa Biển Marincess",
    2098: "Thuốc Tiến Hóa",
    2099: "Thú Hóa Học",
    2100: "Phá Mã Codebreaker",
    2101: "Nắm Đấm Lửa Fire Fist",
    2102: "Mã Ngữ Code Talker",
    2103: "Hỏa Thú Luân Hồi",
    2104: "Gottoms",
    2105: "Hoa Trát Flower Cardian",
    2106: "Genex",
    2107: "Ma Thần Fabled",
    2108: "Gandora",
    2109: "Cực Tinh Nordic",
    2110: "Cực Thần Aesir",
    2111: "Ma Thuật",
    2112: "Thơ Ca Điểu Lyrilusc",
    2113: "Dododo",
    2114: "Từ Tượng Thanh Onomat",
    2115: "Mắt Xanh",
    2116: "Đồng Minh Công Lý",
    2117: "Bánh Ngọt Madolche",
    2118: "Siêu Trọng Kiếm Sĩ",
    2119: "Siêu Trọng Linh Hồn",
    2120: "Barbaros",
    2121: "Di Sản Tinh Tú",
    2122: "Đoàn Tàu",
    2123: "Perseus",
    2124: "Phù Thủy Gió",
    2125: "Búp Bê Bóng Đêm Shaddoll",
    2126: "Vũ Khí Zexal ZW",
    2127: "CNo.39",
    2128: "Thiên Không Thánh Vực",
    2129: "Thi Hài Báo Thù",
    2130: "Thủy Tinh Cơ Khí Crystron",
    2131: "Nữ Tu Thủ Mộ",
    2132: "Quái Thú Huy Hiệu",
    2133: "Chiến Sĩ",
    2134: "Kiếm Diệt Rồng",
    2135: "Kẻ Trộm Thời Gian",
    2136: "Quang Ba Cipher",
    2137: "Hiệp Sĩ Đá Quý",
    2138: "Anh Hùng Ngoại Hạng",
    2139: "Hoa Tuyết Rikka",
    2140: "Bộ Xương",
    2141: "Vua Khởi Nguyên Generaider",
    2142: "Kỵ Sĩ Bóng Ma",
    2143: "Rắn Độc Venom",
    2144: "Luyện Ngục Void",
    2145: "Đạn Pháo",
    2146: "Nòng Súng Borrel",
    2147: "Giáo Đạo Dogmatika",
    2148: "Lò Phản Ứng Reactor",
    2149: "Tiên Cá Mermail",
    2150: "Vực Thẳm Abyss",
    2151: "Rồng Hoa Hồng",
    2152: "Hóa Thạch Fossil",
    2153: "Xúc Xắc Speedroid",
    2154: "Lôi Tinh Spright",
    2155: "Đại Hiền Giả Magistus",
    2156: "Linh Thú",
    2157: "Người Luyện Linh Thú",
    2158: "Quái Thú Linh Thú",
    2159: "Sao Rồng Yang Zing",
    2160: "Công Chúa Biển",
    2161: "Bướm Ảo Morpho",
    2162: "Thiên Sứ Ánh Sáng",
    2163: "Tàu Sushi Gunkan",
    2164: "Xyz",
    2165: "Rồng Bụi Sao",
    2166: "Tâm Linh Psychic",
    2167: "Rồng Quang Ba",
    2168: "Chế Độ Bùng Nổ",
    2169: "Tam Quốc",
    2170: "Quyến Rũ",
    2171: "Linh Hồn Nhập",
    2172: "Ánh Trăng Lunalight",
    2173: "Hiến Tế",
    2174: "Rồng Huy Hoàng Drytron",
    2175: "Rồng Sao Drytron",
    2176: "Sứa Vô Hình",
    2177: "Pháo Rồng XYZ",
    2178: "Kiếm Hồn Swordsoul",
    2179: "Hài Âm Onomat",
    2180: "Ác Ma",
    2181: "Song Thiên",
    2182: "Móng Vuốt Kinh Hoàng",
    2183: "Bầy Tôi Zexal ZS",
    2184: "Khủng Long Cơ Xảo",
    2185: "Trẻ Nghịch Ngợm",
    2186: "Băng Ngọc Icejade",
}

# 3. Subtypes 1 - KHÔNG DÙNG DẤU NGOẶC, dùng trực tiếp Link, Synchro, Xyz, Dung Hợp
SUBTYPES_1 = {
    2198: "Thông Thường",
    2199: "Hiệu Ứng",
    2200: "Dung Hợp",
    2201: "Linh Hồn",
    2202: "Nghi Thức",
    2203: "Toon",
    2204: "Nhị Trọng",
    2205: "Tuner",
    2206: "Liên Minh",
    2207: "Synchro",
    2208: "Xyz",
    2209: "Lật",
    2210: "Pendulum",
    2211: "Link",
    2212: "Non-Tuner",
}

# 4. Material Prompts - Chuẩn Link, Synchro, Xyz, Dung Hợp
MATERIAL_PROMPTS = {
    2213: "Vui lòng chọn phương thức Triệu Hồi",
    2214: "Vui lòng chọn mục tiêu Dung Hợp",
    2215: "Vui lòng chọn %d nguyên liệu Dung Hợp",
    2216: "Vui lòng chọn mục tiêu Trang Bị",
    2217: "Vui lòng chọn nguyên liệu Synchro mục tiêu %d sao",
    2218: "Vui lòng chọn %d nguyên liệu Xyz %d sao",
    2219: "Vui lòng chọn %d nguyên liệu Xyz",
    2220: "Vui lòng chọn tối đa %d nguyên liệu Link %s",
}

# 5. Spell / Trap / Monster Subtypes 2
SUBTYPES_2 = {
    3430: "Thông Thường",
    3431: "Trang Bị",
    3432: "Môi Trường",
    3433: "Nghi Thức",
    3434: "Vĩnh Cửu",
    3435: "Tốc Công",
    3436: "Thông Thường",
    3437: "Vĩnh Cửu",
    3438: "Phản Đòn",
    3439: "Trang Bị",
    3440: "Thông Thường",
    3441: "Hiệu Ứng",
    3442: "Dung Hợp",
    3443: "Linh Hồn",
    3444: "Nghi Thức",
    3445: "Toon",
    3446: "Nhị Trọng",
    3447: "Tuner",
    3448: "Liên Minh",
    3449: "Synchro",
    3450: "Xyz",
    3451: "Lật",
    3452: "Pendulum",
    3453: "Link",
}

OTHER_DIRECT = {
    664: "EX-",
    3235: r"Quái Thú: %2d\nPhép & Bẫy: %2d",
    3237: "Quái Thú: %d - Phép & Bẫy: %d - Leya: %d",
    3595: r"Thể lệ cuộc thi 6.22 ~ 6.28:\nSau khi quái thú của bạn tấn công/phòng thủ ở lượt này,\ntất cả lá bài trên tay không thể sử dụng,\nđồng thời kỹ năng chủ động và triệu hồi Leya không khả dụng.",
}

# Verify no parentheses in RACES or ARCHETYPES or SUBTYPES:
all_direct = {}
all_direct.update(RACES)
all_direct.update(ARCHETYPES)
all_direct.update(SUBTYPES_1)
all_direct.update(MATERIAL_PROMPTS)
all_direct.update(SUBTYPES_2)
all_direct.update(OTHER_DIRECT)

for idx, val in all_direct.items():
    assert '\n' not in val, f"Line {idx} has raw newline!"
    assert '\r' not in val, f"Line {idx} has raw return!"
    if idx not in [3235, 3237, 3595]:
        assert '(' not in val and ')' not in val, f"Found parentheses in line {idx}: {val}"
    lines[idx] = val

def sub_line(pattern, repl, line, flags=0):
    return re.sub(pattern, repl, line, flags=flags)

clean_lines = []
for i, line in enumerate(lines):
    l = line
    # Common machine bugs:
    l = sub_line(r"eMa Phápil", "Hòm Thư", l)
    l = sub_line(r"Ma Phápy mắn", "May mắn", l)
    l = sub_line(r"Ma Phápy Mắn", "May Mắn", l)
    l = sub_line(r"ma phápy mắn", "may mắn", l)
    l = sub_line(r"Ma Phápy", "May", l)
    l = sub_line(r"Trại Ma TaMa Pháp", "Trại Tà Ma", l)
    l = sub_line(r"huyền thoại boong", "Huyền Thoại Bộ Bài", l, flags=re.I)
    l = sub_line(r"\bboong\b", "bộ bài", l)
    l = sub_line(r"\bBoong\b", "Bộ Bài", l)
    l = sub_line(r"trò chơi giết", "Đấu Trường Sinh Tử", l, flags=re.I)

    # Summon terms: Link, Synchro, Xyz, Dung Hợp (NO Vietnamese translation for Link/Synchro/Xyz, Dung Hợp for Fusion)
    # Link:
    l = sub_line(r"\btriệu hồi liên kết\b", "Triệu Hồi Link", l, flags=re.I)
    l = sub_line(r"\bquái thú liên kết\b", "Quái Thú Link", l, flags=re.I)
    l = sub_line(r"\bnguyên liệu liên kết\b", "nguyên liệu Link", l, flags=re.I)
    l = sub_line(r"\bvật liệu kết nối\b", "nguyên liệu Link", l, flags=re.I)
    l = sub_line(r"\bmũi tên liên kết\b", "mũi tên Link", l, flags=re.I)
    l = sub_line(r"\bmũi tên kết nối\b", "mũi tên Link", l, flags=re.I)
    l = sub_line(r"\bchỉ số liên kết\b", "chỉ số Link", l, flags=re.I)
    l = sub_line(r"\bkết nối đấu tay đôi\b", "Quyết Đấu Link", l, flags=re.I)
    l = sub_line(r"Dung hợp - Đồng bộ - Hyper và Liên kết", "Dung Hợp - Synchro - Xyz và Link", l, flags=re.I)
    l = sub_line(r"Dung hợp - Đồng bộ - Hyper - Liên kết", "Dung Hợp - Synchro - Xyz - Link", l, flags=re.I)
    l = sub_line(r"Dung hợp - Tế lễ - Hyper hoặc Liên kết", "Dung Hợp - Nghi Thức - Xyz hoặc Link", l, flags=re.I)

    # Synchro:
    l = sub_line(r"\btriệu hồi đồng bộ\b", "Triệu Hồi Synchro", l, flags=re.I)
    l = sub_line(r"\bquái thú đồng bộ\b", "Quái Thú Synchro", l, flags=re.I)
    l = sub_line(r"\bnguyên liệu đồng bộ\b", "nguyên liệu Synchro", l, flags=re.I)
    l = sub_line(r"\btài liệu đồng bộ\b", "nguyên liệu Synchro", l, flags=re.I)
    l = sub_line(r"\bĐồng bộ hóa\b", "Synchro", l, flags=re.I)
    l = sub_line(r"\btừ chối sự tương đồng\b", "Phân Tách Synchro", l, flags=re.I)
    l = sub_line(r"\bsự tương đồng\b", "Synchro", l, flags=re.I)
    l = sub_line(r"\bquái thú điều chỉnh\b", "Quái Thú Tuner", l, flags=re.I)

    # Xyz:
    l = sub_line(r"\bHyper Summon\b", "Triệu Hồi Xyz", l, flags=re.I)
    l = sub_line(r"\btriệu hồi siêu lượng\b", "Triệu Hồi Xyz", l, flags=re.I)
    l = sub_line(r"\bquái thú siêu lượng\b", "Quái Thú Xyz", l, flags=re.I)
    l = sub_line(r"\bnguyên liệu siêu lượng\b", "nguyên liệu Xyz", l, flags=re.I)
    l = sub_line(r"\bvật liệu thừa\b", "nguyên liệu Xyz", l, flags=re.I)
    l = sub_line(r"\bSynchro và Hyper Summon\b", "Synchro và Triệu Hồi Xyz", l, flags=re.I)

    # Dung Hợp:
    l = sub_line(r"\btriệu hồi dung hợp\b", "Triệu Hồi Dung Hợp", l, flags=re.I)
    l = sub_line(r"\bquái thú dung hợp\b", "Quái Thú Dung Hợp", l, flags=re.I)
    l = sub_line(r"\bnguyên liệu dung hợp\b", "nguyên liệu Dung Hợp", l, flags=re.I)
    l = sub_line(r"\bvật liệu tổng hợp\b", "nguyên liệu Dung Hợp", l, flags=re.I)
    l = sub_line(r"quái thú Dung hợp", "Quái Thú Dung Hợp", l)
    l = sub_line(r"\bDung hợp\b", "Dung Hợp", l)

    # Pendulum:
    l = sub_line(r"Quái Thú con lắc", "Quái Thú Pendulum", l)
    l = sub_line(r"quái thú con lắc", "Quái Thú Pendulum", l)

    # Archetype cleanups - no Hán Việt like Chân Hồng Nhãn:
    l = sub_line(r"Chân Hồng Nhãn", "Mắt Đỏ", l)
    l = sub_line(r"chân hồng nhãn", "mắt đỏ", l)
    l = sub_line(r"AMa Phápzon", "Amazoness", l)
    l = sub_line(r"\bmắt xanh lam\b", "Mắt Xanh", l, flags=re.I)
    l = sub_line(r"<mắt xanh>", "<Mắt Xanh>", l, flags=re.I)
    l = sub_line(r"<Mắt xanh>", "<Mắt Xanh>", l)
    l = sub_line(r"rồng trắng mắt xanh", "Rồng Trắng Mắt Xanh", l, flags=re.I)
    l = sub_line(r"<Blue Eyes White Dragon>", "<Rồng Trắng Mắt Xanh>", l)
    l = sub_line(r"<Phù Thủy bóng tối>", "<Phù Thủy Áo Đen>", l)
    l = sub_line(r"<Phù Thủy Bóng Tối>", "<Phù Thủy Áo Đen>", l)
    l = sub_line(r"<Salamon Reincarnation>", "<Hỏa Thú Luân Hồi>", l)
    l = sub_line(r"<Black Feather>", "<Lông Đen Blackwing>", l)

    # Duel terms:
    l = sub_line(r"đấu tay đôi với Quái Thú", "Quyết Đấu Quái Thú", l, flags=re.I)
    l = sub_line(r"Cuộc đấu tay đôi của Quái Thú", "Đấu Trường Quái Thú", l, flags=re.I)
    l = sub_line(r"Học viện đấu tay đôi", "Học Viện Quyết Đấu", l, flags=re.I)
    l = sub_line(r"vương quốc đấu tay đôi", "Vương Quốc Quyết Đấu", l, flags=re.I)
    l = sub_line(r"vua đấu tay đôi", "Vua Quyết Đấu", l, flags=re.I)
    l = sub_line(r"trò chơi vua đấu tay đôi", "Vua Trò Chơi Quyết Đấu", l, flags=re.I)

    # Barriers:
    l = sub_line(r"Rào chắn Quái Thú - Phép thuật và Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", l, flags=re.I)
    l = sub_line(r"Quái Thú - Phép Thuật - Rào chắn Bẫy", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", l, flags=re.I)
    l = sub_line(r"Trận chiến·Quái Thú·Phép Thuật·Bẫy rào chắn", "Tường chắn Toàn Diện: Chiến Đấu - Quái - Phép - Bẫy", l, flags=re.I)
    l = sub_line(r"Quái Thú·Phép Thuật·Bẫy Rào chắn", "Tường chắn Quái Thú - Phép Thuật - Cạm Bẫy", l, flags=re.I)

    l = sub_line(r"Rào Chắn Quái Thú", "Tường Chắn Quái Thú", l)
    l = sub_line(r"rào chắn Quái Thú", "Tường chắn Quái Thú", l)
    l = sub_line(r"rào chắn quái thú", "Tường chắn Quái Thú", l)
    l = sub_line(r"Rào Chắn Cạm Bẫy", "Tường Chắn Cạm Bẫy", l)
    l = sub_line(r"rào chắn Cạm Bẫy", "Tường chắn Cạm Bẫy", l)
    l = sub_line(r"rào chắn Bẫy", "Tường chắn Cạm Bẫy", l)
    l = sub_line(r"rào chắn Phép Thuật", "Tường chắn Phép Thuật", l)
    l = sub_line(r"Rào chắn Phép Thuật", "Tường Chắn Phép Thuật", l)
    l = sub_line(r"Rào chắn Phép thuật", "Tường Chắn Phép Thuật", l)
    l = sub_line(r"rào chắn phép thuật", "Tường chắn Phép Thuật", l)
    l = sub_line(r"rào chắn chiến đấu", "Tường chắn Chiến Đấu", l)
    l = sub_line(r"khiên chiến đấu", "Tường chắn Chiến Đấu", l)
    l = sub_line(r"Hiệu ứng Phá hủy Rào chắn", "Tường chắn Phá Hủy", l)
    l = sub_line(r"Phá hủy Rào chắn", "Tường chắn Phá Hủy", l)
    l = sub_line(r"Phá hủy rào chắn", "Tường chắn Phá Hủy", l)
    l = sub_line(r"Tiêu diệt Rào chắn", "Tường chắn Phá Hủy", l)

    l = sub_line(r"bỏ qua <rào chắn", "bỏ qua <Tường chắn", l)
    l = sub_line(r"bỏ qua <Rào chắn", "bỏ qua <Tường chắn", l)
    l = sub_line(r"\(xuyên thủng rào chắn\)", "xuyên Tường chắn", l)
    l = sub_line(r"\(xuyên thủng\)", "xuyên Tường chắn", l)

    # Mechanics & LP:
    l = sub_line(r"Mạng sống của người chơi của bạn", "Điểm gốc LP", l)
    l = sub_line(r"mạng sống của người chơi của bạn", "Điểm gốc LP", l)
    l = sub_line(r"mạng sống của người chơi đối phương", "Điểm gốc LP của đối phương", l)
    l = sub_line(r"Bẫy Ma Pháp thuật", "Phép & Bẫy", l)
    l = sub_line(r"bẫy Ma Pháp thuật", "Phép & Bẫy", l)
    l = sub_line(r"lá bài bẫy Ma Pháp thuật", "lá bài Phép Thuật hoặc Cạm Bẫy", l)
    l = sub_line(r"Ma Pháp thuật hoặc Cạm Bẫy", "Phép Thuật hoặc Cạm Bẫy", l)
    l = sub_line(r"Ma Pháp thuật", "Phép Thuật", l)

    assert '\n' not in l, f"Line {i} created an internal newline!"
    clean_lines.append(l)

assert len(clean_lines) == 56673, f"Clean lines count {len(clean_lines)} != 56673"
print(f"Verified all 56673 lines! Joining with newline...")

final_content = "\n".join(clean_lines).encode('utf-8')
lines_check = final_content.split(b'\n')
print(f"Final output lines count: {len(lines_check)} (must be 56673)")
assert len(lines_check) == 56673

# Re-encrypt
orig_path = r"D:\yugitauapk\extracted\1.0.7\res\lan.lcres"
with open(orig_path, "rb") as f:
    orig = f.read()

cur_key = struct.unpack('<I', orig[4:8])[0]
delta_key = struct.unpack('<I', orig[8:12])[0]
orig_md5 = orig[12:44]

enc_fn = encrypt_data(b'extend.lan', cur_key)
k2 = (cur_key + delta_key) & 0xFFFFFFFF
enc_data = encrypt_data(final_content, k2)

rebuilt = bytearray()
rebuilt.extend(b'LCR\x01')
rebuilt.extend(struct.pack('<II', cur_key, delta_key))
rebuilt.extend(orig_md5)
rebuilt.append(0)
rebuilt.append(1)
rebuilt.extend(struct.pack('<I', len(final_content)))
rebuilt.append(len(b'extend.lan'))
rebuilt.extend(enc_fn)
rebuilt.extend(struct.pack('<I', len(enc_data)))
rebuilt.extend(enc_data)

target_res = r"D:\yugitauapk\extracted\1.0.7\res\lan.lcres"
with open(target_res, "wb") as f:
    f.write(rebuilt)
print(f"Encrypted new lan.lcres ({len(rebuilt)} bytes) successfully with EXACT 56673 lines!")
