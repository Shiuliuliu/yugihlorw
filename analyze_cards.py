import json, re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

with open(r'D:\yugitauapk\web\data_dumps.json', 'r', encoding='utf-8') as f:
    dumps = json.load(f)

# Count _available in each card bin
for binfile in ['monster.bin', 'magic.bin', 'trap.bin', 'rare.bin']:
    s = dumps.get(binfile, '')
    avail = [int(m) for m in re.findall(r'_available\"\]=(\d)', s)]
    from collections import Counter
    c = Counter(avail)
    print(f'{binfile}: {dict(c)}')

# Also check _isHide
print()
for binfile in ['monster.bin', 'magic.bin', 'trap.bin', 'rare.bin']:
    s = dumps.get(binfile, '')
    hides = [int(m) for m in re.findall(r'_isHide\"\]=(\d)', s)]
    from collections import Counter
    c = Counter(hides)
    print(f'{binfile} _isHide: {dict(c)}')

# Check how many with _available=1 AND _isHide=0
print()
for binfile in ['monster.bin']:
    s = dumps.get(binfile, '')
    # Find entries with _available=1
    entries_avail1 = re.findall(r'\[(\d+)\]=\{[^~]*?_available\"\]=1', s)
    print(f'{binfile}: _available=1 entries: {len(entries_avail1)}, sample: {entries_avail1[:5]}')
