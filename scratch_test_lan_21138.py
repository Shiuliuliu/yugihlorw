import sys
sys.stdout.reconfigure(encoding='utf-8')

for fname in ['extend_lan.txt', 'orig_lan.txt']:
    try:
        with open('D:/yugitauapk/' + fname, 'r', encoding='utf-8') as f:
            for line in f:
                if '56857' in line or '56858' in line or '56861' in line or '56862' in line or '12316' in line or '21138' in line:
                    print(f"{fname}: {line.strip()[:150]}")
    except Exception as e:
        print(f"Error {fname}:", e)
