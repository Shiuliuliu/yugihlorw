from PIL import Image
import io

with open(r"D:\yugitauapk\web\res\cards_img_1.lcres\cards_img_1.jpm", "rb") as f:
    data = f.read()

jpeg_start = data.find(b"\xff\xd8\xff")
print("JPEG start offset:", jpeg_start)
jpeg_data = data[jpeg_start:]

# Try to find end of JPEG
jpeg_end = jpeg_data.find(b"\xff\xd9")
if jpeg_end != -1:
    print("JPEG end offset:", jpeg_start + jpeg_end + 2)
    raw_jpeg = jpeg_data[:jpeg_end + 2]
    img = Image.open(io.BytesIO(raw_jpeg))
    print("Image size:", img.size)

    # Let's crop 12, 13, 14, 15
    crops = {
        "12": (1210, 491, 1210+24, 491+24),
        "13": (1184, 630, 1184+24, 630+24),
        "14": (1200, 586, 1200+24, 586+24),
        "15": (1225, 518, 1225+24, 518+24)
    }

    for k, box in crops.items():
        c = img.crop(box)
        c.save(rf"D:\yugitauapk\crop_{k}.png")
        print(f"Saved crop_{k}.png")
