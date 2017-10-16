# Disable Ctrl-s
stty -ixon

# Set Vim as default editor
export EDITOR='vim'
export VISUAL='vim'

# Set Terminal mode as vi
set -o vi
set editing-mode vi
set keymap vi-command
set show-mode-in-prompt on

# Oh my git
source ~/.oh-my-git/prompt.sh

