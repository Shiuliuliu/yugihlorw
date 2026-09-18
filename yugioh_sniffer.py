import socket, sys, threading

sys.stdout.reconfigure(encoding='utf-8')

HOST = '0.0.0.0'
PORT = 9191

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind((HOST, PORT))
server.listen(5)
print(f"=== YUGIOH TEST SNIFFER LISTENING ON {HOST}:{PORT} ===")

def handle_client(conn, addr):
    print(f"[+] Incoming connection from {addr}")
    try:
        while True:
            data = conn.recv(4096)
            if not data:
                print(f"[-] Client {addr} disconnected")
                break
            print(f"[*] Received {len(data)} bytes from {addr}:")
            print(f"    HEX: {data.hex()}")
            print(f"    RAW: {data}")
    except Exception as e:
        print(f"[!] Error: {e}")
    finally:
        conn.close()

try:
    while True:
        conn, addr = server.accept()
        t = threading.Thread(target=handle_client, args=(conn, addr), daemon=True)
        t.start()
except KeyboardInterrupt:
    print("Server stopped.")
finally:
    server.close()
