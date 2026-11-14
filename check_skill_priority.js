const fs = require('fs');
const factory = require('D:/yugitauapk/web/dist/lua51.js');

factory().then(Module => {
    require('D:/yugitauapk/web/js/lua.js');
    const lua = new global.JdzcLua(Module);
    
    // Setup minimal stubs for Cocos/engine
    lua.run(`
        cc = { PLATFORM_OS_WINDOWS = 0, PLATFORM_OS_ANDROID = 1, PLATFORM_OS_IPHONE = 2 }
        lc = { App = { getBinaryVersion = function() return "1.5.0" end } }
        jsres = { setCallbacks = function() end }
        jsbridge = { object = function() return { setCallbacks = function() end } end, call = function() end, on = function() end }
        class = function(name, base)
            local cls = {}
            cls.__index = cls
            return cls
        end
        Data = {
            _monsterInfo = {},
            _magicInfo = {},
            _trapInfo = {},
            _rareInfo = {},
            _skillInfo = {}
        }
    `);
    
    const compat51 = fs.readFileSync('D:/yugitauapk/web/src/compat51.lua', 'utf8');
    lua.run(compat51);
    
    // Also load skill.lua
    const skillLua = fs.readFileSync('D:/yugitauapk/web/data/skill.lua', 'utf8');
    lua.run(`
        local skills = (function() ` + skillLua + ` end)()
        for k, v in pairs(skills) do
            Data._skillInfo[k] = v
        end
    `);
    
    const h5Patch = fs.readFileSync('D:/yugitauapk/web/src/h5_patch.lua', 'utf8');
    lua.run(h5Patch);
    
    // Now inspect Data._skillInfo in Lua
    const missingPriority = lua.run(`
        local missing = {}
        for id, info in pairs(Data._skillInfo) do
            if type(info) == "table" and info._priority == nil then
                table.insert(missing, id)
            end
        end
        table.sort(missing)
        local res = ""
        for _, id in ipairs(missing) do
            res = res .. tostring(id) .. " "
        end
        return res
    `);
    
    console.log('Skills in Data._skillInfo with _priority == nil:');
    console.log(missingPriority ? missingPriority : 'NONE! All have _priority!');
    
    process.exit(0);
});
