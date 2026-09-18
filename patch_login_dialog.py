"""
Patch lua_src.json:
1. Add dialog background panel to RegionScene login form
2. Bump version in index.html to force browser to reload data_dumps.json
"""
import json, sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

LUA_SRC_PATH  = r'D:\yugitauapk\web\lua_src.json'
INDEX_PATH    = r'D:\yugitauapk\web\index.html'

# ─── 1. Patch lua_src.json ────────────────────────────────────────────────────
print('Loading lua_src.json...')
with open(LUA_SRC_PATH, 'r', encoding='utf-8') as f:
    lua_data = json.load(f)

src = lua_data.get('RegionScene', '')
print('RegionScene length:', len(src))

# Find the exact insertion point — right after the dark overlay is created
# and before the Title label is added.
# We insert a rounded rectangle panel behind the form.
OLD_DIALOG_MARK = '\t-- Title\n\tlocal lblTitle = cc.Label:createWithTTF("ĐĂNG NHẬP"'
NEW_DIALOG_INSERT = '''\t-- Dialog background panel (rounded dark box behind form)
\tlocal panelW, panelH = 580, 460
\tlocal dialogBg = cc.LayerColor:create(cc.c4b(8, 10, 28, 215), panelW, panelH)
\tdialogBg:setPosition(ClientView.SCR_CW - panelW/2, ClientView.SCR_CH - panelH/2 - 20)
\tloginLayer:addChild(dialogBg, 0)

\t-- Panel border (gold)
\tlocal borderNode = cc.DrawNode:create()
\tlocal bx, by = ClientView.SCR_CW - panelW/2, ClientView.SCR_CH - panelH/2 - 20
\tborderNode:drawRect(cc.p(bx+1, by+1), cc.p(bx+panelW-1, by+panelH-1), cc.c4f(0.8, 0.62, 0.15, 0.7))
\tborderNode:drawRect(cc.p(bx+3, by+3), cc.p(bx+panelW-3, by+panelH-3), cc.c4f(0.8, 0.62, 0.15, 0.3))
\tloginLayer:addChild(borderNode, 0)

\t-- Title\n\tlocal lblTitle = cc.Label:createWithTTF("ĐĂNG NHẬP"'''

if OLD_DIALOG_MARK in src:
    src2 = src.replace(OLD_DIALOG_MARK, NEW_DIALOG_INSERT, 1)
    lua_data['RegionScene'] = src2
    print('✓ Dialog background panel injected into RegionScene')
else:
    print('✗ Could not find insertion point in RegionScene')
    # Show what's near that area
    i = src.find('-- Title')
    print('Near -- Title:', repr(src[max(0,i-100):i+200]))

# ─── 2. Save patched lua_src.json ─────────────────────────────────────────────
print('Saving lua_src.json...')
with open(LUA_SRC_PATH, 'w', encoding='utf-8') as f:
    json.dump(lua_data, f, ensure_ascii=False, separators=(',', ':'))
print('lua_src.json saved')

# ─── 3. Bump version in index.html to force browser cache bust ────────────────
print('Bumping version in index.html...')
with open(INDEX_PATH, 'r', encoding='utf-8') as f:
    html = f.read()

# Change version string from '20260909e' to '20260912b' (force reload)
html2 = html.replace("version: '20260909e'", "version: '20260912b'")
html2 = html2.replace('version: "20260909e"', 'version: "20260912b"')

if html2 != html:
    with open(INDEX_PATH, 'w', encoding='utf-8') as f:
        f.write(html2)
    print('✓ Version bumped to 20260912b (forces data_dumps.json reload)')
else:
    print('✗ Version string not found — check manually')

print('Done!')
