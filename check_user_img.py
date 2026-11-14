from PIL import Image

im = Image.open(r"C:\Users\Nitro 5\.gemini\antigravity\brain\1935a16b-edc5-417f-a74d-a2641dd97101\.user_uploaded\media_1794341570016_f3e65ff5.jpg")
w, h = im.size
print(f"User image size: {w}x{h}")

# The card in the image: top right icon
# Let's crop the top-right area (x from 0.7*w to w, y from 0 to 0.25*h)
crop_top_right = im.crop((int(0.7 * w), 0, w, int(0.25 * h)))
crop_top_right.save(r"D:\yugitauapk\user_top_right.png")
print("Saved user_top_right.png")
