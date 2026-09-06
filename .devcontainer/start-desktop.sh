#!/usr/bin/env bash
set -e
export DISPLAY=:1

vncserver -kill :1 >/dev/null 2>&1 || true
rm -rf ~/.vnc/*.pid

mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/bash
xrdb $HOME/.Xresources 2>/dev/null
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

if [ ! -f ~/.vnc/passwd ]; then
  echo "codespace" | vncpasswd -f > ~/.vnc/passwd
  chmod 600 ~/.vnc/passwd
fi

echo "==> Starting VNC server on :1 (1920x1080)..."
vncserver :1 -geometry 1920x1080 -depth 24

echo "==> Starting noVNC bridge on port 6080..."
nohup /opt/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 \
  > /tmp/novnc.log 2>&1 &

echo "==> Desktop is up. Open the forwarded 6080 port in your browser."
