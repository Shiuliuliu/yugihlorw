import sys
sys.stdout.reconfigure(encoding='utf-8')
import json

with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    summary = json.load(f)

def format_card_list(cards):
    return "{" + ", ".join(str(c) for c in cards) + "}"

out = []

# PACK_TITLES
out.append("\tlocal PACK_TITLES = {")
for p in summary['char_packs']:
    num = p['num']
    val = p['value'] # e.g. 10201
    name = p['name']
    out.append(f'\t\t[{num}] = "{name}", [{val}] = "{name}", [{val+9}] = "{name}", [{val+49}] = "{name}",')

for p in summary['liya_packs']:
    num = p['num']
    val = p['value']
    name = p['name']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{num}] = "{name}", [{prefix+1}] = "{name}", [{prefix+10}] = "{name}", [{prefix+50}] = "{name}",')

for p in summary['extra_packs']:
    num = p['num']
    val = p['value']
    name = p['name']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{num}] = "{name}", [{prefix+1}] = "{name}", [{prefix+10}] = "{name}", [{prefix+50}] = "{name}",')

for p in summary.get('expansion_packs', []):
    num = p['num']
    val = p['value']
    name = p['name']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{prefix+1}] = "{name}", [{prefix+10}] = "{name}", [{prefix+50}] = "{name}",')

out.append("\t}")
out.append("\tClientData._packTitles = PACK_TITLES")
out.append("\tClientData.getPackTitle = function(boxId)")
out.append("\t\tif not boxId then return \"\" end")
out.append("\t\treturn PACK_TITLES[boxId] or \"\"")
out.append("\tend\n")

# PACK_IMAGES
out.append("\tlocal PACK_IMAGES = {")
for p in summary['char_packs']:
    val = p['value']
    img = p['fallback_img']
    out.append(f'\t\t[{val}] = "lottery_{img}", [{val+9}] = "lottery_{img}", [{val+49}] = "lottery_{img}",')

for p in summary['liya_packs']:
    val = p['value']
    img = p['fallback_img']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{prefix+1}] = "lottery_{img}", [{prefix+10}] = "lottery_{img}", [{prefix+50}] = "lottery_{img}",')

for p in summary['extra_packs']:
    val = p['value']
    img = p['fallback_img']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{prefix+1}] = "lottery_{img}", [{prefix+10}] = "lottery_{img}", [{prefix+50}] = "lottery_{img}",')

