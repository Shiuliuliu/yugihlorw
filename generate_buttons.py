import os
import shutil
from PIL import Image

AVAILABLE_BTN_SIZES = [
	(60, 50), (60, 60), (80, 40), (80, 60), (82, 60),
	(100, 40), (100, 60), (100, 78), (110, 44), (110, 60), (110, 78),
	(120, 40), (120, 60), (120, 70), (120, 78),
	(140, 44), (140, 60), (140, 70), (140, 78), (146, 70),
	(150, 60), (150, 78), (152, 78), (160, 60), (160, 78), (170, 78),
	(180, 50), (180, 56), (180, 60), (180, 70), (180, 78),
	(200, 60), (200, 78), (210, 60), (210, 78),
	(220, 60), (220, 70), (220, 78), (240, 78),
	(250, 56), (250, 60), (250, 78), (260, 60), (260, 64), (260, 78), (300, 78)
]

SOURCES = {
	'confirm': 'web/res/new/extracted_btns/xanh.png',
	'cancel': 'web/res/new/extracted_btns/vang.png',
	'red': 'web/res/new/extracted_btns/do.png',
}

OUTPUT_DIR = 'web/res/new/buttons'
os.makedirs(OUTPUT_DIR, exist_ok=True)

def slice_9patch(src, dst_w, dst_h, left_margin=50, top_margin=28, right_margin=50, bottom_margin=28):
	sw, sh = src.size

	h_scale = dst_h / sh

	dl = int(left_margin * h_scale)
	dr = int(right_margin * h_scale)
	dt = int(top_margin * h_scale)
	db = int(bottom_margin * h_scale)

	if dl + dr >= dst_w:
		ratio = (dst_w * 0.45) / max(dl, dr)
		dl = int(dl * ratio)
		dr = int(dr * ratio)

	if dt + db >= dst_h:
		ratio = (dst_h * 0.45) / max(dt, db)
		dt = int(dt * ratio)
		db = int(db * ratio)

	dl = max(1, dl)
	dr = max(1, dr)
	dt = max(1, dt)
	db = max(1, db)

	# Corners
	tl = src.crop((0, 0, left_margin, top_margin)).resize((dl, dt), Image.Resampling.LANCZOS)
	tr = src.crop((sw - right_margin, 0, sw, top_margin)).resize((dr, dt), Image.Resampling.LANCZOS)
	bl = src.crop((0, sh - bottom_margin, left_margin, sh)).resize((dl, db), Image.Resampling.LANCZOS)
	br = src.crop((sw - right_margin, sh - bottom_margin, sw, sh)).resize((dr, db), Image.Resampling.LANCZOS)

	# Edges
	top = src.crop((left_margin, 0, sw - right_margin, top_margin)).resize((dst_w - dl - dr, dt), Image.Resampling.LANCZOS)
	bottom = src.crop((left_margin, sh - bottom_margin, sw - right_margin, sh)).resize((dst_w - dl - dr, db), Image.Resampling.LANCZOS)
	left = src.crop((0, top_margin, left_margin, sh - bottom_margin)).resize((dl, dst_h - dt - db), Image.Resampling.LANCZOS)
	right = src.crop((sw - right_margin, top_margin, sw, sh - bottom_margin)).resize((dr, dst_h - dt - db), Image.Resampling.LANCZOS)

	# Center
	center = src.crop((left_margin, top_margin, sw - right_margin, sh - bottom_margin)).resize((dst_w - dl - dr, dst_h - dt - db), Image.Resampling.LANCZOS)

	res = Image.new('RGBA', (dst_w, dst_h), (0, 0, 0, 0))
	res.paste(tl, (0, 0))
	res.paste(tr, (dst_w - dr, 0))
	res.paste(bl, (0, dst_h - db))
	res.paste(br, (dst_w - dr, dst_h - db))

	res.paste(top, (dl, 0))
	res.paste(bottom, (dl, dst_h - db))
	res.paste(left, (0, dt))
	res.paste(right, (dst_w - dr, dt))
	res.paste(center, (dl, dt))

	return res

total_generated = 0
for kind, src_path in SOURCES.items():
	if not os.path.exists(src_path):
		print(f"Error: missing source file {src_path}")
		continue

	src_img = Image.open(src_path).convert('RGBA')
	sw, sh = src_img.size

	left_m = 50
	right_m = 50
	top_m = 28
	bottom_m = 28

	for w, h in AVAILABLE_BTN_SIZES:
		out_img = slice_9patch(src_img, w, h, left_m, top_m, right_m, bottom_m)
		out_filename = f"{kind}_{w}x{h}.png"
		out_path = os.path.join(OUTPUT_DIR, out_filename)
		out_img.save(out_path, format='PNG', optimize=True)
		total_generated += 1

print(f"Successfully generated {total_generated} button assets in {OUTPUT_DIR}")

# Copy master buttons to web/res/new/
shutil.copyfile('web/res/new/extracted_btns/xanh.png', 'web/res/new/btn-khangdinh.png')
shutil.copyfile('web/res/new/extracted_btns/vang.png', 'web/res/new/btn-phudinh.png')
shutil.copyfile('web/res/new/extracted_btns/do.png', 'web/res/new/btn-red.png')
print("Updated master buttons: btn-khangdinh.png, btn-phudinh.png, btn-red.png")
