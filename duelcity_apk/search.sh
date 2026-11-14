#!/system/bin/sh
cat /proc/6973/maps | while read -r line; do
    addr=$(echo "$line" | awk '{print $1}')
    perms=$(echo "$line" | awk '{print $2}')
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
                match=$(dd if=/proc/6973/mem bs=4096 skip=$skip count=$count 2>/dev/null | grep -a -F '白银之城' | head -n 1)
                if [ -n "$match" ]; then
                    echo "FOUND in $addr ($perms): $match"
                fi
            fi
            ;;
    esac
done
