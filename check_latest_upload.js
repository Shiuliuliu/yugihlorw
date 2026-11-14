const fs = require('fs');
const { execSync } = require('child_process');

// Let's use Python to check if media_1794341570016_f3e65ff5.jpg is identical to the new image
const img1Path = 'C:/Users/Nitro 5/.gemini/antigravity/brain/1935a16b-edc5-417f-a74d-a2641dd97101/.user_uploaded/media_1794341570016_f3e65ff5.jpg';

// Find the latest image in .user_uploaded
const userUpDir = 'C:/Users/Nitro 5/.gemini/antigravity/brain/1935a16b-edc5-417f-a74d-a2641dd97101/.user_uploaded';
const files = fs.readdirSync(userUpDir).map(f => ({
  name: f,
  time: fs.statSync(userUpDir + '/' + f).mtimeMs
})).sort((a, b) => b.time - a.time);

console.log('Top 3 latest uploads:');
files.slice(0, 3).forEach(f => console.log(f.name, new Date(f.time).toISOString()));
