#!/bin/bash

CACHE_DIR="$HOME/.cache/waybar-nowplaying"
CACHE_FILE="$CACHE_DIR/art.jpg"

mkdir -p "$CACHE_DIR"

ART_URL=$(playerctl metadata mpris:artUrl 2>/dev/null)
[ -z "$ART_URL" ] && exit 0

# Download only if changed
if [ ! -f "$CACHE_FILE" ] || ! grep -q "$ART_URL" "$CACHE_DIR/last_url" 2>/dev/null; then
  curl -fsSL "$ART_URL" -o "$CACHE_FILE" || exit 0
  echo "$ART_URL" > "$CACHE_DIR/last_url"
fi

imv "$CACHE_FILE"
