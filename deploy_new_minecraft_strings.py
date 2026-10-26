import sys, os

sys.stdout.reconfigure(encoding='utf-8')

EXTEND_LAN = r"D:\yugitauapk\web\res\lan.lcres\extend.lan"

with open(EXTEND_LAN, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

current_count = len(lines)
print(f"Current extend.lan line count: {current_count}")

new_strings = [
    # 57341 - 57347: Ender Dragon
    "Ender Dragon",
    r'[Rồng / Hiệu Ứng]\n+ Nguyên tố tương tác (3043): Miễn nhiễm quái thú, phép và bẫy.\n+ Trong Mộ phe ta có từ 5 quái có từ khóa "minecraft" trở lên có thể triệu hồi đặc biệt lá bài này từ tay.\n+ Khi lá bài này bị phá hủy, phe ta tăng LP bằng tổng tấn công quái thú trên sân đối phương.',
    "Ender Dragon",
    "Ender Dragon - Giáng Lâm Hư Không",
    'Trong Mộ phe ta có từ 5 quái có từ khóa "minecraft" trở lên có thể triệu hồi đặc biệt lá bài này từ tay.',
    "Ender Dragon - Hồn Rồng Bất Diệt",
    "Khi lá bài này bị phá hủy, phe ta tăng LP bằng tổng tấn công quái thú trên sân đối phương.",

    # 57348 - 57352: Command Block
    "Command Block",
    r'[Phép Thường]\nLấy 1 lá bài có từ khóa "minecraft" từ Mộ hoặc Bộ bài lên tay.',
    "Command Block",
    "Command Block - Lệnh Triệu Hồi",
    'Lấy 1 lá bài có từ khóa "minecraft" từ Mộ hoặc Bộ bài lên tay.',

    # 57353 - 57359: Totem
    "Totem",
    r'[Bẫy Thường]\n+ 1 lượt 1 lần, khi quái có từ khóa "minecraft" trên sân phe ta bị phá hủy sẽ kích hoạt, bỏ qua 1 lần bị phá hủy.\n+ 1 lượt 1 lần, khi lá bài này trên tay, quái thú đối phương tấn công trực tiếp và điểm tấn công của quái đối phương lớn hơn hoặc bằng điểm LP phe ta sẽ kích hoạt: Đưa lá bài này vào Mộ, phe ta nhận 1 tầng "Khiên Sinh Mệnh" trong lượt này và 1000 LP.',
    "Totem",
    "Totem - Bất Tử Hộ Mệnh",
    '1 lượt 1 lần, khi quái có từ khóa "minecraft" trên sân phe ta bị phá hủy sẽ kích hoạt, bỏ qua 1 lần bị phá hủy.',
    "Totem - Thần Tượng Trường Sinh",
    '1 lượt 1 lần, khi lá bài này trên tay, quái thú đối phương tấn công trực tiếp và điểm tấn công của quái đối phương lớn hơn hoặc bằng điểm LP phe ta sẽ kích hoạt: Đưa lá bài này vào Mộ, phe ta nhận 1 tầng "Khiên Sinh Mệnh" trong lượt này và 1000 LP.',

    # 57360 - 57366: Táo vàng được phù phép
    "Táo vàng được phù phép",
    r'[Phép Thường]\n+ Phe ta nhận 3000 LP, nếu LP phe ta thấp hơn 8000 sẽ cộng thêm LP để LP bằng 8000.\n+ Khi bài này trong Mộ, mỗi lượt tăng 400 LP cho phe ta (14797).\n+ Nguồn thanh tẩy (9232): Khi chịu sát thương hiệu ứng hoặc sát thương trực tiếp, đưa lá bài này từ tay vào Mộ để vô hiệu hóa và hồi LP tương ứng.',
    "Táo vàng được phù phép",
    "Táo vàng - Hồi Phục Thần Thánh",
    "Phe ta nhận 3000 LP, nếu LP phe ta thấp hơn 8000 sẽ cộng thêm LP để LP bằng 8000.",
    "Táo vàng - Tinh Chất Hoàng Kim",
    "Khi lá bài này trong Mộ, ở giai đoạn chuẩn bị mỗi hiệp, phe ta hồi phục 400 LP.",

    # 57367 - 57371: Trứng rồng ender
    "Trứng rồng ender",
    r'[Rồng / Hiệu Ứng]\n+ Khiên chắn phá hủy (12006): Không thể bị tiêu diệt trong chiến đấu hoặc bởi hiệu ứng.\n+ Kĩ năng chủ động (1 lượt 1 lần): Đưa lá bài này vào Mộ, chọn triệu hồi đặc biệt 1 <Ender Dragon> từ trong Bộ bài, Bài trên tay hoặc Mộ bài lên sân. Sau đó trong lượt này phe ta chỉ có thể triệu hồi đặc biệt quái có từ khóa "minecraft".',
    "Trứng rồng ender",
    "Trứng rồng - Khơi Dậy Hắc Long",
    r'1 lượt 1 lần, đưa lá bài này vào Mộ: Chọn triệu hồi đặc biệt 1 <Ender Dragon> từ trong Bộ bài, Bài trên tay hoặc Mộ bài lên sân. Sau đó lượt này phe ta chỉ có thể triệu hồi đặc biệt quái có từ khóa "minecraft".'
]

if current_count < 57340:
    print(f"[ERR] Unexpected line count {current_count}, expected >= 57340")
elif current_count == 57340:
    with open(EXTEND_LAN, 'a', encoding='utf-8') as f:
        for s in new_strings:
            f.write(s + "\n")
    print(f"[OK] Appended {len(new_strings)} strings. New total lines: {current_count + len(new_strings)}")
else:
    print(f"[INFO] extend.lan already has {current_count} lines (> 57340). Checking if strings already present...")
    if lines[57340].strip() == "Ender Dragon":
        print("[SKIP] Strings 57341+ already present in extend.lan")
    else:
        print(f"[WARN] Line 57341 is: {lines[57340].strip()}")
