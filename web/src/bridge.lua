-- bridge.lua -- the Lua half of the JS bridge.
--
-- Every engine object the game touches is a JS object living in
-- cocos2d-html5. Here it looks like a plain table carrying the JS handle:
--
--     { __h = 41, __cls = "Sprite" }
--
-- An unknown key on such a table is resolved once per class by asking JS
-- whether the key is a method. It it is, the key becomes a bound closure;
-- if it is not, the key stays nil -- the game reads `if node._foo then`
-- all over the place and must not see a stray function there.
--
-- Loaded before anything else, so `cc`, `ccui` and `ccexp` exist as lazy
-- namespaces by the time the game's own Cocos2d.lua does `cc = cc or {}`.

local OP_STATIC   = 1
local OP_CALL     = 2
local OP_MEMBER   = 3
local OP_RELEASE  = 4
local OP_GET      = 5
local OP_INDEX    = 6
local OP_SETINDEX = 7
local OP_BINCALL  = 8

local jsb = __jsb

jsbridge = {
	OP_CALL = OP_CALL,
	OP_BINCALL = OP_BINCALL,
	OP_GET = OP_GET,
	OP_INDEX = OP_INDEX,
	OP_SETINDEX = OP_SETINDEX,
	call = jsb,
}

-- ---------------------------------------------------------------------------
-- instance proxies
-- ---------------------------------------------------------------------------

-- per-class member cache: classes[cls][key] is either the bound closure or
-- false, meaning "JS says this key is not a method".
local classes = {}

local instmt = {}

instmt.__index = function(self, key)
	-- keys we own are always raw; anything starting with __ is ours
	if type(key) ~= "string" then
		return nil
	end

	local cls = rawget(self, "__cls") or "?"
	local cache = classes[cls]

	if cache == nil then
		cache = {}
		classes[cls] = cache
	end

	local hit = cache[key]

	if hit == nil then
		if jsb(OP_MEMBER, rawget(self, "__h"), key) == "f" then
			hit = function(this, ...)
				return jsb(OP_CALL, rawget(this, "__h"), key, this, ...)
			end
		else
			hit = false
		end

		cache[key] = hit
	end

	if hit == false then
		return nil
	end

	return hit
end

instmt.__tostring = function(self)
	return "js<" .. tostring(rawget(self, "__cls")) .. "#"
		.. tostring(rawget(self, "__h")) .. ">"
end

-- live proxies, weak so a node dropped by Lua can be released on the JS side
local proxies = setmetatable({}, { __mode = "v" })

function __jsb_newproxy(h, cls)
	local p = proxies[h]

	if p ~= nil then
		return p
	end

	p = setmetatable({ __h = h, __cls = cls }, instmt)

	-- Lua 5.1 tables cannot have __gc, so hang a userdata sentinel off the
	-- proxy: when the proxy dies the sentinel dies, and JS drops the handle.
	local sentinel = newproxy(true)

	getmetatable(sentinel).__gc = function()
		jsb(OP_RELEASE, h)
	end

	rawset(p, "__gcs", sentinel)
	proxies[h] = p

	return p
end

-- ---------------------------------------------------------------------------
-- namespaces: cc.Sprite, ccui.Layout, ...
--
-- A class is just the JS constructor seen through the same proxy, so
-- `cc.Sprite:create(path)` is a method call on it and needs no special case.
-- ---------------------------------------------------------------------------

local function namespace(name)
	local t = {}

	setmetatable(t, {
		__index = function(self, key)
			if type(key) ~= "string" then
				return nil
			end

			local v = jsb(OP_GET, name .. "." .. key)

			if v ~= nil then
				rawset(self, key, v)
			end

			return v
		end,
	})

	return t
end

cc = namespace("cc")
ccui = namespace("ccui")
ccexp = namespace("ccexp")
ccs = namespace("ccs")

-- ---------------------------------------------------------------------------
-- JS-side services the game reaches through globals rather than cc.*
-- ---------------------------------------------------------------------------

jsbridge.namespace = namespace

-- A JS singleton (jdzcRes, jdzcNet) reached as an object rather than as a
-- namespace, so `obj:method(...)` dispatches on it.
function jsbridge.object(path)
	return jsb(OP_GET, path)
end

-- Ordinary calls decode strings as UTF-8, which is right for the game's text
-- and wrong for the network: a protobuf frame is arbitrary bytes and would
-- not survive the round trip. This form passes strings through as bytes.
function jsbridge.bincall(obj, name, ...)
	return jsb(OP_BINCALL, rawget(obj, "__h"), name, obj, ...)
end
