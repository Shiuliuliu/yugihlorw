const fs = require('fs');
const c = fs.readFileSync('D:/yugitauapk/web/data/trap.lua', 'utf8');
const lines = c.split('\n');

const typeToOpt = {};
lines.forEach(l => {
  const mType = l.match(/\["_type"\]=(\d+)/);
  const mOpt = l.match(/\["_option"\]=(\d+)/);
  if (mType && mOpt) {
    const t = mType[1];
    const o = mOpt[1];
    if (!typeToOpt[t]) typeToOpt[t] = {};
    typeToOpt[t][o] = (typeToOpt[t][o] || 0) + 1;
  }
});
console.log('Type to Option mapping in trap.lua:', typeToOpt);
