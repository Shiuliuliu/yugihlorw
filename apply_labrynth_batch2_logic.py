import sys
import os

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
        if old_crlf in text:
            text = text.replace(old_crlf, new_crlf, 1)
        else:
            raise AssertionError(f"Target not found in {path} ({label})")
    else:
        text = text.replace(old, new, 1)
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[OK] Updated {path} ({label})")

# ==============================================================================
# 1. ClientView.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\ClientView.lua",
    r"[12371] = true, [12372] = true, [12373] = true, [12374] = true, [12375] = true, [12376] = true",
    r"[12371] = true, [12372] = true, [12373] = true, [12374] = true, [12375] = true, [12376] = true, [12377] = true, [12378] = true, [12379] = true, [12380] = true, [12381] = true",
    "ClientView customCards 12377..12381"
)

# ==============================================================================
# 2. BattleStep.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\BattleStep.lua",
    """	for lab_sid = 20135, 20154 do
		arg_2_0._castedSkillCounts[lab_sid] = nil
		arg_2_0._opponent._castedSkillCounts[lab_sid] = nil
	end""",
    """	for lab_sid = 20135, 20193 do
		arg_2_0._castedSkillCounts[lab_sid] = nil
		arg_2_0._opponent._castedSkillCounts[lab_sid] = nil
	end""",
    "BattleStep reset loop 20135..20193"
)

# ==============================================================================
# 3. BattleInitiativeSkillsDialog.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\BattleInitiativeSkillsDialog.lua",
    """			[20154] = "Thệ Ước Trung Thành",
		}""",
    """			[20154] = "Thệ Ước Trung Thành",
			[20155] = "Quản Gia Tiếp Đón",
			[20156] = "Chuẩn Bị Cạm Bẫy",
			[20157] = "Quản Gia Tái Xuất",
			[20158] = "Thu Thập Mộ Phần",
			[20159] = "Giáp Quỷ Bất Hoại",
			[20160] = "Tượng Đá Canh Gác",
			[20161] = "Tấm Khiên Mê Cung",
			[20162] = "Uy Lực Bẫy Ngầm",
			[20163] = "Ác Quỷ Phục Kích",
			[20164] = "Truy Tìm Bẫy Mê Cung",
			[20165] = "Hộ Mệnh Vực Thẳm",
			[20166] = "Quý Cô Giá Lâm",
			[20167] = "Quyền Uy Lâu Đài Bạc",
			[20168] = "Hộ Giáp Bạch Ngân",
			[20169] = "Bảo Hộ Cạm Bẫy",
			[20170] = "Phán Quyết Bạch Ngân",
			[20171] = "Thiết Lập Mê Cung",
			[20172] = "Hoàng Tộc Tăng Trí",
			[20173] = "Phong Ấn Ngoại Điện",
			[20174] = "Trừng Phạt Kẻ Xâm Nhập",
			[20175] = "Di Sản Bạch Ngân",
			[20176] = "Nữ Hoàng Lâm Triều",
			[20177] = "Sức Mạnh Lâu Đài Bạc",
			[20178] = "Hộ Vệ Bạch Ngân",
			[20179] = "Kết Giới Bẫy Bạc",
			[20180] = "Bắt Giữ Kẻ Xâm Nhập",
			[20181] = "Bẻ Gãy Kế Hoạch",
			[20182] = "Khôi Phục Cạm Bẫy",
			[20183] = "Tái Sinh Không Gian",
			[20184] = "Triệu Gọi Binh Đoàn",
			[20185] = "Công Chúa Xuất Chinh",
			[20186] = "Hoàng Quyền Tuyệt Đối",
			[20187] = "Bất Khả Xâm Phạm",
			[20188] = "Tam Trọng Kết Giới",
			[20189] = "Kho Báu Hoàng Gia",
			[20190] = "Điều Động Hoàng Gia",
			[20191] = "Tiêu Diệt Dị Giới",
			[20192] = "Di Ngôn Công Chúa",
			[20193] = "Hồi Sinh Công Chúa",
		}""",
    "BattleInitiativeSkillsDialog dbSkillNames batch 2"
)

# ==============================================================================
# 4. SkillUi.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\SkillUi.lua",
    r"var_1_0 == 20146 or var_1_0 == 20149 then",
    r"var_1_0 == 20146 or var_1_0 == 20149 or var_1_0 == 20155 or var_1_0 == 20163 or var_1_0 == 20166 or var_1_0 == 20176 or var_1_0 == 20185 then",
    "SkillUi replaceHandCards batch 2"
)

# ==============================================================================
# 5. BattleCard.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """	if arg_215_0._infoId == 40730 and not arg_215_0._tsAwakened then
		return false
	end""",
    """	if arg_215_0._owner and arg_215_0._owner._princessAttackLockedTurn == arg_215_0._owner._round then
		return false
	end

	if arg_215_0._infoId == 12378 or arg_215_0:hasSkillFast(20160) then
		return false
	end

	if arg_215_0._infoId == 40730 and not arg_215_0._tsAwakened then
		return false
	end""",
    "BattleCard canAttack locks"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """	local defender = arg_256_0._owner and arg_256_0._owner._opponent
	if defender then
		local hasPiglin = false""",
    """	local defender = arg_256_0._owner and arg_256_0._owner._opponent
	if defender then
		local archfiendCard = nil
		local hasOtherLabrynth = false
		for _, bc in ipairs(defender:getBoardCards()) do
			if bc:isInfoId(12378) or bc:hasSkillFast(20161) then
				archfiendCard = bc
				break
			end
		end
		if archfiendCard then
			for _, bc in ipairs(defender:getBoardCards()) do
				if bc ~= archfiendCard and (bc:isKeyword(308) or (bc._info and bc._info._keyword == 308)) then
					hasOtherLabrynth = true
					break
				end
			end
			if hasOtherLabrynth and arg_256_1 ~= archfiendCard then
				return false
			end
		end

		local hasPiglin = false""",
    "BattleCard canAttackTarget Archfiend taunt"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCard.lua",
    """	if (arg_127_1 == 12009 or arg_127_1 == 12010) and arg_127_0._status == BattleData.CardStatus.board and (arg_127_0._info and arg_127_0._info._keyword == 308) and arg_127_0:getStar() == 8 then
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
    """	if (arg_127_1 == 12009 or arg_127_1 == 12010) and arg_127_0._status == BattleData.CardStatus.board and (arg_127_0._info and arg_127_0._info._keyword == 308) and arg_127_0:getStar() == 8 then
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
	end

	-- Labrynth Archfiend (12378 / 20159): Khi lên sân, nhận được "Khiên Chấn Phá Hủy" (12006)
	if arg_127_1 == 12006 and (arg_127_0:isInfoId(12378) or arg_127_0._infoId == 12378 or arg_127_0:hasSkillFast(20159)) and arg_127_0._status == BattleData.CardStatus.board then
		return true
	end

	-- Lady Labrynth (12379 / 20168), Lovely Labrynth (12380 / 20178): Tường Chấn Quái (12008)
	if arg_127_1 == 12008 and (arg_127_0:isInfoId(12379) or arg_127_0._infoId == 12379 or arg_127_0:isInfoId(12380) or arg_127_0._infoId == 12380) and arg_127_0._status == BattleData.CardStatus.board then
		return true
	end

	-- Princess Labrynth (12381 / 20188): Tường Chấn Quái (12008), Tường Chấn Phép (12009), Tường Chấn Bẫy (12010) (Ngoại trừ hiệu ứng Hồi Sinh Công Chúa: chỉ nhận 12008)
	if (arg_127_0:isInfoId(12381) or arg_127_0._infoId == 12381) and arg_127_0._status == BattleData.CardStatus.board then
		if arg_127_1 == 12008 then
			return true
		elseif (arg_127_1 == 12009 or arg_127_1 == 12010) and not arg_127_0._revivedBy20193 then
			return true
		end
	end""",
    "BattleCard hasSkillFast batch 2 shields"
)

