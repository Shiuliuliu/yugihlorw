from PIL import Image
import io

with open(r"D:\yugitauapk\web\res\cards_img_1.lcres\cards_img_1.jpm", "rb") as f:
    header = f.read(12)
    colorLen = int.from_bytes(header[4:8], "little")
    alphaLen = int.from_bytes(header[8:12], "little")
    colorBytes = f.read(colorLen)
    alphaBytes = f.read(alphaLen)

rgb = Image.open(io.BytesIO(colorBytes)).convert("RGB")
alpha = Image.open(io.BytesIO(alphaBytes)).convert("L")

print("RGB size:", rgb.size, "Alpha size:", alpha.size)
rgba = Image.new("RGBA", rgb.size)
rgba.paste(rgb, (0, 0))
rgba.putalpha(alpha)

# Coordinates from parse_frames:
# {"name":"card_magictrap_12","x":1210,"y":491,"w":24,"h":24,"rotated":false,"ox":87,"oy":138,"ow":282,"oh":390}
# {"name":"card_magictrap_13","x":1184,"y":630,"w":24,"h":24,"rotated":false,"ox":87,"oy":138,"ow":282,"oh":390}
# {"name":"card_magictrap_14","x":1200,"y":586,"w":24,"h":24,"rotated":false,"ox":88,"oy":138,"ow":282,"oh":390}
# {"name":"card_magictrap_15","x":1225,"y":518,"w":24,"h":24,"rotated":false,"ox":87,"oy":138,"ow":282,"oh":390}

crops = {
    "12": (1210, 491, 1210+24, 491+24),
    "13": (1184, 630, 1184+24, 630+24),
    "14": (1200, 586, 1200+24, 586+24),
    "15": (1225, 518, 1225+24, 518+24)
}

for name, box in crops.items():
    c = rgba.crop(box)
    c.save(f"D:/yugitauapk/rgba_{name}.png")
    print(f"Saved rgba_{name}.png")
