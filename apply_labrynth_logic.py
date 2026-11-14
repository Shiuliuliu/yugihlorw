import sys
sys.stdout.reconfigure(encoding='utf-8')

def replace_once(path, old, new, label=""):
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    if new in text:
        print(f"[SKIP] Already applied in {path} ({label})")
        return
    if old not in text:
        old_crlf = old.replace("\n", "\r\n")
        new_crlf = new.replace("\n", "\r\n")
        if new_crlf in text:
            print(f"[SKIP] Already applied (CRLF) in {path} ({label})")
            return
        assert old_crlf in text, f"Target not found in {path} ({label})"
        text = text.replace(old_crlf, new_crlf, 1)
    else:
        text = text.replace(old, new, 1)
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[OK] Updated {path} ({label})")

# 0. Fix _refSkills of 20152 from 2001 to 1080 in skill.lua and h5_patch.lua
replace_once(
    r"D:\yugitauapk\web\data\skill.lua",
    '[20152]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58163,["_effectVal"]={[1]=152,},["_id"]=20152,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},["_nameSid"]=58162,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12376,},["_refSkills"]={[1]=2001,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},',
    '[20152]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58163,["_effectVal"]={[1]=152,},["_id"]=20152,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},["_nameSid"]=58162,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12376,},["_refSkills"]={[1]=1080,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},',
    "20152 _refSkills 1080 in skill.lua"
)
replace_once(
    r"D:\yugitauapk\web\src\h5_patch.lua",
    "Data._skillInfo[20152] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 58163, _effectVal = { 152 }, _id = 20152, _isIgnoreDefend = 0, _modes = { 31 }, _nameSid = 58162, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 12376 }, _refSkills = { 2001 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }",
    "Data._skillInfo[20152] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 58163, _effectVal = { 152 }, _id = 20152, _isIgnoreDefend = 0, _modes = { 31 }, _nameSid = 58162, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 12376 }, _refSkills = { 1080 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }",
    "20152 _refSkills 1080 in h5_patch.lua"
)

# 1. BattleCard.lua
replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """					elseif bcId == 12370 then
						if arg_127_1 == 12010 then return true end
						if arg_127_1 == 2794 and bc ~= arg_127_0 then return true end
					end
				end
			end
		end
	end""",
    """					elseif bcId == 12370 then
						if arg_127_1 == 12010 then return true end
						if arg_127_1 == 2794 and bc ~= arg_127_0 then return true end
					end
				end
			end
		end
	end

	-- Labrynth Knight (12376 / 20150): Khi có mặt, quái 8 sao có từ khóa "Labrynth" phe ta khi lên sân không bị ảnh hưởng bởi Phép/Bẫy của đối thủ (12009, 12010)
	if (arg_127_1 == 12009 or arg_127_1 == 12010) and arg_127_0._status == BattleData.CardStatus.board and (arg_127_0._info and arg_127_0._info._keyword == 308) and arg_127_0:getStar() == 8 then
		if arg_127_0._labKnightShieldProtected then
			return true
		end
		local owner = arg_127_0._owner
		if owner and owner._boardCards then
			for iter_lab = 1, #owner._boardCards do
				local bc = owner._boardCards[iter_lab]
				if bc and bc._status == BattleData.CardStatus.board and (bc._infoId == 12376 or bc._id == 12376) then
					return true
				end
			end
		end
	end""",
    "Labrynth Knight 20150 shield in BattleCard.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """function var_0_0.hasDisableMonsterBeforeAttackSkills(arg_143_0, arg_143_1)
	if arg_143_1 then
		return arg_143_0:hasCanCastMonsterSkills({
			1017,
			1045,
			1056,
			1064,
			1164
		}) or arg_143_0:isBindedSkill(7532)
	else
		return arg_143_0:hasSkills({
			1017,
			1045,
			1056,
			1064,
			1164
		}) or arg_143_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableMagicBeforeAttackSkills(arg_144_0, arg_144_1)
	if arg_144_1 then
		return arg_144_0:hasCanCastMonsterSkills({
			1045,
			1056,
			1065
		}) or arg_144_0:isBindedSkill(7532)
	else
		return arg_144_0:hasSkills({
			1045,
			1056,
			1065
		}) or arg_144_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableTrapBeforeAttackSkills(arg_145_0, arg_145_1)
	if arg_145_1 then
		return arg_145_0:hasCanCastMonsterSkills({
			1038,
			1045,
			1056,
			1065,
			1097
		}) or arg_145_0:isBindedSkill(7532)
	else
		return arg_145_0:hasSkills({
			1038,
			1045,
			1056,
			1065,
			1097
		}) or arg_145_0:isBindedSkill(7532)
	end
end""",
    """function var_0_0.hasDisableMonsterBeforeAttackSkills(arg_143_0, arg_143_1)
	if arg_143_1 then
		return arg_143_0:hasCanCastMonsterSkills({
			1017,
			1045,
			1056,
			1064,
			1164,
			20153
		}) or arg_143_0:isBindedSkill(7532)
	else
		return arg_143_0:hasSkills({
			1017,
			1045,
			1056,
			1064,
			1164,
			20153
		}) or arg_143_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableMagicBeforeAttackSkills(arg_144_0, arg_144_1)
	if arg_144_1 then
		return arg_144_0:hasCanCastMonsterSkills({
			1045,
			1056,
			1065,
			20153
		}) or arg_144_0:isBindedSkill(7532)
	else
		return arg_144_0:hasSkills({
			1045,
			1056,
			1065,
			20153
		}) or arg_144_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableTrapBeforeAttackSkills(arg_145_0, arg_145_1)
	if arg_145_1 then
		return arg_145_0:hasCanCastMonsterSkills({
			1038,
			1045,
			1056,
			1065,
			1097,
			20153
		}) or arg_145_0:isBindedSkill(7532)
	else
		return arg_145_0:hasSkills({
			1038,
			1045,
			1056,
			1065,
			1097,
			20153
		}) or arg_145_0:isBindedSkill(7532)
	end
