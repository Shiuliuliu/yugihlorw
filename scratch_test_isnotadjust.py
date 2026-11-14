with open('D:/yugitauapk/web/src/BattleCard.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(8430, 8460):
    print(f'{i+1}: {lines[i]}', end='')
