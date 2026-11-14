with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

for i in range(8050, 8110):
    if 'function' in lines[i]:
        print(f'{i+1}: {lines[i]}', end='')
