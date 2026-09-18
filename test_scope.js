
const fengari = require('./web/vendor/fengari-web.js');
const lua = fengari.lua;
const lauxlib = fengari.lauxlib;
const lualib = fengari.lualib;

const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);

const code = 
local s = 1140
local r = 538
local t = { a = 1, b = 2 }
for S, s in pairs(t) do
end
print('s after pairs loop: ' .. tostring(s))
;

lauxlib.luaL_dostring(L, fengari.to_luastring(code));
