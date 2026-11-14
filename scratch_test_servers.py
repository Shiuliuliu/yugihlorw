for fname in ['yugioh_battle_server.py', 'yugioh_proto_server.py']:
    try:
        with open('D:/yugitauapk/' + fname, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        print(f"=== {fname} ({len(lines)} lines) ===")
        for line in lines[:30]:
            print(line, end='')
    except Exception as e:
        print(e)
