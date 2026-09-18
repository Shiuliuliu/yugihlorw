import json, sys
sys.stdout.reconfigure(encoding='utf-8')
lua = json.load(open('web/lua_src.json', encoding='utf-8'))
s = lua.get('h5_patch', '')

pos = 0
while True:
    pos = s.find('LIYA_CARDS_MAP', pos)
    if pos == -1: break
    print(f'=== Pos {pos} ===')
    print(s[max(0, pos-100):min(len(s), pos+400)])
    print('='*50)
    pos += 15
