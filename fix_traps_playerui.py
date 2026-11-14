import sys

sys.stdout.reconfigure(encoding='utf-8')

path = r"D:\yugitauapk\web\src\PlayerUi.lua"
with open(path, "r", encoding="utf-8") as f:
    text = f.read()

# 1. useCard handler for 20118 and 20120
old_use_card = """	elseif arg_55_2._id == 20119 then
		return arg_55_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_55_1,
			_choice = var_55_4 * BattleData.ChoiceId.stage_3
		})"""

new_use_card = """	elseif arg_55_2._id == 20118 or arg_55_2._id == 20119 then
		return arg_55_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_55_1,
			_choice = var_55_4 * BattleData.ChoiceId.stage_3
		})
	elseif arg_55_2._id == 20120 then
		local cands = {}
		for _, c in ipairs(B.mergeTable({ arg_55_0._player:getBattleCards("C"), arg_55_0._player:getBattleCards("S") })) do
			if c ~= arg_55_1 and c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		else
			return arg_55_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_55_1,
				_choice = var_55_4 * BattleData.ChoiceId.stage_3
			})
		end"""

if old_use_card in text:
    text = text.replace(old_use_card, new_use_card, 1)
    print("[OK] Replaced useCard for 20118/20120")
else:
    print("[SKIP] useCard already updated or not found")

# 2. Dialog title for 20120
old_title_target = """	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20195, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then"""
new_title_code = """	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20120, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Phép/Bẫy phe ta để phá hủy"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20195, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then"""

if old_title_target in text and "20120" not in text[text.find(old_title_target)-150:text.find(old_title_target)]:
    text = text.replace(old_title_target, new_title_code, 1)
    print("[OK] Added dialog title for 20120")
else:
    print("[SKIP] Dialog title for 20120 already added or not found")

# 3. onChoiceGrave single choice dispatch for 20120
old_dispatch = """or arg_89_2._card:isSkillAtIndex(20218, labIdx) then"""
new_dispatch = """or arg_89_2._card:isSkillAtIndex(20218, labIdx) or arg_89_2._card:isSkillAtIndex(20120, labIdx) then"""

if old_dispatch in text:
    text = text.replace(old_dispatch, new_dispatch, 1)
    print("[OK] Added 20120 to onChoiceGrave dispatch")
else:
    print("[SKIP] 20120 already in dispatch or not found")

with open(path, "w", encoding="utf-8") as f:
    f.write(text)

print("[DONE] Finished updating PlayerUi.lua for 4 trap cards")
