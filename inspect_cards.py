import subprocess
import time
import os

ADB = r"C:\Program Files\Netease\MuMuPlayer\nx_main\adb.exe"
DEV = "127.0.0.1:16384"
ARTIFACT_DIR = r"C:\Users\Nitro 5\.gemini\antigravity\brain\1935a16b-edc5-417f-a74d-a2641dd97101"

def cmd(args):
    res = subprocess.run([ADB, "-s", DEV] + args, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"Error running {args}: {res.stderr}")
    return res

def tap(x, y):
    print(f"Tap {x}, {y}")
    cmd(["shell", "input", "tap", str(x), str(y)])

def save_screen(name):
    target = os.path.join(ARTIFACT_DIR, name)
    cmd(["shell", "screencap", "-p", f"/sdcard/{name}"])
    res = subprocess.run([ADB, "-s", DEV, "pull", f"/sdcard/{name}", target], capture_output=True, text=True)
    print(f"Pulled {name}: {res.stdout.strip()} {res.stderr.strip()}")

# Connect first
res = subprocess.run([ADB, "connect", DEV], capture_output=True, text=True)
print("Connect:", res.stdout.strip())
time.sleep(1)

# Check current screen
save_screen("current_screen.png")

# Tap Rồng Trắng Mắt Xanh (80, 850)
tap(80, 850)
time.sleep(2)
save_screen("inspect_blue_eyes.png")

print("Done!")
