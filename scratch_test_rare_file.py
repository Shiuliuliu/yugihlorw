import os

for fname in ['monster.lua', 'rare.lua']:
    p = os.path.join('D:/yugitauapk/web/data', fname)
    if os.path.exists(p):
        with open(p, 'r', encoding='utf-8') as f:
            content = f.read()
        idx = content.find('[40765]')
        if idx != -1:
            print(f"Found 40765 in {fname}:")
            print(content[idx:idx+300])
        else:
            print(f"40765 not in {fname}")