# ==============================================================================
# 6. PlayerBattle.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\PlayerBattle.lua",
    """			local var_trap_cover = p_owner:getBattleCardsByInfoId("C", 30592)""",
    """			-- LABRYNTH ARCHFIEND (12378 / 20165): Khi bài này nằm trong mộ, phe ta bị mất LP từ chiến đấu trực tiếp sẽ có thể dùng. Loại bỏ bản thân bài này, bỏ qua lần sát thương đó.
			if (arg_9_5 == Data.SkillMode.before_attack or arg_9_4 == Data.ATTACKING_SKILL_ID or arg_9_5 == Data.SkillMode.attack) then
				local graveArchfiends = p_owner:getBattleCardsByInfoId("G", 12378)
				if #graveArchfiends > 0 then
					local afCard = graveArchfiends[1]
					if afCard:canChangeToLeave() then
						arg_9_0:setCardStatus(afCard, BattleData.CardStatus.leave, afCard._id, 20165, Data.SkillMode.grave, BattleData.CardStatusVal.g2l_normal)
						return
					end
				end
			end

			local var_trap_cover = p_owner:getBattleCardsByInfoId("C", 30592)""",
    "PlayerBattle addDamage Archfiend negate"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerBattle.lua",
    """		-- Cua dia nguc (30597 / 14813): Halo +500 ATK & Tin Nguong (2002) handled in BattleSkill:castTrapSkill2""",
    """		-- LABRYNTH ARCHFIEND (12378 / 20162): Tăng tấn công và phòng thủ bằng tổng số lá Bẫy trong mộ/mộ bài loại bỏ phe ta × 400.
		if (arg_38_1._infoId == 12378 or arg_38_1:hasSkillFast(20162)) and arg_38_1._status == BattleData.CardStatus.board then
			local owner = arg_38_1._owner or arg_38_0
			local trapCount = 0
			if owner then
				for _, c in ipairs(owner:getBattleCards("G")) do
					if c:isTrap() or c._type == Data.CardType.trap then trapCount = trapCount + 1 end
				end
				for _, c in ipairs(owner:getBattleCards("L")) do
					if c:isTrap() or c._type == Data.CardType.trap then trapCount = trapCount + 1 end
				end
			end
			local bonus = trapCount * 400
			arg_38_1._atk = arg_38_1._atk + bonus
			arg_38_1._hp = arg_38_1._hp + bonus
			if arg_38_1._maxHp then
				arg_38_1._maxHp = arg_38_1._maxHp + bonus
			end
		end

		-- Cua dia nguc (30597 / 14813): Halo +500 ATK & Tin Nguong (2002) handled in BattleSkill:castTrapSkill2""",
    "PlayerBattle accountTarget Archfiend boost"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerBattle.lua",
    """	-- Bulma (12364): Khi vào sân (triệu hồi/hồi sinh), tự động lấy 1 lá Rada dò ngọc (21167) từ bộ bài lên tay""",
    """	-- Labrynth Trap Protection (20169, 20179, 20187): Khi Lady (12379), Lovely (12380), Princess (12381) trên sân, bài Bẫy phe ta điều khiển bị ảnh hưởng bởi bài đối thủ sẽ bị bỏ qua.
	if (arg_7_1:isTrap() or arg_7_1._type == Data.CardType.trap) and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local tOwner = arg_7_1._owner
		if tOwner and (tOwner:hasBattleCardsByInfoId("B", 12379) or tOwner:hasBattleCardsByInfoId("B", 12380) or tOwner:hasBattleCardsByInfoId("B", 12381)) then
			local casterCard = arg_7_3 and arg_7_0:getCardById(arg_7_3)
			if casterCard and casterCard._owner == tOwner._opponent then
				return
			end
		end
	end

	-- Bulma (12364): Khi vào sân (triệu hồi/hồi sinh), tự động lấy 1 lá Rada dò ngọc (21167) từ bộ bài lên tay""",
    "PlayerBattle setCardStatus trap protection"
)

