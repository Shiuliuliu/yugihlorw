ccb = ccb or {}

function CCBReaderLoad(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == nil then
		return nil
	end

	local var_1_0 = arg_1_1:createCCBReader()
	local var_1_1 = var_1_0:load(arg_1_0)
	local var_1_2 = ""

	if arg_1_2 ~= nil then
		local var_1_3 = var_1_0:getOwnerCallbackNames()
		local var_1_4 = var_1_0:getOwnerCallbackNodes()
		local var_1_5 = var_1_0:getOwnerCallbackControlEvents()
		local var_1_6 = 1

		for iter_1_0 = 1, table.getn(var_1_3) do
			local var_1_7 = var_1_3[iter_1_0]
			local var_1_8 = tolua.cast(var_1_4[iter_1_0], "cc.Node")

			if type(arg_1_2[var_1_7]) == "function" then
				arg_1_1:setCallback(var_1_8, arg_1_2[var_1_7], var_1_5[iter_1_0])
			else
				print("Warning: Cannot find owner's lua function:" .. ":" .. var_1_7 .. " for ownerVar selector")
			end
		end

		local var_1_9 = var_1_0:getOwnerOutletNames()
		local var_1_10 = var_1_0:getOwnerOutletNodes()

		for iter_1_1 = 1, table.getn(var_1_9) do
			arg_1_2[var_1_9[iter_1_1]] = tolua.cast(var_1_10[iter_1_1], "cc.Node")
		end
	end

	local var_1_11 = var_1_0:getNodesWithAnimationManagers()
	local var_1_12 = var_1_0:getAnimationManagersForNodes()

	for iter_1_2 = 1, table.getn(var_1_11) do
		local var_1_13 = tolua.cast(var_1_11[iter_1_2], "cc.Node")
		local var_1_14 = tolua.cast(var_1_12[iter_1_2], "cc.CCBAnimationManager")
		local var_1_15 = var_1_14:getDocumentControllerName()

		if var_1_15 == "" then
			-- block empty
		end

		if ccb[var_1_15] ~= nil then
			ccb[var_1_15].mAnimationManager = var_1_14
		end

		local var_1_16 = var_1_14:getDocumentCallbackNames()
		local var_1_17 = var_1_14:getDocumentCallbackNodes()
		local var_1_18 = var_1_14:getDocumentCallbackControlEvents()

		for iter_1_3 = 1, table.getn(var_1_16) do
			local var_1_19 = var_1_16[iter_1_3]
			local var_1_20 = tolua.cast(var_1_17[iter_1_3], "cc.Node")

			if var_1_15 ~= "" and ccb[var_1_15] ~= nil then
				if type(ccb[var_1_15][var_1_19]) == "function" then
					arg_1_1:setCallback(var_1_20, ccb[var_1_15][var_1_19], var_1_18[iter_1_3])
				else
					print("Warning: Cannot found lua function [" .. var_1_15 .. ":" .. var_1_19 .. "] for docRoot selector")
				end
			end
		end

		local var_1_21 = var_1_14:getDocumentOutletNames()
		local var_1_22 = var_1_14:getDocumentOutletNodes()

		for iter_1_4 = 1, table.getn(var_1_21) do
			local var_1_23 = var_1_21[iter_1_4]
			local var_1_24 = tolua.cast(var_1_22[iter_1_4], "cc.Node")

			if ccb[var_1_15] ~= nil then
				ccb[var_1_15][var_1_23] = tolua.cast(var_1_24, arg_1_1:getNodeTypeName(var_1_24))
			end
		end

		local var_1_25 = var_1_14:getKeyframeCallbacks()

		for iter_1_5 = 1, table.getn(var_1_25) do
			local var_1_26 = var_1_25[iter_1_5]
			local var_1_27, var_1_28 = string.find(var_1_26, ":")
			local var_1_29 = tonumber(string.sub(var_1_26, 1, var_1_27 - 1))
			local var_1_30 = string.sub(var_1_26, var_1_28 + 1, -1)

			if var_1_29 == 1 and ccb[var_1_15] ~= nil then
				local var_1_31 = cc.CallFunc:create(ccb[var_1_15][var_1_30])

				var_1_14:setCallFuncForLuaCallbackNamed(var_1_31, var_1_26)
			elseif var_1_29 == 2 and arg_1_2 ~= nil then
				local var_1_32 = cc.CallFunc:create(arg_1_2[var_1_30])

				var_1_14:setCallFuncForLuaCallbackNamed(var_1_32, var_1_26)
			end
		end

		local var_1_33 = var_1_14:getAutoPlaySequenceId()

		if var_1_33 ~= -1 then
			var_1_14:runAnimationsForSequenceIdTweenDuration(var_1_33, 0)
		end
	end

	return var_1_1
end

local function var_0_0(arg_2_0, arg_2_1, arg_2_2)
	print("\n********** \n" .. "CCBuilderReaderLoad(strFilePath,proxy,owner)" .. " was deprecated please use " .. "CCBReaderLoad(strFilePath,proxy,owner)" .. " instead.\n**********")

	return CCBReaderLoad(arg_2_0, arg_2_1, arg_2_2)
end

rawset(_G, "CCBuilderReaderLoad", var_0_0)
