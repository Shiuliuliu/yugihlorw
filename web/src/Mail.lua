local var_0_0 = class("Mail")

var_0_0.Mails = {}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(arg_1_0.id)

	var_1_0._timestamp = arg_1_0.timestamp / 1000
	var_1_0._type = arg_1_0.type
	var_1_0._content = string.gsub(arg_1_0.content, "\\n", "\n")

	if arg_1_0:HasField("param") then
		local var_1_1 = json.decode(arg_1_0.param)

		var_1_0._title = var_1_1.title
		var_1_0._sender = var_1_1.sender
		var_1_0._opponentId = var_1_1.opponentId
		var_1_0._levelId = var_1_1.cityId

		if var_1_1.memberId then
			local var_1_2

			for iter_1_0, iter_1_1 in ipairs(var_1_1.memberId) do
				if iter_1_1 == P._id then
					var_1_2 = true

					break
				end
			end

			if not var_1_2 then
				var_1_0._isIgnore = true
			end
		end
	end

	if arg_1_0:HasField("user_info") then
		var_1_0._user = require("User").create(arg_1_0.user_info)
	else
		var_1_0._user = require("User").createNpc()
	end

	var_1_0._sender = var_1_0._user._name

	if arg_1_0:HasField("invite_status") then
		var_1_0._inviteStatus = arg_1_0.invite_status
	elseif arg_1_0:HasField("apply_status") then
		var_1_0._applyStatus = arg_1_0.apply_status
	elseif arg_1_0:HasField("sos_status") then
		var_1_0._sosStatus = arg_1_0.sos_status
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._id = arg_2_1
end

function var_0_0.sendMailDirty(arg_3_0)
	local var_3_0 = require("PlayerMail")
	local var_3_1 = cc.EventCustom:new(Data.Event.mail)

	var_3_1._event = var_3_0.Event.mail_dirty
	var_3_1._data = arg_3_0

	lc.Dispatcher:dispatchEvent(var_3_1)
end

return var_0_0
