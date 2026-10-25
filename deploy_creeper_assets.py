import os
import json
import struct
import io
import sys
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')

WEB_DIR = r"D:\yugitauapk\web"
SOURCE_IMG = r"D:\yugitauapk\web\res\new\thumb\creeper.png"
CARD_ID = 12337

def process_images():
    print("[*] Processing images from:", SOURCE_IMG)
    src = Image.open(SOURCE_IMG)
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

    # 2. JPM bytes: JPM\x01 + len(jpg) + len(mask) + jpg + mask
    jpm_header = struct.pack('<4sII', b'JPM\x01', len(jpg_bytes), len(mask_bytes))
    jpm_bytes = jpm_header + jpg_bytes + mask_bytes

    # 3. 82x82 Icon RGBA
    ico_82 = src.resize((82, 82), Image.Resampling.LANCZOS)
    ico_io = io.BytesIO()
    ico_82.save(ico_io, format='PNG')
    ico_bytes = ico_io.getvalue()

    cid_str = str(CARD_ID)

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
    os.makedirs(ico_dir, exist_ok=True)
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

def update_manifest():
    print("[*] Updating res_manifest.json...")
    mpath = os.path.join(WEB_DIR, 'res_manifest.json')
    with open(mpath, 'r', encoding='utf-8') as f:
        manifest = json.load(f)

    cid_str = str(CARD_ID)
    manifest["containers"][f"res/thumb_rare/{cid_str}.lcres"] = [f"{cid_str}.jpm"]
    manifest["containers"][f"res/thumb_monster/{cid_str}.lcres"] = [f"{cid_str}.jpm"]
    manifest["containers"][f"res/thumb_rare/{cid_str}_3.lcres"] = [f"{cid_str}_3.jpm"]
    manifest["containers"][f"res/thumb_monster/{cid_str}_3.lcres"] = [f"{cid_str}_3.jpm"]

    new_files = [
        f"res/{cid_str}.jpg",
        f"res/{cid_str}_mask.png",
        f"res/new/thumb/card_ico_{cid_str}.png",
        f"res/{cid_str}_3.jpg",
        f"res/{cid_str}_3_mask.png",
        f"res/new/thumb/card_ico_{cid_str}_3.png"
    ]
    files_set = set(manifest.get("files", []))
    for nf in new_files:
        if nf not in files_set:
            manifest["files"].append(nf)

    # Update sizes
    manifest["sizes"][f"res/new/thumb/card_ico_{cid_str}.png"] = [82, 82]
    manifest["sizes"][f"card_ico_{cid_str}.png"] = [82, 82]
    manifest["sizes"][f"res/{cid_str}.jpg"] = [256, 256]
    manifest["sizes"][f"{cid_str}.jpg"] = [256, 256]
    manifest["sizes"][f"res/new/thumb/card_ico_{cid_str}_3.png"] = [82, 82]
    manifest["sizes"][f"card_ico_{cid_str}_3.png"] = [82, 82]
    manifest["sizes"][f"res/{cid_str}_3.jpg"] = [256, 256]
    manifest["sizes"][f"{cid_str}_3.jpg"] = [256, 256]

    # Update thumbs list
    for tkey in ["thumb_monster", "thumb_rare"]:
        tlist = manifest.get("thumbs", {}).get(tkey, [])
        for tid in [cid_str, f"{cid_str}_3"]:
            if tid not in tlist:
                tlist.append(tid)

    with open(mpath, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
    print("[OK] res_manifest.json updated successfully!")

if __name__ == '__main__':
    process_images()
    update_manifest()