# ==============================================================================
# 7. BattleCardStatus.lua
# ==============================================================================
replace_once(
    r"D:\yugitauapk\web\src\BattleCardStatus.lua",
    """	if arg_6_1:isStatusValSacrifice() and arg_6_1:hasSkillFast(3206) then""",
    """	-- PRINCESS LABRYNTH (12381 / 20192): Khi bài này rời sân trong lượt của đối thủ; trong lượt này, quái vật đối thủ không thể tấn công và đối thủ không thể sử dụng bài trên tay.
	if (arg_6_1:isInfoId(12381) or arg_6_1._infoId == 12381 or arg_6_1:hasSkillFast(20192)) then
		local owner = arg_6_1._owner or (arg_6_1.getOriginOwner and arg_6_1:getOriginOwner())
		local oppo = owner and owner._opponent
		if oppo and oppo._macroStatus == BattleData.Status.use then
			oppo._princessAttackLockedTurn = oppo._round
			oppo._princessHandLockedTurn = oppo._round
		elseif oppo and owner and owner._battle and owner._battle:getActivePlayer() == oppo then
			oppo._princessAttackLockedTurn = oppo._round
			oppo._princessHandLockedTurn = oppo._round
		end
	end

	if arg_6_1:isStatusValSacrifice() and arg_6_1:hasSkillFast(3206) then""",
    "BattleCardStatus removeCardFromBoard Princess lock"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCardStatus.lua",
    """			if (arg_15_0._battleType == Data.BattleType.PVP_room and arg_15_0._round == 1) or (arg_15_0._isAttacker and arg_15_0._round == (arg_15_0._battleType == Data.BattleType.PVP_room and 2 or 1) and arg_15_0._battleType ~= Data.BattleType.unittest and arg_15_0._battleType ~= Data.BattleType.teach) or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_compose_ex or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_decompose or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_sync_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_xyz_attack_frozen then""",
    """			-- Labrynth Special Summon ATK Boost (20167, 20177, 20186): ATK += ("Labrynth" Traps in GL) * 300
			if (arg_15_1._infoId == 12379 or arg_15_1._infoId == 12380 or arg_15_1._infoId == 12381) and (arg_15_1:isStatusValSpecialSummon() or arg_15_1._statusVal == BattleData.CardStatusVal.h2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.p2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.l2b_normal) then
				local trapCount = 0
				for _, c in ipairs(arg_15_0:getBattleCards("G")) do
					if (c:isTrap() or c._type == Data.CardType.trap) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
						trapCount = trapCount + 1
					end
				end
				for _, c in ipairs(arg_15_0:getBattleCards("L")) do
					if (c:isTrap() or c._type == Data.CardType.trap) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
						trapCount = trapCount + 1
					end
				end
				local atkBonus = trapCount * 300
				if atkBonus > 0 then
					arg_15_1._atk = arg_15_1._atk + atkBonus
					if arg_15_1._maxAtk then
						arg_15_1._maxAtk = arg_15_1._maxAtk + atkBonus
					end
				end
			end

			-- LADY LABRYNTH (12379 / 20172): Draw 1 when 8★ Labrynth monster (except Lady) summoned
			if (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) and arg_15_1:getStar() == 8 and arg_15_1._infoId ~= 12379 then
				if (arg_15_0._castedSkillCounts[20172] or 0) == 0 and #arg_15_0:getBattleCardsByInfoId("B", 12379) > 0 then
					arg_15_0._castedSkillCounts[20172] = 1
					arg_15_0:drawCards(1)
				end
			end

			if (arg_15_0._battleType == Data.BattleType.PVP_room and arg_15_0._round == 1) or (arg_15_0._isAttacker and arg_15_0._round == (arg_15_0._battleType == Data.BattleType.PVP_room and 2 or 1) and arg_15_0._battleType ~= Data.BattleType.unittest and arg_15_0._battleType ~= Data.BattleType.teach) or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_compose_ex or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_decompose or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_sync_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_xyz_attack_frozen then""",
    "BattleCardStatus addCardToBoard ATK boost & Lady draw"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleCardStatus.lua",
    """			if arg_15_1._infoId == 12324 or arg_15_1:hasSkillFast(14700) then""",
    """				-- Opponent Special Summon triggers (20174, 20180, 20191)
				if (arg_15_1:isStatusValSpecialSummon() or arg_15_1._destStatusVal == BattleData.CardStatusVal.h2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.p2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.g2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.l2b_normal) then
					local labOppo = arg_15_0._opponent
					if labOppo and (labOppo._castedSkillCounts[20174] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12379) > 0 then
						labOppo._castedSkillCounts[20174] = 1
						arg_15_0:setCardStatus(arg_15_1, BattleData.CardStatus.grave, 12379, 20174, Data.SkillMode.once, BattleData.CardStatusVal.b2g_destroy)
					elseif labOppo and (labOppo._castedSkillCounts[20180] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12380) > 0 then
						labOppo._castedSkillCounts[20180] = 1
						arg_15_0:changeCardStatus(arg_15_1, arg_15_1._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.x2g_oppo, 12380, 20180, Data.SkillMode.once)
					end

					if labOppo and (labOppo._castedSkillCounts[20191] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12381) > 0 then
						if arg_15_1:isMonsterRare() or arg_15_1._status == BattleData.CardStatus.rare or arg_15_1._destStatusVal == BattleData.CardStatusVal.z2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.z2b_normal or arg_15_1:isStatusValLinkSummon() then
							labOppo._castedSkillCounts[20191] = 1
							arg_15_0:setCardStatus(arg_15_1, BattleData.CardStatus.grave, 12381, 20191, Data.SkillMode.once, BattleData.CardStatusVal.b2g_destroy)
						end
					end
				end

			if arg_15_1._infoId == 12324 or arg_15_1:hasSkillFast(14700) then""",
    "BattleCardStatus addCardToBoard oppo summon triggers"
)

# ==============================================================================
# 8. BattleSkill.lua
# ==============================================================================
# 8a. Hand lock checks in canUseMonster, canUseMagic, canUseTrap, canUseMonsterSpecial
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """function var_0_0.canUseMonster(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._battleType == Data.BattleType.PVP_room and arg_15_0._round == 1 and not arg_15_1:isInfoId(20236) then""",
    """function var_0_0.canUseMonster(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._princessHandLockedTurn == arg_15_0._round and arg_15_1._status == BattleData.CardStatus.hand then
		return false
	end
	if arg_15_0._battleType == Data.BattleType.PVP_room and arg_15_0._round == 1 and not arg_15_1:isInfoId(20236) then""",
    "BattleSkill canUseMonster princess hand lock"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """function var_0_0.canUseMagic(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._opponent and not arg_22_0._opponent._isSkillDisabled then""",
    """function var_0_0.canUseMagic(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._princessHandLockedTurn == arg_22_0._round and arg_22_1._status == BattleData.CardStatus.hand then
		return false
	end
	if arg_22_0._opponent and not arg_22_0._opponent._isSkillDisabled then""",
    "BattleSkill canUseMagic princess hand lock"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """function var_0_0.canUseTrap(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._battleType == Data.BattleType.PVP_room and arg_27_0._round == 1 and not arg_27_1:isInfoId(20236) then""",
    """function var_0_0.canUseTrap(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._princessHandLockedTurn == arg_27_0._round and arg_27_1._status == BattleData.CardStatus.hand then
		return false
	end
	if arg_27_0._battleType == Data.BattleType.PVP_room and arg_27_0._round == 1 and not arg_27_1:isInfoId(20236) then""",
    "BattleSkill canUseTrap princess hand lock"
)

replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """function var_0_0.canUseMonsterSpecial(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._battleType == Data.BattleType.PVP_room and arg_19_0._round == 1 then""",
    """function var_0_0.canUseMonsterSpecial(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._princessHandLockedTurn == arg_19_0._round and arg_19_1._status == BattleData.CardStatus.hand then
		return false
	end
	if arg_19_0._battleType == Data.BattleType.PVP_room and arg_19_0._round == 1 then""",
    "BattleSkill canUseMonsterSpecial princess hand lock"
)

