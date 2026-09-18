-- compat51.lua -- Lua 5.1 compatibility shims for the jdzc client.
--
-- The original client runs on LuaJIT 2.0 inside libyugioh_lua.so, which also
-- registers a handful of custom C functions into the `string` table and a
-- LuaJIT-style global `bit` library. This file re-implements all of them in
-- pure Lua 5.1 so the same game code runs on a stock Lua 5.1 interpreter
-- (desktop shell, Emscripten/wasm, iOS).
--
-- A C++ shell can (and should) override the hot ones (crc16/encrypt/decrypt,
-- bit) with native implementations after loading this file; everything here
-- stays as a fallback.
--
-- Wire-format references: jdzc-java LcCrypt.java / Crc16.java and
-- server/jdzc/crypto.py, both lifted out of the original binary.

-- ---------------------------------------------------------------------------
-- bit.* -- LuaJIT-compatible bitops. Results are SIGNED 32-bit, like LuaJIT.
-- The protocol depends on that: the rolling serial is kept as
-- bit.band(serial + step, 4294967295), which wraps to a negative number past
-- 2^31, and LCCrypt folds abs() over the signed value.
-- ---------------------------------------------------------------------------
if not bit then
	bit = {}

	local POW32 = 4294967296.0
	local POW31 = 2147483648.0

	local function toint(x)
		-- LuaJIT's bitops take anything tonumber() accepts, and the game
		-- leans on that: ids and counts reach bit.band straight out of a
		-- string.format or a config field. Coerce first, or the arithmetic
		-- below throws on a perfectly ordinary "1024".
		if type(x) ~= "number" then
			x = tonumber(x) or 0
		end

		x = x - x % 1.0
		x = x % POW32

		if x >= POW31 then
			x = x - POW32
		end

		return x
	end

	local function tou(x)
		x = toint(x)

		if x < 0 then
			x = x + POW32
		end

		return x
	end

	local function fold(u)
		if u >= POW31 then
			u = u - POW32
		end

		return u
	end

	bit.tobit = toint

	bit.tohex = function(x, n)
		local u = tou(x)

		if n == nil then
			return string.format("%08x", u)
		end

		return string.format("%0" .. n .. "x", u)
	end

	-- byte-wise boolean tables, built once (256*256 entries each)
	local BYTE_AND = {}
	local BYTE_OR = {}
	local BYTE_XOR = {}

	for a = 0, 255 do
		BYTE_AND[a] = {}
		BYTE_OR[a] = {}
		BYTE_XOR[a] = {}

		for b = 0, 255 do
			local aAND = 0
			local aOR = 0
			local aXOR = 0
			local s = 1
			local ua, ub = a, b

			for _ = 1, 8 do
				local ba = ua % 2
				local bb = ub % 2

				if ba == 1 and bb == 1 then
					aAND = aAND + s
				end

				if ba == 1 or bb == 1 then
					aOR = aOR + s
				end

				if ba ~= bb then
					aXOR = aXOR + s
				end

				ua = (ua - ba) / 2
				ub = (ub - bb) / 2
				s = s * 2
			end

			BYTE_AND[a][b] = aAND
			BYTE_OR[a][b] = aOR
			BYTE_XOR[a][b] = aXOR
		end
	end

	local function wordop(TABLE, a, b)
		local ua, ub = tou(a), tou(b)
		local r = 0.0
		local scale = 1.0

		for _ = 1, 4 do
			local ba = ua % 256
			local bb = ub % 256

			r = r + TABLE[ba][bb] * scale
			ua = (ua - ba) / 256
			ub = (ub - bb) / 256
			scale = scale * 256
		end

		return fold(r)
	end

	bit.band = function(a, ...)
		local r = a

		for i = 1, select("#", ...) do
			r = wordop(BYTE_AND, r, (select(i, ...)))
		end

		return r
	end

	bit.bor = function(a, ...)
		local r = a

		for i = 1, select("#", ...) do
			r = wordop(BYTE_OR, r, (select(i, ...)))
		end

		return r
	end

	bit.bxor = function(a, ...)
		local r = a

		for i = 1, select("#", ...) do
			r = wordop(BYTE_XOR, r, (select(i, ...)))
		end

		return r
	end

	bit.bnot = function(x)
		return fold(POW32 - 1 - tou(x))
	end

	bit.lshift = function(x, n)
		n = tou(n) % 32

		return fold((tou(x) * 2 ^ n) % POW32)
	end

	bit.rshift = function(x, n)
		n = tou(n) % 32

		return fold(math.floor(tou(x) / 2 ^ n))
	end

	bit.arshift = function(x, n)
		n = tou(n) % 32

		return toint(math.floor(toint(x) / 2 ^ n))
	end

	bit.rol = function(x, n)
		n = tou(n) % 32
		local u = tou(x)

		if n == 0 then
			return fold(u)
		end

		return fold((u * 2 ^ n) % POW32 + math.floor(u / 2 ^ (32 - n)))
	end

	bit.ror = function(x, n)
		n = tou(n) % 32
		local u = tou(x)

		if n == 0 then
			return fold(u)
		end

		return fold(math.floor(u / 2 ^ n) + (u % 2 ^ n) * 2 ^ (32 - n))
	end

	bit.bswap = function(x)
		local u = tou(x)
		local r = 0.0

		for i = 0, 3 do
			local b = math.floor(u / 2 ^ (8 * i)) % 256

			r = r + b * 2 ^ (8 * (3 - i))
		end

		return fold(r)
	end
