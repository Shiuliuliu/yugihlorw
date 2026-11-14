const fs = require('fs');
const buf = fs.readFileSync('D:/yugitauapk/web/res/cards_img_1.lcres/cards_img_1.png.sfb');

// Look for strings in sfb
let str = '';
const strings = [];
for (let i = 0; i < buf.length; i++) {
  const b = buf[i];
  if (b >= 32 && b <= 126) {
    str += String.fromCharCode(b);
  } else {
    if (str.length >= 4) strings.push(str);
    str = '';
  }
}

const relevant = strings.filter(s => s.includes('magictrap') || s.includes('nature'));
console.log('Strings:', relevant);
