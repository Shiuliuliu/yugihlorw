import json

with open('D:/yugitauapk/web/data_dumps.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

for k in data.keys():
    if any(x in k.lower() for x in ['lan', 'str', 'text', 'desc', 'name']):
        print(k)
