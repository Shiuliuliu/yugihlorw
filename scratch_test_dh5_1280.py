with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

for i in range(1280, 1300):
    print(f'{i+1}: {lines[i]}', end='')
