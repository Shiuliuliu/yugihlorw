import re
import glob

sizes = set()
for f in glob.glob('web/src/*.lua'):
    with open(f, 'r', encoding='utf-8', errors='ignore') as fp:
        content = fp.read()
        for m in re.finditer(r'createScale9ShaderButton\s*\(\s*["\']([^"\']+)["\']\s*,\s*[^,]*,\s*[^,]*,\s*([^,)]*)\s*,\s*([^)]*)\)', content):
            btn = m.group(1)
            w = m.group(2).strip()
            h = m.group(3).strip()
            if 'img_btn' in btn:
                sizes.add((btn, w, h))

for s in sorted(sizes):
    print(s)