# 8b. canUseMonsterSpecial hand active skills
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	if arg_19_1:isInfoId(12376) or arg_19_1:hasSkillFast(20149) then
		local var_sk_lab = arg_19_1:getSkillById(20149) or (arg_19_1._skills and arg_19_1._skills[1])
		if var_sk_lab and var_0_0.KeywordSkill.canUse(arg_19_0, arg_19_1, var_sk_lab) then
			return true, nil, 2, var_sk_lab
		end
	end""",
    """	for _, sk_lab_id in ipairs({ 20149, 20155, 20163, 20166, 20176, 20185 }) do
		if arg_19_1:hasSkillFast(sk_lab_id) then
			local var_sk_lab = arg_19_1:getSkillById(sk_lab_id)
			if var_sk_lab and var_0_0.KeywordSkill.canUse(arg_19_0, arg_19_1, var_sk_lab) then
				return true, nil, 2, var_sk_lab
			end
		end
	end""",
    "BattleSkill canUseMonsterSpecial batch 2 skills"
)

# 8c. Trap activation tracking, Lovely 20181 hand banish, Arias 20157 revive in castTrapSkill
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	local var_9_10 = arg_9_1._monsterTarget""",
    """	if var_9_1 and (var_9_1:isTrap() or var_9_1._type == Data.CardType.trap) and arg_9_3 ~= Data.SkillMode.halo then
		local trapOwner = var_9_1._owner
		if trapOwner then
			trapOwner._trapActivatedRound = trapOwner._round
			if (var_9_1:isKeyword(308) or (var_9_1._info and var_9_1._info._keyword == 308)) or (var_9_1._info and var_9_1._info._type == Data.MagicTrapType.normal) then
				trapOwner._labOrNormalTrapUsedRound = trapOwner._round
			end
			-- Lovely 20181: Banish random 1 card from oppo hand
			for _, pCheck in ipairs({ trapOwner, trapOwner._opponent }) do
				if pCheck and (pCheck._castedSkillCounts[20181] or 0) == 0 and #pCheck:getBattleCardsByInfoId("B", 12380) > 0 and pCheck._opponent and #pCheck._opponent:getBattleCards("H") > 0 then
					pCheck._castedSkillCounts[20181] = 1
					local randH = pCheck:randomOne(pCheck._opponent:getBattleCards("H"))
					if randH then
						arg_9_0:setCardStatus(randH, BattleData.CardStatus.leave, 12380, 20181, Data.SkillMode.once, BattleData.CardStatusVal.h2l_normal)
					end
				end
			end
			-- Arias 20157: Special summon self from grave
			for _, pCheck in ipairs({ trapOwner, trapOwner._opponent }) do
				if pCheck and (pCheck._castedSkillCounts[20157] or 0) == 0 and not pCheck._isSummonDisabled and not pCheck._isSpecialSummonDisabled then
					local graveArias = pCheck:getBattleCardsByInfoId("G", 12377)
					if #graveArias > 0 and pCheck:getEmptyBoardPos(graveArias[1]) ~= nil and pCheck:canSpecialSummon(graveArias[1]) then
						pCheck._castedSkillCounts[20157] = 1
						arg_9_0:setCardStatus(graveArias[1], BattleData.CardStatus.board, 12377, 20157, Data.SkillMode.once, BattleData.CardStatusVal.g2b_normal)
					end
				end
			end
		end
	end

	local var_9_10 = arg_9_1._monsterTarget""",
    "BattleSkill castTrapSkill trap tracking & triggers"
)

# 8d. decodeLabMultiChoice helper in var_0_lab
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """local function decodeLabTwoStageChoice(ks_fc)
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
end""",
    """local function decodeLabTwoStageChoice(ks_fc)
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

local function decodeLabMultiChoice(ks_fc)
	local card = ks_fc.card
	if card and card._labChosenIds and #card._labChosenIds > 0 then
		local ids = card._labChosenIds
		card._labChosenIds = nil
		return ids
	end
	local choice = (card and card._choice) or ks_fc.choice or 0
	local val = math.floor(choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2
	local id1 = val % BattleData.UseCardId.id_group
	local id2 = math.floor(val / BattleData.UseCardId.id_group) % BattleData.UseCardId.id_group
	local res = {}
	if id1 > 0 then table.insert(res, id1) end
	if id2 > 0 then table.insert(res, id2) end
	return res
end""",
    "BattleSkill decodeLabMultiChoice"
)

