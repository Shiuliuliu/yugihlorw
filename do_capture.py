import subprocess
import time

ADB = r"C:\Program Files\Netease\MuMuPlayer\nx_main\adb.exe"
DEV = "127.0.0.1:16384"
OUT = r"C:\Users\Nitro 5\.gemini\antigravity\brain\1935a16b-edc5-417f-a74d-a2641dd97101\screen_now.png"

def cmd(args):
    return subprocess.run([ADB, "-s", DEV] + args, capture_output=True)

subprocess.run([ADB, "connect", DEV], capture_output=True)
time.sleep(1)

# Screencap via shell screencap to /sdcard then pull
cmd(["shell", "screencap", "-p", "/sdcard/sc.png"])
res = subprocess.run([ADB, "-s", DEV, "pull", "/sdcard/sc.png", OUT], capture_output=True, text=True)
print("Pull result:", res.stdout, res.stderr)
