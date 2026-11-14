with open('D:/yugitauapk/web/src/Data.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'XYZ_STAR' in line:
            print(f'{idx+1}: {line.strip()}')
