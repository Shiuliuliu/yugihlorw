with open('D:/yugitauapk/web/src/ClientView.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()
for i in range(3515, 3595):
    print(f'{i+1}: {lines[i]}', end='')
