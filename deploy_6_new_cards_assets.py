import os, json, struct, io, sys
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')
WEB_DIR = r"D:\yugitauapk\web"

CARDS = [
    (12341, r"D:\yugitauapk\web\res\new\thumb\Drowned.png", "monster"),
    (12342, r"D:\yugitauapk\web\res\new\thumb\Zombified-piglin-kiem.png", "monster"),
    (12343, r"D:\yugitauapk\web\res\new\thumb\Zombified-piglin-riu.png", "monster"),
    (12344, r"D:\yugitauapk\web\res\new\thumb\husk.png", "monster"),
    (30597, r"D:\yugitauapk\web\res\new\thumb\cuadianguc.png", "trap"),
    (12345, r"D:\yugitauapk\web\res\new\thumb\warden.png", "monster"),
]

for card_id, src_img, ctype in CARDS:
    print(f"[*] Processing {card_id} from {src_img}...")
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

    # Save icon in web/res/new/thumb/
    ico_dir = os.path.join(WEB_DIR, 'res', 'new', 'thumb')
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}.png'), 'wb') as f:
        f.write(ico_bytes)
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}_3.png'), 'wb') as f:
        f.write(ico_bytes)

    # Save JPM in all thumb folders
    for folder in ['thumb_monster', 'thumb_rare', 'thumb_magic', 'thumb_trap']:
        d1 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}.lcres')
        d2 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}_3.lcres')
        os.makedirs(d1, exist_ok=True)
        os.makedirs(d2, exist_ok=True)
        with open(os.path.join(d1, f'{cid_str}.jpm'), 'wb') as f:
            f.write(jpm_bytes)
        with open(os.path.join(d2, f'{cid_str}_3.jpm'), 'wb') as f:
            f.write(jpm_bytes)
        with open(os.path.join(d1, f'{cid_str}.jpg'), 'wb') as f:
            f.write(jpg_bytes)
        with open(os.path.join(d2, f'{cid_str}_3.jpg'), 'wb') as f:
            f.write(jpg_bytes)

# Update web/res_manifest.json
manifest_path = os.path.join(WEB_DIR, 'res_manifest.json')
if os.path.exists(manifest_path):
    with open(manifest_path, 'r', encoding='utf-8') as f:
        manifest = json.load(f)
    added = 0
    file_list = manifest.get('files', []) if isinstance(manifest, dict) else manifest
    for cid, _, _ in CARDS:
        for p in [f'res/new/thumb/card_ico_{cid}.png', f'res/new/thumb/card_ico_{cid}_3.png', f'res/{cid}.jpg', f'res/{cid}_3.jpg', f'res/{cid}_mask.png', f'res/{cid}_3_mask.png']:
            if p not in file_list:
                file_list.append(p)
                added += 1
    if added > 0:
        with open(manifest_path, 'w', encoding='utf-8') as f:
            json.dump(manifest, f, indent=2)
        print(f"[OK] Added {added} items to res_manifest.json")

print("[DONE] Assets deployed for all 6 cards!")
