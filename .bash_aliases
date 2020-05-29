# Disable Ctrl-s
stty -ixon

## Set Vim as default editor
export EDITOR='vim'
export VISUAL='vim'

# Oh my git
source ~/.oh-my-git/prompt.sh

# Load pyenv if exist
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
