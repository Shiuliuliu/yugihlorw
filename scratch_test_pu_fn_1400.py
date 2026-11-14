with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(1390, 1425):
    if 'function' in lines[i]:
        print(f'{i+1}: {lines[i]}', end='')
