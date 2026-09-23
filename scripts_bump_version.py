import re

files = ['web/index.html', 'web/js/boot.js', 'web/js/res.js']
for fpath in files:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    new_content = content.replace('20260923v3', '20260924v1')
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Updated {fpath}")
