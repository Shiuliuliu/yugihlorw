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
        if (l.includes('_btnConfirm') || l.includes('btn_confirm') || l.includes('_btnOk') || l.includes('onSelectConfirm')) {
          console.log(f + ':' + (i+1) + ': ' + l.trim());
        }
      });
    }
  }
}

search('D:/yugitauapk/web/src');
