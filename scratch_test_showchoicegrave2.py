with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(2340, 2390):
    print(f'{i+1}: {lines[i]}', end='')
