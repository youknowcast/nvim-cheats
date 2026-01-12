#!/bin/bash
set -e

# Get absolute path to the cheat script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_SCRIPT="$SCRIPT_DIR/nvim-cheats.sh"
HYPR_DIR="$HOME/.config/hypr"
BINDINGS_CONF="$HYPR_DIR/bindings.conf"
HYPRLAND_CONF="$HYPR_DIR/hyprland.conf"

# Ensure target script is executable
chmod +x "$TARGET_SCRIPT"
echo "Made $TARGET_SCRIPT executable."

# 1. Configure Keybinding in bindings.conf
if [ -f "$BINDINGS_CONF" ]; then
    # Backup
    cp "$BINDINGS_CONF" "$BINDINGS_CONF.bak.$(date +%s)"
    echo "Backed up bindings.conf"

    # Check if binding already exists (simplistic check)
    if grep -q "nvim-cheats.sh" "$BINDINGS_CONF"; then
        echo "Keybinding seems to already exist in $BINDINGS_CONF. Skipping."
    else
        echo "" >> "$BINDINGS_CONF"
        echo "# nvim-cheats launch binding" >> "$BINDINGS_CONF"
        # Using bindd for description if supported, else bind
        echo "bind = SUPER, V, exec, ghostty --title=nvim-cheats -e $TARGET_SCRIPT" >> "$BINDINGS_CONF"
        echo "Added SUPER+V binding to $BINDINGS_CONF"
    fi
else
    echo "Error: $BINDINGS_CONF not found."
fi

# 2. Configure Window Rules in hyprland.conf
if [ -f "$HYPRLAND_CONF" ]; then
    # Backup
    cp "$HYPRLAND_CONF" "$HYPRLAND_CONF.bak.$(date +%s)"
    echo "Backed up hyprland.conf"

    # Check for existing rules
    if grep -q "title:^(nvim-cheats)$" "$HYPRLAND_CONF"; then
        echo "Window rules seem to already exist in $HYPRLAND_CONF. Skipping."
    else
        echo "" >> "$HYPRLAND_CONF"
        echo "# nvim-cheats window rules" >> "$HYPRLAND_CONF"
        echo "windowrule = float, title:^(nvim-cheats)$" >> "$HYPRLAND_CONF"
        echo "windowrule = size 600 400, title:^(nvim-cheats)$" >> "$HYPRLAND_CONF"
        echo "windowrule = center, title:^(nvim-cheats)$" >> "$HYPRLAND_CONF"
        echo "Added window rules to $HYPRLAND_CONF"
    fi
else
    echo "Error: $HYPRLAND_CONF not found."
fi

echo "--------------------------------------------------------"
echo "Installation complete."
echo "Please run 'hyprctl reload' to apply changes immediately."
echo "--------------------------------------------------------"
