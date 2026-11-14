const fs = require('fs');
const c = fs.readFileSync('D:/yugitauapk/web/data/trap.lua', 'utf8');
const lines = c.split('\n');

const typeCounts = {};
lines.forEach(l => {
  const m = l.match(/\["_type"\]=(\d+)/);
  if (m) {
    typeCounts[m[1]] = (typeCounts[m[1]] || 0) + 1;
  }
});
console.log('Type counts in trap.lua:', typeCounts);
