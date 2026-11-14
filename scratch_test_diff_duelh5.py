import sys
sys.stdout.reconfigure(encoding='utf-8')

for fname in ['onChoiceGrave_duelh5.lua', 'onChoiceGrave_local.lua', 'showChoiceGrave_duelh5.lua', 'showChoiceGrave_local.lua']:
    try:
        with open('D:/yugitauapk/' + fname, 'r', encoding='utf-8') as f:
            content = f.read()
        print(f"=== {fname} ({len(content)} chars) ===")
        print(content[:500])
        print("...\n")
    except Exception as e:
        print(f"Error {fname}:", e)
