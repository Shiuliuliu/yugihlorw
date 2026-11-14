from PIL import Image

im = Image.open(r"D:\yugitauapk\user_top_right.png").convert("L")
w, h = im.size
print(f"User top right ({w}x{h}):")
for y in range(0, h, 3):
    line = ""
    for x in range(0, w, 2):
        p = im.getpixel((x, y))
        line += " " if p < 80 else ("." if p < 160 else "#")
    print(f"{y:2d}: {line}")
