#!/bin/env bash
. vars

while :; do
    echo -e TIME$(date +"%D %l:%M")
sleep 45
done > "$PANEL_FIFO" 
