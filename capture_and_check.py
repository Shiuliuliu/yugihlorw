import subprocess
import time
import os

ADB = r"C:\Program Files\Netease\MuMuPlayer\nx_main\adb.exe"
DEV = "127.0.0.1:16384"
ARTIFACT_DIR = r"C:\Users\Nitro 5\.gemini\antigravity\brain\1935a16b-edc5-417f-a74d-a2641dd97101"

def run_adb(cmd_list):
    full_cmd = [ADB, "-s", DEV] + cmd_list
    res = subprocess.run(full_cmd, capture_output=True, text=False)
    return res

def tap(x, y):
    print(f"Tapping {x}, {y}...")
    run_adb(["shell", "input", "tap", str(x), str(y)])

def screencap(filename):
    out_path = os.path.join(ARTIFACT_DIR, filename)
    print(f"Capturing to {out_path}...")
    res = run_adb(["exec-out", "screencap", "-p"])
    with open(out_path, "wb") as f:
        f.write(res.stdout)
    print(f"Saved {len(res.stdout)} bytes")

# Ensure connected
subprocess.run([ADB, "connect", DEV], capture_output=True)

# First take a screencap of current state
screencap("current_state.png")

# Tap confirm popup if present
tap(800, 690)
time.sleep(2)

# Tap Bộ Bài (1040, 340)
tap(1040, 340)
time.sleep(3)

# Screencap deck
screencap("deck_screen.png")

# Tap card 1 (Blue-Eyes at 75, 850)
tap(75, 850)
time.sleep(2)
screencap("card_blue_eyes.png")

# Tap close (tap outside or back button 60, 40)
tap(60, 40)
time.sleep(1)

# Tap card 2 in deck grid (360, 240)
tap(360, 240)
time.sleep(2)
screencap("card_sample_2.png")
print("Done!")
