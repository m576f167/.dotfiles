#!/bin/bash
# Tmux layout setup - equivalent to .screen_layout
# Run this to create the session with predefined windows and layouts
# Usage: tmux-layout [session-name]

SESSION="${1:-main}"

# Check if session already exists
tmux has-session -t "$SESSION" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Session '$SESSION' already exists. Attaching..."
    tmux attach-session -t "$SESSION"
    exit 0
fi

# Create session with first window named "Terminal"
tmux new-session -d -s "$SESSION" -n "Terminal"

# Create additional named windows
tmux new-window -t "$SESSION" -n "Editor"
tmux new-window -t "$SESSION" -n "Monitor"
tmux new-window -t "$SESSION" -n "Console"

# --- Layout: Default ---
# Just select window 1 (Editor) - single pane
tmux select-window -t "$SESSION:Editor"

# --- Layout: IDE ---
# Create IDE layout in Editor window:
#   Left (Editor) | Right-top (Monitor)
#                 | Right-bottom (Console)
# We'll set this up in a dedicated window group
# For tmux, we achieve this with pane splits in the Editor window

# Go to Editor window and split for IDE layout
tmux select-window -t "$SESSION:Editor"
tmux split-window -h -t "$SESSION:Editor"
tmux split-window -v -t "$SESSION:Editor.1"

# Resize right column to be smaller (approximately 52 chars as in screen config)
tmux resize-pane -t "$SESSION:Editor.1" -x 52
# Resize bottom-right pane to ~17 lines
tmux resize-pane -t "$SESSION:Editor.2" -y 17

# Select the main (left) pane
tmux select-pane -t "$SESSION:Editor.0"

# --- Start in Default (Terminal window, single pane) ---
tmux select-window -t "$SESSION:Terminal"

# Attach to session
tmux attach-session -t "$SESSION"
