const fs = require('fs');
const content = fs.readFileSync('D:/yugitauapk/add_labrynth_batch3_data.py', 'utf8');
console.log(content.slice(0, 3000));
