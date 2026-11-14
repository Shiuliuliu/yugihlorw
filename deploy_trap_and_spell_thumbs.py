import os, json, struct, io, sys
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')
WEB_DIR = r"D:\yugitauapk\web"
LA_DIR = r"D:\yugitauapk\web\res\new\thumb\la"

CARDS = [
    # Traps
    (30598, r"D:\yugitauapk\web\res\30598.jpg", "thumb_trap"),
    (30599, r"D:\yugitauapk\web\res\30599.jpg", "thumb_trap"),
    (30600, r"D:\yugitauapk\web\res\30600.jpg", "thumb_trap"),
    (30601, r"D:\yugitauapk\web\res\30601.jpg", "thumb_trap"),
    (30602, os.path.join(LA_DIR, "Farewelcome-Labrynth.png"), "thumb_trap"),
    (30603, os.path.join(LA_DIR, "LABRYNTH-BARRAGE.png"), "thumb_trap"),
    (30604, os.path.join(LA_DIR, "WELCOME-LABRYNTH.png"), "thumb_trap"),
    (30605, os.path.join(LA_DIR, "BIG-WELCOME-LABRYNTH.png"), "thumb_trap"),
    # Spells
    (21171, r"D:\yugitauapk\web\res\21171.jpg", "thumb_magic"),
    (21172, os.path.join(LA_DIR, "Labrynth-Set-Up.png"), "thumb_magic"),
    (21173, os.path.join(LA_DIR, "LABRYNTH-LABYRINTH.png"), "thumb_magic"),
]

for card_id, src_img, primary_folder in CARDS:
    print(f"[*] Processing {card_id} from {src_img} ({primary_folder})...")
    src = Image.open(src_img)
    if src.mode != 'RGBA':
        src = src.convert('RGBA')

    # 1. 256x256 RGB JPEG & Mask PNG
    img_256 = src.resize((256, 256), Image.Resampling.LANCZOS)
    rgb_256 = Image.new('RGB', (256, 256), (0, 0, 0))
    rgb_256.paste(img_256, mask=img_256.split()[3])

    jpg_io = io.BytesIO()
    rgb_256.save(jpg_io, format='JPEG', quality=90)
    jpg_bytes = jpg_io.getvalue()

    alpha_mask = img_256.split()[3]
    mask_io = io.BytesIO()
    alpha_mask.save(mask_io, format='PNG')
    mask_bytes = mask_io.getvalue()

    # 2. JPM bytes
    jpm_header = struct.pack('<4sII', b'JPM\x01', len(jpg_bytes), len(mask_bytes))
    jpm_bytes = jpm_header + jpg_bytes + mask_bytes

    # 3. 82x82 Icon
    ico_82 = src.resize((82, 82), Image.Resampling.LANCZOS)
    ico_io = io.BytesIO()
    ico_82.save(ico_io, format='PNG')
    ico_bytes = ico_io.getvalue()

    cid_str = str(card_id)

    # Save jpg & mask in web/res/
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}.jpg'), 'wb') as f:
        f.write(jpg_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_3.jpg'), 'wb') as f:
        f.write(jpg_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_mask.png'), 'wb') as f:
        f.write(mask_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_3_mask.png'), 'wb') as f:
        f.write(mask_bytes)

    # Save icon in web/res/new/thumb/ and web/res/
    ico_dir = os.path.join(WEB_DIR, 'res', 'new', 'thumb')
    os.makedirs(ico_dir, exist_ok=True)
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}.png'), 'wb') as f:
        f.write(ico_bytes)
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}_3.png'), 'wb') as f:
        f.write(ico_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'card_ico_{cid_str}.png'), 'wb') as f:
        f.write(ico_bytes)

    # Save both .jpg and .jpm in primary container folder and fallback folders
    target_folders = [primary_folder]
    if primary_folder == "thumb_trap":
        target_folders.extend(["thumb_magic", "thumb_monster", "thumb_rare"])
    elif primary_folder == "thumb_magic":
        target_folders.extend(["thumb_trap", "thumb_monster", "thumb_rare"])

    for folder in target_folders:
        d1 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}.lcres')
        d2 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}_3.lcres')
        os.makedirs(d1, exist_ok=True)
        os.makedirs(d2, exist_ok=True)
        # Write .jpg (needed by Web H5 ClientView and res.js for traps & magic)
        with open(os.path.join(d1, f'{cid_str}.jpg'), 'wb') as f:
            f.write(jpg_bytes)
        with open(os.path.join(d2, f'{cid_str}_3.jpg'), 'wb') as f:
            f.write(jpg_bytes)
        # Write .jpm (for completeness & future proofing)
        with open(os.path.join(d1, f'{cid_str}.jpm'), 'wb') as f:
            f.write(jpm_bytes)
        with open(os.path.join(d2, f'{cid_str}_3.jpm'), 'wb') as f:
            f.write(jpm_bytes)