end""",
    "20153 attack lock in BattleCard.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """	if arg_215_0._picoloLockedTurn and arg_215_0._owner and arg_215_0._picoloLockedTurn == arg_215_0._owner._round then
		return false
	end""",
    """	if arg_215_0._picoloLockedTurn and arg_215_0._owner and arg_215_0._picoloLockedTurn == arg_215_0._owner._round then
		return false
	end
	if arg_215_0._owner and arg_215_0._owner._labKnightAtkLockTurn == arg_215_0._owner._round then
		if arg_215_0 ~= arg_215_0._owner._labKnightAtkLockCard and not ((arg_215_0:isKeyword(308) or (arg_215_0._info and arg_215_0._info._keyword == 308)) and arg_215_0:getStar() == 8) then
			return false
		end
	end""",
    "20152 canAttack restriction in BattleCard.lua"
)

# 2. BattleCardStatus.lua
replace_once(
    r"D:\yugitauapk\web\src\BattleCardStatus.lua",
    """		-- 3. Card 11959: Opponent draws Dragon -> discard 11959, banish drawn dragon""",
    """		-- LABRYNTH STOVIE TORBIE (12372 / 20138): Mỗi lượt chỉ 1 lần. Khi bài này nằm trong mộ, khi đối thủ lấy bài vào tay, sẽ loại bỏ bản thân bài này và bài đối thủ vừa lấy được.
		if arg_1_3 == BattleData.CardStatus.hand and arg_1_2 ~= BattleData.CardStatus.hand then
			local isDuelRound = (arg_1_0._round and arg_1_0._round > 0) and (arg_1_0._macroStatus ~= BattleData.Status.initial_deal) and (not arg_1_1.isStatusValDeal or not arg_1_1:isStatusValDeal())
			if isDuelRound and oppo then
				local turnId = (arg_1_0._round or 0) * 1000 + (oppo._round or 0)
				if oppo._stovieBanishTurn ~= turnId and (oppo._castedSkillCounts[20138] or 0) == 0 then
					local stovieCard = nil
					for _, gc in ipairs(oppo:getBattleCards("G")) do
						if (gc:isInfoId(12372) or gc._infoId == 12372 or gc:hasSkillFast(20138)) and gc._status == BattleData.CardStatus.grave and gc:canChangeToLeave() then
							stovieCard = gc
							break
						end
					end
					if stovieCard then
						oppo._stovieBanishTurn = turnId
						oppo._castedSkillCounts[20138] = (oppo._castedSkillCounts[20138] or 0) + 1
						oppo:changeCardStatus(stovieCard, BattleData.CardStatus.grave, BattleData.CardStatus.leave, BattleData.CardStatusVal.g2l_self, stovieCard, 20138, 91)
						arg_1_3 = BattleData.CardStatus.leave
						if arg_1_2 == BattleData.CardStatus.pile then
							arg_1_4 = BattleData.CardStatusVal.p2l_show
						end
						if oppo.checkLabrynthGraveTriggers then
							oppo:checkLabrynthGraveTriggers(stovieCard, 20138)
						end
						arg_1_0:battleLog("[BATTLE] Labrynth Stovie Torbie (12372) banished self from grave and banished opponent added card %d!", arg_1_1._infoId)
					end
				end
			end
		end

		-- 3. Card 11959: Opponent draws Dragon -> discard 11959, banish drawn dragon""",
    "Stovie Torbie 20138 in BattleCardStatus.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCardStatus.lua",
    """	-- Shin - Ăn vạ (12370 / 20132): khi lá bài này trên sân, phe ta nhận 2000 LP
	if arg_15_1:isInfoId(12370) or arg_15_1._infoId == 12370 then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner and boardOwner._fortress then
			boardOwner:incHp(boardOwner._fortress, 2000, false, arg_15_1._id, 20132, Data.SkillMode.using)
			boardOwner:account()
		end
	end""",
    """	-- Shin - Ăn vạ (12370 / 20132): khi lá bài này trên sân, phe ta nhận 2000 LP
	if arg_15_1:isInfoId(12370) or arg_15_1._infoId == 12370 then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner and boardOwner._fortress then
			boardOwner:incHp(boardOwner._fortress, 2000, false, arg_15_1._id, 20132, Data.SkillMode.using)
			boardOwner:account()
		end
	end

	-- LABRYNTH KNIGHT (12376 / 20151): Khi lên sân, tăng ATK bằng tổng số quái "Labrynth" trong mộ và mộ bài loại bỏ phe ta x300
	if arg_15_1:isInfoId(12376) or arg_15_1._infoId == 12376 or arg_15_1:hasSkillFast(20151) then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner then
			local labCount = 0
			for _, c in ipairs(boardOwner:getBattleCards("GL")) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
					labCount = labCount + 1
				end
			end
			if labCount > 0 then
				boardOwner:incAtk(arg_15_1, true, labCount * 300, Data.AggregateType.sum, arg_15_1._id, 20151, Data.SkillMode.entering)
			end
		end
	end

	-- LABRYNTH KNIGHT (12376 / 20150): Khi có mặt, quái 8 sao có từ khóa "Labrynth" phe ta khi lên sân không bị ảnh hưởng bởi Phép/Bẫy đối thủ
	if (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) and (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) and arg_15_1:getStar() == 8 then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner and #boardOwner:getBattleCardsByInfoId("B", 12376) > 0 then
			arg_15_1._labKnightShieldProtected = true
			boardOwner:incPositiveStatus(arg_15_1, { BattleData.PositiveType.extraSkill }, false, arg_15_1._id, 20150, Data.SkillMode.entering)
			boardOwner:incPositiveValue(arg_15_1, BattleData.PositiveType.extraSkill, 65536 + 12009, Data.AggregateType.table, arg_15_1._id, 20150, Data.SkillMode.entering)
			boardOwner:incPositiveValue(arg_15_1, BattleData.PositiveType.extraSkill, 65536 + 12010, Data.AggregateType.table, arg_15_1._id, 20150, Data.SkillMode.entering)
		end
	end""",
    "Labrynth Knight 20150/20151 in BattleCardStatus.lua"
)

# 3. BattleSkill.lua
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	if var_1_1 and (var_1_1._type == Data.CardType.magic or var_1_1._type == Data.CardType.trap) and var_1_1._owner and var_1_1._owner._opponent then
		local oppo = var_1_1._owner._opponent""",
    """	if var_1_1 and (var_1_1._type == Data.CardType.magic or var_1_1._type == Data.CardType.trap) and var_1_1._owner and var_1_1._owner._opponent then
		local oppo = var_1_1._owner._opponent

		-- LABRYNTH CHANDRAGLIER (12373 / 20141): Mỗi lượt chỉ 1 lần. Khi bài này nằm trong mộ, khi trong mộ phe ta có lá Bẫy từ khóa “Labrynth”, khi đối thủ dùng bài Phép sẽ kích hoạt. Loại bỏ bản thân bài này, vô hiệu hóa và phá hủy bài của đối thủ.
		if var_1_1._type == Data.CardType.magic then
			local turnId = (oppo._round or 0) * 1000 + (var_1_1._owner._round or 0)
			if oppo._chandraglierNegateTurn ~= turnId and (oppo._castedSkillCounts[20141] or 0) == 0 then
				local chandCard = nil
				local hasLabTrapInGrave = false
				for _, gc in ipairs(oppo:getBattleCards("G")) do
					if not chandCard and (gc:isInfoId(12373) or gc._infoId == 12373 or gc:hasSkillFast(20141)) and gc._status == BattleData.CardStatus.grave and gc:canChangeToLeave() then
						chandCard = gc
					end
					if gc._type == Data.CardType.trap and (gc:isKeyword(308) or (gc._info and gc._info._keyword == 308)) then
						hasLabTrapInGrave = true
					end
				end
				if chandCard and hasLabTrapInGrave then
					oppo._chandraglierNegateTurn = turnId
					oppo._castedSkillCounts[20141] = (oppo._castedSkillCounts[20141] or 0) + 1
					oppo:changeCardStatus(chandCard, BattleData.CardStatus.grave, BattleData.CardStatus.leave, BattleData.CardStatusVal.g2l_self, chandCard, 20141, 91)

					local actionPlayer = var_1_1._owner:getActionPlayer()
					local foundInQueue = false
					if actionPlayer and actionPlayer._cardStatusToChange then
						for _, item in ipairs(actionPlayer._cardStatusToChange) do
							if item._card == var_1_1 then
								item._destStatus = BattleData.CardStatus.grave
								item._statusVal = BattleData.CardStatusVal.x2g_oppo
								item._triggerCard = chandCard
								foundInQueue = true
							end
						end
					end
					if not foundInQueue and var_1_1._status ~= BattleData.CardStatus.grave then
						var_1_1._owner:changeCardStatus(var_1_1, var_1_1._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.x2g_oppo, chandCard, 20141, 91)
					end
					if oppo.checkLabrynthGraveTriggers then
						oppo:checkLabrynthGraveTriggers(chandCard, 20141)
					end
					return false
				end
			end
		end""",
    "Chandraglier 20141 spell negate in BattleSkill.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	if var_1_2 then
		arg_1_2._totalCastedTimes = arg_1_2._totalCastedTimes + 1
		var_1_1._owner._skillTotalCastedTimes[arg_1_2._id] = (var_1_1._owner._skillTotalCastedTimes[arg_1_2._id] or 0) + 1

		var_1_1._owner:skillCasted(var_1_1, arg_1_2, arg_1_3)
	elseif arg_1_3 ~= Data.SkillMode.halo then""",
    """	if var_1_2 then
		arg_1_2._totalCastedTimes = arg_1_2._totalCastedTimes + 1
		var_1_1._owner._skillTotalCastedTimes[arg_1_2._id] = (var_1_1._owner._skillTotalCastedTimes[arg_1_2._id] or 0) + 1

		var_1_1._owner:skillCasted(var_1_1, arg_1_2, arg_1_3)
		if var_1_1 and var_1_1._owner and (var_1_1:isKeyword(308) or (var_1_1._info and var_1_1._info._keyword == 308)) and arg_1_3 ~= Data.SkillMode.halo then
			if var_1_1._owner.checkLabrynthGraveTriggers then
				var_1_1._owner:checkLabrynthGraveTriggers(var_1_1, arg_1_2._id)
			end
		end
	elseif arg_1_3 ~= Data.SkillMode.halo then""",
    "checkLabrynthGraveTriggers hook in castSkill"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	if arg_19_1:isInfoId(12367) or arg_19_1:hasSkillFast(20121) or arg_19_1:isInfoId(12370) or arg_19_1:hasSkillFast(20131) then
		local var_sk_shin = arg_19_1:getSkillById(20121) or arg_19_1:getSkillById(20131) or (arg_19_1._skills and arg_19_1._skills[1])
		if var_sk_shin and var_0_0.KeywordSkill.canUse(arg_19_0, arg_19_1, var_sk_shin) then
			return true, nil, 2, var_sk_shin
		end
	end""",
    """	if arg_19_1:isInfoId(12367) or arg_19_1:hasSkillFast(20121) or arg_19_1:isInfoId(12370) or arg_19_1:hasSkillFast(20131) then
		local var_sk_shin = arg_19_1:getSkillById(20121) or arg_19_1:getSkillById(20131) or (arg_19_1._skills and arg_19_1._skills[1])
		if var_sk_shin and var_0_0.KeywordSkill.canUse(arg_19_0, arg_19_1, var_sk_shin) then
			return true, nil, 2, var_sk_shin
		end
	end
	if arg_19_1:isInfoId(12376) or arg_19_1:hasSkillFast(20149) then
		local var_sk_lab = arg_19_1:getSkillById(20149) or (arg_19_1._skills and arg_19_1._skills[1])
		if var_sk_lab and var_0_0.KeywordSkill.canUse(arg_19_0, arg_19_1, var_sk_lab) then
			return true, nil, 2, var_sk_lab
		end
	end""",
    "12376 canUseMonsterSpecial in BattleSkill.lua"
)

