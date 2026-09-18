import json, re, sys
sys.stdout.reconfigure(encoding='utf-8')
lua = json.load(open('web/lua_src.json', encoding='utf-8'))

for fname in ['TavernScene', 'h5_patch']:
    s = lua.get(fname, '')
    print(f'=== {fname} ===')
    for m in re.finditer(r'up_pkg_card_id|featured|showcase|banner|cover|liya|Liya', s):
        pos = m.start()
        print(s[max(0, pos-80):min(len(s), pos+200)])
        print('-'*30)
