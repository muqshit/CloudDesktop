#!/bin/bash

set -e

export DISPLAY=:1
export HOME=/home/vscode

mkdir -p "$HOME/.vnc"

if ! pgrep -f "Xvfb :1" >/dev/null; then
    Xvfb :1 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
    sleep 2
fi

if ! pgrep -f "xfce4-session" >/dev/null; then
    dbus-launch --exit-with-session startxfce4 >/tmp/xfce.log 2>&1 &
    sleep 5
fi

if ! pgrep -f "x11vnc.*5901" >/dev/null; then
    x11vnc \
        -display :1 \
        -rfbport 5901 \
        -forever \
        -shared \
        -nopw \
        -listen 0.0.0.0 \
        >/tmp/x11vnc.log 2>&1 &
fi

if ! pgrep -f "novnc_proxy.*6080" >/dev/null; then
    /usr/share/novnc/utils/novnc_proxy \
        --vnc localhost:5901 \
        --listen 6080 \
        >/tmp/novnc.log 2>&1 &
fi

echo "ABMMM Cloud PC is ready."
