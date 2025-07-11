#!/bin/bash

# This script is useful to implement floating PiP windows until issue
# https://github.com/nikitabobko/AeroSpace/issues/2 is closed.

pip_window_names=(
    "Picture-in-Picture"
    "Picture in Picture"
)
# Build the regex pattern for grep by joining the array with a '|'
pip_windows_grep_pattern=$(IFS='|'; echo "${pip_window_names[*]}")

current_workspace=$(aerospace list-workspaces --focused)
current_monitor=$(aerospace list-monitors --focused | awk '{print $1}')

# Move PiP windows to current workspace if they are on the current monitor
aerospace list-windows --monitor "$current_monitor" | grep -E "$pip_windows_grep_pattern" | awk '{print $1}' | while read window_id; do
    if [ -n "$window_id" ]; then
        aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    fi
done
