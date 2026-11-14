const fs = require('fs');

// Read strings from str.lua or wherever strings are
let strContent = '';
if (fs.existsSync('D:/yugitauapk/web/data/str.lua')) {
  strContent = fs.readFileSync('D:/yugitauapk/web/data/str.lua', 'utf8');
} else if (fs.existsSync('D:/yugitauapk/web/src/data/str.lua')) {
  strContent = fs.readFileSync('D:/yugitauapk/web/src/data/str.lua', 'utf8');
}

function getStr(sid) {
  const m = strContent.match(new RegExp(`\\[${sid}\\]\\s*=\\s*"([^"]+)"`));
  return m ? m[1] : '';
}

const trapContent = fs.readFileSync('D:/yugitauapk/web/data/trap.lua', 'utf8');
const lines = trapContent.split('\n');

const cards = [];
lines.forEach(l => {
  const m = l.match(/\[(\d+)\]=.*\["_nameSid"\]=(\d+).*\["_option"\]=(\d+)/);
  if (m) {
    cards.push({ id: m[1], nameSid: m[2], option: m[3] });
  }
});

console.log('Sample option 1 (normal trap):');
cards.filter(c => c.option === '1').slice(0, 5).forEach(c => {
  console.log(`  id=${c.id}, nameSid=${c.nameSid}, name=${getStr(c.nameSid)}`);
});

console.log('Sample option 2 (sustainable / continuous trap):');
cards.filter(c => c.option === '2').slice(0, 5).forEach(c => {
  console.log(`  id=${c.id}, nameSid=${c.nameSid}, name=${getStr(c.nameSid)}`);
});

console.log('Sample option 4 (counter trap):');
cards.filter(c => c.option === '4').slice(0, 5).forEach(c => {
  console.log(`  id=${c.id}, nameSid=${c.nameSid}, name=${getStr(c.nameSid)}`);
});
