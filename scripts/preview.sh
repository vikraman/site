#!/usr/bin/env bash

set -euo pipefail

wait_for_exit() {
    local pid=$1
    while kill -0 "$pid" 2>/dev/null; do
        sleep 0.2
    done
}

# Kill process listening on port 7771
if lsof -i tcp:7771 -s tcp:listen >/dev/null 2>&1; then
    OLD_PID=$(lsof -ti tcp:7771 -s tcp:listen)
    echo -n "Killing listening process $OLD_PID..."
    kill -9 "$OLD_PID"
    wait_for_exit "$OLD_PID" || true
    echo " done."
fi

PIDFILE="${PIDFILE:-/tmp/quarto-preview.pid}"

# Kill process from PIDFILE
if [[ -f "$PIDFILE" ]]; then
    OLD_PID=$(cat "$PIDFILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo -n "Killing existing process $OLD_PID..."
        kill -9 "$OLD_PID"
        wait_for_exit "$OLD_PID"
        echo " done."
    fi
fi

echo -n "Starting quarto preview..."
quarto preview &
new_pid=$!
echo "$new_pid" > "$PIDFILE"
disown "$new_pid"
echo " done. PID $new_pid"
