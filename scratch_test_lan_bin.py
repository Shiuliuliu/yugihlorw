import json, sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/data_dumps.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

for k, v in data.items():
    if 'lan' in k.lower():
        print("Lan key:", k)
        for line in v.splitlines():
            if '56857' in line or '56858' in line or '56861' in line or '56862' in line:
                print(f"  {line[:150]}")
