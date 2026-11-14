from PIL import Image

def analyze_rgba(num):
    im = Image.open(f"D:/yugitauapk/rgba_{num}.png")
    w, h = im.size
    print(f"=== RGBA {num} ===")
    for y in range(h):
        line = ""
        for x in range(w):
            r, g, b, a = im.getpixel((x, y))
            if a < 30:
                line += " "
            elif (r + g + b) // 3 > 128:
                line += "#"
            else:
                line += "."
        print(f"{y:2d}: {line}")

analyze_rgba("12")
analyze_rgba("13")
analyze_rgba("14")
analyze_rgba("15")
