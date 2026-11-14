import sys
sys.stdout.reconfigure(encoding='utf-8')

for fname in ['diff_PlayerUi_detailed.txt', 'diff_PlayerUi_check.txt', 'diff_BattleSkill_vs_duelh5.txt']:
    try:
        with open('D:/yugitauapk/' + fname, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        print(f"=== {fname} ({len(lines)} lines) ===")
        for line in lines[:30]:
            print(line, end='')
    except Exception as e:
        print(f"Error {fname}:", e)
