#!/bin/bash

# Usage:
#   ./workspace_control.sh +   # increase workspace count by 1
#   ./workspace_control.sh -   # decrease workspace count by 1

KEY="org.gnome.desktop.wm.preferences"
CURRENT=$(gsettings get $KEY num-workspaces)
if [[ "$1" == "+" ]]; then
    NEW=$((CURRENT + 1))
elif [[ "$1" == "-" ]]; then
    NEW=$((CURRENT - 1))
else
    echo "Usage: $0 [+|-]"
    exit 1
fi

# Prevent going below 1
if (( NEW < 1 )); then
    NEW=1
fi

gsettings set $KEY num-workspaces $NEW