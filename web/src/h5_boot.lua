-- h5_boot.lua -- the web client's Lua entry point.
--
-- By the time this runs the JS side has already:
--   * created the Lua state and run bridge.lua, so cc / ccui resolve
--   * written every game module into /src and set package.path
--   * set SCR_W / SCR_H, which the fork registers as native constants and
--     the game reads arithmetically while modules are still loading
--
-- What is left is the same sequence the native shell performs: install the
-- compatibility shims, install the web-specific patches, then hand over to
-- the game's own main.lua.

-- lc.log is what the game's own error handler reports through, and it is
-- only defined once lcUtils loads; give it a home early so a failure during
-- the boot chain still says something.
lc = lc or {}
lc.log = lc.log or print

require("compat51")
local h5Patch = require("h5_patch")

print("[h5] booting " .. _VERSION .. " " .. tostring(SCR_W) .. "x" .. tostring(SCR_H))

-- A watchdog for the port: a browser tab cannot be interrupted, so a Lua
-- loop that never ends just wedges the page with nothing in the console.
-- With tracing on, report where the VM is every few million instructions and
-- break out if it keeps happening in the same place.
if JDZC_TRACE then
	local hits = 0
	local last = ""

	debug.sethook(function()
		local info = debug.getinfo(2, "Sl")
		local at = info and (tostring(info.short_src) .. ":" .. tostring(info.currentline)) or "?"

		print("[h5] watchdog at " .. at)

		if at == last then
			hits = hits + 1

			if hits > 4 then
				debug.sethook()
				error("watchdog: stuck at " .. at, 2)
			end
		else
			hits = 0
			last = at
		end
	end, "", 20000000)
end

local ok, err = xpcall(function()
	require("main")
end, function(e)
	return debug.traceback(tostring(e), 2)
end)

-- LoadingScene normally installs IconWidget after its resource milestones.
-- Direct H5 scene drivers can enter CardOperate/Depot before that callback,
-- so install the shared widget once the game's module graph is available.
pcall(require, "IconWidget")

if not ok then
	print("[h5] boot failed: " .. tostring(err))
end

-- Ensure late engine compatibility wrappers are installed even though
-- lcUtils returns no module table of its own.
if h5Patch.patchLcUtils then
	pcall(h5Patch.patchLcUtils, lc)
end
if h5Patch.patchLateClientData then
	pcall(h5Patch.patchLateClientData)
end

-- lcUtils may already have been loaded by the game before its require hook is
-- installed. Install the bounded legacy animation lookup directly as a final
-- guard; `sd.lcres/sd_tex.bin` has five atlas regions in the shipped data.
if lc.animate then
	local originalAnimate = lc.animate
	lc.animate = function(prefix, delay, loops)
		if prefix ~= "sd" then
			return originalAnimate(prefix, delay, loops)
		end
		local frames = {}
		for i = 1, 5 do
			local name = string.format("%s_%02d", prefix, i)
			local frame = lc.FrameCache:getSpriteFrame(name)
			if frame == nil then break end
			frames[#frames + 1] = name
		end
		return frames
	end
end

if lc.sequence then
	lc.sequence = function(...)
		local var_91_0 = { ... }
		local var_91_1 = {}
		for iter_91_0 = 1, #var_91_0 do
			local var_91_2 = var_91_0[iter_91_0]
			if type(var_91_2) == "function" then
				var_91_2 = lc.call(var_91_2)
			elseif type(var_91_2) == "number" then
				var_91_2 = lc.delay(var_91_2)
			elseif type(var_91_2) == "table" and rawget(var_91_2, "__h") == nil then
				var_91_2 = lc.spawn(unpack(var_91_2))
			end
			table.insert(var_91_1, var_91_2)
		end
		return cc.Sequence:create(var_91_1)
	end
end

if lc.spawn then
	lc.spawn = function(...)
		local var_92_0 = { ... }
		local var_92_1 = {}
		for iter_92_0 = 1, #var_92_0 do
			local var_92_2 = var_92_0[iter_92_0]
			if type(var_92_2) == "function" then
				var_92_2 = lc.call(var_92_2)
			elseif type(var_92_2) == "number" then
				var_92_2 = lc.delay(var_92_2)
			elseif type(var_92_2) == "table" and rawget(var_92_2, "__h") == nil then
				var_92_2 = lc.sequence(unpack(var_92_2))
			end
			table.insert(var_92_1, var_92_2)
		end
		return cc.Spawn:create(var_92_1)
	end
end
