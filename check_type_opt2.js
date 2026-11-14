const fs = require('fs');
const c = fs.readFileSync('D:/yugitauapk/web/data/trap.lua', 'utf8');

// Match [id] = { ... }
const cardBlocks = c.split(/\[\d+\]\s*=\s*\{/);

const typeToOpt = {};
cardBlocks.forEach(b => {
  const mType = b.match(/\["_type"\]\s*=\s*(\d+)/);
  const mOpt = b.match(/\["_option"\]\s*=\s*(\d+)/);
  if (mType && mOpt) {
    const t = mType[1];
    const o = mOpt[1];
    if (!typeToOpt[t]) typeToOpt[t] = {};
    typeToOpt[t][o] = (typeToOpt[t][o] || 0) + 1;
  }
});
console.log('Type to Option mapping in trap.lua:', typeToOpt);
