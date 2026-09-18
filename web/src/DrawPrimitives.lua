local var_0_0 = false
local var_0_1
local var_0_2 = -1
local var_0_3 = {
	1,
	1,
	1,
	1
}
local var_0_4 = -1
local var_0_5 = 1
local var_0_6 = "ShaderPosition_uColor"
local var_0_7 = CCApplication:getInstance():getTargetPlatform()

local function var_0_8()
	if not var_0_0 then
		var_0_1 = CCShaderCache:getInstance():getProgram(var_0_6)

		if var_0_1 ~= nil then
			var_0_2 = gl.getUniformLocation(var_0_1:getProgram(), "u_color")
			var_0_4 = gl.getUniformLocation(var_0_1:getProgram(), "u_pointSize")
			dp_Initialized = true
		end
	end

	if var_0_1 == nil then
		print("Error:dp_shader is nil!")

		return false
	end

	return true
end

local function var_0_9()
	gl.glEnableVertexAttribs(CCConstants.VERTEX_ATTRIB_FLAG_POSITION)
	var_0_1:use()
	var_0_1:setUniformsForBuiltins()
	var_0_1:setUniformLocationWith4fv(var_0_2, var_0_3, 1)
end

function ccDrawInit()
	var_0_8()
end

function ccDrawFree()
	var_0_0 = false
end