for p in summary.get('expansion_packs', []):
    val = p['value']
    img = p['fallback_img']
    prefix = (val // 1000) * 1000
    out.append(f'\t\t[{prefix+1}] = "lottery_{img}", [{prefix+10}] = "lottery_{img}", [{prefix+50}] = "lottery_{img}",')

out.append("\t}")
out.append("\tClientData._packImages = PACK_IMAGES")
out.append("\tClientData.getPackImageName = function(boxId)")
out.append("\t\tif not boxId then return nil end")
out.append("\t\treturn PACK_IMAGES[boxId]")
out.append("\tend\n")

# CHAR_CARDS_MAP
out.append("\tlocal CHAR_CARDS_MAP = {")
for p in summary['char_packs']:
    num = p['num']
    val = p['value']
    c_str = format_card_list(p['cards'])
    out.append(f'\t\t[{num}] = {c_str},')
    out.append(f'\t\t[{val}] = {c_str}, [{val+9}] = {c_str}, [{val+49}] = {c_str},')
out.append("\t}")
out.append("\tClientData._charCardsMap = CHAR_CARDS_MAP\n")

# LIYA_CARDS_MAP
out.append("\tlocal LIYA_CARDS_MAP = {")
for p in summary['liya_packs']:
    num = p['num']
    val = p['value']
    prefix = (val // 1000) * 1000
    c_str = format_card_list(p['cards'])
    out.append(f'\t\t[{num}] = {c_str},')
    out.append(f'\t\t[{prefix+1}] = {c_str}, [{prefix+10}] = {c_str}, [{prefix+50}] = {c_str},')
out.append("\t}")
out.append("\tClientData._liyaCardsMap = LIYA_CARDS_MAP\n")

# EXTRA_CARDS_MAP
out.append("\tlocal EXTRA_CARDS_MAP = {")
for p in summary['extra_packs']:
    num = p['num']
    val = p['value']
    prefix = (val // 1000) * 1000
    c_str = format_card_list(p['cards'])
    out.append(f'\t\t[{num}] = {c_str},')
    out.append(f'\t\t[{prefix+1}] = {c_str}, [{prefix+10}] = {c_str}, [{prefix+50}] = {c_str},')
out.append("\t}")
out.append("\tClientData._extraCardsMap = EXTRA_CARDS_MAP\n")

# EXPANSION_CARDS_MAP
out.append("\tlocal EXPANSION_CARDS_MAP = {")
for p in summary.get('expansion_packs', []):
    num = p['num']
    val = p['value']
    prefix = (val // 1000) * 1000
    c_str = format_card_list(p['cards'])
    out.append(f'\t\t[{num}] = {c_str},')
    out.append(f'\t\t[{prefix+1}] = {c_str}, [{prefix+10}] = {c_str}, [{prefix+50}] = {c_str},')
out.append("\t}")
out.append("\tClientData._expansionCardsMap = EXPANSION_CARDS_MAP\n")

# injectPacks()
out.append("""\t-- Card Box Info & Reset (Tavern / draw)
\tlocal function injectPacks()
\t\tif not rawget(_G, "Data") or not Data._recruitInfo then return end

\t\t-- Helper to ensure pack object exists in Data._recruitInfo and Data._dropInfo
\t\tlocal function registerPack(pval, cardList, ptype, pcost)
\t\t\tlocal pidTbl = {}
\t\t\tfor _, pId in ipairs(cardList) do
\t\t\t\ttable.insert(pidTbl, { pId })
\t\t\tend
\t\t\tlocal item = Data._recruitInfo[pval] or (Data._dropInfo and Data._dropInfo[pval])
\t\t\tif not item then
\t\t\t\titem = {
\t\t\t\t\t_id = pval,
\t\t\t\t\t_value = pval,
\t\t\t\t\t_type = ptype,
\t\t\t\t\t_isHide = 0,
\t\t\t\t\t_nameSid = 14202,
\t\t\t\t\t_descSid = 14202,
\t\t\t\t\t_param = { [1] = Data.ResType.gold, [2] = pcost, [3] = 0, [4] = 0, [5] = 0 },
\t\t\t\t\t_pid = pidTbl,
\t\t\t\t\t_rid = cardList,
\t\t\t\t\t_cards = cardList
\t\t\t\t}
\t\t\telse
\t\t\t\titem._rid = cardList
\t\t\t\titem._cards = cardList
\t\t\t\titem._pid = pidTbl
\t\t\t\tif not item._param then item._param = {} end
\t\t\t\titem._param[1] = Data.ResType.gold
\t\t\t\titem._param[2] = pcost
\t\t\t\titem._isHide = 0
\t\t\tend
\t\t\tData._recruitInfo[pval] = item
\t\t\tif Data._dropInfo then Data._dropInfo[pval] = item end
\t\tend

\t\t-- Inject all 20 Character theme packs (1, 10, 50)
\t\tfor i = 1, 20 do
\t\t\tlocal baseVal = 10100 + i * 100
\t\t\tlocal cList = CHAR_CARDS_MAP[i] or CHAR_CARDS_MAP[baseVal + 1] or {}
\t\t\tregisterPack(baseVal + 1, cList, 1002, 500)
\t\t\tregisterPack(baseVal + 10, cList, 1002, 4500)
\t\t\tregisterPack(baseVal + 50, cList, 1002, 22500)
\t\t\tregisterPack(i, cList, 1002, 500)
\t\tend

\t\t-- Inject all 20 Liya theme packs (1, 10, 50)
\t\tfor i = 1, 20 do
\t\t\tlocal prefix = 100000 + i * 1000
\t\t\tlocal cList = LIYA_CARDS_MAP[i] or LIYA_CARDS_MAP[prefix + 10] or {}
\t\t\tregisterPack(prefix + 1, cList, 1001, 600)
\t\t\tregisterPack(prefix + 10, cList, 1001, 6000)
\t\t\tregisterPack(prefix + 50, cList, 1001, 28500)
\t\t\tregisterPack(i, cList, 1001, 600)
\t\tend

\t\t-- Inject 22 Extra theme packs (1, 10, 50)
\t\tfor i = 1, 22 do
\t\t\tlocal prefix = 120000 + i * 1000
\t\t\tlocal cList = EXTRA_CARDS_MAP[i] or EXTRA_CARDS_MAP[prefix + 10] or {}
\t\t\tregisterPack(prefix + 1, cList, 1001, 600)
\t\t\tregisterPack(prefix + 10, cList, 1001, 6000)
\t\t\tregisterPack(prefix + 50, cList, 1001, 28500)
\t\tend

\t\t-- Inject 5 Expansion theme packs (1, 10, 50)
\t\tfor i = 1, 5 do
\t\t\tlocal prefix = 150000 + i * 1000
\t\t\tlocal cList = EXPANSION_CARDS_MAP[i] or EXPANSION_CARDS_MAP[prefix + 10] or {}
\t\t\tregisterPack(prefix + 1, cList, 1001, 600)
\t\t\tregisterPack(prefix + 10, cList, 1001, 6000)
\t\t\tregisterPack(prefix + 50, cList, 1001, 28500)
\t\tend

\t\tif rawget(_G, "Data") and Data._productsExInfo then
\t\t\tif not Data._productsExInfo[59] then
\t\t\t\tData._productsExInfo[59] = {
\t\t\t\t\t_id = 59,
\t\t\t\t\t_cardId = 40209,
\t\t\t\t\t_cost = 200000,
\t\t\t\t\t_resType = 1,
\t\t\t\t\t_date = "20170101.0"
\t\t\t\t}
\t\t\tend
\t\tend
\tend
\tClientData.injectPacks = injectPacks
\tpcall(injectPacks)

\t-- Universal Pack Card Pool Helper
\tClientData.getPackCardPool = function(boxId)
\t\tlocal pool = {}
\t\tlocal added = {}
\t\tlocal cList = nil

\t\tif boxId then
\t\t\tif boxId >= 151001 and boxId <= 155050 then
\t\t\t\tlocal expIdx = math.floor((boxId - 150000) / 1000)
\t\t\t\tlocal xpm = ClientData._expansionCardsMap or EXPANSION_CARDS_MAP
\t\t\t\tcList = xpm and (xpm[boxId] or xpm[expIdx])
\t\t\telseif boxId >= 121001 and boxId <= 145000 then
\t\t\t\tlocal eIdx = math.floor((boxId - 120000) / 1000)
\t\t\t\tlocal em = ClientData._extraCardsMap or EXTRA_CARDS_MAP
\t\t\t\tcList = em and (em[boxId] or em[eIdx])
\t\t\telseif boxId >= 101001 and boxId <= 120050 then
\t\t\t\tlocal lIdx = math.floor((boxId - 100000) / 1000)
\t\t\t\tlocal lm = ClientData._liyaCardsMap or LIYA_CARDS_MAP
\t\t\t\tcList = lm and (lm[boxId] or lm[lIdx])
\t\t\telseif boxId >= 10201 and boxId <= 12150 then
\t\t\t\tlocal cIdx = math.floor((boxId - 10100) / 100)
\t\t\t\tlocal cm = ClientData._charCardsMap or CHAR_CARDS_MAP
\t\t\t\tcList = cm and (cm[boxId] or cm[cIdx])
\t\t\telseif EXPANSION_CARDS_MAP and EXPANSION_CARDS_MAP[boxId] then
\t\t\t\tcList = EXPANSION_CARDS_MAP[boxId]
\t\t\telseif EXTRA_CARDS_MAP and EXTRA_CARDS_MAP[boxId] then
\t\t\t\tcList = EXTRA_CARDS_MAP[boxId]
\t\t\telseif LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
\t\t\t\tcList = LIYA_CARDS_MAP[boxId]
\t\t\telseif CHAR_CARDS_MAP and CHAR_CARDS_MAP[boxId] then
\t\t\t\tcList = CHAR_CARDS_MAP[boxId]
\t\t\tend
\t\tend

\t\tif cList then
\t\t\tfor _, pId in ipairs(cList) do
\t\t\t\tpId = tonumber(pId)
\t\t\t\tif pId and pId > 0 and not added[pId] then
\t\t\t\t\tadded[pId] = true
\t\t\t\t\ttable.insert(pool, pId)
\t\t\t\tend
\t\t\tend
\t\tend

\t\t-- Fallback to recruit._pid / drop._pid if not in custom maps
\t\tif #pool == 0 then
\t\t\tlocal recruit = (Data and Data._recruitInfo and Data._recruitInfo[boxId]) or (Data and Data._dropInfo and Data._dropInfo[boxId])
\t\t\tif recruit and recruit._pid then
\t\t\t\tfor _, pv in ipairs(recruit._pid) do
\t\t\t\t\tlocal pId = type(pv) == "table" and (pv[1] or pv.id) or pv
\t\t\t\t\tpId = tonumber(pId)
\t\t\t\t\tif pId and pId > 0 and not added[pId] then
\t\t\t\t\t\tadded[pId] = true
\t\t\t\t\t\ttable.insert(pool, pId)
\t\t\t\t\tend
\t\t\t\tend
\t\t\tend
\t\t\tif #pool == 0 and recruit and recruit._rid then
\t\t\t\tfor _, pId in ipairs(recruit._rid) do
\t\t\t\t\tpId = tonumber(pId)
\t\t\t\t\tif pId and pId > 0 and not added[pId] then
\t\t\t\t\t\tadded[pId] = true
\t\t\t\t\t\ttable.insert(pool, pId)
\t\t\t\t\tend
\t\t\tend
\t\t\tend
\t\tend

\t\treturn pool
\tend""")

lua_code = "\n".join(out)
with open('generated_patch_pack_section.lua', 'w', encoding='utf-8') as f:
    f.write(lua_code)

print("Generated generated_patch_pack_section.lua successfully with all 4 tabs!")
