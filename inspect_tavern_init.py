import json
lua = json.load(open('web/lua_src.json', encoding='utf-8'))
s = lua.get('TavernScene', '')
pos = s.find('function var_0_1.sendShowDetail')
print(s[pos:pos+1500])
