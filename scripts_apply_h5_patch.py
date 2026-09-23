import sys
sys.stdout.reconfigure(encoding='utf-8')
import re

with open('generated_patch_pack_section.lua', 'r', encoding='utf-8') as f:
    replacement_pack_section = f.read()

with open('web/src/h5_patch.lua', 'r', encoding='utf-8') as f:
    h5_content = f.read()

start_marker = "ClientData.sendBuyPackage = function(packageId, count) return true end\n"
end_marker = "\n\t-- Card Box Info & Reset (Tavern / draw)\n\tClientData.sendCardBoxInfo = function(boxId)"

if start_marker not in h5_content or end_marker not in h5_content:
    print("ERROR: Markers not found!")
    sys.exit(1)

parts = h5_content.split(start_marker)
part1 = parts[0] + start_marker + "\n"
rest = parts[1]
sub_parts = rest.split(end_marker)
part2 = end_marker + sub_parts[1]

new_h5 = part1 + replacement_pack_section + part2

# Update cost calculation block in doBuyPackage
new_cost_block = """\t\t\tlocal isLiyaOrExtra = (boxId and boxId >= 101001 and boxId <= 210050)
\t\t\tlocal packIdx = nil
\t\t\tif isLiyaOrExtra then
\t\t\t\tif boxId <= 120050 then
\t\t\t\t\tpackIdx = math.floor((boxId - 100000) / 1000)
\t\t\t\telseif boxId <= 174050 then
\t\t\t\t\tpackIdx = math.floor((boxId - 120000) / 1000)
\t\t\t\telse
\t\t\t\t\tpackIdx = math.floor((boxId - 180000) / 1000)
\t\t\t\tend
\t\t\telseif boxId and boxId >= 1 and boxId <= 20 and LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
\t\t\t\tisLiyaOrExtra = true
\t\t\t\tpackIdx = boxId
\t\t\tend

\t\t\tlocal costType = (resType == Data.ResType.ingot and "gem") or "gold"
\t\t\tlocal costVal = 0
\t\t\tif costType == "gem" then
\t\t\t\tif actualScene and actualScene._curRecruitInfo and actualScene._curRecruitInfo._param and actualScene._curRecruitInfo._param[2] then
\t\t\t\t\tcostVal = tonumber(actualScene._curRecruitInfo._param[2]) or 0
\t\t\t\tend
\t\t\telse
\t\t\t\tif isLiyaOrExtra then
\t\t\t\t\tcostVal = (numPacks >= 50 and 28500) or (numPacks >= 10 and 6000) or (600 * numPacks)
\t\t\t\telse
\t\t\t\t\tcostVal = (numPacks >= 50 and 22500) or (numPacks >= 10 and 4500) or (500 * numPacks)
\t\t\t\tend
\t\t\tend"""

new_h5 = re.sub(
    r'local isLiyaOrExtra = \(boxId and boxId >= 101001 and boxId <= \d+\).*?costVal = \(numPacks >= 50 and 22500\) or \(numPacks >= 10 and 4500\) or \(500 \* numPacks\)\s+end\s+end',
    new_cost_block.strip(),
    new_h5,
    flags=re.DOTALL
)

with open('web/src/h5_patch.lua', 'w', encoding='utf-8') as f:
    f.write(new_h5)

print("web/src/h5_patch.lua successfully updated!")
