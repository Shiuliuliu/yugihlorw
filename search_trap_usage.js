const fs = require('fs');
const path = require('path');

function search(dir) {
  for (const f of fs.readdirSync(dir)) {
    const full = path.join(dir, f);
    if (fs.statSync(full).isDirectory()) {
      search(full);
    } else if (f.endsWith('.lua')) {
      const txt = fs.readFileSync(full, 'utf8');
      const lines = txt.split('\n');
      lines.forEach((l, i) => {
        if (l.includes('is_sustainable') || l.includes('is_counter') || l.includes('card_magictrap') || l.includes('STR.CARD_TYPE') || l.includes('STR.TRAP')) {
          console.log(`${f}:${i+1}: ${l.trim()}`);
        }
      });
    }
  }
}

search('D:/yugitauapk/web/src');