end

-- ---------------------------------------------------------------------------
-- string.crc16 -- CRC-16/IBM, poly 0xA001 reflected, init 0, no final xor.
-- Reference check: crc16("123456789") == 0xBB3D.
-- ---------------------------------------------------------------------------
if not string.crc16 then
	local CRC16_TABLE = {}

	for i = 0, 255 do
		local c = i

		for _ = 1, 8 do
			local lo = c % 2

			c = math.floor(c / 2)

			if lo == 1 then
				c = bit.bxor(c, 0xA001)
			end
		end

		CRC16_TABLE[i + 1] = c
	end

	string.crc16 = function(data)
		local crc = 0

		for i = 1, #data do
			crc = bit.bxor(math.floor(crc / 256), CRC16_TABLE[bit.band(bit.bxor(string.byte(data, i), crc), 255) + 1])
		end

		return crc
	end
end

-- ---------------------------------------------------------------------------
-- string.encrypt / string.decrypt -- LCCrypt stream cipher.
--     K = abs(signed32(key)) % 46 ; s = FIB[K] & 7 (rolling per byte)
--     encrypt: out[i] = rol8(in[i], s) ^ K ; s = s + 1 & 7
--     decrypt: out[i] = ror8(in[i] ^ K, s)
-- ---------------------------------------------------------------------------
if not string.encrypt or not string.decrypt then
	local FIB = {
		1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597,
		584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418,
		317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465,
		14930352, 24157817, 39088169, 63245986, 102334155, 165580141,
		267914296, 433494437, 701408733, 1134903170, 1836311903
	}

	local ROL = {}
	local ROR = {}

	local function band8(x)
		return x % 256
	end

	for r = 0, 7 do
		ROL[r] = {}
		ROR[r] = {}

		for b = 0, 255 do
			ROL[r][b] = band8((b * 2 ^ r) % 256 + math.floor(b / 2 ^ (8 - r)))
			ROR[r][b] = band8(math.floor(b / 2 ^ r) + (b % 2 ^ r) * 2 ^ (8 - r))
		end
	end

	local function key_byte(key)
		local k = bit.tobit(key)

		if k < 0 then
			k = -k
		end

		return k % 46
	end

	string.encrypt = function(data, key)
		local k = key_byte(key)
		local s = FIB[k + 1] % 8
		local out = {}

		for i = 1, #data do
			out[i] = string.char(bit.band(bit.bxor(ROL[s][string.byte(data, i)], k), 255))

			s = s + 1

			if s == 8 then
				s = 0
			end
		end

		return table.concat(out)
	end

	string.decrypt = function(data, key)
		local k = key_byte(key)
		local s = FIB[k + 1] % 8
		local out = {}

		for i = 1, #data do
			out[i] = string.char(ROR[s][bit.band(bit.bxor(string.byte(data, i), k), 255)])

			s = s + 1

			if s == 8 then
				s = 0
			end
		end

		return table.concat(out)
	end
end

