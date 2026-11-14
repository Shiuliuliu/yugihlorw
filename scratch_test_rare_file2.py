with open('D:/yugitauapk/web/data/rare.lua', 'r', encoding='utf-8') as f:
    content = f.read()
idx = content.find('[40765]')
print(content[idx:idx+600])
