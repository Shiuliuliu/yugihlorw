local var_0_0 = {}
local var_0_1 = "bt_"

var_0_0.OperationType = {
	_modifyHp = "modify_hp",
	_empty = "empty",
	_export = "export",
	_batch = "batch",
	_runTest = "run_test",
	_addSkill = "add_skill",
	_load = "load"
}
var_0_0._curOpType = var_0_0.OperationType._empty
var_0_0._batch = {
	_okCount = 0,
	_batchCount = 0,
	_curBatch = 1,
	_errorCount = 0
}
var_0_0._singleFileName = nil
var_0_0._playerUsedCards = {}
var_0_0._opponentUsedCards = {}
var_0_0.DEFAULT_FILE = lc.File:getWritablePath() .. "DEFAULT_TEST_CARDS.ygo"

function var_0_0.importBattleTestData(arg_1_0)
	local var_1_0 = var_0_0._singleFileName

	if arg_1_0 ~= nil and arg_1_0 ~= "" then
		var_0_0._singleFileName = arg_1_0
	end

	local var_1_1

	if var_0_0._singleFileName ~= nil and var_0_0._singleFileName ~= "" then
		local var_1_2 = lc.readFile(var_0_0._singleFileName)

		var_1_1 = json.decode(var_1_2)
	else
		lc.log("filename null")
	end

	if arg_1_0 ~= nil and arg_1_0 ~= "" then
		var_0_0._singleFileName = var_1_0
	end

	return var_1_1
end

function var_0_0.parseInfoIds(arg_2_0)
	local var_2_0 = {
		AttackerFields = {},
		DefenderFields = {}
	}

	var_2_0.AttackerFields.P = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.P)
	var_2_0.AttackerFields.H = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.H)
	var_2_0.AttackerFields.B = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.B)
	var_2_0.AttackerFields.G = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.G)
	var_2_0.AttackerFields.L = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.L)
	var_2_0.AttackerFields.S = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.S)
	var_2_0.AttackerFields.R = BattleTestData.insertFilterCard(arg_2_0.AttackerFields.R)
	var_2_0.DefenderFields.P = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.P)
	var_2_0.DefenderFields.H = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.H)
	var_2_0.DefenderFields.B = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.B)
	var_2_0.DefenderFields.G = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.G)
	var_2_0.DefenderFields.L = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.L)
	var_2_0.DefenderFields.S = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.S)
	var_2_0.DefenderFields.R = BattleTestData.insertFilterCard(arg_2_0.DefenderFields.R)

	return var_2_0
end

function var_0_0.exportTestCardsData(arg_3_0, arg_3_1)
	if arg_3_0 ~= nil then
		BattleTestData.onFileSaved(arg_3_0, arg_3_1)
	end
end

