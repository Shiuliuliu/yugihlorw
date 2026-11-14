with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(4435, 4475):
    print(f'{i+1}: {lines[i]}', end='')
