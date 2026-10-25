import os, sys
sys.stdout.reconfigure(encoding='utf-8')

LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

desc_40746 = (
    '[Chiến Binh - Hiệu Quả - Link]\\n'
    '2 quái trở lên, trong đó gồm 1 quái có từ khóa "Kiếm phá hủy".\\n'
    '(1) Mỗi lượt chỉ 1 lần. Khi bài này nằm trong bộ bài thêm; trên sân phe ta không có quái hoặc trên sân phe ta chỉ có quái có từ khóa “Kiếm sĩ diệt rồng”; đồng thời đối thủ Triệu Hồi Đặc Biệt quái tộc "rồng" sẽ có thể dùng. Hi sinh bản thân bài này; khi bài này nằm trong mộ; loại bỏ bài của đối thủ bị đưa vào mộ từ trên sân.\\n'
    '(2) 1 lượt 1 lần, Khi lá bài này được triệu hồi lên sân, ngẫu nhiên loại bỏ tối đa 2 quái tộc "rồng" trong bộ bài thêm đối thủ.\\n'
    '(3) Kẻ Diệt Rồng: Tăng ATK/DEF theo số lượng quái tộc Rồng trên sân và mộ đối thủ x1000.\\n'
    '(4) Lá Chắn Năng Lượng: Khi được Triệu Hồi Đặc Biệt, nhận Khiên Quái, Phép, Bẫy.\\n'
    '(5) 1 lượt 1 lần, khi lá bài này trên sân, đối phương triệu hồi/triệu hồi đặc biệt quái tộc "rồng" sẽ kích hoạt, đưa quái đó vào mộ (Xuyên qua tường chắn quái), sau đó lượt này đối phương không thể triệu hồi/triệu hồi đặc biệt quái tộc "rồng".\\n'
    '(6) Khi quái đối thủ rời sân trong lượt đối thủ: đối thủ không thể triệu hồi thông thường hoặc Triệu Hồi Đặc Biệt quái tộc "rồng" ở lượt này. Tất cả Quái Vật tộc "rồng" của đối thủ không thể tấn công . đưa tất cả quái tộc "rồng" trên tay đối phương vào mộ.\n'
)

new_entries = {
    57308: 'Kỵ sĩ diệt rồng\n',
    57309: desc_40746,
    57310: 'Kỵ sĩ diệt rồng\n',
    57311: 'Kỵ Sĩ - Giáng Long Trảm\n',
    57312: 'Mỗi lượt chỉ 1 lần. Khi bài này nằm trong bộ bài thêm; trên sân phe ta không có quái hoặc trên sân phe ta chỉ có quái có từ khóa “Kiếm sĩ diệt rồng”; đồng thời đối thủ Triệu Hồi Đặc Biệt quái tộc "rồng" sẽ có thể dùng. Hi sinh bản thân bài này; khi bài này nằm trong mộ; loại bỏ bài của đối thủ bị đưa vào mộ từ trên sân.\n',
    57313: 'Kỵ Sĩ - Tuyệt Long Uyển\n',
    57314: '1 lượt 1 lần, Khi lá bài này được triệu hồi lên sân, ngẫu nhiên loại bỏ tối đa 2 quái tộc "rồng" trong bộ bài thêm đối thủ.\n',
    57315: 'Kỵ Sĩ - Trảm Long Quyết\n',
    57316: '1 lượt 1 lần, khi lá bài này trên sân, đối phương triệu hồi/triệu hồi đặc biệt quái tộc "rồng" sẽ kích hoạt, đưa quái đó vào mộ (Xuyên qua tường chắn quái), sau đó lượt này đối phương không thể triệu hồi/triệu hồi đặc biệt quái tộc "rồng".\n',
    57317: 'Kỵ Sĩ - Long Uy Tận Diệt\n',
    57318: 'Khi đối thủ rời sân trong lượt đối thủ: đối thủ không thể triệu hồi thông thường hoặc Triệu Hồi Đặc Biệt quái tộc "rồng" ở lượt này. Tất cả Quái Vật tộc "rồng" của đối thủ không thể tấn công . đưa tất cả quái tộc "rồng" trên tay đối phương vào mộ.\n'
}

def update_file(p):
    with open(p, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    print(f"Current lines in {p}: {len(lines)}")
    while len(lines) < 57318:
        lines.append('\n')
    for sid, text in new_entries.items():
        lines[sid - 1] = text
    with open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.writelines(lines)
    print(f"Updated {p}, now {len(lines)} lines")

for p in LAN_FILES:
    if os.path.isfile(p):
        update_file(p)

print("[OK] Language files updated successfully!")
