const fs = require('fs');

function parseSfb(buf) {
  var v = new DataView(buf.buffer, buf.byteOffset, buf.byteLength);
  var u8 = new Uint8Array(buf.buffer, buf.byteOffset, buf.byteLength);
  var count = v.getUint32(0, true), off = 4, frames = [];
  var dec = new TextDecoder('utf-8');

  for (var i = 0; i < count; i++) {
    var n = v.getUint8(off);
    var name = dec.decode(u8.subarray(off + 1, off + n));
    off += 1 + n;
    frames.push({
      name: name,
      x: v.getUint16(off, true),
      y: v.getUint16(off + 2, true),
      w: v.getUint16(off + 4, true),
      h: v.getUint16(off + 6, true),
      rotated: v.getUint8(off + 8) !== 0,
      ox: v.getInt16(off + 9, true),
      oy: v.getInt16(off + 11, true),
      ow: v.getUint16(off + 13, true),
      oh: v.getUint16(off + 15, true),
    });
    off += 17;
  }
  return frames;
}

const buf = fs.readFileSync('D:/yugitauapk/web/res/cards_img_1.lcres/cards_img_1.png.sfb');
const frames = parseSfb(buf);
console.log('Total frames:', frames.length);
frames.filter(f => f.name.includes('magictrap') || f.name.includes('nature')).forEach(f => {
  console.log(JSON.stringify(f));
});
