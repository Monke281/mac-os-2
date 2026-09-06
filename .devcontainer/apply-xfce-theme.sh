#!/usr/bin/env bash
xfconf-query -c xsettings -p /Net/ThemeName -s "WhiteSur-Dark" 2>/dev/null || true
xfconf-query -c xsettings -p /Net/IconThemeName -s "WhiteSur" 2>/dev/null || true
xfconf-query -c xfwm4 -p /general/theme -s "WhiteSur-Dark" 2>/dev/null || true

xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image \
  -s "$HOME/Pictures/macos-wallpaper.png" 2>/dev/null || true

xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=6;x=0;y=0" 2>/dev/null || true
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 26 2>/dev/null || true
xfconf-query -c xfce4-panel -p /panels/panel-1/length -s 100 2>/dev/null || true

echo "Theme applied."
