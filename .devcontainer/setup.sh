#!/usr/bin/env bash
set -e

echo "==> Updating apt and installing base packages..."
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  xfce4 xfce4-goodies \
  tigervnc-standalone-server tigervnc-common \
  git curl wget unzip \
  fonts-cantarell fonts-noto-color-emoji \
  chromium-browser \
  libreoffice \
  plank \
  dbus-x11 x11-xserver-utils

echo "==> Setting up noVNC..."
sudo mkdir -p /opt/noVNC
sudo git clone --depth 1 https://github.com/novnc/noVNC.git /opt/noVNC
sudo git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify
sudo ln -sf /opt/noVNC/vnc.html /opt/noVNC/index.html

echo "==> Installing WhiteSur (macOS-style) GTK theme..."
git clone --depth 1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git /tmp/WhiteSur-gtk-theme
cd /tmp/WhiteSur-gtk-theme
./install.sh -c Dark -N glassy || true
cd -

echo "==> Installing WhiteSur icon theme..."
git clone --depth 1 https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icon-theme
cd /tmp/WhiteSur-icon-theme
./install.sh -a || true
cd -

echo "==> Installing WhiteSur cursor theme..."
mkdir -p ~/.icons
git clone --depth 1 https://github.com/vinceliuice/WhiteSur-cursors.git /tmp/WhiteSur-cursors
cd /tmp/WhiteSur-cursors
./install.sh || true
cd -

echo "==> Fetching a macOS-style wallpaper..."
mkdir -p ~/Pictures
curl -sL "https://raw.githubusercontent.com/vinceliuice/WhiteSur-gtk-theme/master/wallpaper/4k/1.png" \
  -o ~/Pictures/macos-wallpaper.png || true

echo "==> Configuring Plank (dock) autostart..."
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/plank.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Plank
Exec=plank
X-GNOME-Autostart-enabled=true
EOF

echo "==> Autostart script to apply theme + panel layout on login..."
cat > ~/.config/autostart/apply-theme.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Apply macOS Theme
Exec=bash -c "sleep 5 && bash $HOME/.devcontainer/apply-xfce-theme.sh"
X-GNOME-Autostart-enabled=true
EOF

echo "==> Done. Run start-desktop.sh (or restart the Codespace) to launch the GUI."
