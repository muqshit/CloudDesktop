#!/bin/bash

set -e

export DISPLAY=:1
export HOME=/home/vscode
export USER=vscode

mkdir -p /tmp/cloudpc
mkdir -p "$HOME/.vnc"

echo "Starting virtual display..."

Xvfb :1 \
    -screen 0 1920x1080x24 \
    -ac \
    -nolisten tcp \
    +extension GLX \
    +render \
    -noreset \
    > /tmp/cloudpc/xvfb.log 2>&1 &

sleep 3

echo "Starting XFCE..."

dbus-launch --exit-with-session startxfce4 \
    > /tmp/cloudpc/xfce.log 2>&1 &

sleep 8

echo "Starting VNC server..."

x11vnc \
    -display :1 \
    -rfbport 5901 \
    -forever \
    -shared \
    -nopw \
    -listen 127.0.0.1 \
    > /tmp/cloudpc/x11vnc.log 2>&1 &

sleep 3

echo "Starting noVNC..."

/usr/share/novnc/utils/novnc_proxy \
    --vnc localhost:5901 \
    --listen 0.0.0.0:6080 \
    > /tmp/cloudpc/novnc.log 2>&1 &

sleep 3

echo ""
echo "======================================"
echo "       ABMMM CLOUD PC READY"
echo "======================================"
echo "XFCE      : Running"
echo "VNC       : 5901"
echo "noVNC     : 6080"
echo "Resolution: 1920x1080"
echo "======================================"
echo ""

tail -f /dev/null
