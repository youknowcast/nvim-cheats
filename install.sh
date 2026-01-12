#!/bin/bash
set -e

# Define paths
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="nvim-cheats.sh"
CONFIG_NAME="nvim-cheats.conf"

DEST_SCRIPT_DIR="$HOME/.config/hypr/scripts"
DEST_CONFIG_DIR="$HOME/.config/hypr"

DEST_SCRIPT="$DEST_SCRIPT_DIR/$SCRIPT_NAME"
DEST_CONFIG="$DEST_CONFIG_DIR/$CONFIG_NAME"
DEST_DATA_DIR="$DEST_SCRIPT_DIR/data"

# Colors
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

echo "Installing nvim-cheats..."

# 1. Install the script and data
if [ ! -d "$DEST_SCRIPT_DIR" ]; then
    mkdir -p "$DEST_SCRIPT_DIR"
    echo "Created directory: $DEST_SCRIPT_DIR"
fi

# Copy script
cp "$SOURCE_DIR/$SCRIPT_NAME" "$DEST_SCRIPT"
chmod +x "$DEST_SCRIPT"
echo -e "${GREEN}Installed script to: $DEST_SCRIPT${RESET}"

# Copy data directory
if [ -d "$SOURCE_DIR/data" ]; then
    rm -rf "$DEST_DATA_DIR" # Remove old data to ensure clean update
    cp -r "$SOURCE_DIR/data" "$DEST_SCRIPT_DIR/"
    echo -e "${GREEN}Installed data to: $DEST_DATA_DIR${RESET}"
else
    echo "Error: Data directory not found in $SOURCE_DIR"
    exit 1
fi

# 2. Install the config file
cp "$SOURCE_DIR/$CONFIG_NAME" "$DEST_CONFIG"
echo -e "${GREEN}Installed config to: $DEST_CONFIG${RESET}"

# 3. Print instructions for the user
echo ""
echo "------------------------------------------------------------------"
echo -e "${GREEN}Installation successful!${RESET}"
echo ""
echo -e "To enable nvim-cheats, please add the following line to your"
echo -e "${YELLOW}~/.config/hypr/hyprland.conf${RESET} (or bindings.conf):"
echo ""
echo -e "    ${YELLOW}source = $DEST_CONFIG${RESET}"
echo ""
echo "After adding the line, run 'hyprctl reload' to apply changes."
echo "------------------------------------------------------------------"