-- ---------------------------------------------------------------------------
-- string.pack / string.unpack -- the game's own byte-packing dialect.
--
-- Format letters: '<' little-endian, '>' big-endian, 'b'/'B' one byte,
-- 'h'/'H' two bytes, 'i'/'I' four bytes. Reproduces the native convention
-- recovered from the shipped binary: string.unpack returns the values of the
-- format fields PRECEDED by the next unread position, i.e.
--     pos, v1, v2, ... = string.unpack(s, fmt)
-- (verified against ClientData.loadLCRes / lcres.py on real containers).
-- ---------------------------------------------------------------------------
if not string.pack then
	string.pack = function(fmt, ...)
		local endian = ">"
		local out = {}
		local argn = 1

		for i = 1, #fmt do
			local c = string.sub(fmt, i, i)

			if c == "<" then
				endian = "<"
			elseif c == ">" then
				endian = ">"
			elseif c == "b" or c == "B" then
				out[#out + 1] = string.char(bit.band((select(argn, ...)), 255))
				argn = argn + 1
			elseif c == "h" or c == "H" then
				local v = bit.band((select(argn, ...)), 65535)
				local b1 = math.floor(v / 256)
				local b2 = v % 256

				if endian == "<" then
					out[#out + 1] = string.char(b2, b1)
				else
					out[#out + 1] = string.char(b1, b2)
				end

				argn = argn + 1
			elseif c == "i" or c == "I" then
				local v = bit.band((select(argn, ...)), 4294967295)
				local b1 = math.floor(v / 16777216) % 256
				local b2 = math.floor(v / 65536) % 256
				local b3 = math.floor(v / 256) % 256
				local b4 = v % 256

				if endian == "<" then
					out[#out + 1] = string.char(b4, b3, b2, b1)
				else
					out[#out + 1] = string.char(b1, b2, b3, b4)
				end

				argn = argn + 1
			else
				error("string.pack: unknown format char '" .. c .. "'")
			end
		end

		return table.concat(out)
	end

	string.unpack = function(s, fmt, init)
		local endian = ">"
		local pos = init or 1
		local vals = {}

		for i = 1, #fmt do
			local c = string.sub(fmt, i, i)

			if c == "<" then
				endian = "<"
			elseif c == ">" then
				endian = ">"
			elseif c == "b" or c == "B" then
				vals[#vals + 1] = string.byte(s, pos)
				pos = pos + 1
			elseif c == "h" or c == "H" then
				local b1, b2 = string.byte(s, pos, pos + 1)
				local v

				if endian == "<" then
					v = b1 + b2 * 256
				else
					v = b1 * 256 + b2
				end

				if c == "h" and v >= 32768 then
					v = v - 65536
				end

				vals[#vals + 1] = v
				pos = pos + 2
			elseif c == "i" or c == "I" then
				local b1, b2, b3, b4 = string.byte(s, pos, pos + 3)
				local v

				if b1 == nil then
					b1, b2, b3, b4 = 0, 0, 0, 0
				end

				if endian == "<" then
					v = b1 + b2 * 256 + b3 * 65536 + b4 * 16777216
				else
					v = b1 * 16777216 + b2 * 65536 + b3 * 256 + b4
				end

				if c == "i" and v >= 2147483648 then
					v = v - 4294967296
				end

				vals[#vals + 1] = v
				pos = pos + 4
			else
				error("string.unpack: unknown format char '" .. c .. "'")
			end
		end

		return pos, unpack(vals)
	end
end

-- ---------------------------------------------------------------------------
-- Misc native string helpers used by the game code.
-- ---------------------------------------------------------------------------
if not string.hasPrefix then
	string.hasPrefix = function(s, prefix)
		return string.sub(s, 1, #prefix) == prefix
	end
end

if not string.hasSuffix then
	string.hasSuffix = function(s, suffix)
		return suffix == "" or string.sub(s, -#suffix) == suffix
	end
end

if not string.splitByChar then
	string.splitByChar = function(s, sep)
		local out = {}
		local start = 1

		if #sep ~= 1 then
			sep = string.sub(sep, 1, 1)
		end

		while true do
			local at = string.find(s, sep, start, true)

			if at == nil then
				out[#out + 1] = string.sub(s, start)

				break
			end

			out[#out + 1] = string.sub(s, start, at - 1)
			start = at + 1
		end

		return out
	end
end

-- ---------------------------------------------------------------------------
-- Globals the engine normally provides.
-- ---------------------------------------------------------------------------
if not release_print then
	release_print = print
end

if not onLuaException then
	onLuaException = function(msg, log)
		print("[LUA EXCEPTION] " .. tostring(msg))
	end
end

-- ---------------------------------------------------------------------------
-- tolua
--
-- The stock client binds cocos2d-x through tolua, and eleven places in the
-- game's own code reach for that binding directly. There is no tolua table in
-- the web engine at all, so every one of them was a hard crash: BaseScene's
-- reload dialog calls tolua.isnull the moment the socket drops, which turned a
-- disconnect into an error every frame instead of the dialog that offers to
-- reconnect.
--
-- Each function has a real answer here rather than a stub:
--
--   isnull  asks whether a Lua handle has outlived the C++ object behind it.
--           Nothing here is backed by C++ - the objects are the JavaScript
--           ones - so a handle is dead only when it is nil.
--   cast    is a static-type assertion for the binding's benefit. The web
--           objects carry their own methods, so the value is already what the
--           cast claims it is.
--   getpeer and setpeer are how tolua keeps Lua-assigned fields beside a
--           userdata. There is no userdata here, so they keep the same
--           association in a weak-keyed table of their own - which matters
--           because the one caller, ccs.TriggerObj.extend, puts a metatable on
--           whatever getpeer hands back, and that must not be the node.
-- ---------------------------------------------------------------------------
if not tolua then
	local TOLUA_PEERS = setmetatable({}, { __mode = "k" })

	tolua = {
		isnull = function(value)
			return value == nil
		end,
		cast = function(value)
			return value
		end,
		getpeer = function(value)
			return TOLUA_PEERS[value]
		end,
		setpeer = function(value, peer)
			TOLUA_PEERS[value] = peer

			return value
		end,
		type = function(value)
			return type(value)
		end
	}
end