lab_module_code = """	-- Sau đó triệu hồi đặc biệt lá bài này lên sân đối thủ
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_oppo_special)

	return true
end

-- ===========================================================================
-- LABRYNTH (Keyword 308 / Cards 12371..12376 / Skills 20135..20154)
-- ===========================================================================
function var_0_0.checkLabrynthGraveTriggers(arg_lab_0, arg_lab_source, arg_lab_sid)
	if not arg_lab_0 then return end
	if arg_lab_sid == 20136 or arg_lab_sid == 20139 or arg_lab_sid == 20142 then
		return
	end
	local graveSnapshot = {}
	for _, gc in ipairs(arg_lab_0:getBattleCards("G")) do
		table.insert(graveSnapshot, gc)
	end
	for _, gc in ipairs(graveSnapshot) do
		if gc ~= arg_lab_source and gc._status == BattleData.CardStatus.grave then
			-- 12371 / 20136 (LABRYNTH COOCLOCK): đưa bản thân lá này vào tay (1 lượt 1 lần)
			if (gc:isInfoId(12371) or gc._infoId == 12371 or gc:hasSkillFast(20136)) and (arg_lab_0._castedSkillCounts[20136] or 0) == 0 and gc:canChangeToHand() then
				arg_lab_0._castedSkillCounts[20136] = (arg_lab_0._castedSkillCounts[20136] or 0) + 1
				arg_lab_0:changeCardStatus(gc, BattleData.CardStatus.grave, BattleData.CardStatus.hand, BattleData.CardStatusVal.g2h_self, gc, 20136, 91)
			-- 12372 / 20139 (LABRYNTH STOVIE TORBIE): Triệu hồi đặc biệt lá này lên sân phe ta (1 lượt 1 lần)
			elseif (gc:isInfoId(12372) or gc._infoId == 12372 or gc:hasSkillFast(20139)) and (arg_lab_0._castedSkillCounts[20139] or 0) == 0 then
				if #arg_lab_0:getBoardCards() < Data.MAX_CARD_COUNT_ON_BOARD and arg_lab_0:getEmptyBoardPos(gc) ~= nil and not arg_lab_0._isSummonDisabled and not arg_lab_0._isSpecialSummonDisabled and arg_lab_0:canSpecialSummon(gc) then
					arg_lab_0._castedSkillCounts[20139] = (arg_lab_0._castedSkillCounts[20139] or 0) + 1
					arg_lab_0:changeCardStatus(gc, BattleData.CardStatus.grave, BattleData.CardStatus.board, BattleData.CardStatusVal.g2b_self, gc, 20139, 91)
				end
			-- 12373 / 20142 (LABRYNTH CHANDRAGLIER): đưa bản thân lá này vào tay (1 lượt 1 lần)
			elseif (gc:isInfoId(12373) or gc._infoId == 12373 or gc:hasSkillFast(20142)) and (arg_lab_0._castedSkillCounts[20142] or 0) == 0 and gc:canChangeToHand() then
				arg_lab_0._castedSkillCounts[20142] = (arg_lab_0._castedSkillCounts[20142] or 0) + 1
				arg_lab_0:changeCardStatus(gc, BattleData.CardStatus.grave, BattleData.CardStatus.hand, BattleData.CardStatusVal.g2h_self, gc, 20142, 91)
			end
		end
	end
end

local var_0_lab = {
	handlers = {}
}

local function isLabrynthCard(c)
	return c ~= nil and (c:isKeyword(308) or (c._info and c._info._keyword == 308))
end

local function isMonsterCard(c)
	return c ~= nil and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare)
end

local function decodeLabSingleChoice(ks_fc)
	local card = ks_fc.card
	if card and card._labChosenId and card._labChosenId > 0 then
		local id = card._labChosenId
		card._labChosenId = nil
		return id
	end
	if card and card._choice and card._choice > 0 then
		local raw = math.floor(card._choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2
		if raw > 0 then
			return raw
		end
	end
	return 0
end

local function decodeLabTwoStageChoice(ks_fc)
	local card = ks_fc.card
	if card and (card._labStage1Id or card._labStage2Id) then
		local s1 = card._labStage1Id or 0
		local s2 = card._labStage2Id or 0
		card._labStage1Id = nil
		card._labStage2Id = nil
		return s1, s2
	end
	if card and card._choice and card._choice > 0 then
		local raw = math.floor(card._choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2
		if raw > 0 then
			local s1 = raw % BattleData.UseCardId.id_group
			local s2 = math.floor(raw / BattleData.UseCardId.id_group) % BattleData.UseCardId.id_group
			return s1, s2
		end
	end
	return 0, 0
end

function var_0_lab.canUse(arg_cu_0, arg_cu_1, arg_cu_2)
	local sid = arg_cu_2._id
	if (arg_cu_0._castedSkillCounts[sid] or 0) > 0 then
		return false
	end

	if sid == 20135 then
		-- LABRYNTH COOCLOCK (12371): Kỹ năng tay chủ động. Khi trên sân phe ta có quái vật "Labrynth", hi sinh bản thân; lấy 1 Phép/Bẫy trên tay đối thủ vào tay phe ta.
		if arg_cu_1._status ~= BattleData.CardStatus.hand or not arg_cu_1:canChangeToGrave() then
			return false
		end
		local hasLabOnBoard = false
		for _, bc in ipairs(arg_cu_0:getBoardCards()) do
			if isLabrynthCard(bc) then
				hasLabOnBoard = true
				break
			end
		end
		if not hasLabOnBoard then
			return false
		end
		local oppo = arg_cu_0._opponent
		if not oppo then return false end
		for _, hc in ipairs(oppo:getBattleCards("H")) do
			if (hc._type == Data.CardType.magic or hc._type == Data.CardType.trap) and hc:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20137 then
		-- LABRYNTH STOVIE TORBIE (12372): Kỹ năng tay/sân chủ động. Hi sinh bản thân; Chọn 1 lá trên tay đưa vào mộ. Sau đó lấy 1 Phép/Bẫy "Labrynth" từ bộ bài vào tay.
		if (arg_cu_1._status ~= BattleData.CardStatus.hand and arg_cu_1._status ~= BattleData.CardStatus.board) or not arg_cu_1:canChangeToGrave() then
			return false
		end
		local hasOtherHand = false
		for _, hc in ipairs(arg_cu_0:getBattleCards("H")) do
			if hc ~= arg_cu_1 and hc:canChangeToGrave() then
				hasOtherHand = true
				break
			end
		end
		return hasOtherHand

	elseif sid == 20140 then
		-- LABRYNTH CHANDRAGLIER (12373): Kỹ năng tay/sân chủ động. Hi sinh bản thân; Chọn 1 lá trên tay đưa vào mộ. Sau đó lấy 1 lá Bẫy từ bộ bài vào tay.
		if (arg_cu_1._status ~= BattleData.CardStatus.hand and arg_cu_1._status ~= BattleData.CardStatus.board) or not arg_cu_1:canChangeToGrave() then
			return false
		end
		local hasOtherHand = false
		for _, hc in ipairs(arg_cu_0:getBattleCards("H")) do
			if hc ~= arg_cu_1 and hc:canChangeToGrave() then
				hasOtherHand = true
				break
			end
		end
		return hasOtherHand

	elseif sid == 20143 then
		-- ARIANNA (12374): Kỹ năng tay chủ động: Hi sinh bản thân lấy 1 quái "Labrynth" 4 sao trở xuống từ bộ bài vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand or not arg_cu_1:canChangeToGrave() then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and isLabrynthCard(pc) and pc:getStar() <= 4 then
				return true
			end
		end
		return false

	elseif sid == 20144 then
		-- ARIANNA (12374): Chủ động trên sân: Lấy 1 bài có từ khóa "Labrynth" từ bộ bài vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isLabrynthCard(pc) then
				return true
			end
		end
		return false

	elseif sid == 20145 then
		-- ARIANNA (12374): Kỹ năng mộ chủ động: Chọn và Triệu Hồi Đặc Biệt 1 quái 4 sao trở xuống có từ khóa "Labrynth" từ mộ phe ta
		if arg_cu_1._status ~= BattleData.CardStatus.grave then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then
			return false
		end
		for _, gc in ipairs(arg_cu_0:getBattleCards("G")) do
			if isMonsterCard(gc) and isLabrynthCard(gc) and gc:getStar() <= 4 and arg_cu_0:getEmptyBoardPos(gc) ~= nil and arg_cu_0:canSpecialSummon(gc) then
				return true
			end
		end
		return false

	elseif sid == 20146 then
		-- ARIANE (12375): Kỹ năng tay chủ động: Hi sinh 1 lá bẫy trên tay phe ta; Triệu Hồi Đặc Biệt bản thân từ trên tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		for _, hc in ipairs(arg_cu_0:getBattleCards("H")) do
			if hc ~= arg_cu_1 and hc._type == Data.CardType.trap and hc:canChangeToGrave() then
				return true
			end
		end
		return false

	elseif sid == 20147 then
		-- ARIANE (12375): Chủ động trên sân: Chọn và triệu hồi lá bài “ARIANE THE LABRYNTH SERVANT” từ mộ hoặc bộ bài phe ta
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then
			return false
		end
		for _, c in ipairs(arg_cu_0:getBattleCards("GP")) do
			if (c:isInfoId(12375) or c._infoId == 12375) and arg_cu_0:getEmptyBoardPos(c) ~= nil and arg_cu_0:canSpecialSummon(c) then
				return true
			end
		end
		return false

	elseif sid == 20148 then
		-- ARIANE (12375): Kỹ năng mộ chủ động: Loại bỏ 1 lá bài trong mộ phe ta, chọn và lấy 1 quái có từ khóa “Labrynth” trong mộ bài loại bỏ phe ta về bộ bài
		if arg_cu_1._status ~= BattleData.CardStatus.grave then
			return false
		end
		local hasGraveToBanish = false
		for _, gc in ipairs(arg_cu_0:getBattleCards("G")) do
			if gc:canChangeToLeave() then
				hasGraveToBanish = true
				break
			end
		end
		if not hasGraveToBanish then
			return false
		end
		for _, lcCard in ipairs(arg_cu_0:getBattleCards("L")) do
			if isMonsterCard(lcCard) and isLabrynthCard(lcCard) then
				return true
			end
		end
		return false

	elseif sid == 20149 then
		-- LABRYNTH KNIGHT (12376): Kỹ năng tay chủ động: Khi trên sân phe ta có quái 8 sao có từ khóa “Labrynth”; Triệu Hồi Đặc Biệt bản thân từ trên tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		for _, bc in ipairs(arg_cu_0:getBoardCards()) do
			if isLabrynthCard(bc) and bc:getStar() == 8 then
				return true
			end
		end
		return false

	elseif sid == 20152 then
		-- LABRYNTH KNIGHT (12376): Chủ động trên sân: Bản thân chưa hành động có thể dùng. Nhận "Liên Trảm", các quái khác không thể tấn công trừ quái 8 sao "Labrynth"
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		return (arg_cu_1._actionIndex or 1) <= 1

	elseif sid == 20154 then
		-- LABRYNTH KNIGHT (12376): Kỹ năng mộ chủ động: Loại bỏ bản thân lá này, chọn và triệu hồi 1 Quái Vật 8 sao có từ khóa “Labrynth” trong mộ phe ta
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToLeave() then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then
			return false
		end
		for _, gc in ipairs(arg_cu_0:getBattleCards("G")) do
			if gc ~= arg_cu_1 and isMonsterCard(gc) and isLabrynthCard(gc) and gc:getStar() == 8 and arg_cu_0:getEmptyBoardPos(gc) ~= nil and arg_cu_0:canSpecialSummon(gc) then
				return true
			end
		end
		return false
	end

	return false
end

-- 20135 / LABRYNTH COOCLOCK (12371)
var_0_lab.handlers[135] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_oppo = ks_player._opponent
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20135
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20135] = (ks_player._castedSkillCounts[20135] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)

	local cands = {}
	for _, hc in ipairs(ks_oppo:getBattleCards("H")) do
		if (hc._type == Data.CardType.magic or hc._type == Data.CardType.trap) and hc:canChangeToHand() then
			table.insert(cands, hc)
		end
	end
	if #cands > 0 then
		local picked = ks_player:randomOne(cands) or cands[1]
		ks_battle:setCardStatus(picked, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2h_oppo)
	end
	return true
end

-- 20137 / LABRYNTH STOVIE TORBIE (12372)
var_0_lab.handlers[137] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20137
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20137] = (ks_player._castedSkillCounts[20137] or 0) + 1
	local handId, deckId = decodeLabTwoStageChoice(ks_fc)

	local selfVal = ks_card._status == BattleData.CardStatus.hand and BattleData.CardStatusVal.h2g_self or BattleData.CardStatusVal.b2g_sacrifice
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, selfVal)

	local discardCard = nil
	for _, hc in ipairs(ks_player:getBattleCards("H")) do
		if hc ~= ks_card and hc:canChangeToGrave() then
			if hc._id == handId then
				discardCard = hc
				break
			elseif not discardCard then
				discardCard = hc
			end
		end
	end
	if discardCard then
		ks_battle:setCardStatus(discardCard, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)
	end

	local searchCard = nil
	for _, pc in ipairs(ks_player:filterCanChangeToHandCards(ks_player:getBattleCards("P"))) do
		if isLabrynthCard(pc) and (pc._type == Data.CardType.magic or pc._type == Data.CardType.trap) then
			if pc._id == deckId then
				searchCard = pc
				break
			elseif not searchCard then
				searchCard = pc
			end
		end
	end
	if searchCard then
		ks_battle:setCardStatus(searchCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20140 / LABRYNTH CHANDRAGLIER (12373)
var_0_lab.handlers[140] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20140
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20140] = (ks_player._castedSkillCounts[20140] or 0) + 1
	local handId, deckId = decodeLabTwoStageChoice(ks_fc)

	local selfVal = ks_card._status == BattleData.CardStatus.hand and BattleData.CardStatusVal.h2g_self or BattleData.CardStatusVal.b2g_sacrifice
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, selfVal)

	local discardCard = nil
	for _, hc in ipairs(ks_player:getBattleCards("H")) do
		if hc ~= ks_card and hc:canChangeToGrave() then
			if hc._id == handId then
				discardCard = hc
				break
			elseif not discardCard then
				discardCard = hc
			end
		end
	end
	if discardCard then
		ks_battle:setCardStatus(discardCard, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)
	end

	local searchCard = nil
	for _, pc in ipairs(ks_player:filterCanChangeToHandCards(ks_player:getBattleCards("P"))) do
		if pc._type == Data.CardType.trap then
			if pc._id == deckId then
				searchCard = pc
				break
			elseif not searchCard then
				searchCard = pc
			end
		end
	end
	if searchCard then
		ks_battle:setCardStatus(searchCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20143 / ARIANNA (12374) Hand Active
var_0_lab.handlers[143] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20143
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20143] = (ks_player._castedSkillCounts[20143] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)

	local targetCard = nil
	for _, pc in ipairs(ks_player:filterCanChangeToHandCards(ks_player:getBattleCards("P"))) do
		if isMonsterCard(pc) and isLabrynthCard(pc) and pc:getStar() <= 4 then
			if pc._id == chosenId then
				targetCard = pc
				break
			elseif not targetCard then
				targetCard = pc
			end
		end
	end
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20144 / ARIANNA (12374) Board Active
var_0_lab.handlers[144] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20144
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20144] = (ks_player._castedSkillCounts[20144] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	local targetCard = nil
	for _, pc in ipairs(ks_player:filterCanChangeToHandCards(ks_player:getBattleCards("P"))) do
		if isLabrynthCard(pc) then
			if pc._id == chosenId then
				targetCard = pc
				break
			elseif not targetCard then
				targetCard = pc
			end
		end
	end
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20145 / ARIANNA (12374) Grave Active
var_0_lab.handlers[145] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20145
	local ks_mode = ks_fc.mode or 32

	ks_player._castedSkillCounts[20145] = (ks_player._castedSkillCounts[20145] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	local targetCard = nil
	for _, gc in ipairs(ks_player:getBattleCards("G")) do
		if isMonsterCard(gc) and isLabrynthCard(gc) and gc:getStar() <= 4 and ks_player:getEmptyBoardPos(gc) ~= nil and ks_player:canSpecialSummon(gc) then
			if gc._id == chosenId then
				targetCard = gc
				break
			elseif not targetCard then
				targetCard = gc
			end
		end
	end
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2b_self)
	end
	return true
end

-- 20146 / ARIANE (12375) Hand Active
var_0_lab.handlers[146] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20146
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20146] = (ks_player._castedSkillCounts[20146] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	local trapCard = nil
	for _, hc in ipairs(ks_player:getBattleCards("H")) do
		if hc ~= ks_card and hc._type == Data.CardType.trap and hc:canChangeToGrave() then
			if hc._id == chosenId then
				trapCard = hc
				break
			elseif not trapCard then
				trapCard = hc
			end
		end
	end
	if trapCard then
		ks_battle:setCardStatus(trapCard, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)
	end
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20147 / ARIANE (12375) Board Active
var_0_lab.handlers[147] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20147
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20147] = (ks_player._castedSkillCounts[20147] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	local targetCard = nil
	for _, c in ipairs(ks_player:getBattleCards("GP")) do
		if (c:isInfoId(12375) or c._infoId == 12375) and ks_player:getEmptyBoardPos(c) ~= nil and ks_player:canSpecialSummon(c) then
			if c._id == chosenId then
				targetCard = c
				break
			elseif not targetCard then
				targetCard = c
			end
		end
	end
	if targetCard then
		local val = targetCard._status == BattleData.CardStatus.grave and BattleData.CardStatusVal.g2b_self or BattleData.CardStatusVal.p2b_self
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, val)
	end
	return true
end

-- 20148 / ARIANE (12375) Grave Active
var_0_lab.handlers[148] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20148
	local ks_mode = ks_fc.mode or 32

	ks_player._castedSkillCounts[20148] = (ks_player._castedSkillCounts[20148] or 0) + 1
	local banishId, returnId = decodeLabTwoStageChoice(ks_fc)

	local banishCard = nil
	for _, gc in ipairs(ks_player:getBattleCards("G")) do
		if gc:canChangeToLeave() then
			if gc._id == banishId then
				banishCard = gc
				break
			elseif not banishCard then
				banishCard = gc
			end
		end
	end
	if banishCard then
		ks_battle:setCardStatus(banishCard, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_self)
	end

	local returnCard = nil
	for _, lcCard in ipairs(ks_player:getBattleCards("L")) do
		if isMonsterCard(lcCard) and isLabrynthCard(lcCard) then
			if lcCard._id == returnId then
				returnCard = lcCard
				break
			elseif not returnCard then
				returnCard = lcCard
			end
		end
	end
	if returnCard then
		ks_battle:setCardStatus(returnCard, BattleData.CardStatus.pile, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20149 / LABRYNTH KNIGHT (12376) Hand Active
var_0_lab.handlers[149] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20149
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20149] = (ks_player._castedSkillCounts[20149] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20152 / LABRYNTH KNIGHT (12376) Board Active: Liên Trảm + khóa tấn công ngoại trừ 8 sao Labrynth
var_0_lab.handlers[152] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20152
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20152] = (ks_player._castedSkillCounts[20152] or 0) + 1
	ks_battle:incPositiveStatus(ks_card, { BattleData.PositiveType.extraSkill }, true, ks_cid, ks_sid, ks_mode)
	ks_battle:incPositiveValue(ks_card, BattleData.PositiveType.extraSkill, 65536 + 1080, Data.AggregateType.table, ks_cid, ks_sid, ks_mode)
	ks_player._labKnightAtkLockTurn = ks_player._round
	ks_player._labKnightAtkLockCard = ks_card
	return true
end

-- 20154 / LABRYNTH KNIGHT (12376) Grave Active
var_0_lab.handlers[154] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20154
	local ks_mode = ks_fc.mode or 32

	ks_player._castedSkillCounts[20154] = (ks_player._castedSkillCounts[20154] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)

	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_self)

	local targetCard = nil
	for _, gc in ipairs(ks_player:getBattleCards("G")) do
		if gc ~= ks_card and isMonsterCard(gc) and isLabrynthCard(gc) and gc:getStar() == 8 and ks_player:getEmptyBoardPos(gc) ~= nil and ks_player:canSpecialSummon(gc) then
			if gc._id == chosenId then
				targetCard = gc
				break
			elseif not targetCard then
				targetCard = gc
			end
		end
	end
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2b_self)
	end
	return true
end

var_0_1.register(308, var_0_lab)

return var_0_0"""

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	-- Sau đó triệu hồi đặc biệt lá bài này lên sân đối thủ
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_oppo_special)

	return true
