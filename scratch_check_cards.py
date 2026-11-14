import json

with open('D:/yugitauapk/web/data_dumps.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

content = data['rare.bin']
for cid in range(40755, 40781):
    needle = f'[{cid}]='
    idx = content.find(needle)
    if idx != -1:
        end = content.find('},\n', idx)
        if end == -1: end = content.find('},  [', idx)
        block = content[idx:end]
        print(f"Card {cid}:")
        for key in ['_py', '_atk', '_hp', '_star', '_option', '_link', '_category']:
            kneedle = f'"{key}"'
            pos = block.find(kneedle)
            if pos != -1:
                print(f"  {block[pos:pos+35]}")
