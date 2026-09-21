import re, json

def parse_drop_lua():
    char_packs = {}   # value -> list of card_ids
    liya_packs = {}   # value -> list of card_ids
    
    cur_id = None
    cur_type = None
    cur_value = None
    cur_pids = []
    in_pid = False

    with open('web/data/drop.lua', 'r', encoding='utf-8') as f:
        for line in f:
            line_s = line.strip()
            
            # Check for entry start:   [33]={["_descSid"]=...
            m_start = re.match(r'^  \[(\d+)\]=\{(.*\["_id"\]=.*)', line)
            if m_start:
                # Save previous entry if valid
                if cur_value and cur_type in (1001, 1002) and cur_pids:
                    if cur_type == 1002:
                        char_packs[cur_value] = cur_pids
                    else:
                        liya_packs[cur_value] = cur_pids
                
                cur_id = int(m_start.group(1))
                cur_type = None
                cur_value = None
                cur_pids = []
                in_pid = False
                rest = m_start.group(2)
            else:
                rest = line_s

            if '["_pid"]=' in rest:
                in_pid = True
                continue
            
            if in_pid:
                # Match card id: [1]={[1]=10290,},
                m_pid = re.match(r'\[\d+\]=\{\[1\]=(\d+),\}', rest)
                if m_pid:
                    cur_pids.append(int(m_pid.group(1)))
                elif rest.startswith('},') or rest == '},':
                    in_pid = False
            
            if '["_type"]=' in rest:
                m_t = re.search(r'\["_type"\]=(\d+)', rest)
                if m_t: cur_type = int(m_t.group(1))
            if '["_value"]=' in rest:
                m_v = re.search(r'\["_value"\]=(\d+)', rest)
                if m_v: cur_value = int(m_v.group(1))

        # Save last entry
        if cur_value and cur_type in (1001, 1002) and cur_pids:
            if cur_type == 1002:
                char_packs[cur_value] = cur_pids
            else:
                liya_packs[cur_value] = cur_pids

    return char_packs, liya_packs

if __name__ == '__main__':
    char_packs, liya_packs = parse_drop_lua()
    print(f"Parsed {len(char_packs)} character pack entries from drop.lua")
    print(f"Parsed {len(liya_packs)} liya pack entries from drop.lua")
    for k in sorted(char_packs.keys()):
        print(f"  Char pack _value={k}: {len(char_packs[k])} cards")
    for k in sorted(liya_packs.keys())[:15]:
        print(f"  Liya pack _value={k}: {len(liya_packs[k])} cards")
