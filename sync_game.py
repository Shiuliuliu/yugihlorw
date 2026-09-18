#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script dong bo ma nguon va du lieu game:
Doc toan bo file trong web/src/*.lua -> tao web/lua_src.json
Doc toan bo file trong web/data/*    -> tao web/data_dumps.json
"""

import os
import json
import time

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WEB_DIR = os.path.join(BASE_DIR, 'web')
SRC_DIR = os.path.join(WEB_DIR, 'src')
DATA_DIR = os.path.join(WEB_DIR, 'data')

def sync_lua():
    if not os.path.isdir(SRC_DIR):
        print(f"[ERR] Khong tim thay thu muc: {SRC_DIR}")
        return
    print(f"[*] Dang dong bo ma nguon Lua tu {SRC_DIR}...")
    lua_data = {}
    for entry in os.scandir(SRC_DIR):
        if entry.is_file() and entry.name.endswith('.lua'):
            mod_name = entry.name[:-4]
            with open(entry.path, 'r', encoding='utf-8') as f:
                lua_data[mod_name] = f.read()
    
    out_file = os.path.join(WEB_DIR, 'lua_src.json')
    with open(out_file, 'w', encoding='utf-8') as f:
        json.dump(lua_data, f, ensure_ascii=False)
    
    sz = os.path.getsize(out_file)
    print(f"[OK] Da dong bo {len(lua_data)} module Lua -> {out_file} ({sz / 1024 / 1024:.2f} MB)")

def sync_data():
    if not os.path.isdir(DATA_DIR):
        print(f"[ERR] Khong tim thay thu muc: {DATA_DIR}")
        return
    print(f"[*] Dang dong bo du lieu game tu {DATA_DIR}...")
    data_dumps = {}
    for entry in os.scandir(DATA_DIR):
        if entry.is_file():
            name = entry.name
            with open(entry.path, 'r', encoding='utf-8') as f:
                content = f.read()
            if name == 'teach_dumps.json':
                dump_key = 'teach_dumps.json'
            elif name.endswith('.bin.lua'):
                dump_key = name[:-4]
            elif name.endswith('.lua'):
                base = name[:-4]
                dump_key = base if base in ('unknown_72', 'unknown_73', 'unknown_74', 'unknown_75') else base + '.bin'
            elif name.endswith('.bin.json'):
                dump_key = name[:-5]
            elif name.endswith('.json'):
                dump_key = name
            else:
                dump_key = name
            data_dumps[dump_key] = content
            
    out_file = os.path.join(WEB_DIR, 'data_dumps.json')
    with open(out_file, 'w', encoding='utf-8') as f:
        json.dump(data_dumps, f, ensure_ascii=False)
        
    sz = os.path.getsize(out_file)
    print(f"[OK] Da dong bo {len(data_dumps)} bang du lieu -> {out_file} ({sz / 1024 / 1024:.2f} MB)")

if __name__ == '__main__':
    t0 = time.time()
    sync_lua()
    sync_data()
    print(f"[HOAN TAT] Dong bo toan bo thanh cong trong {time.time() - t0:.2f}s!")
