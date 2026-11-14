from PIL import Image

def analyze_crop(num):
    im = Image.open(f"D:/yugitauapk/crop_{num}.png").convert("RGB")
    w, h = im.size
    print(f"Crop {num} ({w}x{h}):")
    # print all pixels > 50 brightness
    for y in range(h):
        row = ""
        for x in range(w):
            r, g, b = im.getpixel((x, y))
            lum = (r + g + b) // 3
            if lum < 50:
                row += " "
            elif lum < 150:
                row += "."
            else:
                row += "#"
        print(f"{y:2d}: {row}")

analyze_crop("12")
analyze_crop("13")
