with open(r'D:\yugitauapk\web\src\Data.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(1900, 1920):
    print(f'{i+1}: {lines[i].rstrip()}')
