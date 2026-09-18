local var_0_0 = class("ChapterLevel")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._chapterId = arg_1_1._chapter
	arg_1_0._chapterInfo = arg_1_1
	arg_1_0._conditions = {}

	local var_1_0 = arg_1_1._condition

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = Data._conditionInfo[var_1_0[iter_1_0]]

		table.insert(arg_1_0._conditions, var_1_1)
	end

	arg_1_0._troopCards = {}

	local var_1_2 = arg_1_1._opponentTroopID
	local var_1_3 = Data._troopInfo[var_1_2]
	local var_1_4 = {}

	for iter_1_1 = 1, #var_1_3._infoId do
		local var_1_5 = require("Card").create(var_1_3._infoId[iter_1_1])

		var_1_5._id = 1
		var_1_5._level = var_1_3._level[iter_1_1]

		if var_1_5._type == Data.CardType.monster then
			var_1_5._weaponId = var_1_3._weapon[iter_1_1]
			var_1_5._armorId = var_1_3._armor[iter_1_1]

			table.insert(arg_1_0._troopCards, var_1_5)
		elseif var_1_5._type == Data.CardType.weapon or var_1_5._type == Data.CardType.armor then
			var_1_5._newSkillId = var_1_3._newSkillId[iter_1_1]
			var_1_5._newSkillLevel = var_1_3._newSkillLevel[iter_1_1]
			var_1_4[var_1_3._cardId[iter_1_1]] = var_1_5
		else
			table.insert(arg_1_0._troopCards, var_1_5)
		end
	end

	for iter_1_2 = 1, #arg_1_0._troopCards do
		local var_1_6 = arg_1_0._troopCards[iter_1_2]

		if var_1_6._type == Data.CardType.monster then
			var_1_6._weapon = var_1_4[var_1_6._weaponId]
			var_1_6._armor = var_1_4[var_1_6._armorId]

			if var_1_6._weapon then
				var_1_6._weapon._ownerData = var_1_6
			end

			if var_1_6._armor then
				var_1_6._armor._ownerData = var_1_6
			end

			var_1_6._weaponId = 0
			var_1_6._armorId = 0
		end

		var_1_6._troop = arg_1_0._troopCards
	end

	arg_1_0._troopNameSid = var_1_3._nameSid

	if arg_1_0._chapterId == 1 then
		arg_1_0:appendEventTroop()
	end
end

function var_0_0.appendEventTroop(arg_2_0)
	local var_2_0 = arg_2_0._chapterInfo

	local function var_2_1(arg_3_0)
		local var_3_0 = require("Card").create(arg_3_0.id)

		var_3_0._evel = arg_3_0.lv or 1

		if arg_3_0.si then
			var_3_0._newSkillId = arg_3_0.si
		end

		if arg_3_0.sa then
			var_3_0._newSkillLevel = arg_3_0.sa
		end

		return var_3_0
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_0._oppoEventId) do
		local var_2_2 = Data._eventInfo[iter_2_1]

		if var_2_2 then
			for iter_2_2, iter_2_3 in ipairs(var_2_2._effect) do
				if iter_2_3 == 2 then
					local var_2_3 = var_2_2._effectValue[iter_2_2]

					if var_2_3.c.troop and var_2_3.c.troop == 1 then
						local var_2_4 = var_2_1(var_2_3.c)

						if var_2_3.w then
							local var_2_5 = var_2_1(var_2_3.w)

							var_2_4._weapon = var_2_5
							var_2_5._ownerData = var_2_4
						end

						if var_2_3.a then
							local var_2_6 = var_2_1(var_2_3.a)

							var_2_4._armor = var_2_6
							var_2_6._ownerData = var_2_4
						end

						table.insert(arg_2_0._troopCards, var_2_4)
					end
				end
			end
		end
	end
end

function var_0_0.getConditions(arg_4_0)
	return arg_4_0._conditions
end

function var_0_0.getDrops(arg_5_0, arg_5_1)
	if arg_5_1 then
		return arg_5_0._chapterInfo._firstPid
	else
		return arg_5_0._chapterInfo._pid
	end
end

function var_0_0.getTroopCards(arg_6_0)
	return arg_6_0._troopCards
end

function var_0_0.getTroopName(arg_7_0)
	return Str(arg_7_0._troopNameSid)
end

return var_0_0
