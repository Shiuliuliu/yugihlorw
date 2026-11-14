from PIL import Image

def ascii_art(filename):
    img = Image.open(filename).convert("L")
    w, h = img.size
    print(f"=== {filename} ({w}x{h}) ===")
    for y in range(0, h, 2):
        line = ""
        for x in range(w):
            p = img.getpixel((x, y))
            line += " " if p < 128 else "#"
        print(line)

for k in ["12", "13", "14", "15"]:
    ascii_art(rf"D:\yugitauapk\crop_{k}.png")
