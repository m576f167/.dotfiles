# Disable Ctrl-s
stty -ixon

## Set Vim as default editor
export EDITOR='vim'
export VISUAL='vim'

# Oh my git
source ~/.oh-my-git/prompt.sh

# Make sure python is installed with dynamic library in pyenv
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Load pyenv if exist
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Set bat config file path
export BAT_CONFIG_PATH="~/.config/bat/config"
