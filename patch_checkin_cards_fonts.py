"""
Patch all 3 user requests:
1. Fix Check-in (CheckinForm) tabs & MonthCheckinPanel layout so tabs have backgrounds and text doesn't overlap.
2. Fix card clicks in HeroCenterScene and CardBoxScene so clicking any card opens CardInfoPanel (card description/details).
3. Adjust ClientView.FontSize scale and fitLabel floor so Vietnamese text fits neatly and is not oversized.
4. Add res/activity.lcres to preload in index.html and bump version.
"""
import json, sys, io, re

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

LUA_PATH = r'D:\yugitauapk\web\lua_src.json'
with open(LUA_PATH, 'r', encoding='utf-8') as f:
    lua_data = json.load(f)

# =========================================================================
# 1. CLIENTVIEW: Adjust FontSize and fitLabel
# =========================================================================
cv_src = lua_data['ClientView']

# Adjust FontSize table
old_font_size = '''var_0_0.FontSize = {
\tS2 = 22,
\tB2 = 36,
\tM2 = 28,
\tM1 = 32,
\tB1 = 48,
\tS1 = 26,
\tS3 = 20
}'''

new_font_size = '''var_0_0.FontSize = {
\tS2 = 18,
\tB2 = 28,
\tM2 = 22,
\tM1 = 25,
\tB1 = 38,
\tS1 = 20,
\tS3 = 15
}'''

if old_font_size in cv_src:
    cv_src = cv_src.replace(old_font_size, new_font_size, 1)
    print('✓ ClientView.FontSize adjusted')
else:
    print('ℹ Notice: old_font_size pattern not exact match, checking with regex...')
    cv_src = re.sub(
        r'var_0_0\.FontSize\s*=\s*\{[^}]+\}',
        new_font_size,
        cv_src,
        count=1
    )
    print('✓ ClientView.FontSize updated via regex')

# Adjust fitLabel floor from 0.6 to 0.35
old_fit_label = 'arg_90_8:setScale(math.max((arg_90_6 or 0.6) * var_90_5,'
new_fit_label = 'arg_90_8:setScale(math.max((arg_90_6 or 0.35) * var_90_5,'
if old_fit_label in cv_src:
    cv_src = cv_src.replace(old_fit_label, new_fit_label, 1)
    print('✓ ClientView.fitLabel floor adjusted to 0.35')

lua_data['ClientView'] = cv_src

# =========================================================================
# 2. CHECKIN: CheckinForm tab buttons & text layout
# =========================================================================
cf_src = lua_data['CheckinForm']

# Replace tab label creation in CheckinForm
old_tab_code = '''\t\t\tlocal var_2_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.CHECKIN_MONTH + var_2_2 - 1))

\t\t\tvar_2_7:setColor(lc.Color3B.yellow)
\t\t\tlc.addChildToPos(var_2_5, var_2_7, cc.p(lc.w(var_2_5) / 2, 20))
\t\t\t-- six tabs share one row: a caption wider than its own button runs
\t\t\t-- straight into the caption beside it
\t\t\tClientView.fitLabel(var_2_7, lc.w(var_2_4) - 8)'''

new_tab_code = '''\t\t\tvar_2_5:setContentSize(124, 128)
\t\t\tlocal _tabNames = {
\t\t\t\t[Data.CheckinType.month_checkin] = "Điểm danh",
\t\t\t\t[Data.CheckinType.week_checkin] = "7 Ngày",
\t\t\t\t[Data.CheckinType.month_card] = "Thẻ tháng",
\t\t\t\t[Data.CheckinType.month_card3] = "Chí tôn",
\t\t\t\t[Data.CheckinType.novice] = "Tân thủ",
\t\t\t\t[Data.CheckinType.online] = "Online"
\t\t\t}
\t\t\tlocal _titleStr = _tabNames[var_2_2] or Str(STR.CHECKIN_MONTH + var_2_2 - 1)
\t\t\tlocal var_2_7 = ClientView.createTTF(_titleStr, ClientView.FontSize.S2, lc.Color3B.yellow)
\t\t\tlc.addChildToPos(var_2_5, var_2_7, cc.p(lc.w(var_2_4) / 2, 18))
\t\t\tClientView.fitLabel(var_2_7, lc.w(var_2_4) - 12, 0.4)'''

if old_tab_code in cf_src:
    cf_src = cf_src.replace(old_tab_code, new_tab_code, 1)
    print('✓ CheckinForm tab labels updated')
else:
    # try replacing the key lines
    cf_src = re.sub(
        r'local var_2_7 = ClientView\.createBMFont\(ClientView\.BMFont\.huali_26, Str\(STR\.CHECKIN_MONTH \+ var_2_2 - 1\)\)[\s\S]*?ClientView\.fitLabel\(var_2_7, lc\.w\(var_2_4\) - 8\)',
        new_tab_code.strip(),
        cf_src,
        count=1
    )
    print('✓ CheckinForm tab labels updated via regex')