function ccDrawColor4f(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_3[1] = arg_5_0
	var_0_3[2] = arg_5_1
	var_0_3[3] = arg_5_2
	var_0_3[4] = arg_5_3
end

function ccPointSize(arg_6_0)
	var_0_5 = arg_6_0 * CCDirector:getInstance():getContentScaleFactor()
end

function ccDrawColor4B(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_3[1] = arg_7_0 / 255
	var_0_3[2] = arg_7_1 / 255
	var_0_3[3] = arg_7_2 / 255
	var_0_3[4] = arg_7_3 / 255
end

function ccDrawPoint(arg_8_0)
	if not var_0_8() then
		return
	end

	local var_8_0 = {}

	;(function()
		var_8_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_8_0.buffer_id)

		local var_9_0 = {
			arg_8_0.x,
			arg_8_0.y
		}

		gl.bufferData(gl.ARRAY_BUFFER, 2, var_9_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	var_0_1:setUniformLocationWith1f(var_0_4, var_0_5)
	gl.bindBuffer(gl.ARRAY_BUFFER, var_8_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.POINTS, 0, 1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawPoints(arg_10_0, arg_10_1)
	if not var_0_8() then
		return
	end

	local var_10_0 = {}
	local var_10_1 = 1

	;(function()
		var_10_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_10_0.buffer_id)

		local var_11_0 = {}

		for iter_11_0 = 1, arg_10_1 do
			var_11_0[2 * iter_11_0 - 1] = arg_10_0[iter_11_0].x
			var_11_0[2 * iter_11_0] = arg_10_0[iter_11_0].y
		end

		gl.bufferData(gl.ARRAY_BUFFER, arg_10_1 * 2, var_11_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	var_0_1:setUniformLocationWith1f(var_0_4, var_0_5)
	gl.bindBuffer(gl.ARRAY_BUFFER, var_10_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.POINTS, 0, arg_10_1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawLine(arg_12_0, arg_12_1)
	if not var_0_8() then
		return
	end

	local var_12_0 = {}

	;(function()
		var_12_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_12_0.buffer_id)

		local var_13_0 = {
			arg_12_0.x,
			arg_12_0.y,
			arg_12_1.x,
			arg_12_1.y
		}

		gl.bufferData(gl.ARRAY_BUFFER, 4, var_13_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_12_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.LINES, 0, 2)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawPoly(arg_14_0, arg_14_1, arg_14_2)
	if not var_0_8() then
		return
	end

	local var_14_0 = {}
	local var_14_1 = 1

	;(function()
		var_14_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_14_0.buffer_id)

		local var_15_0 = {}

		for iter_15_0 = 1, arg_14_1 do
			var_15_0[2 * iter_15_0 - 1] = arg_14_0[iter_15_0].x
			var_15_0[2 * iter_15_0] = arg_14_0[iter_15_0].y
		end

		gl.bufferData(gl.ARRAY_BUFFER, arg_14_1 * 2, var_15_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_14_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)

	if arg_14_2 then
		gl.drawArrays(gl.LINE_LOOP, 0, arg_14_1)
	else
		gl.drawArrays(gl.LINE_STRIP, 0, arg_14_1)
	end

	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawSolidPoly(arg_16_0, arg_16_1, arg_16_2)
	if not var_0_8() then
		return
	end

	local var_16_0 = {}
	local var_16_1 = 1

	;(function()
		var_16_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_16_0.buffer_id)

		local var_17_0 = {}

		for iter_17_0 = 1, arg_16_1 do
			var_17_0[2 * iter_17_0 - 1] = arg_16_0[iter_17_0].x
			var_17_0[2 * iter_17_0] = arg_16_0[iter_17_0].y
		end

		gl.bufferData(gl.ARRAY_BUFFER, arg_16_1 * 2, var_17_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	gl.glEnableVertexAttribs(CCConstants.VERTEX_ATTRIB_FLAG_POSITION)
	var_0_1:use()
	var_0_1:setUniformsForBuiltins()
	var_0_1:setUniformLocationWith4fv(var_0_2, arg_16_2, 1)
	gl.bindBuffer(gl.ARRAY_BUFFER, var_16_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.TRIANGLE_FAN, 0, arg_16_1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawRect(arg_18_0, arg_18_1)
	ccDrawLine(CCPoint:__call(arg_18_0.x, arg_18_0.y), CCPoint:__call(arg_18_1.x, arg_18_0.y))
	ccDrawLine(CCPoint:__call(arg_18_1.x, arg_18_0.y), CCPoint:__call(arg_18_1.x, arg_18_1.y))
	ccDrawLine(CCPoint:__call(arg_18_1.x, arg_18_1.y), CCPoint:__call(arg_18_0.x, arg_18_1.y))
	ccDrawLine(CCPoint:__call(arg_18_0.x, arg_18_1.y), CCPoint:__call(arg_18_0.x, arg_18_0.y))
end

function ccDrawSolidRect(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {
		arg_19_0,
		CCPoint:__call(arg_19_1.x, arg_19_0.y),
		arg_19_1,
		CCPoint:__call(arg_19_0.x, arg_19_1.y)
	}

	ccDrawSolidPoly(var_19_0, 4, arg_19_2)
end

function ccDrawCircleScale(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	if not var_0_8() then
		return
	end

	local var_20_0 = 1

	if arg_20_4 then
		var_20_0 = var_20_0 + 1
	end

	local var_20_1 = {}

	;(function()
		local var_21_0 = 2 * math.pi / arg_20_3
		local var_21_1 = 1
		local var_21_2 = {}

		var_20_1.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_20_1.buffer_id)

		for iter_21_0 = 1, arg_20_3 + 1 do
			local var_21_3 = (iter_21_0 - 1) * var_21_0
			local var_21_4 = arg_20_1 * math.cos(var_21_3 + arg_20_2) * arg_20_5 + arg_20_0.x
			local var_21_5 = arg_20_1 * math.sin(var_21_3 + arg_20_2) * arg_20_6 + arg_20_0.y

			var_21_2[iter_21_0 * 2 - 1] = var_21_4
			var_21_2[iter_21_0 * 2] = var_21_5
		end

		var_21_2[(arg_20_3 + 2) * 2 - 1] = arg_20_0.x
		var_21_2[(arg_20_3 + 2) * 2] = arg_20_0.y

		gl.bufferData(gl.ARRAY_BUFFER, (arg_20_3 + 2) * 2, var_21_2, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_20_1.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.LINE_STRIP, 0, arg_20_3 + var_20_0)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawCircle(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	ccDrawCircleScale(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, 1, 1)
end

function ccDrawSolidCircle(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	if not var_0_8() then
		return
	end

	local var_23_0 = {}

	;(function()
		local var_24_0 = 2 * math.pi / arg_23_3
		local var_24_1 = 1
		local var_24_2 = {}

		var_23_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_23_0.buffer_id)

		for iter_24_0 = 1, arg_23_3 + 1 do
			local var_24_3 = (iter_24_0 - 1) * var_24_0
			local var_24_4 = arg_23_1 * math.cos(var_24_3 + arg_23_2) * arg_23_4 + arg_23_0.x
			local var_24_5 = arg_23_1 * math.sin(var_24_3 + arg_23_2) * arg_23_5 + arg_23_0.y

			var_24_2[iter_24_0 * 2 - 1] = var_24_4
			var_24_2[iter_24_0 * 2] = var_24_5
		end

		var_24_2[(arg_23_3 + 2) * 2 - 1] = arg_23_0.x
		var_24_2[(arg_23_3 + 2) * 2] = arg_23_0.y

		gl.bufferData(gl.ARRAY_BUFFER, (arg_23_3 + 2) * 2, var_24_2, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_23_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.TRIANGLE_FAN, 0, arg_23_3 + 1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawQuadBezier(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not var_0_8() then
		return
	end

	local var_25_0 = {}

	;(function()
		local var_26_0 = {}
		local var_26_1 = 1
		local var_26_2 = 0

		for iter_26_0 = 1, arg_25_3 do
			var_26_0[2 * iter_26_0 - 1] = math.pow(1 - var_26_2, 2) * arg_25_0.x + 2 * (1 - var_26_2) * var_26_2 * arg_25_1.x + var_26_2 * var_26_2 * arg_25_2.x
			var_26_0[2 * iter_26_0] = math.pow(1 - var_26_2, 2) * arg_25_0.y + 2 * (1 - var_26_2) * var_26_2 * arg_25_1.y + var_26_2 * var_26_2 * arg_25_2.y
			var_26_2 = var_26_2 + 1 / arg_25_3
		end

		var_26_0[2 * (arg_25_3 + 1) - 1] = arg_25_2.x
		var_26_0[2 * (arg_25_3 + 1)] = arg_25_2.y
		var_25_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_25_0.buffer_id)
		gl.bufferData(gl.ARRAY_BUFFER, (arg_25_3 + 1) * 2, var_26_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_25_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.LINE_STRIP, 0, arg_25_3 + 1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end

function ccDrawCubicBezier(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if not var_0_8 then
		return
	end

	local var_27_0 = {}

	;(function()
		local var_28_0 = {}
		local var_28_1 = 0
		local var_28_2 = 1

		for iter_28_0 = 1, arg_27_4 do
			var_28_0[2 * iter_28_0 - 1] = math.pow(1 - var_28_1, 3) * arg_27_0.x + 3 * math.pow(1 - var_28_1, 2) * var_28_1 * arg_27_1.x + 3 * (1 - var_28_1) * var_28_1 * var_28_1 * arg_27_2.x + var_28_1 * var_28_1 * var_28_1 * arg_27_3.x
			var_28_0[2 * iter_28_0] = math.pow(1 - var_28_1, 3) * arg_27_0.y + 3 * math.pow(1 - var_28_1, 2) * var_28_1 * arg_27_1.y + 3 * (1 - var_28_1) * var_28_1 * var_28_1 * arg_27_2.y + var_28_1 * var_28_1 * var_28_1 * arg_27_3.y
			var_28_1 = var_28_1 + 1 / arg_27_4
		end

		var_28_0[2 * (arg_27_4 + 1) - 1] = arg_27_3.x
		var_28_0[2 * (arg_27_4 + 1)] = arg_27_3.y
		var_27_0.buffer_id = gl.createBuffer()

		gl.bindBuffer(gl.ARRAY_BUFFER, var_27_0.buffer_id)
		gl.bufferData(gl.ARRAY_BUFFER, (arg_27_4 + 1) * 2, var_28_0, gl.STATIC_DRAW)
		gl.bindBuffer(gl.ARRAY_BUFFER, 0)
	end)()
	var_0_9()
	gl.bindBuffer(gl.ARRAY_BUFFER, var_27_0.buffer_id)
	gl.vertexAttribPointer(CCConstants.VERTEX_ATTRIB_POSITION, 2, gl.FLOAT, false, 0, 0)
	gl.drawArrays(gl.LINE_STRIP, 0, arg_27_4 + 1)
	gl.bindBuffer(gl.ARRAY_BUFFER, 0)
end
