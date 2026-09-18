import subprocess
import time
import os

ADB = r"C:\Program Files\Netease\MuMuPlayer\nx_main\adb.exe"
DEV = "127.0.0.1:16384"
ARTIFACT_DIR = r"C:\Users\Nitro 5\.gemini\antigravity\brain\1935a16b-edc5-417f-a74d-a2641dd97101"

def cmd(args):
    return subprocess.run([ADB, "-s", DEV] + args, capture_output=True, text=True)

def tap(x, y):
    print(f"Tap {x}, {y}")
    cmd(["shell", "input", "tap", str(x), str(y)])

def save_screen(name):
    target = os.path.join(ARTIFACT_DIR, name)
    cmd(["shell", "screencap", "-p", f"/sdcard/{name}"])
    res = subprocess.run([ADB, "-s", DEV, "pull", f"/sdcard/{name}", target], capture_output=True, text=True)
    print(f"Pulled {name}")

subprocess.run([ADB, "connect", DEV], capture_output=True)

# Close modal
tap(100, 100)
time.sleep(1)

# Tap EX-Quái Thú tab (x=60, y=595)
tap(60, 595)
time.sleep(2)
save_screen("ex_cards_list.png")

# Tap first card in EX list (x=230, y=240)
tap(230, 240)
time.sleep(2)
save_screen("ex_card_1.png")

# Close modal
tap(100, 100)
time.sleep(1)

# Tap second card in EX list (x=360, y=240)
tap(360, 240)
time.sleep(2)
save_screen("ex_card_2.png")