function var_0_0.exportToBattleLog()
	if var_0_0._singleFileName ~= nil and var_0_0._singleFileName ~= "" then
		local var_4_0 = string.reverse(var_0_0._singleFileName)
		local var_4_1 = string.find(var_4_0, "[.]")
		local var_4_2 = string.sub(var_0_0._singleFileName, 1, #var_0_0._singleFileName - var_4_1) .. ".log"

		lc.writeFile(var_4_2, ClientData._battleDebugLog)
	end
end

function var_0_0.exportUsedCards()
	if var_0_0._singleFileName ~= nil and var_0_0._singleFileName ~= "" and (#var_0_0._playerUsedCards > 0 or #var_0_0._opponentUsedCards > 0) then
		local var_5_0 = var_0_0.importBattleTestData()

		var_5_0.AttackerUsedCards = var_0_0._playerUsedCards
		var_5_0.DefenderUsedCards = var_0_0._opponentUsedCards

		local var_5_1 = json.encode(var_5_0)

		if var_5_1 ~= "" then
			lc.writeFile(var_0_0._singleFileName, var_5_1)
		end
	end
end

function var_0_0.onFileSaved(arg_6_0, arg_6_1)
	local var_6_0 = {
		AttackerFields = {},
		DefenderFields = {}
	}

	var_6_0.AttackerFields.HP = arg_6_1.attackerHP
	var_6_0.AttackerFields.P, var_6_0.AttackerFields.PS = BattleTestData.filterCardId(arg_6_1.attackerP, "P")
	var_6_0.AttackerFields.H, var_6_0.AttackerFields.HS = BattleTestData.filterCardId(arg_6_1.attackerH, "H")
	var_6_0.AttackerFields.B, var_6_0.AttackerFields.BS = BattleTestData.filterCardId(arg_6_1.attackerB, "B")
	var_6_0.AttackerFields.G, var_6_0.AttackerFields.GS = BattleTestData.filterCardId(arg_6_1.attackerG, "G")
	var_6_0.AttackerFields.L, var_6_0.AttackerFields.LS = BattleTestData.filterCardId(arg_6_1.attackerL, "L")
	var_6_0.AttackerFields.S, var_6_0.AttackerFields.SS = BattleTestData.filterCardId(arg_6_1.attackerS, "S")
	var_6_0.AttackerFields.R, var_6_0.AttackerFields.RS = BattleTestData.filterCardId(arg_6_1.attackerR, "R")
	var_6_0.DefenderFields.HP = arg_6_1.defenderHP
	var_6_0.DefenderFields.P, var_6_0.DefenderFields.PS = BattleTestData.filterCardId(arg_6_1.defenderP, "P")
	var_6_0.DefenderFields.H, var_6_0.DefenderFields.HS = BattleTestData.filterCardId(arg_6_1.defenderH, "H")
	var_6_0.DefenderFields.B, var_6_0.DefenderFields.BS = BattleTestData.filterCardId(arg_6_1.defenderB, "B")
	var_6_0.DefenderFields.G, var_6_0.DefenderFields.GS = BattleTestData.filterCardId(arg_6_1.defenderG, "G")
	var_6_0.DefenderFields.L, var_6_0.DefenderFields.LS = BattleTestData.filterCardId(arg_6_1.defenderL, "L")
	var_6_0.DefenderFields.S, var_6_0.DefenderFields.SS = BattleTestData.filterCardId(arg_6_1.defenderS, "S")
	var_6_0.DefenderFields.R, var_6_0.DefenderFields.RS = BattleTestData.filterCardId(arg_6_1.defenderR, "R")

	local var_6_1 = json.encode(var_6_0)

	lc.log(var_6_1)
	lc.writeFile(arg_6_0, var_6_1)
end

function var_0_0.getCurDateTime()
	local var_7_0 = os.date()
	local var_7_1 = string.sub(var_7_0, 1, 2)
	local var_7_2 = string.sub(var_7_0, 4, 5)
	local var_7_3 = string.sub(var_7_0, 7, 8)
	local var_7_4 = string.sub(var_7_0, 10, 11)
	local var_7_5 = string.sub(var_7_0, 13, 14)
	local var_7_6 = string.sub(var_7_0, 16, 17)

	return var_7_3 .. "-" .. var_7_1 .. "-" .. var_7_2
end

function var_0_0.filterCardId(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}

	if arg_8_0 == nil or type(arg_8_0) ~= "table" then
		return nil
	end

	if arg_8_1 == "P" or arg_8_1 == "H" or arg_8_1 == "G" or arg_8_1 == "G" or arg_8_1 == "L" or arg_8_1 == "R" then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
			table.insert(var_8_0, iter_8_1._infoId)
			table.insert(var_8_1, iter_8_1._extraSkillId or 0)
		end
	elseif arg_8_1 == "B" then
		for iter_8_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
			if arg_8_0[iter_8_2] then
				local var_8_2 = arg_8_0[iter_8_2]._infoId

				if arg_8_0[iter_8_2]:hasBuff(true, BattleData.PositiveType.defendPosture) then
					var_8_2 = -var_8_2
				end

				table.insert(var_8_0, var_8_2)
				table.insert(var_8_1, arg_8_0[iter_8_2]._extraSkillId or 0)
			else
				table.insert(var_8_0, 0)
				table.insert(var_8_1, 0)
			end
		end
	elseif arg_8_1 == "S" then
		for iter_8_3 = 1, 5 do
			if arg_8_0[iter_8_3] then
				local var_8_3 = arg_8_0[iter_8_3]._infoId

				table.insert(var_8_0, var_8_3)
				table.insert(var_8_1, arg_8_0[iter_8_3]._extraSkillId or 0)
			else
				table.insert(var_8_0, 0)
				table.insert(var_8_1, 0)
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.resetUsedCards()
	var_0_0._playerUsedCards = {}
	var_0_0._opponentUsedCards = {}
end

function var_0_0.dealTestResult()
	if BattleTestData._curOpType == var_0_0.OperationType._runTest then
		require("Dialog").showDialog(var_0_0.isTestResultSame() and "PASS" or "FAIL", function()
			return
		end)
	elseif BattleTestData._curOpType == var_0_0.OperationType._batch then
		if var_0_0.isTestResultSame() then
			var_0_0._batch._okCount = var_0_0._batch._okCount + 1
		else
			var_0_0._batch._errorCount = var_0_0._batch._errorCount + 1
		end

		if var_0_0._batch._callback and var_0_0._batch._curBatch < var_0_0._batch._batchCount then
			var_0_0._batch._curBatch = var_0_0._batch._curBatch + 1

			var_0_0._batch._callback()
		else
			BattleTestData._batch._filenames = nil

			var_0_0._batch._callback()
			var_0_0.resetBatch()

			BattleTestData._singleFileName = nil

			ToastManager.push(Str(STR.BATCH_END), 1)
		end
	end
end

function var_0_0.resetBatch()
	var_0_0._curOpType = var_0_0.OperationType._empty
	var_0_0._batch._batchCount = 0
	var_0_0._batch._curBatch = 1
	var_0_0._batch._okCount = 0
	var_0_0._batch._errorCount = 0
	var_0_0._batch._callback = nil
	var_0_0._batch._filenames = nil
end

function var_0_0.isTestResultSame()
	if var_0_0._singleFileName == nil or var_0_0._singleFileName == "" then
		return false
	end

	local var_13_0 = var_0_0.importBattleTestData()
	local var_13_1 = string.reverse(var_0_0._singleFileName)
	local var_13_2 = string.find(var_13_1, "[.]")
	local var_13_3 = string.find(var_13_1, "\\")
	local var_13_4 = string.sub(var_0_0._singleFileName, 1, #var_0_0._singleFileName - var_13_3 + 1)
	local var_13_5 = string.sub(var_0_0._singleFileName, #var_0_0._singleFileName - var_13_3 + 2, #var_0_0._singleFileName - var_13_2)
	local var_13_6 = var_13_4 .. var_13_5 .. ".log"
	local var_13_7 = ClientData._battleDebugLog
	local var_13_8 = var_0_0.fileContentContains(var_13_7, var_13_6)

	if var_13_8 ~= true then
		lc.writeFile(var_13_4 .. "ERROR\\" .. var_13_5 .. ".log", var_13_7)
		var_0_0.copyFile(var_13_6, var_13_4 .. "ORIGIN\\" .. var_13_5 .. ".log")
	end

	print("[UNITTEST BATCH] ", var_13_8)

	return var_13_8
end

function var_0_0.fileContentContains(arg_14_0, arg_14_1)
	local var_14_0 = io.open(arg_14_1, "r")

	if not var_14_0 then
		return false
	end

	local var_14_1 = var_0_0.splitString(arg_14_0, "\n")
	local var_14_2 = {}
	local var_14_3 = {}
	local var_14_4 = false
	local var_14_5 = false

	for iter_14_0 = 1, #var_14_1 do
		local var_14_6 = var_14_1[iter_14_0]

		if var_14_4 or var_14_6 == "[BATTLE] ==================================" then
			var_14_4 = true

			table.insert(var_14_2, var_14_6)
		end
	end

	for iter_14_1 in var_14_0:lines() do
		if var_14_5 or iter_14_1 == "[BATTLE] ==================================" then
			var_14_5 = true

			table.insert(var_14_3, iter_14_1)
		end
	end

	var_14_0:close()

	for iter_14_2 = 2, #var_14_3 do
		if var_14_2[iter_14_2] ~= var_14_3[iter_14_2] then
			return false
		end
	end

	return true
end

function var_0_0.copyFile(arg_15_0, arg_15_1)
	fin = io.open(arg_15_0, "rb")
	fout = io.open(arg_15_1, "wb")
	c = fin:read("*a")

	fout:write(c)
	fin:close()
	fout:close()
end

function var_0_0.splitString(arg_16_0, arg_16_1)
	local var_16_0 = {}

	while true do
		local var_16_1 = string.find(arg_16_0, arg_16_1)

		if var_16_1 then
			local var_16_2 = string.sub(arg_16_0, 1, var_16_1 - 1)

			table.insert(var_16_0, var_16_2)

			arg_16_0 = string.sub(arg_16_0, var_16_1 + 1)
		else
			break
		end
	end

	return var_16_0
end

BattleTestData = var_0_0
