with open('D:/yugitauapk/web/src/BattleSkill.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for target in [17449, 25508, 30193]:
    print(f"=== Target {target} ===")
    for i in range(target-5, target+20):
        print(f'{i+1}: {lines[i]}', end='')