# Update web/js/res.js CUSTOM_ICON_REPLACEMENTS
res_js_path = os.path.join(WEB_DIR, 'js', 'res.js')
with open(res_js_path, 'r', encoding='utf-8') as f:
    res_js = f.read()

new_icon_entries = ""
for cid, _, _ in CARDS:
    entry1 = f"\t\t'card_ico_{cid}': {{ path: 'res/new/thumb/card_ico_{cid}.png', w: 82, h: 82 }},\n"
    entry2 = f"\t\t'card_ico_{cid}_3': {{ path: 'res/new/thumb/card_ico_{cid}_3.png', w: 82, h: 82 }},\n"
    if f"'card_ico_{cid}'" not in res_js:
        new_icon_entries += entry1 + entry2

if new_icon_entries:
    target = "CUSTOM_ICON_REPLACEMENTS = {\n"
    if target in res_js:
        res_js = res_js.replace(target, target + new_icon_entries, 1)
        with open(res_js_path, 'w', encoding='utf-8') as f:
            f.write(res_js)
        print("[OK] Updated web/js/res.js with missing custom icons")

# Update web/res_manifest.json
mpath = os.path.join(WEB_DIR, 'res_manifest.json')
with open(mpath, 'r', encoding='utf-8') as f:
    manifest = json.load(f)

files_set = set(manifest.get("files", []))

for card_id, _, primary_folder in CARDS:
    cid_str = str(card_id)
    
    # Register containers
    manifest["containers"][f"res/{primary_folder}/{cid_str}.lcres"] = [f"{cid_str}.jpg", f"{cid_str}.jpm"]
    manifest["containers"][f"res/{primary_folder}/{cid_str}_3.lcres"] = [f"{cid_str}_3.jpg", f"{cid_str}_3.jpm"]

    new_files = [
        f"res/{cid_str}.jpg",
        f"res/{cid_str}_mask.png",
        f"res/new/thumb/card_ico_{cid_str}.png",
        f"res/{cid_str}_3.jpg",
        f"res/{cid_str}_3_mask.png",
        f"res/new/thumb/card_ico_{cid_str}_3.png",
        f"res/{primary_folder}/{cid_str}.lcres/{cid_str}.jpg",
        f"res/{primary_folder}/{cid_str}.lcres/{cid_str}.jpm",
        f"res/{primary_folder}/{cid_str}_3.lcres/{cid_str}_3.jpg",
        f"res/{primary_folder}/{cid_str}_3.lcres/{cid_str}_3.jpm",
    ]
    for nf in new_files:
        if nf not in files_set:
            manifest["files"].append(nf)
            files_set.add(nf)

    manifest["sizes"][f"res/new/thumb/card_ico_{cid_str}.png"] = [82, 82]
    manifest["sizes"][f"card_ico_{cid_str}.png"] = [82, 82]
    manifest["sizes"][f"res/{cid_str}.jpg"] = [256, 256]
    manifest["sizes"][f"{cid_str}.jpg"] = [256, 256]
    manifest["sizes"][f"res/new/thumb/card_ico_{cid_str}_3.png"] = [82, 82]
    manifest["sizes"][f"card_ico_{cid_str}_3.png"] = [82, 82]
    manifest["sizes"][f"res/{cid_str}_3.jpg"] = [256, 256]
    manifest["sizes"][f"{cid_str}_3.jpg"] = [256, 256]

    # Register in thumbs category
    tlist = manifest.get("thumbs", {}).setdefault(primary_folder, [])
    for tid in [cid_str, f"{cid_str}_3"]:
        if tid not in tlist:
            tlist.append(tid)

# Also ensure 40780 is in thumb_rare
tlist_rare = manifest.get("thumbs", {}).setdefault("thumb_rare", [])
for tid in ["40780", "40780_3"]:
    if tid not in tlist_rare:
        tlist_rare.append(tid)

with open(mpath, 'w', encoding='utf-8') as f:
    json.dump(manifest, f, indent=2, ensure_ascii=False)
print("[OK] res_manifest.json updated successfully!")