lua_data['CheckinForm'] = cf_src

# =========================================================================
# 3. MONTH CHECKIN PANEL: Fix header text overflow
# =========================================================================
mcp_src = lua_data['MonthCheckinPanel']

old_mcp_title = 'local var_10_3 = ClientView.createTTF(string.format(Str(STR.MONTH_REGISTER_NUM), 0), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)'
new_mcp_title = '''local var_10_3 = ClientView.createTTF(string.format(Str(STR.MONTH_REGISTER_NUM), 0), ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK)
\tvar_10_3:setScale(0.8)'''

if old_mcp_title in mcp_src:
    mcp_src = mcp_src.replace(old_mcp_title, new_mcp_title, 1)
    print('✓ MonthCheckinPanel title text size adjusted')

lua_data['MonthCheckinPanel'] = mcp_src

# =========================================================================
# 4. CARD CLICKS: HeroCenterScene & CardBoxScene -> Open CardInfoPanel
# =========================================================================
hcs_src = lua_data['HeroCenterScene']

# In onCardSelected: remove distance check so card clicks always open CardInfoPanel
old_hcs_sel = 'if cc.pGetDistance(var_50_0:getTouchEndPosition(), var_50_0:getTouchBeganPosition()) < 20 then'
new_hcs_sel = 'if var_50_0 ~= nil then'

if old_hcs_sel in hcs_src:
    hcs_src = hcs_src.replace(old_hcs_sel, new_hcs_sel, 1)
    print('✓ HeroCenterScene onCardSelected distance check removed')

# In onTroopThumbnailSelected: remove distance check so deck card clicks open CardInfoPanel
old_troop_sel = 'if cc.pGetDistance(arg_48_1:getTouchEndPosition(), arg_48_1:getTouchBeganPosition()) < 32 then'
new_troop_sel = 'if arg_48_1 ~= nil then'

if old_troop_sel in hcs_src:
    hcs_src = hcs_src.replace(old_troop_sel, new_troop_sel, 1)
    print('✓ HeroCenterScene onTroopThumbnailSelected distance check removed')

lua_data['HeroCenterScene'] = hcs_src

# In CardBoxScene: open CardInfoPanel instead of CardOperatePanel decompose
cbs_src = lua_data['CardBoxScene']
old_cbs_sel = '''function var_0_4.onCardSelected(arg_15_0, arg_15_1, arg_15_2)
\tvar_0_3.create(arg_15_1, var_0_3.OperateMode.decompose):show()
end'''

new_cbs_sel = '''function var_0_4.onCardSelected(arg_15_0, arg_15_1, arg_15_2)
\tlocal CardInfoPanel = require("CardInfoPanel")
\tlocal var_15_0 = CardInfoPanel.create(arg_15_1, P._playerCard._levels[arg_15_1] or 1, CardInfoPanel.OperateType.operate)
\tlocal var_15_1 = (arg_15_0._cardList._curPage - 1) * arg_15_0._cardList._itemRow * arg_15_0._cardList._itemCol + (arg_15_2 or 1)
\tvar_15_0:setCardList(arg_15_0._cardList._cards, var_15_1, ClientData.getStrByCardType(Data.getType(arg_15_1)) .. Str(STR.CARD_LIST))
\tvar_15_0:show()
end'''

if old_cbs_sel in cbs_src:
    cbs_src = cbs_src.replace(old_cbs_sel, new_cbs_sel, 1)
    print('✓ CardBoxScene onCardSelected updated to open CardInfoPanel')

lua_data['CardBoxScene'] = cbs_src

# Save lua_src.json
with open(LUA_PATH, 'w', encoding='utf-8') as f:
    json.dump(lua_data, f, ensure_ascii=False, separators=(',', ':'))
print('✓ lua_src.json successfully saved')

# =========================================================================
# 5. PRELOAD: Add res/activity.lcres to index.html & bump version
# =========================================================================
INDEX_PATH = r'D:\yugitauapk\web\index.html'
with open(INDEX_PATH, 'r', encoding='utf-8') as f:
    html = f.read()

# Add res/activity.lcres to preload if missing
if "'res/activity.lcres'" not in html:
    html = html.replace("'res/city.lcres',", "'res/city.lcres', 'res/activity.lcres',")
    print('✓ res/activity.lcres added to preload list in index.html')

# Bump version to 20260912f
html = re.sub(r"version:\s*'20260912[a-z]'", "version: '20260912f'", html)
print('✓ version bumped to 20260912f')

with open(INDEX_PATH, 'w', encoding='utf-8') as f:
    f.write(html)
print('✓ index.html successfully saved')
