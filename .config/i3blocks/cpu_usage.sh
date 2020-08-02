#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) urxvt -title floating -e top  ;; 
esac

cpu_info=/tmp/.cpu_info
if [ -f $cpu_info ];then
    IFS=' ' read -r -a arr < $cpu_info
fi
PREV_TOTAL=${arr[0]:-0}
PREV_IDLE=${arr[1]:-0}

# Get the total CPU statistics, discarding the 'cpu ' prefix.
CPU=($(sed -n 's/^cpu\s//p' /proc/stat))
IDLE=${CPU[3]} # Just the idle CPU time.

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]:0:8}"; do
    TOTAL=$((TOTAL+VALUE))
done

# Calculate the CPU usage since we last checked.
DIFF_IDLE=$((IDLE-PREV_IDLE))
DIFF_TOTAL=$((TOTAL-PREV_TOTAL))
DIFF_USAGE=$(((1000*(DIFF_TOTAL-DIFF_IDLE)/DIFF_TOTAL+5)/10))
if (( DIFF_USAGE < 25 ));then
    color="#00C0FF"
elif (( DIFF_USAGE >= 25 && DIFF_USAGE < 60 ));then
    color="#50C0FF"
elif (( DIFF_USAGE >= 60 && DIFF_USAGE < 75 ));then
    color="#80C0FF"
else
    color="#C0C0FF"
fi
printf ' CPU <span foreground="%s">%2d%% </span>\n' "$color" "$DIFF_USAGE"

# Remember the total and idle CPU times for the next check.
[ -f "$cpu_info" ] && rm -f $cpu_info
echo "$TOTAL $IDLE" > $cpu_info