# 8e. canUse branches in var_0_lab
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """	elseif sid == 20154 then
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
	end""",
    """	elseif sid == 20154 then
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

	elseif sid == 20155 then
		-- ARIAS (12377): Kỹ năng tay chủ động: Hi sinh bản thân lá này; chọn và Triệu Hồi Đặc Biệt 1 lá quái vật có từ khóa “Labrynth” từ tay/bộ bài
		if arg_cu_1._status ~= BattleData.CardStatus.hand or not arg_cu_1:canChangeToGrave() then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then
			return false
		end
		for _, hc in ipairs(arg_cu_0:getBattleCards("H")) do
			if hc ~= arg_cu_1 and isMonsterCard(hc) and isLabrynthCard(hc) and arg_cu_0:getEmptyBoardPos(hc) ~= nil and arg_cu_0:canSpecialSummon(hc) then
				return true
			end
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToBoardCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and isLabrynthCard(pc) and arg_cu_0:getEmptyBoardPos(pc) ~= nil and arg_cu_0:canSpecialSummon(pc) then
				return true
			end
		end
		return false

	elseif sid == 20156 then
		-- ARIAS (12377): Chủ động: Hi sinh bản thân lá này; lấy 1 lá bài Phép/Bẫy có từ khóa “Labrynth” từ bộ bài phe ta vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board or not arg_cu_1:canChangeToGrave() then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isLabrynthCard(pc) and (pc:isMagic() or pc:isTrap() or pc._type == Data.CardType.magic or pc._type == Data.CardType.trap) then
				return true
			end
		end
		return false

	elseif sid == 20158 then
		-- ARIAS (12377): Kỹ năng mộ chủ động: Hi sinh bản thân; Chọn 1 lá trong mộ đối thủ đưa về mộ phe ta
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToLeave() then
			return false
		end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBattleCards("G") > 0

	elseif sid == 20163 then
		-- ARCHFIEND (12378): Kỹ năng tay chủ động: Khi ở trên tay, khi phe ta kích hoạt bài Bẫy; Triệu hồi đặc biệt bản thân từ trên tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		return arg_cu_0._trapActivatedRound == arg_cu_0._round

	elseif sid == 20164 then
		-- ARCHFIEND (12378): Chủ động: Chọn và lấy 1 lá bài Bẫy từ khóa “Labrynth” từ bộ bài phe ta vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isLabrynthCard(pc) and (pc:isTrap() or pc._type == Data.CardType.trap) then
				return true
			end
		end
		return false

	elseif sid == 20166 then
		-- LADY (12379): Kỹ năng tay chủ động: Nếu 1 lá bài "Labrynth" hoặc Bẫy Thường kích hoạt trong lượt này; Triệu hồi Đặc biệt từ trên tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		return arg_cu_0._labOrNormalTrapUsedRound == arg_cu_0._round

	elseif sid == 20170 then
		-- LADY (12379): Chủ động: Chọn tối đa 1 lá bài trên sân đối thủ và đưa vào mộ
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBoardCards() > 0

	elseif sid == 20171 then
		-- LADY (12379): Chủ động: Chọn và lấy 1 lá Bẫy từ bộ bài phe ta vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if pc:isTrap() or pc._type == Data.CardType.trap then
				return true
			end
		end
		return false

	elseif sid == 20173 then
		-- LADY (12379): Kỹ năng kích hoạt: Khi phe ta kích hoạt bài Bẫy; Chọn tối đa 2 quái vật từ bộ bài phụ đối thủ tạm thời trục xuất
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		local oppo = arg_cu_0._opponent
		if not oppo or #oppo:getBattleCards("Z") == 0 then
			return false
		end
		return arg_cu_0._trapActivatedRound == arg_cu_0._round

	elseif sid == 20175 then
		-- LADY (12379): Kỹ năng mộ loại bỏ chủ động: Chọn và lấy 1 lá Bẫy có từ khóa "Labrynth" từ mộ/loại bỏ vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.leave then
			return false
		end
		for _, gc in ipairs(arg_cu_0:getBattleCards("G")) do
			if isLabrynthCard(gc) and (gc:isTrap() or gc._type == Data.CardType.trap) and gc:canChangeToHand() then
				return true
			end
		end
		for _, lc in ipairs(arg_cu_0:getBattleCards("L")) do
			if isLabrynthCard(lc) and (lc:isTrap() or lc._type == Data.CardType.trap) and lc:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20176 then
		-- LOVELY (12380): Kỹ năng tay chủ động: Loại bỏ 1 quái vật trên sân đối thủ và 1 bẫy trên tay; Triệu hồi Đặc biệt bản thân
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		local oppo = arg_cu_0._opponent
		if not oppo or #oppo:getBoardCards() == 0 then
			return false
		end
		local hasTrapInHand = false
		for _, hc in ipairs(arg_cu_0:getBattleCards("H")) do
			if hc ~= arg_cu_1 and (hc:isTrap() or hc._type == Data.CardType.trap) and hc:canChangeToLeave() then
				hasTrapInHand = true
				break
			end
		end
		return hasTrapInHand

	elseif sid == 20182 then
		-- LOVELY (12380): Chủ động: Chọn và lấy tối đa 2 lá bài Bẫy từ mộ phe ta vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, gc in ipairs(arg_cu_0:getBattleCards("G")) do
			if (gc:isTrap() or gc._type == Data.CardType.trap) and gc:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20183 then
		-- LOVELY (12380): Chủ động: Chọn và lấy 1 lá bài Phép/Bẫy từ vùng loại bỏ phe ta vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, lc in ipairs(arg_cu_0:getBattleCards("L")) do
			if (lc:isMagic() or lc:isTrap() or lc._type == Data.CardType.magic or lc._type == Data.CardType.trap) and lc:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20184 then
		-- LOVELY (12380): Kỹ năng mộ loại bỏ: Chọn và lấy 1 quái vật "Labrynth" 4 sao trở xuống từ bộ bài vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.leave then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and isLabrynthCard(pc) and pc:getStar() <= 4 then
				return true
			end
		end
		return false

	elseif sid == 20185 then
		-- PRINCESS (12381): Kỹ năng tay chủ động: Triệu hồi đặc biệt bản thân lá bài này từ trên tay
		if arg_cu_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		return true

	elseif sid == 20189 then
		-- PRINCESS (12381): Chủ động: Chọn và lấy 2 lá bài Bẫy từ bộ bài/mộ/loại bỏ vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		local trapCount = 0
		for _, c in ipairs(arg_cu_0:getBattleCards("P")) do
			if c:isTrap() or c._type == Data.CardType.trap then trapCount = trapCount + 1 end
		end
		for _, c in ipairs(arg_cu_0:getBattleCards("G")) do
			if (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then trapCount = trapCount + 1 end
		end
		for _, c in ipairs(arg_cu_0:getBattleCards("L")) do
			if (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then trapCount = trapCount + 1 end
		end
		return trapCount >= 2

	elseif sid == 20190 then
		-- PRINCESS (12381): Chủ động: Chọn và lấy 1 quái vật "Labrynth" từ bộ bài vào tay
		if arg_cu_1._status ~= BattleData.CardStatus.board then
			return false
		end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and isLabrynthCard(pc) then
				return true
			end
		end
		return false

	elseif sid == 20193 then
		-- PRINCESS (12381): Kỹ năng mộ chủ động: Loại bỏ 2 lá bài trong mộ đối thủ; Triệu hồi đặc biệt bản thân từ mộ
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToBoard() then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBattleCards("G") >= 2
	end""",
    "BattleSkill var_0_lab canUse batch 2"
)

