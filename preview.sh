#!/usr/bin/env bash

set -euo pipefail

# if a process is listening on tcp port 7771, kill it with signal 9
if lsof -i tcp:7771 -s tcp:listen >/dev/null 2>&1; then
    OLD_PID=$(lsof -ti tcp:7771 -s tcp:listen)
    echo -n "Killing listening process with PID $OLD_PID..."
    kill -9 "$OLD_PID"
    # wait until the process is gone
    while lsof -i tcp:7771 -s tcp:listen >/dev/null 2>&1; do
        sleep 0.2
    done
    echo " done."
fi

PIDFILE="${PIDFILE:-/tmp/quarto-preview.pid}"

# if PIDFILE exists, read old PID and kill it with signal 9
if [[ -f "$PIDFILE" ]]; then
    OLD_PID=$(cat "$PIDFILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo -n "Killing existing process with PID $OLD_PID..."
        kill -9 "$OLD_PID"
        # wait until the process is gone
        while kill -0 "$OLD_PID" 2>/dev/null; do
            sleep 0.2
        done
        echo " done."
    fi
fi

# start new preview in background
echo -n "Starting new quarto preview..."
quarto preview &
new_pid=$!

# save PID and disown
echo "$new_pid" > "$PIDFILE"
disown "$new_pid"

echo " done. PID $new_pid"
