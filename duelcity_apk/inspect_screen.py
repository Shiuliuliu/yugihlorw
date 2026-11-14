from PIL import Image
import sys

sys.stdout.reconfigure(encoding='utf-8')

im = Image.open(r'D:\yugitauapk\duelcity_apk\mumu_screen2.png')
w, h = im.size
print('Screen size:', w, h)

# Save thumbnail for inspection
thumb = im.resize((800, 450))
thumb.save(r'D:\yugitauapk\duelcity_apk\screen_small.png')
print('Saved small screen')