# 8f. handlers in var_0_lab
replace_once(
    r"D:\yugitauapk\web\src\BattleSkill.lua",
    """var_0_lab.handlers[154] = function(ks_fc)
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
end""",
    """var_0_lab.handlers[154] = function(ks_fc)
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

-- 20155 / ARIAS (12377): Special summon 1 Labrynth monster from hand/deck
var_0_lab.handlers[155] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20155
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20155] = (ks_player._castedSkillCounts[20155] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2g_self)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		if targetCard._status == BattleData.CardStatus.hand then
			ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
		else
			ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2b_normal)
		end
	end
	return true
end

-- 20156 / ARIAS (12377): Add 1 Labrynth Spell/Trap from deck to hand
var_0_lab.handlers[156] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20156
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20156] = (ks_player._castedSkillCounts[20156] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.b2g_self)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20158 / ARIAS (12377): Tribute self from grave; take 1 card in oppo grave into player grave
var_0_lab.handlers[158] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20158
	local ks_mode = ks_fc.mode or 32

	ks_player._castedSkillCounts[20158] = (ks_player._castedSkillCounts[20158] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_normal)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:changeCardStatus(targetCard, targetCard._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.x2g_oppo, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20163 / ARCHFIEND (12378): Special summon self from hand
var_0_lab.handlers[163] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20163
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20163] = (ks_player._castedSkillCounts[20163] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20164 / ARCHFIEND (12378): Add 1 Labrynth Trap from deck to hand
var_0_lab.handlers[164] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20164
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20164] = (ks_player._castedSkillCounts[20164] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20166 / LADY (12379): Special summon self from hand
var_0_lab.handlers[166] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20166
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20166] = (ks_player._castedSkillCounts[20166] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20170 / LADY (12379): Send up to 1 card on oppo board to grave
var_0_lab.handlers[170] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20170
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20170] = (ks_player._castedSkillCounts[20170] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.b2g_destroy)
	end
	return true
end

-- 20171 / LADY (12379): Add 1 Trap from deck to hand
var_0_lab.handlers[171] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20171
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20171] = (ks_player._castedSkillCounts[20171] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20173 / LADY (12379): Banish up to 2 cards from oppo Extra Deck
var_0_lab.handlers[173] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20173
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20173] = (ks_player._castedSkillCounts[20173] or 0) + 1
	local chosenIds = decodeLabMultiChoice(ks_fc)
	for _, id in ipairs(chosenIds) do
		local tc = ks_battle:getCardById(id)
		if tc and tc:canChangeToLeave() then
			ks_battle:setCardStatus(tc, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.x2l_temp_oppo)
		end
	end
	return true
end

-- 20175 / LADY (12379): Add 1 Labrynth Trap from Grave or Banish to hand
var_0_lab.handlers[175] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20175
	local ks_mode = ks_fc.mode or 35

	ks_player._castedSkillCounts[20175] = (ks_player._castedSkillCounts[20175] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		if targetCard._status == BattleData.CardStatus.grave then
			ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2h_draw)
		else
			ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.l2h_normal)
		end
	end
	return true
end

-- 20176 / LOVELY (12380): Banish 1 monster on oppo board + 1 trap in hand -> special summon
var_0_lab.handlers[176] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20176
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20176] = (ks_player._castedSkillCounts[20176] or 0) + 1
	local oppoMonsterId, handTrapId = decodeLabTwoStageChoice(ks_fc)
	local oppoM = ks_battle:getCardById(oppoMonsterId)
	local handT = ks_battle:getCardById(handTrapId)
	if oppoM then
		ks_battle:setCardStatus(oppoM, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.b2l_normal)
	end
	if handT then
		ks_battle:setCardStatus(handT, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2l_normal)
	end
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20182 / LOVELY (12380): Add up to 2 Traps from Grave to hand
var_0_lab.handlers[182] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20182
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20182] = (ks_player._castedSkillCounts[20182] or 0) + 1
	local chosenIds = decodeLabMultiChoice(ks_fc)
	for _, id in ipairs(chosenIds) do
		local tc = ks_battle:getCardById(id)
		if tc and tc._status == BattleData.CardStatus.grave then
			ks_battle:setCardStatus(tc, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2h_draw)
		end
	end
	return true
end

-- 20183 / LOVELY (12380): Add 1 Spell/Trap from Banish to hand
var_0_lab.handlers[183] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20183
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20183] = (ks_player._castedSkillCounts[20183] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.l2h_normal)
	end
	return true
end

-- 20184 / LOVELY (12380): Add 1 Labrynth monster <= 4★ from deck to hand
var_0_lab.handlers[184] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20184
	local ks_mode = ks_fc.mode or 35

	ks_player._castedSkillCounts[20184] = (ks_player._castedSkillCounts[20184] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20185 / PRINCESS (12381): Special summon self from hand
var_0_lab.handlers[185] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20185
	local ks_mode = ks_fc.mode or 34

	ks_player._castedSkillCounts[20185] = (ks_player._castedSkillCounts[20185] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	return true
end

-- 20189 / PRINCESS (12381): Add 2 Traps from Deck/Grave/Banish to hand
var_0_lab.handlers[189] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20189
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20189] = (ks_player._castedSkillCounts[20189] or 0) + 1
	local chosenIds = decodeLabMultiChoice(ks_fc)
	for _, id in ipairs(chosenIds) do
		local tc = ks_battle:getCardById(id)
		if tc then
			if tc._status == BattleData.CardStatus.pile then
				ks_battle:setCardStatus(tc, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
			elseif tc._status == BattleData.CardStatus.grave then
				ks_battle:setCardStatus(tc, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2h_draw)
			elseif tc._status == BattleData.CardStatus.leave then
				ks_battle:setCardStatus(tc, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.l2h_normal)
			end
		end
	end
	return true
end

-- 20190 / PRINCESS (12381): Add 1 Labrynth monster from deck to hand
var_0_lab.handlers[190] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20190
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20190] = (ks_player._castedSkillCounts[20190] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20193 / PRINCESS (12381): Banish 2 cards in oppo grave -> special summon self from grave
var_0_lab.handlers[193] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20193
	local ks_mode = ks_fc.mode or 32

	ks_player._castedSkillCounts[20193] = (ks_player._castedSkillCounts[20193] or 0) + 1
	local chosenIds = decodeLabMultiChoice(ks_fc)
	for _, id in ipairs(chosenIds) do
		local tc = ks_battle:getCardById(id)
		if tc and tc._status == BattleData.CardStatus.grave then
			ks_battle:setCardStatus(tc, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_normal)
		end
	end
	ks_card._revivedBy20193 = true
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2b_normal)
	return true
end""",
    "BattleSkill var_0_lab handlers batch 2"
)

