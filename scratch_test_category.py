with open('D:/yugitauapk/web/src/Data.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if '24' in line or 'Category' in line or 'CardCategory' in line:
            print(f'{idx+1}: {line.strip()[:100]}')
