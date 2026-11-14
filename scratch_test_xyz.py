import json

with open('D:/yugitauapk/web/data_dumps.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Let's inspect Lua CardType and MonsterOption in Data.lua
with open('D:/yugitauapk/web/src/Data.lua', 'r', encoding='utf-8') as f:
    data_lua = f.read()

# Let's check card 40765 in rare.bin
content = data['rare.bin']
idx = content.find('[40765]=')
idx2 = content.find('[40766]=')
print(content[idx:idx2])
