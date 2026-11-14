# -*- coding: utf-8 -*-
import os, io, struct, json
from PIL import Image

WEB_DIR = r"D:\yugitauapk\web"
RES_DIR = os.path.join(WEB_DIR, "res")

CARDS = [
    {
        "id": 12387,
        "src": r"D:\yugitauapk\web\res\new\thumb\liqi\dolia.png"
    },
    {
        "id": 12388,
        "src": r"D:\yugitauapk\web\res\new\thumb\liqi\heino.png"
    },
    {
        "id": 40782,
        "src": r"D:\yugitauapk\web\res\new\thumb\liqi\heinoxdolia.png"
    }
]

print("[*] Starting deploy_new_3_cards_assets.py...")

res_js_path = os.path.join(WEB_DIR, "js", "res.js")
manifest_path = os.path.join(WEB_DIR, "res_manifest.json")

manifest = {}
if os.path.exists(manifest_path):
    try:
        with open(manifest_path, "r", encoding="utf-8") as f:
            manifest = json.load(f)
    except Exception as e:
        print("[WARN] Failed to load manifest:", e)

with open(res_js_path, "r", encoding="utf-8") as f:
    res_js = f.read()

lcres_dirs = [
    os.path.join(RES_DIR, "new", "thumb_monster.lcres"),
    os.path.join(RES_DIR, "new", "thumb_rare.lcres"),
    os.path.join(RES_DIR, "new", "thumb_magic.lcres"),
    os.path.join(RES_DIR, "new", "thumb_trap.lcres"),
]

for card in CARDS:
    cid = card["id"]
    src_path = card["src"]
    print(f"\nProcessing Card {cid} from {src_path}...")
    if not os.path.exists(src_path):
        print(f"[ERR] File not found: {src_path}")
        continue

    src = Image.open(src_path).convert("RGBA")

    # 1. card_ico_{cid}.png (82x82)
    ico = src.resize((82, 82), Image.LANCZOS)
    ico_path_1 = os.path.join(RES_DIR, f"card_ico_{cid}.png")
    ico_path_2 = os.path.join(RES_DIR, "new", "thumb", f"card_ico_{cid}.png")
    os.makedirs(os.path.dirname(ico_path_2), exist_ok=True)
    ico.save(ico_path_1, "PNG")
    ico.save(ico_path_2, "PNG")
    print(f"[OK] Saved icons for {cid}")

    # 2. card_{cid}.jpm (256x256)
    card_img = src.resize((256, 256), Image.LANCZOS)
    rgb = card_img.convert("RGB")
    alpha = card_img.split()[3]

    rgb_buf = io.BytesIO()
    rgb.save(rgb_buf, format="JPEG", quality=90)
    rgb_bytes = rgb_buf.getvalue()

    alpha_buf = io.BytesIO()
    alpha.save(alpha_buf, format="PNG")
    alpha_bytes = alpha_buf.getvalue()

    jpm_header = b'JPM\x01' + struct.pack('>II', len(rgb_bytes), len(alpha_bytes))
    jpm_bytes = jpm_header + rgb_bytes + alpha_bytes

    temp_jpm_path = os.path.join(RES_DIR, f"card_{cid}.jpm")
    with open(temp_jpm_path, "wb") as f:
        f.write(jpm_bytes)
    print(f"[OK] Saved JPM ({len(jpm_bytes)} bytes) for {cid}")

    # 3. Inject JPM into lcres dirs
    for d in lcres_dirs:
        if os.path.isdir(d):
            target = os.path.join(d, f"card_{cid}.jpm")
            with open(target, "wb") as f:
                f.write(jpm_bytes)

    # 4. Update res.js CUSTOM_ICON_REPLACEMENTS
    target_str = f"'{cid}': 'res/new/thumb/card_ico_{cid}.png',"
    if target_str not in res_js:
        pattern = "var CUSTOM_ICON_REPLACEMENTS = {"
        if pattern in res_js:
            res_js = res_js.replace(pattern, pattern + f"\n\t'{cid}': 'res/new/thumb/card_ico_{cid}.png',")
            print(f"[OK] Added {cid} to res.js")

    # 5. Manifest
    rel_path = f"res/new/thumb/card_ico_{cid}.png"
    manifest[rel_path] = len(open(ico_path_2, "rb").read())

with open(res_js_path, "w", encoding="utf-8") as f:
    f.write(res_js)

if manifest:
    try:
        with open(manifest_path, "w", encoding="utf-8") as f:
            json.dump(manifest, f, indent=2)
        print("[OK] Updated res_manifest.json")
    except Exception as e:
        print("[WARN] Failed to write manifest:", e)

print("[*] Assets deployment finished successfully!")