# ==============================================================================
# 9. PlayerUi.lua
# ==============================================================================
# 9a. Fix syntax error in showChoiceGrave (lines 2648..2677) and add Batch 2 titles
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20091, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or (arg_85_5 == nil and arg_85_1._card:hasSkillFast(20091)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú có từ khóa "7 viên ngọc rồng" từ mộ"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20137, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_discard_hand") and "Chọn 1 lá bài trên tay đưa vào mộ" or "Chọn 1 lá Phép/Bẫy "Labrynth" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20140, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_discard_hand") and "Chọn 1 lá bài trên tay đưa vào mộ" or "Chọn 1 lá Bẫy từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20143, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái "Labrynth" 4 sao trở xuống từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20144, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài "Labrynth" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20145, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái "Labrynth" 4 sao trở xuống từ mộ để triệu hồi"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20146, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá Bẫy trên tay để hi sinh"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20147, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 ARIANE THE LABRYNTH SERVANT từ mộ hoặc bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20148, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_banish_grave") and "Chọn 1 lá bài trong mộ để loại bỏ" or "Chọn 1 quái "Labrynth" bị loại bỏ về bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20154, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái "Labrynth" 8 sao trong mộ để triệu hồi"
	elseif arg_85_1._card:hasSkillFast(14756) or (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14756, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) then""",
    r'''	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20091, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or (arg_85_5 == nil and arg_85_1._card:hasSkillFast(20091)) then
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
		var_85_1 = "Chọn 1 quái \"Labrynth\" 8 sao trong mộ để triệu hồi"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20155, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" từ tay hoặc bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20156, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Phép/Bẫy \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20158, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài trong mộ đối thủ đưa về mộ phe ta"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20164, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Bẫy \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20170, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn tối đa 1 lá bài trên sân đối thủ để đưa vào mộ"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20171, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Bẫy từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20173, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn tối đa 2 quái vật từ bộ bài phụ đối thủ để trục xuất"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20175, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Bẫy \"Labrynth\" từ mộ hoặc vùng loại bỏ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20176, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = (arg_85_6 == "lab_oppo_monster") and "Chọn 1 quái thú trên sân đối thủ để loại bỏ" or "Chọn 1 lá bài Bẫy trên tay để loại bỏ"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20182, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn tối đa 2 lá bài Bẫy từ mộ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20183, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Phép/Bẫy từ vùng loại bỏ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20184, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" 4 sao trở xuống từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20189, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 2 lá bài Bẫy từ bộ bài, mộ hoặc vùng loại bỏ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20190, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20193, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 2 lá bài trong mộ đối thủ để loại bỏ"
	elseif arg_85_1._card:hasSkillFast(14756) or (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14756, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) then''',
    "PlayerUi fix quotes & add batch 2 titles"
)

# 9b. Add candidate gathering in castInitiativeSkill
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """	elseif arg_55_2._id == 20154 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if c ~= arg_55_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() == 8 and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end""",
    """	elseif arg_55_2._id == 20154 then
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if c ~= arg_55_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() == 8 and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20155 then
		-- ARIAS (12377): Special summon 1 "Labrynth" monster from hand or deck
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if c ~= arg_55_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:canChangeToBoard() and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		for _, c in ipairs(arg_55_0._player:filterCanChangeToBoardCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20156 then
		-- ARIAS (12377): Add 1 Labrynth Spell/Trap from deck to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20158 then
		-- ARIAS (12377): Choose 1 card from opponent grave to player grave
		local cands = {}
		for _, c in ipairs(arg_55_0._player._opponent:getBattleCards("G")) do
			table.insert(cands, c)
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20164 then
		-- ARCHFIEND (12378): Add 1 Labrynth Trap from deck to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isTrap() or c._type == Data.CardType.trap) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20170 then
		-- LADY (12379): Send up to 1 card on opponent board to grave
		local cands = {}
		for _, c in ipairs(arg_55_0._player._opponent:getBattleCards("B")) do
			if c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20171 then
		-- LADY (12379): Add 1 Trap from deck to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if c:isTrap() or c._type == Data.CardType.trap then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20173 then
		-- LADY (12379): Banish up to 2 monsters from opponent Extra Deck
		local cands = {}
		for _, c in ipairs(arg_55_0._player._opponent:getBattleCards("Z")) do
			if c:canChangeToLeave() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, math.min(2, #cands), var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20175 then
		-- LADY (12379): Add 1 Labrynth Trap from Grave or Banish to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		for _, c in ipairs(arg_55_0._player:getBattleCards("L")) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20176 then
		-- LOVELY (12380): Banish 1 monster on oppo board + 1 trap in hand -> special summon
		local oppoCands = {}
		for _, c in ipairs(arg_55_0._player._opponent:getBattleCards("B")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and c:canChangeToLeave() then
				table.insert(oppoCands, c)
			end
		end
		local handTraps = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if c ~= arg_55_1 and (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToLeave() then
				table.insert(handTraps, c)
			end
		end
		if #oppoCands > 0 and #handTraps > 0 and arg_55_0._player:getEmptyBoardPos(arg_55_1) ~= nil and arg_55_0._player:canSpecialSummon(arg_55_1) then
			return arg_55_0:showChoiceGrave(var_55_0, nil, oppoCands, 1, var_55_4 * BattleData.ChoiceId.stage_3, "lab_oppo_monster")
		end
	elseif arg_55_2._id == 20182 then
		-- LOVELY (12380): Add up to 2 Traps from Grave to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, math.min(2, #cands), var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20183 then
		-- LOVELY (12380): Add 1 Spell/Trap from Banish to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("L")) do
			if (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20184 then
		-- LOVELY (12380): Add 1 Labrynth monster <= 4★ from deck to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() <= 4 then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20189 then
		-- PRINCESS (12381): Add 2 Traps from Deck/Grave/Banish to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if c:isTrap() or c._type == Data.CardType.trap then table.insert(cands, c) end
		end
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then table.insert(cands, c) end
		end
		for _, c in ipairs(arg_55_0._player:getBattleCards("L")) do
			if (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToHand() then table.insert(cands, c) end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, math.min(2, #cands), var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20190 then
		-- PRINCESS (12381): Add 1 Labrynth monster from deck to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3)
		end
	elseif arg_55_2._id == 20193 then
		-- PRINCESS (12381): Banish 2 cards in oppo grave -> special summon self
		local cands = {}
		for _, c in ipairs(arg_55_0._player._opponent:getBattleCards("G")) do
			if c:canChangeToLeave() then
				table.insert(cands, c)
			end
		end
		if #cands >= 2 and arg_55_0._player:getEmptyBoardPos(arg_55_1) ~= nil and arg_55_0._player:canSpecialSummon(arg_55_1) then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 2, var_55_4 * BattleData.ChoiceId.stage_3)
		end""",
    "PlayerUi castInitiativeSkill batch 2 candidates"
)

# 9c. onChoiceGrave multi-stage and multi-choice
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    r"if arg_89_2._card:isSkillAtIndex(20137, labIdx) or arg_89_2._card:isSkillAtIndex(20140, labIdx) or arg_89_2._card:isSkillAtIndex(20148, labIdx) then",
    r"if arg_89_2._card:isSkillAtIndex(20137, labIdx) or arg_89_2._card:isSkillAtIndex(20140, labIdx) or arg_89_2._card:isSkillAtIndex(20148, labIdx) or arg_89_2._card:isSkillAtIndex(20176, labIdx) then",
    "PlayerUi onChoiceGrave two-stage 20176 header"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    r'if arg_89_1._choiceParam == "lab_discard_hand" or arg_89_1._choiceParam == "lab_banish_grave" then',
    r'if arg_89_1._choiceParam == "lab_discard_hand" or arg_89_1._choiceParam == "lab_banish_grave" or arg_89_1._choiceParam == "lab_oppo_monster" then',
    "PlayerUi onChoiceGrave two-stage 20176 stage 1 param"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """				elseif arg_89_2._card:isSkillAtIndex(20148, labIdx) then
					for _, c in ipairs(arg_89_0._player:getBattleCards("L")) do
						if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
							table.insert(stage2Cands, c)
						end
					end
				end""",
    """				elseif arg_89_2._card:isSkillAtIndex(20148, labIdx) then
					for _, c in ipairs(arg_89_0._player:getBattleCards("L")) do
						if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
							table.insert(stage2Cands, c)
						end
					end
				elseif arg_89_2._card:isSkillAtIndex(20176, labIdx) then
					for _, c in ipairs(arg_89_0._player:getBattleCards("H")) do
						if c ~= arg_89_2._card and (c:isTrap() or c._type == Data.CardType.trap) and c:canChangeToLeave() then
							table.insert(stage2Cands, c)
						end
					end
				end""",
    "PlayerUi onChoiceGrave two-stage 20176 stage 2 cands"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """		elseif arg_89_2._card:isSkillAtIndex(20143, labIdx) or arg_89_2._card:isSkillAtIndex(20144, labIdx) or arg_89_2._card:isSkillAtIndex(20145, labIdx) or arg_89_2._card:isSkillAtIndex(20146, labIdx) or arg_89_2._card:isSkillAtIndex(20147, labIdx) or arg_89_2._card:isSkillAtIndex(20154, labIdx) then""",
    """		elseif arg_89_2._card:isSkillAtIndex(20173, labIdx) or arg_89_2._card:isSkillAtIndex(20182, labIdx) or arg_89_2._card:isSkillAtIndex(20189, labIdx) or arg_89_2._card:isSkillAtIndex(20193, labIdx) then
			local id1 = (var_89_0 and var_89_0[1]) and var_89_0[1]._id or 0
			local id2 = (var_89_0 and var_89_0[2]) and var_89_0[2]._id or 0
			local var_choice = id2 * BattleData.UseCardId.id_group + id1
			return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_89_2._card,
				_target = arg_89_3 ~= nil and arg_89_3._card or nil,
				_choice = var_choice * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
			})
		elseif arg_89_2._card:isSkillAtIndex(20143, labIdx) or arg_89_2._card:isSkillAtIndex(20144, labIdx) or arg_89_2._card:isSkillAtIndex(20145, labIdx) or arg_89_2._card:isSkillAtIndex(20146, labIdx) or arg_89_2._card:isSkillAtIndex(20147, labIdx) or arg_89_2._card:isSkillAtIndex(20154, labIdx) or arg_89_2._card:isSkillAtIndex(20155, labIdx) or arg_89_2._card:isSkillAtIndex(20156, labIdx) or arg_89_2._card:isSkillAtIndex(20158, labIdx) or arg_89_2._card:isSkillAtIndex(20164, labIdx) or arg_89_2._card:isSkillAtIndex(20170, labIdx) or arg_89_2._card:isSkillAtIndex(20171, labIdx) or arg_89_2._card:isSkillAtIndex(20175, labIdx) or arg_89_2._card:isSkillAtIndex(20183, labIdx) or arg_89_2._card:isSkillAtIndex(20184, labIdx) or arg_89_2._card:isSkillAtIndex(20190, labIdx) then""",
    "PlayerUi onChoiceGrave multi and single choice batch 2"
)

# 9d. checkChoiceGrave count validation
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    r"if dbCard:isSkillAtIndex(20137, sBase) or dbCard:isSkillAtIndex(20140, sBase) or dbCard:isSkillAtIndex(20143, sBase) or dbCard:isSkillAtIndex(20144, sBase) or dbCard:isSkillAtIndex(20145, sBase) or dbCard:isSkillAtIndex(20146, sBase) or dbCard:isSkillAtIndex(20147, sBase) or dbCard:isSkillAtIndex(20148, sBase) or dbCard:isSkillAtIndex(20154, sBase) then",
    r"if dbCard:isSkillAtIndex(20137, sBase) or dbCard:isSkillAtIndex(20140, sBase) or dbCard:isSkillAtIndex(20143, sBase) or dbCard:isSkillAtIndex(20144, sBase) or dbCard:isSkillAtIndex(20145, sBase) or dbCard:isSkillAtIndex(20146, sBase) or dbCard:isSkillAtIndex(20147, sBase) or dbCard:isSkillAtIndex(20148, sBase) or dbCard:isSkillAtIndex(20154, sBase) or dbCard:isSkillAtIndex(20155, sBase) or dbCard:isSkillAtIndex(20156, sBase) or dbCard:isSkillAtIndex(20158, sBase) or dbCard:isSkillAtIndex(20164, sBase) or dbCard:isSkillAtIndex(20170, sBase) or dbCard:isSkillAtIndex(20171, sBase) or dbCard:isSkillAtIndex(20175, sBase) or dbCard:isSkillAtIndex(20176, sBase) or dbCard:isSkillAtIndex(20183, sBase) or dbCard:isSkillAtIndex(20184, sBase) or dbCard:isSkillAtIndex(20190, sBase) then",
    "PlayerUi checkChoiceGrave single choice batch 2"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    """			if dbCard:isSkillAtIndex(20113, sBase) then
				return var_91_0 > 0 and var_91_0 <= (arg_91_4 or 2)
			end""",
    """			if dbCard:isSkillAtIndex(20113, sBase) or dbCard:isSkillAtIndex(20173, sBase) or dbCard:isSkillAtIndex(20182, sBase) or dbCard:isSkillAtIndex(20189, sBase) then
				return var_91_0 > 0 and var_91_0 <= (arg_91_4 or 2)
			end
			if dbCard:isSkillAtIndex(20193, sBase) then
				return var_91_0 == 2
			end""",
    "PlayerUi checkChoiceGrave multi choice batch 2"
)

# 9e. isMax = true
replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    r"curCard:hasSkills({ 20081, 20109, 20113, 13838, 14785 })",
    r"curCard:hasSkills({ 20081, 20109, 20113, 13838, 14785, 20173, 20182, 20189 })",
    "PlayerUi isMax hasSkills"
)

replace_once(
    r"D:\yugitauapk\web\src\PlayerUi.lua",
    r"curCard:isSkillAtIndex(20113, sBase) or curCard:isSkillAtIndex(13838, sBase)",
    r"curCard:isSkillAtIndex(20113, sBase) or curCard:isSkillAtIndex(13838, sBase) or curCard:isSkillAtIndex(20173, sBase) or curCard:isSkillAtIndex(20182, sBase) or curCard:isSkillAtIndex(20189, sBase)",
    "PlayerUi isMax isSkillAtIndex"
)

print("All batch 2 logic successfully applied!")
