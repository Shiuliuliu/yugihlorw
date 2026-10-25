import os, json, struct, io, sys
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')
WEB_DIR = r"D:\yugitauapk\web"

CARDS = [
    (40747, r"D:\yugitauapk\web\res\new\thumb\skeleton.png", "rare"),
    (12338, r"D:\yugitauapk\web\res\new\thumb\enderman.png", "monster")
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

    # Save jpg & mask
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}.jpg'), 'wb') as f:
        f.write(jpg_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_3.jpg'), 'wb') as f:
        f.write(jpg_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_mask.png'), 'wb') as f:
        f.write(mask_bytes)
    with open(os.path.join(WEB_DIR, 'res', f'{cid_str}_3_mask.png'), 'wb') as f:
        f.write(mask_bytes)

    # Save icon
    ico_dir = os.path.join(WEB_DIR, 'res', 'new', 'thumb')
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}.png'), 'wb') as f:
        f.write(ico_bytes)
    with open(os.path.join(ico_dir, f'card_ico_{cid_str}_3.png'), 'wb') as f:
        f.write(ico_bytes)

    # Save JPM in lcres folders
    for folder in ['thumb_monster', 'thumb_rare']:
        d1 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}.lcres')
        d2 = os.path.join(WEB_DIR, 'res', folder, f'{cid_str}_3.lcres')
        os.makedirs(d1, exist_ok=True)
        os.makedirs(d2, exist_ok=True)
        with open(os.path.join(d1, f'{cid_str}.jpm'), 'wb') as f:
            f.write(jpm_bytes)
        with open(os.path.join(d2, f'{cid_str}_3.jpm'), 'wb') as f:
            f.write(jpm_bytes)

print("[OK] All image assets generated successfully!")
