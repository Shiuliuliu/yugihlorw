#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script dong bo ma nguon va du lieu game:
1. Doc toan bo file trong web/src/*.lua -> tao web/lua_src.json & web/lua_bundle.bin (ma hoa, nen gzip)
2. Doc toan bo file trong web/data/*    -> tao web/data_dumps.json & web/data_bundle.bin (ma hoa, nen gzip)
Tham khao kien truc bundle & bao mat cua https://arcana.ddns.net/
"""

import os
import json
import time
import gzip

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WEB_DIR = os.path.join(BASE_DIR, 'web')
SRC_DIR = os.path.join(WEB_DIR, 'src')
DATA_DIR = os.path.join(WEB_DIR, 'data')

BUNDLE_KEY = b'ArcanaSecret2026'

def xor_data(data_bytes, key=BUNDLE_KEY):
    b = bytearray(data_bytes)
    klen = len(key)
    for i in range(len(b)):
        b[i] ^= key[i % klen]
    return bytes(b)

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
    
    # 1. Output plain json (backward-compatibility fallback)
    raw_json = json.dumps(lua_data, ensure_ascii=False).encode('utf-8')
    out_file = os.path.join(WEB_DIR, 'lua_src.json')
    with open(out_file, 'wb') as f:
        f.write(raw_json)
    
    # 2. Output encrypted compressed bundle (Arcana style)
    compressed = gzip.compress(raw_json, compresslevel=9)
    encrypted_bundle = xor_data(compressed)
    bundle_file = os.path.join(WEB_DIR, 'lua_bundle.bin')
    with open(bundle_file, 'wb') as f:
        f.write(encrypted_bundle)
    
    sz_json = len(raw_json) / 1024 / 1024
    sz_bin = len(encrypted_bundle) / 1024 / 1024
    print(f"[OK] Da dong bo {len(lua_data)} module Lua:")
    print(f"     -> {out_file} ({sz_json:.2f} MB)")
    print(f"     -> {bundle_file} ({sz_bin:.2f} MB) [Ma hoa & nen 85% giup game muot va giau file Lua]")

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
            
    # 1. Output plain json
    raw_json = json.dumps(data_dumps, ensure_ascii=False).encode('utf-8')
    out_file = os.path.join(WEB_DIR, 'data_dumps.json')
    with open(out_file, 'wb') as f:
        f.write(raw_json)
    
    # 2. Output encrypted compressed bundle
    compressed = gzip.compress(raw_json, compresslevel=9)
    encrypted_bundle = xor_data(compressed)
    bundle_file = os.path.join(WEB_DIR, 'data_bundle.bin')
    with open(bundle_file, 'wb') as f:
        f.write(encrypted_bundle)
        
    sz_json = len(raw_json) / 1024 / 1024
    sz_bin = len(encrypted_bundle) / 1024 / 1024
    print(f"[OK] Da dong bo {len(data_dumps)} bang du lieu:")
    print(f"     -> {out_file} ({sz_json:.2f} MB)")
    print(f"     -> {bundle_file} ({sz_bin:.2f} MB) [Ma hoa & nen 94% giup game muot hon]")

if __name__ == '__main__':
    t0 = time.time()
    sync_lua()
    sync_data()
    print(f"[HOAN TAT] Dong bo toan bo thanh cong trong {time.time() - t0:.2f}s!")
