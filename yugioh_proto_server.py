import socket
import threading
import struct
import sys
import time

sys.stdout.reconfigure(encoding='utf-8')

HOST = '0.0.0.0'
PORT = 9191

FIB = [1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269,2178309,3524578,5702887,9227465,14930352,24157817,39088169,63245986,102334155,165580141,267914296,433494437,701408733,1134903170,1836311903]

def calc_crc16(data):
    crc = 0
    for b in data:
        crc ^= b
        for _ in range(8):
            if crc & 1:
                crc = (crc >> 1) ^ 0xa001
            else:
                crc >>= 1
    return crc & 0xFFFF

def encrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r2 = (-shift) & 7
        b = ((b << shift) | (b >> r2)) & 0xFF
        b ^= mod_key
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

def decrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r5 = (-shift) & 7
        b ^= mod_key
        r7 = (b >> shift) & 0xFF
        b = ((b << r5) | r7) & 0xFF
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

def encode_varint(val):
    res = bytearray()
    while val > 0x7f:
        res.append((val & 0x7f) | 0x80)
        val >>= 7
    res.append(val & 0x7f)
    return bytes(res)

def encode_field(fn, wt, data):
    tag = encode_varint((fn << 3) | wt)
    if wt == 0:
        return tag + encode_varint(data)
    elif wt == 2:
        if isinstance(data, str):
            data = data.encode('utf-8')
        return tag + encode_varint(len(data)) + data
    raise ValueError(f'Unsupported wt {wt}')

def build_region_list_resp():
    # Region 1
    r1 = bytearray()
    r1 += encode_field(7, 0, 1) # id = 1
    r1 += encode_field(5, 2, "S1 - Quyết Chiến Chi Thành") # name
    r1 += encode_field(6, 2, "10.0.2.2:9191") # host
    r1 += encode_field(4, 0, 1) # status = 1 (IDLE)
    r1 += encode_field(3, 0, 1) # is_new = 1
    r1 += encode_field(2, 0, 1) # is_recommend = 1
    
    # Region 2
    r2 = bytearray()
    r2 += encode_field(7, 0, 2) # id = 2
    r2 += encode_field(5, 2, "S2 - Đấu Trường Hải Mã")
    r2 += encode_field(6, 2, "10.0.2.2:9191")
    r2 += encode_field(4, 0, 1)
    r2 += encode_field(3, 0, 1)
    r2 += encode_field(2, 0, 0)

    # RegionListResp
    rl_resp = bytearray()
    rl_resp += encode_field(1, 2, bytes(r1))
    rl_resp += encode_field(1, 2, bytes(r2))

    # SglRespMsg
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, 58) # type = 58 (PB_TYPE_REGION_LIST)
    sgl_resp += encode_field(2, 0, 0)  # status = 0 (PB_STATUS_OK)
    sgl_resp += encode_field(1, 2, bytes(rl_resp)) # extension 1 = region_list_resp

    return bytes(sgl_resp)

def build_auth_resp():
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, 388) # type = 388 (PB_TYPE_AUTHENTICATION)
    sgl_resp += encode_field(2, 0, 0)   # status = 0 (PB_STATUS_OK)
    return bytes(sgl_resp)

def make_frame(body, is_encrypted=False, step=0):
    if is_encrypted:
        crc = calc_crc16(body)
        enc = encrypt_data(body, step)
        payload = struct.pack('>H', crc) + enc
    else:
        payload = body
    return struct.pack('>I', len(payload)) + payload

def handle_client(sock, addr):
    print(f"[TCP] Connection accepted from {addr}")
    sock.settimeout(30)
    sys.stdout.flush()
    
    # 1. Send Challenge Frame immediately on connect
    challenge_frame = bytes.fromhex("0000002b08641000a206240102030452934c32eca7ed0296d67b750000881bfbdd333800ebab8cdbec54dd000076e1")
    try:
        sock.sendall(challenge_frame)
        print(f"[TCP] Sent challenge frame ({len(challenge_frame)} bytes)")
        sys.stdout.flush()
    except Exception as e:
        print(f"[TCP ERROR] Send challenge failed: {e}")
        sock.close()
        return

    # 2. Loop to read incoming frames
    recv_count = 0
    buf = bytearray()
    try:
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                print(f"[TCP] Client closed connection")
                break
            buf.extend(chunk)
            
            while len(buf) >= 4:
                frame_len = struct.unpack('>I', buf[:4])[0]
                if len(buf) < 4 + frame_len:
                    break # Wait for more data
                
                frame_data = bytes(buf[4:4+frame_len])
                del buf[:4+frame_len]
                recv_count += 1
                
                print(f"\n[RECV #{recv_count}] {len(frame_data)} bytes: {frame_data.hex()}")
                sys.stdout.flush()
                
                # Check first byte
                fn = (frame_data[0] >> 3)
                wt = frame_data[0] & 7
                print(f"  First byte: field={fn}, wire_type={wt}")
                
                if fn == 1 and wt == 0:
                    val = frame_data[1] & 0x7f
                    print(f"  Plain protobuf! type = {val}")
                    
                    if val == 388 or val == 386 or val == 385:
                        print(f"  Got AUTH/LOGIN ({val})! Sending Auth OK + Region List...")
                        # Send auth response
                        auth_resp = build_auth_resp()
                        sock.sendall(make_frame(auth_resp, is_encrypted=False))
                        print(f"  Sent Auth response ({len(auth_resp)} bytes)")
                        
                        # Send Region List response
                        rl_resp = build_region_list_resp()
                        sock.sendall(make_frame(rl_resp, is_encrypted=False))
                        print(f"  Sent Region List response ({len(rl_resp)} bytes)")
                        sys.stdout.flush()
                    
                    elif val == 58: # PB_TYPE_REGION_LIST
                        print("  Got REGION_LIST request! Sending Region List response...")
                        rl_resp = build_region_list_resp()
                        sock.sendall(make_frame(rl_resp, is_encrypted=False))
                        print(f"  Sent Region List response ({len(rl_resp)} bytes)")
                        sys.stdout.flush()
                else:
                    print(f"  Received encrypted or CRC frame! len={len(frame_data)}")
                    if len(frame_data) >= 2:
                        crc = struct.unpack('>H', frame_data[:2])[0]
                        body = frame_data[2:]
                        for step in range(46):
                            dec = decrypt_data(body, step)
                            if calc_crc16(dec) == crc:
                                print(f"  >>> SUCCESS Decrypted with step={step}: {dec.hex()}")
                                break
                    # Send Region List response
                    print("  Sending Region List response...")
                    rl_resp = build_region_list_resp()
                    sock.sendall(make_frame(rl_resp, is_encrypted=False))
                    sys.stdout.flush()

    except Exception as e:
        print(f"[TCP ERROR] {e}")
    finally:
        sock.close()
        print(f"[TCP] Client disconnected: {addr}")
        sys.stdout.flush()

def main():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((HOST, PORT))
    s.listen(5)
    print(f"===========================================================")
    print(f"   YUGIOH PROTOBUF TCP SERVER LISTENING ON {HOST}:{PORT}   ")
    print(f"===========================================================")
    sys.stdout.flush()
    while True:
        client_sock, client_addr = s.accept()
        t = threading.Thread(target=handle_client, args=(client_sock, client_addr), daemon=True)
        t.start()

if __name__ == '__main__':
    main()
