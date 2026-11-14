const fs = require('fs');
const path = require('path');

function search(dir) {
  for (const f of fs.readdirSync(dir)) {
    const full = path.join(dir, f);
    if (fs.statSync(full).isDirectory()) {
      if (!f.startsWith('.') && f !== 'node_modules') search(full);
    } else if (f.endsWith('.lua')) {
      const txt = fs.readFileSync(full, 'utf8');
      const lines = txt.split('\n');
      lines.forEach((l, i) => {
        if (l.includes('ChoiceDialog') || l.includes('CardSelectDialog') || l.includes('ChoiceForm') || l.includes('selectTarget') || l.includes('ChoiceTarget') || l.includes('choiceCard')) {
          console.log(f + ':' + (i+1) + ': ' + l.trim());
        }
      });
    }
  }
}

search('D:/yugitauapk/web/src');
