# -*- coding: utf-8 -*-
"""
deploy_helen_assets.py
Tạo asset JPM + icon cho Helen (12386) từ D:\yugitauapk\web\res\new\thumb\liqi\helen.png
"""
import os
import io
import struct
import json
from PIL import Image

SRC_IMG = r"D:\yugitauapk\web\res\new\thumb\liqi\helen.png"
CARD_ID = 12386
WEB_DIR = r"D:\yugitauapk\web"
RES_DIR = os.path.join(WEB_DIR, "res")

print(f"[*] Starting deploy_helen_assets.py for Card ID {CARD_ID}...")

if not os.path.exists(SRC_IMG):
    raise FileNotFoundError(f"Source image not found: {SRC_IMG}")

src = Image.open(SRC_IMG).convert("RGBA")

# 1. Create card_ico_12386.png (82x82)
ico = src.resize((82, 82), Image.LANCZOS)
ico_path_1 = os.path.join(RES_DIR, f"card_ico_{CARD_ID}.png")
ico_path_2 = os.path.join(RES_DIR, "new", "thumb", f"card_ico_{CARD_ID}.png")
os.makedirs(os.path.dirname(ico_path_2), exist_ok=True)
ico.save(ico_path_1, "PNG")
ico.save(ico_path_2, "PNG")
print(f"[OK] Saved icons: {ico_path_1} and {ico_path_2}")

# 2. Create card_12386.jpm (256x256 RGB JPEG + Alpha Mask PNG)
card_img = src.resize((256, 256), Image.LANCZOS)
rgb = card_img.convert("RGB")
alpha = card_img.split()[3]

rgb_buf = io.BytesIO()
rgb.save(rgb_buf, format="JPEG", quality=90)
rgb_bytes = rgb_buf.getvalue()

alpha_buf = io.BytesIO()
alpha.save(alpha_buf, format="PNG")
alpha_bytes = alpha_buf.getvalue()

# JPM format: 'JPM\x01' + struct.pack('>II', len(rgb_bytes), len(alpha_bytes)) + rgb_bytes + alpha_bytes
jpm_header = b'JPM\x01' + struct.pack('>II', len(rgb_bytes), len(alpha_bytes))
jpm_bytes = jpm_header + rgb_bytes + alpha_bytes

temp_jpm_path = os.path.join(RES_DIR, f"card_{CARD_ID}.jpm")
with open(temp_jpm_path, "wb") as f:
    f.write(jpm_bytes)
print(f"[OK] Created JPM ({len(jpm_bytes)} bytes): {temp_jpm_path}")

# 3. Inject card_12386.jpm into lcres packages
lcres_dirs = [
    os.path.join(RES_DIR, "new", "thumb_monster.lcres"),
    os.path.join(RES_DIR, "new", "thumb_rare.lcres"),
    os.path.join(RES_DIR, "new", "thumb_magic.lcres"),
    os.path.join(RES_DIR, "new", "thumb_trap.lcres"),
]

for d in lcres_dirs:
    if os.path.isdir(d):
        target = os.path.join(d, f"card_{CARD_ID}.jpm")
        with open(target, "wb") as f:
            f.write(jpm_bytes)
        print(f"[OK] Injected into {d}")

# 4. Update res.js CUSTOM_ICON_REPLACEMENTS
res_js_path = os.path.join(WEB_DIR, "js", "res.js")
if os.path.exists(res_js_path):
    with open(res_js_path, "r", encoding="utf-8") as f:
        res_js = f.read()

    target_str = f"'{CARD_ID}': 'res/new/thumb/card_ico_{CARD_ID}.png',"
    if target_str not in res_js:
        pattern = "var CUSTOM_ICON_REPLACEMENTS = {"
        if pattern in res_js:
            res_js = res_js.replace(pattern, pattern + f"\n\t'{CARD_ID}': 'res/new/thumb/card_ico_{CARD_ID}.png',")
            with open(res_js_path, "w", encoding="utf-8") as f:
                f.write(res_js)
            print(f"[OK] Added {CARD_ID} to CUSTOM_ICON_REPLACEMENTS in res.js")
        else:
            print("[WARN] Could not find CUSTOM_ICON_REPLACEMENTS in res.js")
    else:
        print("[SKIP] Already in res.js")

# 5. Update res_manifest.json if present
manifest_path = os.path.join(WEB_DIR, "res_manifest.json")
if os.path.exists(manifest_path):
    try:
        with open(manifest_path, "r", encoding="utf-8") as f:
            manifest = json.load(f)
        rel_path = f"res/new/thumb/card_ico_{CARD_ID}.png"
        manifest[rel_path] = len(open(ico_path_2, "rb").read())
        with open(manifest_path, "w", encoding="utf-8") as f:
            json.dump(manifest, f, indent=2)
        print("[OK] Updated res_manifest.json")
    except Exception as e:
        print("[WARN] res_manifest update failed:", e)

print("[*] Assets deployment complete!")