end

return var_0_0""",
    lab_module_code,
    "var_0_lab register(308) in BattleSkill.lua"
)

# 4. PlayerUi.lua
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, math.min(2, #cands), var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif var_55_1 then""",
    """		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, math.min(2, #cands), var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20137 or arg_55_2._id == 20140 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if c ~= arg_55_1 and c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3, "lab_discard_hand")
		end
	elseif arg_55_2._id == 20143 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() <= 4 then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20144 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if c:isKeyword(308) or (c._info and c._info._keyword == 308) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20145 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() <= 4 and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20146 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if c ~= arg_55_1 and c._type == Data.CardType.trap and c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20147 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("GP")) do
			if (c:isInfoId(12375) or c._infoId == 12375) and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20148 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if c:canChangeToLeave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3, "lab_banish_grave")
		end
	elseif arg_55_2._id == 20154 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if c ~= arg_55_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() == 8 and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif var_55_1 then""",
    "Labrynth castInitiativeSkill in PlayerUi.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20091, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or (arg_85_5 == nil and arg_85_1._card:hasSkillFast(20091)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú có từ khóa \\"7 viên ngọc rồng\\" từ mộ\"""",
    """	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20091, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or (arg_85_5 == nil and arg_85_1._card:hasSkillFast(20091)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú có từ khóa \"7 viên ngọc rồng\" từ mộ"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20137, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_discard_hand") and "Chọn 1 lá bài trên tay đưa vào mộ" or "Chọn 1 lá Phép/Bẫy \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20140, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_discard_hand") and "Chọn 1 lá bài trên tay đưa vào mộ" or "Chọn 1 lá Bẫy từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20143, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái \"Labrynth\" 4 sao trở xuống từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20144, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20145, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái \"Labrynth\" 4 sao trở xuống từ mộ để triệu hồi"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20146, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá Bẫy trên tay để hi sinh"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20147, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 ARIANE THE LABRYNTH SERVANT từ mộ hoặc bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20148, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_banish_grave") and "Chọn 1 lá bài trong mộ để loại bỏ" or "Chọn 1 quái \"Labrynth\" bị loại bỏ về bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20154, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái \"Labrynth\" 8 sao trong mộ để triệu hồi" """.rstrip(),
    "Labrynth titles in showChoiceGrave in PlayerUi.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """	-- Dragon Ball skills single choice (20093, 20111, 20089, 20091)""",
    """	-- Labrynth two-stage choices (20137, 20140, 20148)
	if arg_89_1._choiceBase then
		local labIdx = math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)
		if arg_89_2._card:isSkillAtIndex(20137, labIdx) or arg_89_2._card:isSkillAtIndex(20140, labIdx) or arg_89_2._card:isSkillAtIndex(20148, labIdx) then
			if arg_89_1._choiceParam == "lab_discard_hand" or arg_89_1._choiceParam == "lab_banish_grave" then
				arg_89_2._card._labStage1Id = (var_89_0 and #var_89_0 > 0) and var_89_0[1]._id or 0
				local stage2Cands = {}
				if arg_89_2._card:isSkillAtIndex(20137, labIdx) then
					for _, c in ipairs(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("P"))) do
						if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
							table.insert(stage2Cands, c)
						end
					end
				elseif arg_89_2._card:isSkillAtIndex(20140, labIdx) then
					for _, c in ipairs(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("P"))) do
						if c._type == Data.CardType.trap then
							table.insert(stage2Cands, c)
						end
					end
				elseif arg_89_2._card:isSkillAtIndex(20148, labIdx) then
					for _, c in ipairs(arg_89_0._player:getBattleCards("L")) do
						if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
							table.insert(stage2Cands, c)
						end
					end
				end
				if #stage2Cands > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, stage2Cands, 1, arg_89_1._choiceBase, "lab_stage2")
				end
				local s1 = arg_89_2._card._labStage1Id or 0
				arg_89_2._card._labStage2Id = 0
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = s1 * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
				})
			else
				local s1 = arg_89_2._card._labStage1Id or 0
				local s2 = (var_89_0 and #var_89_0 > 0) and var_89_0[1]._id or 0
				arg_89_2._card._labStage2Id = s2
				local var_choice = s2 * BattleData.UseCardId.id_group + s1
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = var_choice * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
				})
			end
		elseif arg_89_2._card:isSkillAtIndex(20143, labIdx) or arg_89_2._card:isSkillAtIndex(20144, labIdx) or arg_89_2._card:isSkillAtIndex(20145, labIdx) or arg_89_2._card:isSkillAtIndex(20146, labIdx) or arg_89_2._card:isSkillAtIndex(20147, labIdx) or arg_89_2._card:isSkillAtIndex(20154, labIdx) then
			var_89_1 = (var_89_0 and #var_89_0 > 0) and var_89_0[1]._id or 0
			arg_89_2._card._labChosenId = var_89_1
			return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_89_2._card,
				_target = arg_89_3 ~= nil and arg_89_3._card or nil,
				_choice = var_89_1 * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
			})
		end
	end

	-- Dragon Ball skills single choice (20093, 20111, 20089, 20091)""",
    "Labrynth onChoiceGrave in PlayerUi.lua"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """			if dbCard:isSkillAtIndex(20113, sBase) then
				return var_91_0 > 0 and var_91_0 <= (arg_91_4 or 2)
			end
		end
	end""",
    """			if dbCard:isSkillAtIndex(20113, sBase) then
				return var_91_0 > 0 and var_91_0 <= (arg_91_4 or 2)
			end
			if dbCard:isSkillAtIndex(20137, sBase) or dbCard:isSkillAtIndex(20140, sBase) or dbCard:isSkillAtIndex(20143, sBase) or dbCard:isSkillAtIndex(20144, sBase) or dbCard:isSkillAtIndex(20145, sBase) or dbCard:isSkillAtIndex(20146, sBase) or dbCard:isSkillAtIndex(20147, sBase) or dbCard:isSkillAtIndex(20148, sBase) or dbCard:isSkillAtIndex(20154, sBase) then
				return var_91_0 == 1
			end
		end
	end""",
    "Labrynth checkChoiceGrave in PlayerUi.lua"
)
