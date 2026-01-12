#!/bin/bash

# Define colors
RESET="\033[0m"
BOLD="\033[1m"
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"

# Prepare data with ANSI colors for better visibility in fzf
# Format: "Command  Description"
generate_data() {
    cat <<EOF
# Movement
h            Move left
j            Move down
k            Move up
l            Move right
w            Jump by start of words (forward)
b            Jump by start of words (backward)
e            Jump by end of words (forward)
ge           Jump by end of words (backward)
0            Start of line
^            Start of line (non-blank)
$            End of line
gg           Go to first line
G            Go to last line
<C-u>        Up half page
<C-d>        Down half page
<C-f>        Page down
<C-b>        Page up
%            Go to matching bracket

# Editing
i            Insert before cursor
a            Insert after cursor
I            Insert at line start
A            Insert at line end
o            Append new line below
O            Append new line above
r            Replace one character
R            Enter replace mode
x            Delete character
dd           Delete line
D            Delete to end of line
yy           Yank (copy) line
y$           Yank to end of line
p            Paste after cursor
P            Paste before cursor
u            Undo
<C-r>        Redo
.            Repeat last command

# Visual Mode
v            Visual mode (char)
V            Visual mode (line)
<C-v>        Visual mode (block)

# Window Management
<C-w>h       Move to left window
<C-w>j       Move to window below
<C-w>k       Move to window above
<C-w>l       Move to right window
<C-w>s       Split horizontal
<C-w>v       Split vertical
<C-w>c       Close window
<C-w>o       Close all other windows

# Search & Replace
/pattern     Search forward
?pattern     Search backward
n            Next match
N            Previous match
:%s/old/new/g Replace all in file

# Files
:w           Save file
:q           Quit
:q!          Quit without saving
:wq          Save and quit
:x           Save and quit

# Leader (Example)
<Space>f     Find file (Telescope)
<Space>g     Live grep (Telescope)
<Space>e     Toggle explorer
EOF
}

# Use awk to colorize the input for fzf
generate_data | awk -v blue="$BLUE" -v green="$GREEN" -v reset="$RESET" -v bold="$BOLD" '
    /^#/ { print blue bold $0 reset; next }
    /^[[:space:]]*$/ { next }
    { 
        match($0, /^[[:graph:]]+/)
        cmd = substr($0, RSTART, RLENGTH)
        desc = substr($0, RSTART + RLENGTH)
        gsub(/^[[:space:]]+/, "", desc)
        
        printf "%s%-12s%s %s\n", green, cmd, reset, desc
    }
' | fzf \
    --ansi \
    --header="Type to filter..." \
    --layout=reverse \
    --border \
    --margin=1 \
    --padding=1 \
    --prompt="nvim> " \
    --pointer="▶" \
    --marker="✓" \
    --no-info \
    --cycle
