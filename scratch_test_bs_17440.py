with open('D:/yugitauapk/web/src/BattleSkill.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(17440, 17515):
    print(f'{i+1}: {lines[i]}', end='')
