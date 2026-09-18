import json, sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# Check data_dumps patch status
with open(r'D:\yugitauapk\web\data_dumps.json', 'r', encoding='utf-8') as f:
    dumps = json.load(f)

for binfile in ['monster.bin', 'magic.bin', 'trap.bin', 'rare.bin']:
    s = dumps[binfile]
    a1 = s.count('_available"]=1')
    a0 = s.count('_available"]=0')
    print(f'{binfile}: available=1:{a1}, available=0:{a0}')

# Check lua src for _available filter
with open(r'D:\yugitauapk\web\lua_src.json', 'r', encoding='utf-8') as f:
    lua_data = json.load(f)

print()
print('=== Lua modules using _available ===')
for name, src in lua_data.items():
    if '_available' in src:
        hits = [(m.start(), src[max(0,m.start()-40):m.start()+150]) for m in re.finditer('_available', src)]
        for pos, snippet in hits[:3]:
            if any(k in snippet for k in ['card', 'info', 'Info', 'Card', 'filter', 'Filter']):
                print(f'{name}[{pos}]: {snippet}')
                print()
