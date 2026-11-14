import subprocess, sys

sys.stdout.reconfigure(encoding='utf-8')

adb = r'C:\Program Files\Netease\MuMuPlayer\nx_device\12.0\shell\adb.exe'
subprocess.run([adb, 'connect', '127.0.0.1:16384'], capture_output=True)

res = subprocess.run([adb, '-s', '127.0.0.1:16384', 'shell', 'pidof com.game.duelcity'], capture_output=True, text=True)
pids = res.stdout.strip().split()
if not pids:
    print('No duelcity process found!')
    sys.exit(1)
pid = pids[0]
print('PID:', pid)

# Push a shell script to /data/local/tmp/search.sh
sh_content = f'''#!/system/bin/sh
cat /proc/{pid}/maps | while read -r line; do
    addr=$(echo "$line" | awk '{{print $1}}')
    perms=$(echo "$line" | awk '{{print $2}}')
    case "$perms" in
        r*)
            start_hex=$(echo "$addr" | cut -d'-' -f1)
            end_hex=$(echo "$addr" | cut -d'-' -f2)
            start=$((0x$start_hex))
            end=$((0x$end_hex))
            size=$((end - start))
            if [ $size -ge 4096 ] && [ $size -le 50000000 ]; then
                skip=$((start / 4096))
                count=$((size / 4096))
                match=$(dd if=/proc/{pid}/mem bs=4096 skip=$skip count=$count 2>/dev/null | grep -a -F '白银之城' | head -n 1)
                if [ -n "$match" ]; then
                    echo "FOUND in $addr ($perms): $match"
                fi
            fi
            ;;
    esac
done
'''

with open(r'D:\yugitauapk\duelcity_apk\search.sh', 'w', encoding='utf-8', newline='\n') as f:
    f.write(sh_content)

subprocess.run([adb, '-s', '127.0.0.1:16384', 'push', r'D:\yugitauapk\duelcity_apk\search.sh', '/data/local/tmp/search.sh'])
subprocess.run([adb, '-s', '127.0.0.1:16384', 'shell', 'chmod +x /data/local/tmp/search.sh'])

print('Running /data/local/tmp/search.sh...')
p = subprocess.Popen([adb, '-s', '127.0.0.1:16384', 'shell', '/data/local/tmp/search.sh'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding='utf-8', errors='ignore')
stdout, stderr = p.communicate()
print('Results:')
print(stdout)
if stderr:
    print('STDERR:', stderr[:300])
