import os, json, struct, io, sys
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')
WEB_DIR = r"D:\yugitauapk\web"
SRC_IMG = r"D:\yugitauapk\web\res\new\thumb\liqi\airi.png"
CARD_ID = 12384
ALL_THUMB_FOLDERS = ["thumb_monster", "thumb_rare", "thumb_magic", "thumb_trap"]

print(f"[*] Processing card {CARD_ID} from {SRC_IMG}...")
if not os.path.exists(SRC_IMG):
    print(f"[ERR] File not found: {SRC_IMG}")
    sys.exit(1)

src = Image.open(SRC_IMG)
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

# 2. JPM bytes (header + jpg + mask)
jpm_header = struct.pack('<4sII', b'JPM\x01', len(jpg_bytes), len(mask_bytes))
jpm_bytes = jpm_header + jpg_bytes + mask_bytes

# 3. 82x82 Icon PNG
ico_82 = src.resize((82, 82), Image.Resampling.LANCZOS)
ico_io = io.BytesIO()
ico_82.save(ico_io, format='PNG')
ico_bytes = ico_io.getvalue()

cid_str = str(CARD_ID)

# Save jpg & mask in web/res/
for suffix in [cid_str, f"{cid_str}_3"]:
    with open(os.path.join(WEB_DIR, 'res', f'{suffix}.jpg'), 'wb') as f:
        f.write(jpg_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{suffix}_mask.png'), 'wb') as f:
        f.write(mask_bytes)

# Save icons in web/res/new/thumb/ and web/res/
ico_dir = os.path.join(WEB_DIR, 'res', 'new', 'thumb')
os.makedirs(ico_dir, exist_ok=True)
for suffix in [cid_str, f"{cid_str}_3"]:
    with open(os.path.join(ico_dir, f'card_ico_{suffix}.png'), 'wb') as f:
        f.write(ico_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'card_ico_{suffix}.png'), 'wb') as f:
        f.write(ico_bytes)

# Save both .jpg and .jpm in ALL thumb folders
for folder in ALL_THUMB_FOLDERS:
    for suffix in [cid_str, f"{cid_str}_3"]:
        c_dir = os.path.join(WEB_DIR, 'res', folder, f'{suffix}.lcres')
        os.makedirs(c_dir, exist_ok=True)
        with open(os.path.join(c_dir, f'{suffix}.jpg'), 'wb') as f:
            f.write(jpg_bytes)
        with open(os.path.join(c_dir, f'{suffix}.jpm'), 'wb') as f:
            f.write(jpm_bytes)

print("[OK] All images, JPMs, and icons written to disk.")

# 4. Update web/js/res.js CUSTOM_ICON_REPLACEMENTS
res_js_path = os.path.join(WEB_DIR, 'js', 'res.js')
with open(res_js_path, 'r', encoding='utf-8') as f:
    res_js = f.read()

new_icon_entries = ""
for suffix in [cid_str, f"{cid_str}_3"]:
    needle = f"'card_ico_{suffix}':"
    if needle not in res_js:
        new_icon_entries += f"\t\t'card_ico_{suffix}': {{ path: 'res/new/thumb/card_ico_{suffix}.png', w: 82, h: 82 }},\n"

if new_icon_entries:
    target = "CUSTOM_ICON_REPLACEMENTS = {\n"
    if target in res_js:
        res_js = res_js.replace(target, target + new_icon_entries, 1)
        with open(res_js_path, 'w', encoding='utf-8') as f:
            f.write(res_js)
        print("[OK] Updated web/js/res.js with missing custom icons:\n" + new_icon_entries)
    else:
        print("[WARN] Could not find CUSTOM_ICON_REPLACEMENTS = { in res.js")
else:
    print("[SKIP] All custom icons already present in res.js")

# 5. Update web/res_manifest.json
mpath = os.path.join(WEB_DIR, 'res_manifest.json')
with open(mpath, 'r', encoding='utf-8') as f:
    manifest = json.load(f)

files_set = set(manifest.get("files", []))

# Register containers for ALL thumb folders
for folder in ALL_THUMB_FOLDERS:
    for suffix in [cid_str, f"{cid_str}_3"]:
        c_key = f"res/{folder}/{suffix}.lcres"
        manifest["containers"][c_key] = [f"{suffix}.jpg", f"{suffix}.jpm"]

# Register individual files in files list
new_files = [
    f"res/{cid_str}.jpg",
    f"res/{cid_str}_mask.png",
    f"res/card_ico_{cid_str}.png",
    f"res/new/thumb/card_ico_{cid_str}.png",
    f"res/{cid_str}_3.jpg",
    f"res/{cid_str}_3_mask.png",
    f"res/card_ico_{cid_str}_3.png",
    f"res/new/thumb/card_ico_{cid_str}_3.png",
]
for folder in ALL_THUMB_FOLDERS:
    for suffix in [cid_str, f"{cid_str}_3"]:
        new_files.append(f"res/{folder}/{suffix}.lcres/{suffix}.jpg")
        new_files.append(f"res/{folder}/{suffix}.lcres/{suffix}.jpm")

for nf in new_files:
    if nf not in files_set:
        manifest["files"].append(nf)
        files_set.add(nf)

# Register sizes
for suffix in [cid_str, f"{cid_str}_3"]:
    manifest["sizes"][f"res/new/thumb/card_ico_{suffix}.png"] = [82, 82]
    manifest["sizes"][f"res/card_ico_{suffix}.png"] = [82, 82]
    manifest["sizes"][f"card_ico_{suffix}.png"] = [82, 82]
    manifest["sizes"][f"res/{suffix}.jpg"] = [256, 256]
    manifest["sizes"][f"{suffix}.jpg"] = [256, 256]

# Register in thumbs category
tlist = manifest.get("thumbs", {}).setdefault("thumb_monster", [])
for tid in [cid_str, f"{cid_str}_3"]:
    if tid not in tlist:
        tlist.append(tid)

with open(mpath, 'w', encoding='utf-8') as f:
    json.dump(manifest, f, indent=2, ensure_ascii=False)
print("[OK] res_manifest.json updated successfully!")
