const fs = require('fs');
const buf = fs.readFileSync('D:/yugitauapk/web/res/cards_img_1.lcres/cards_img_1.png.sfb');

// Let's find offsets of 'card_magictrap_12' and 'card_magictrap_13'
['card_magictrap_12', 'card_magictrap_13', 'card_magictrap_14', 'card_magictrap_15'].forEach(name => {
  const idx = buf.indexOf(Buffer.from(name));
  console.log(name, 'offset:', idx);
  // dump 32 bytes after name
  const slice = buf.slice(idx + name.length, idx + name.length + 32);
  console.log(name, 'hex after:', slice.toString('hex'));
});
