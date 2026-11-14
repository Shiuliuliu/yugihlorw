import sys

sys.stdout.reconfigure(encoding='utf-8')

path = r"D:\yugitauapk\web\src\PlayerUi.lua"
with open(path, "r", encoding="utf-8") as f:
    text = f.read()

fixes = [
    ('var_85_1 = "Chọn 1 lá bài Phép/Bẫy "Labrynth" từ bộ bài vào tay"', 'var_85_1 = "Chọn 1 lá bài Phép/Bẫy \\"Labrynth\\" từ bộ bài vào tay"'),
    ('var_85_1 = "Chọn 1 quái thú "Labrynth" 5 hoặc 7 sao từ bộ bài lên sân"', 'var_85_1 = "Chọn 1 quái thú \\"Labrynth\\" 5 hoặc 7 sao từ bộ bài lên sân"'),
    ('var_85_1 = "Chọn 1 lá bài "Labrynth" từ mộ vào tay"', 'var_85_1 = "Chọn 1 lá bài \\"Labrynth\\" từ mộ vào tay"'),
    ('var_85_1 = "Chọn 1 quái thú "Labrynth" 4 sao trở xuống từ bộ bài vào tay"', 'var_85_1 = "Chọn 1 quái thú \\"Labrynth\\" 4 sao trở xuống từ bộ bài vào tay"'),
    ('var_85_1 = "Chọn 1 quái thú "Labrynth" từ trên tay lên sân"', 'var_85_1 = "Chọn 1 quái thú \\"Labrynth\\" từ trên tay lên sân"'),
    ('var_85_1 = "Chọn 1 quái "Labrynth" 8 sao trong mộ để triệu hồi"', 'var_85_1 = "Chọn 1 quái \\"Labrynth\\" 8 sao trong mộ để triệu hồi"'),
]

for old, new in fixes:
    if old in text:
        text = text.replace(old, new)
        print(f"[OK] Replaced: {old[:50]}")
    else:
        print(f"[SKIP/NOT FOUND]: {old[:50]}")

with open(path, "w", encoding="utf-8") as f:
    f.write(text)

print("[DONE] Finished fixing quotes in PlayerUi.lua")
