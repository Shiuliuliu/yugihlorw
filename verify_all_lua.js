const fs = require('fs');
const path = require('path');
const LuaVM = require('D:/yugitauapk/web/dist/lua51.js');

async function testFiles() {
    const M = await LuaVM();
    console.log("LuaVM initialized successfully!");
    
    const files = [
        'D:/yugitauapk/web/src/LordForm.lua',
        'D:/yugitauapk/web/src/BattleHelpForm.lua',
        'D:/yugitauapk/web/src/ClientData.lua',
        'D:/yugitauapk/web/src/RegionScene.lua',
        'D:/yugitauapk/web/src/h5_patch.lua',
        'D:/yugitauapk/web/src/BattleSkill.lua',
        'D:/yugitauapk/web/src/BattleStep.lua',
        'D:/yugitauapk/web/src/PlayerUi.lua',
        'D:/yugitauapk/web/src/BattleCard.lua',
        'D:/yugitauapk/web/src/BattleHelper.lua',
        'D:/yugitauapk/web/src/IllustrationForm.lua',
        'D:/yugitauapk/web/src/CardInfoWidget.lua',
        'D:/yugitauapk/web/src/IconWidget.lua',
        'D:/yugitauapk/web/src/BattleInitiativeSkillsDialog.lua',
        'D:/yugitauapk/web/src/BattleCardStatus.lua',
        'D:/yugitauapk/web/src/PlayerCard.lua',
        'D:/yugitauapk/web/data/monster.lua',
        'D:/yugitauapk/web/data/rare.lua',
        'D:/yugitauapk/web/data/skill.lua',
        'D:/yugitauapk/web/data/trap.lua',
        'D:/yugitauapk/web/data/magic.lua'
    ];

    let hasError = false;

    for (const filePath of files) {
        const code = fs.readFileSync(filePath);
        const L = M._luaL_newstate();
        M._luaL_openlibs(L);

        const ptr = M._malloc(code.length + 1);
        M.HEAPU8.set(code, ptr);
        M.HEAPU8[ptr + code.length] = 0;

        const baseName = path.basename(filePath);
        const chunkNameBytes = Buffer.from('@' + baseName + '\0', 'utf8');
        const chunkName = M._malloc(chunkNameBytes.length);
        M.HEAPU8.set(chunkNameBytes, chunkName);

        const res = M._luaL_loadbuffer(L, ptr, code.length, chunkName);
        if (res !== 0) {
            const errPtr = M._lua_tolstring(L, -1, 0);
            let errStr = "";
            let i = 0;
            while (M.HEAPU8[errPtr + i] !== 0) {
                errStr += String.fromCharCode(M.HEAPU8[errPtr + i]);
                i++;
            }
            console.error(`[FAIL] COMPILE ERROR in ${baseName}:`, errStr);
            hasError = true;
        } else {
            console.log(`[PASS] ${baseName} compiled OK`);
        }

        M._free(ptr);
        M._free(chunkName);
        M._lua_close(L);
    }

    if (hasError) {
        process.exit(1);
    } else {
        console.log("\nALL FILES COMPILED SUCCESSFULLY!");
    }
}

testFiles().catch(err => {
    console.error(err);
    process.exit(1);
});
